package kr.happyjob.study.board.model;

public class NoticeModel {
	@Override
	public String toString() {
		return "NoticeModel [noticeIdx=" + noticeIdx + ", title=" + title + ", content=" + content + ", author="
				+ author + ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", fileName=" + fileName
				+ ", phsycalPath=" + phsycalPath + ", logicalPath=" + logicalPath + ", fileSize=" + fileSize
				+ ", fileExt=" + fileExt + "]";
	}

	private int noticeIdx;
	private String title;
	private String content;
	private String author;
	private String createdDate;
	private String updatedDate;
	private String fileName;
	private String phsycalPath;
	private String logicalPath;
	private int fileSize;
	private String fileExt;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getPhsycalPath() {
		return phsycalPath;
	}

	public void setPhsycalPath(String phsycalPath) {
		this.phsycalPath = phsycalPath;
	}

	public String getLogicalPath() {
		return logicalPath;
	}

	public void setLogicalPath(String logicalPath) {
		this.logicalPath = logicalPath;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public int getNoticeIdx() {
		return noticeIdx;
	}

	public void setNoticeIdx(int noticeIdx) {
		this.noticeIdx = noticeIdx;
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

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
	}

	public String getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(String updatedDate) {
		this.updatedDate = updatedDate;
	}

}
