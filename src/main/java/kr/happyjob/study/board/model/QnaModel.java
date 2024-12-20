package kr.happyjob.study.board.model;

public class QnaModel {
	private int qnaIdx;
	private String title;
	private String content;
	private String author;
	private String createdDate;
	private String updatedDate;
	private String password;
	private String fileName;
	private String phsycalPath;
	private String logicalPath;
	private int fileSize;
	private String fileExt;
	private String qna_type;
	private String ans_content;
	@Override
	public String toString() {
		return "QnaModel [qnaIdx=" + qnaIdx + ", title=" + title + ", content=" + content + ", author=" + author
				+ ", createdDate=" + createdDate + ", updatedDate=" + updatedDate + ", password=" + password
				+ ", fileName=" + fileName + ", phsycalPath=" + phsycalPath + ", logicalPath=" + logicalPath
				+ ", fileSize=" + fileSize + ", fileExt=" + fileExt + ", qna_type=" + qna_type + ", ans_content="
				+ ans_content + ", ans_date=" + ans_date + "]";
	}
	private String ans_date;
	
	public String getAns_content() {
		return ans_content;
	}
	public void setAns_content(String ans_content) {
		this.ans_content = ans_content;
	}
	public String getAns_date() {
		return ans_date;
	}
	public void setAns_date(String ans_date) {
		this.ans_date = ans_date;
	}
	public String getQna_type() {
		return qna_type;
	}
	public void setQna_type(String qna_type) {
		this.qna_type = qna_type;
	}
	public int getQnaIdx() {
		return qnaIdx;
	}
	public void setQnaIdx(int qnaIdx) {
		this.qnaIdx = qnaIdx;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
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
}
