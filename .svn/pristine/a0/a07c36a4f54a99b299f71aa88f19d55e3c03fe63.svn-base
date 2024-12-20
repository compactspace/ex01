package kr.happyjob.study.managepost.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.managepost.model.ManagepostModel;

public interface ManagepostDao {
	
	//보류 공고 모음
	public List<ManagepostModel> getPendingList(Map<String, Object> paramMap);
	int pendingpostListCnt(Map<String, Object> paramMap) throws Exception;

	//승인 공고 모음
    public List<ManagepostModel> getApprovalList(Map<String, Object> paramMap);
	int approvalPostListCnt(Map<String, Object> paramMap) throws Exception;
	
	//공고 상세
	ManagepostModel managePostDetail(Map<String, Object> paramMap) throws Exception;
	
	//승인/불허 처리
	int updateAppStatus(Map<String, Object> paramMap) throws Exception;
	
	
	///////////////////////////////
	////////////2024.11////////////
	////////////TO   BE////////////
	///////////////////////////////
	
	ManagepostModel managePostDetailSearchByPostIdx(Map<String, Object> paramMap) throws Exception;

}
