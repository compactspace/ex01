package kr.happyjob.study.apply.model;

import java.sql.Date;

public class EducationModel {
	private int eduIdx;
	private int resIdx;
	private String eduLevel;
	private String schoolName;
	private String major;
	private Date admDate;
	private Date grdDate;
	private String grdStatus;
	public int getEduIdx() {
		return eduIdx;
	}
	public void setEduIdx(int eduIdx) {
		this.eduIdx = eduIdx;
	}
	public int getResIdx() {
		return resIdx;
	}
	public void setResIdx(int resIdx) {
		this.resIdx = resIdx;
	}
	public String getEduLevel() {
		return eduLevel;
	}
	public void setEduLevel(String eduLevel) {
		this.eduLevel = eduLevel;
	}
	public String getSchoolName() {
		return schoolName;
	}
	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public Date getAdmDate() {
		return admDate;
	}
	public void setAdmDate(Date admDate) {
		this.admDate = admDate;
	}
	public Date getGrdDate() {
		return grdDate;
	}
	public void setGrdDate(Date grdDate) {
		this.grdDate = grdDate;
	}
	public String getGrdStatus() {
		return grdStatus;
	}
	public void setGrdStatus(String grdStatus) {
		this.grdStatus = grdStatus;
	}
	
	

}
