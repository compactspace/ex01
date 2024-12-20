package kr.happyjob.study.company.model;

public class CompanyModel {
	
	private int bizIdx; // 회사번호(pk)
	private String bizName; //사업자명
	private String bizAddr; //사업자주소
	private String bizContact; //사업자연락쳐
	private String bizWebUrl; //홈페이지주소	
	private String bizCeoName; //대표이름
	private String bizFoundDate; //설립일	
	private String bizIntro; //사업자소개	
	private String bizEmpCount; //사원수	
	private String bizRevenue; //매출액	
	private String bizLogo; //기업로고	
	private String loginId; //회원아이디
	private String phsycalPath;
	private String logicalPath;
	private int fileSize;
	private String fileExt; 
	
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

	
	public int getBizIdx() {
		return bizIdx;
	}
	public void setBizIdx(int bizIdx) {
		this.bizIdx = bizIdx;
	}
	public String getBizName() {
		return bizName;
	}
	public void setBizName(String bizName) {
		this.bizName = bizName;
	}
	public String getBizAddr() {
		return bizAddr;
	}
	public void setBizAddr(String bizAddr) {
		this.bizAddr = bizAddr;
	}
	public String getBizContact() {
		return bizContact;
	}
	public void setBizContact(String bizContact) {
		this.bizContact = bizContact;
	}
	public String getBizWebUrl() {
		return bizWebUrl;
	}
	public void setBizWebUrl(String bizWebUrl) {
		this.bizWebUrl = bizWebUrl;
	}
	public String getBizCeoName() {
		return bizCeoName;
	}
	public void setBizCeoName(String bizCeoName) {
		this.bizCeoName = bizCeoName;
	}
	public String getBizFoundDate() {
		return bizFoundDate;
	}
	public void setBizFoundDate(String bizFoundDate) {
		this.bizFoundDate = bizFoundDate;
	}
	public String getBizIntro() {
		return bizIntro;
	}
	public void setBizIntro(String bizIntro) {
		this.bizIntro = bizIntro;
	}
	public String getBizEmpCount() {
		return bizEmpCount;
	}
	public void setBizEmpCount(String bizEmpCount) {
		this.bizEmpCount = bizEmpCount;
	}
	public String getBizRevenue() {
		return bizRevenue;
	}
	public void setBizRevenue(String bizRevenue) {
		this.bizRevenue = bizRevenue;
	}
	public String getBizLogo() {
		return bizLogo;
	}
	public void setBizLogo(String bizLogo) {
		this.bizLogo = bizLogo;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
}
