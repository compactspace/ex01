package kr.happyjob.study.managepost.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.managepost.model.ManagepostModel;

public interface ManagepostService {

	int updateAppStatus(Map<String, Object> paramMap, HttpServletRequest req) throws Exception;

	ManagepostModel managePostDetail(Map<String, Object> paramMap) throws Exception;
	
	
	int updateAppStatus(Map<String, Object> paramMap)throws Exception;

	//보류 공고 모음
	public List<ManagepostModel> getPendingList(Map<String, Object> paramMap)throws Exception;	
	int pendingPostListCnt(Map<String, Object> paramMap) throws Exception;
	
	//승인 공고 모음
    public List<ManagepostModel> getApprovalList(Map<String, Object> paramMap)throws Exception;
	int approvalPostListCnt(Map<String, Object> paramMap) throws Exception;
	
	///////////////////////////////
	////////////2024.11////////////
	////////////TO   BE////////////
	///////////////////////////////
	
	ManagepostModel managePostDetailSearchByPostIdx(Map<String, Object> paramMap) throws Exception;

}
