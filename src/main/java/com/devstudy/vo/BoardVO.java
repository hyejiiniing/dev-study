package com.devstudy.vo;

import java.time.LocalDateTime;

public class BoardVO  {
	
	private Integer boardIdx;
    private Integer boardType;
    private String category;
    private Long memberIdx;
    private String title;
    private String content;
    private Integer viewCount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    private String searchType = "all";
    private String keyword = "";
    private int page = 1;
    private final int pageSize = 10;
    
	public Integer getBoardIdx() {
		return boardIdx;
	}
	public void setBoardIdx(Integer boardIdx) {
		this.boardIdx = boardIdx;
	}
	public Integer getBoardType() {
		return boardType;
	}
	public void setBoardType(Integer boardType) {
		this.boardType = boardType;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Long getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(Long memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getViewCount() {
		return viewCount;
	}
	public void setViewCount(Integer viewCount) {
		this.viewCount = viewCount;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
	public String getSearchType() {
	    return searchType;
	}

	public void setSearchType(String searchType) {
	    this.searchType = searchType;
	}

	public String getKeyword() {
	    return keyword;
	}

	public void setKeyword(String keyword) {
	    this.keyword = keyword;
	}

	public int getPage() {
	    return page;
	}

	public void setPage(int page) {
	    this.page = page;
	}

	public int getPageSize() {
	    return pageSize;
	}

	public long getOffset() {
	    return ((long) page - 1) * pageSize;
	}

	public String getSearchPattern() {
	    String value = keyword == null ? "" : keyword;

	    return "%" + value.replace("!", "!!")
	                      .replace("%", "!%")
	                      .replace("_", "!_") + "%";
	}
    
}