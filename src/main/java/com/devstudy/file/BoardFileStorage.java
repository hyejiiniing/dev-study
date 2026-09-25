package com.devstudy.file;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Locale;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.devstudy.vo.BoardFileVO;

@Component
public class BoardFileStorage {

    private static final long MAX_SIZE = 10L * 1024 * 1024;

    private final Path uploadDir;

    public BoardFileStorage(
            @Value("${upload.board-dir}") String uploadDir)
            throws IOException {

        this.uploadDir = Path.of(uploadDir)
                .toAbsolutePath()
                .normalize();

        Files.createDirectories(this.uploadDir);
    }

    public BoardFileVO store(MultipartFile file) throws IOException {

        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("파일이 비어 있습니다.");
        }

        if (file.getSize() > MAX_SIZE) {
            throw new IllegalArgumentException(
                    "파일 하나의 크기는 10MB 이하여야 합니다.");
        }

        String originalName = normalizeOriginalName(
                file.getOriginalFilename());

        int dotIndex = originalName.lastIndexOf('.');

        if (dotIndex <= 0) {
            throw new IllegalArgumentException(
                    "확장자가 있는 파일을 선택해주세요.");
        }

        String extension = originalName.substring(dotIndex + 1)
                .toLowerCase(Locale.ROOT);

        byte[] bytes = file.getBytes();

        if (bytes.length > MAX_SIZE) {
            throw new IllegalArgumentException(
                    "파일 하나의 크기는 10MB 이하여야 합니다.");
        }

        String contentType = validateContent(extension, bytes);

        String storedExtension = "jpeg".equals(extension)
                ? "jpg" : extension;

        Path savedPath = Files.createTempFile(
                uploadDir,
                UUID.randomUUID().toString() + "-",
                "." + storedExtension);

        try {
            Files.write(savedPath, bytes);
        } catch (IOException e) {
            try {
                Files.deleteIfExists(savedPath);
            } catch (IOException cleanupError) {
                e.addSuppressed(cleanupError);
            }
            throw e;
        }

        BoardFileVO vo = new BoardFileVO();
        vo.setOriginalName(originalName);
        vo.setStoredName(savedPath.getFileName().toString());
        vo.setFileSize((long) bytes.length);
        vo.setContentType(contentType);

        return vo;
    }

    public Path resolve(String storedName) {

        if (storedName == null
                || storedName.isBlank()
                || storedName.contains("/")
                || storedName.contains("\\")) {
            throw new IllegalArgumentException(
                    "올바르지 않은 저장 파일명입니다.");
        }

        Path path = uploadDir.resolve(storedName).normalize();

        if (!uploadDir.equals(path.getParent())
                || Files.isSymbolicLink(path)) {
            throw new IllegalArgumentException(
                    "허용되지 않은 파일 경로입니다.");
        }

        return path;
    }

    public void delete(String storedName) throws IOException {
        Files.deleteIfExists(resolve(storedName));
    }

    private String normalizeOriginalName(String filename) {

        if (filename == null) {
            throw new IllegalArgumentException("파일명이 없습니다.");
        }

        String name = filename.replace('\\', '/');
        name = name.substring(name.lastIndexOf('/') + 1).strip();

        if (name.isEmpty()
                || name.length() > 255
                || name.chars().anyMatch(Character::isISOControl)) {
            throw new IllegalArgumentException(
                    "파일명이 올바르지 않거나 너무 깁니다.");
        }

        return name;
    }

    private String validateContent(String extension, byte[] bytes)
            throws IOException {

        switch (extension) {
            case "png":
            case "jpg":
            case "jpeg":
                validateImage(extension, bytes);
                return "png".equals(extension)
                        ? "image/png" : "image/jpeg";

            case "pdf":
                String signature = new String(
                        bytes, 0, Math.min(bytes.length, 5),
                        StandardCharsets.US_ASCII);

                if (!"%PDF-".equals(signature)) {
                    throw new IllegalArgumentException(
                            "PDF 파일 형식을 확인해주세요.");
                }
                return "application/pdf";

            case "txt":
                try {
                    String text = StandardCharsets.UTF_8.newDecoder()
                            .decode(ByteBuffer.wrap(bytes))
                            .toString();

                    if (text.indexOf('\0') >= 0) {
                        throw new IllegalArgumentException(
                                "텍스트 파일에 허용되지 않는 문자가 있습니다.");
                    }
                } catch (CharacterCodingException e) {
                    throw new IllegalArgumentException(
                            "TXT 파일은 UTF-8로 저장해주세요.", e);
                }
                return "text/plain";

            default:
                throw new IllegalArgumentException(
                        "PNG, JPG, PDF, TXT 파일만 첨부할 수 있습니다.");
        }
    }

    private void validateImage(String extension, byte[] bytes)
            throws IOException {

        try (ImageInputStream input = ImageIO.createImageInputStream(
                new ByteArrayInputStream(bytes))) {

            if (input == null) {
                throw new IllegalArgumentException(
                        "이미지 파일을 읽을 수 없습니다.");
            }

            var readers = ImageIO.getImageReaders(input);

            if (!readers.hasNext()) {
                throw new IllegalArgumentException(
                        "이미지 파일 형식을 확인해주세요.");
            }

            ImageReader reader = readers.next();

            try {
                reader.setInput(input);

                String actualFormat = reader.getFormatName();
                String expectedFormat = "png".equals(extension)
                        ? "png" : "jpeg";

                if (!expectedFormat.equalsIgnoreCase(actualFormat)) {
                    throw new IllegalArgumentException(
                            "이미지 확장자와 실제 형식이 다릅니다.");
                }

                long width = reader.getWidth(0);
                long height = reader.getHeight(0);

                if (width <= 0 || height <= 0
                        || width * height > 25_000_000L) {
                    throw new IllegalArgumentException(
                            "이미지는 2,500만 픽셀 이하여야 합니다.");
                }
            } finally {
                reader.dispose();
            }
        }
    }
}