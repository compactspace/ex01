package kr.happyjob.study.login.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.login.model.UserInfoModel;
import kr.happyjob.study.login.model.UsrMnuAtrtModel;
import kr.happyjob.study.login.model.UsrMnuChildAtrtModel;


public interface LoginDao {
	
	/** 사용자 로그인 체크*/
	public String checkLogin(Map<String, Object> paramMap);
	
	/** 사용자 로그인 */
	public LgnInfoModel selectLogin(Map<String, Object> paramMap);
	
	/** 사용자 로그인 - BCrpyt checkpw로 비밀번호 비교 후 loginId 기준으로 userInfo 가져옴 */
	public LgnInfoModel selectLoginInfo(Map<String, Object> paramMap);
	
	/**로그인을 위해 비밀번호 비교를 위해 비밀번호 조회*/
	public String selectPw(Map<String, Object> paramMap);
	
	/**  사용자 메뉴 권한 */
	public List<UsrMnuAtrtModel> listUsrMnuAtrt(Map<String, Object> paramMap);
	
	/**  사용자 자식 메뉴 권한 */
	public List<UsrMnuChildAtrtModel> listUsrChildMnuAtrt(Map<String, Object> paramMap);
	
	/** 사용자 ID 찾기 */
	public String selectFindId(Map<String, Object> paramMap);
	
	/** 사용자 ID Cnt 찾기 */
	public int selectFindIdCnt(Map<String, Object> paramMap);

	/** 사용자 PW 찾기 */
	public LgnInfoModel selectFindPw(Map<String, Object> paramMap);
	
	/** 사용자 PW 찾기 _ as_is */
	public LgnInfoModel selectFindPw_as(Map<String, Object> paramMap);

	/** 사용자 PW Cnt찾기 ID 체크*/
	public int selectFindPwCnt(Map<String, Object> paramMap) throws Exception;

	
	/** 사용자 비밀번호 찾기 비번 바꿔주기 */
	public int updatePw(Map<String, Object> paramMap) throws Exception;
	
	/** 사용자 PW 찾기 ID 체크*/
	public LgnInfoModel registerIdCheck(Map<String, Object> paraMap);

	/** 사용자 회원가입*/
	public int registerUser(Map<String, Object> paramMap);
	
	/** 사용자스킬*/
	public int registerUser_skill(Map<String, Object> paramMap);
	
	/**loginID 중복체크 - 기존 코드*/
	public int check_loginId(UserInfoModel model);

	/**loginID 중복체크*/
	public int check_loginId(Map<String, Object> paramMap);
	
	/**이메일 중복체크*/
	public int check_email(UserInfoModel model);
	
	/**이력서 파일 업로드 */
	public static void insertResume(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		
	}
	
	public static String getDirectory() {
		// TODO Auto-generated method stub
		return null;
	} 
	
	
/*	*//**select박스 은행 목록*//*
	public List<LgnInfoModel> selectBankList();*/
	
}
