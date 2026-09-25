package com.devstudy.vo;

import java.time.LocalDateTime;

public class BoardFileVO {

    private Long fileIdx;
    private Integer boardIdx;
    private String originalName;
    private String storedName;
    private Long fileSize;
    public Long getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(Long fileIdx) {
		this.fileIdx = fileIdx;
	}
	public Integer getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(Integer boardIdx) {
		this.boardIdx = boardIdx;
	}
	public String getOriginalName() {
		return originalName;
	}
	public void setOriginalName(String originalName) {
		this.originalName = originalName;
	}
	public String getStoredName() {
		return storedName;
	}
	public void setStoredName(String storedName) {
		this.storedName = storedName;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	private String contentType;
    private LocalDateTime createdAt;

}