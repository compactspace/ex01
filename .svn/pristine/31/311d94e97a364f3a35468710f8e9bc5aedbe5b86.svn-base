package kr.happyjob.study.mypage.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.happyjob.study.mypage.model.MypageModel;

public interface MypageDao {
	
	MypageModel getUserInfo(Map<String, Object> paramMap) throws Exception;
	
	int updateUserInfo(Map<String, Object> paramMap) throws Exception;
	
	int updatePasswd(Map<String, Object> paramMap) throws Exception;
	
	int deleteUser(Map<String, Object> paramMap) throws Exception;
	
	int deleteUser_tobe(Map<String, Object> paramMap) throws Exception;
	
	MypageModel chkRegBiz(Map<String, Object> paramMap) throws Exception;

}
