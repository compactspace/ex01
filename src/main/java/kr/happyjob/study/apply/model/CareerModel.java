package kr.happyjob.study.apply.model;

import java.sql.Date;

public class CareerModel {
	private int crrIdx;
	private String company;
	private String dept;
	private String position;
	private Date startDate;
	private Date endDate;
	private String reason;
	private String crrDesc;
	private int resIdx;
	public int getCrrIdx() {
		return crrIdx;
	}
	public void setCrrIdx(int crrIdx) {
		this.crrIdx = crrIdx;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getCrrDesc() {
		return crrDesc;
	}
	public void setCrrDesc(String crrDesc) {
		this.crrDesc = crrDesc;
	}
	public int getResIdx() {
		return resIdx;
	}
	public void setResIdx(int resIdx) {
		this.resIdx = resIdx;
	}
	
	
	
	
}
