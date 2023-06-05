package com.danim.model;

import java.util.Date;

public class ReviewListVO {
	private int num;
	private String title;
	private String content;
	private String writer;
	private Date insertDate;
	private int viewCount;
	private int doId;
	private int goodCount;
	private String filename;
	private int userId;
	private int commentCount;
	
	public ReviewListVO() {
		
	}
	
	public ReviewListVO(int num, String title, String content, String writer, Date insertDate, int viewCount, int doId, int goodCount, String filename, int userId, int commentCount) {
		this.num = num;
		this.title = title;
		this.content = content;
		this.writer = writer;
		this.insertDate = insertDate;
		this.viewCount = viewCount;
		this.doId = doId;
		this.goodCount = goodCount;
		this.filename = filename;
		this.userId = userId;
		this.commentCount = commentCount;
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public int getDoId() {
		return doId;
	}
	public void setDoId(int doId) {
		this.doId = doId;
	}
	public int getGoodCount() {
		return goodCount;
	}
	public void setGoodCount(int goodCount) {
		this.goodCount = goodCount;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
}