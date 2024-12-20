package kr.happyjob.study.manageuser.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.manageuser.model.ManageuserModel;

public interface ManageuserDao {
	
	List<ManageuserModel> applicantList(Map<String, Object> paramMap) throws Exception;
	
	List<ManageuserModel> bizList(Map<String, Object> paramMap) throws Exception;
	
	int applicantListCnt(Map<String, Object> paramMap) throws Exception;
	
	int bizListCnt(Map<String, Object> paramMap) throws Exception;
	
	ManageuserModel applicantManageDetail(Map<String, Object> paramMap) throws Exception;
	
	int applicantPwReset(Map<String, Object> paramMap) throws Exception;
	
	//1234 해시화해서 비밀번호로 저장함으로써 초기화
	int applicantPwResetTo1234(Map<String, Object> paramMap) throws Exception;
	
	int applicantInfoUpdate(Map<String, Object> paramMap) throws Exception;
	
	ManageuserModel bizManageDetail(Map<String, Object> paramMap) throws Exception;
	
	int bizInfoUpdate(Map<String, Object> paramMap) throws Exception;

}
