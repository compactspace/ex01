package kr.happyjob.study.managepost.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.managepost.dao.ManagepostDao;
import kr.happyjob.study.managepost.model.ManagepostModel;

@Service
public class ManagepostServiceImpl implements ManagepostService {
	
	@Autowired
	private ManagepostDao managepostDao;
	
	@Value("${fileUpload.postPath}")
	private String postPath;

	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;	

	//공고 상세
	@Override
	public ManagepostModel managePostDetail(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return managepostDao.managePostDetail(paramMap);
	}


	//폼 형식일 때
	 @Override
	public int updateAppStatus(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		// TODO Auto-generated method stub
		return managepostDao.updateAppStatus(paramMap);
	}
	 
	 //폼 형식이 아닐 때
	 @Override
	public int updateAppStatus(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return managepostDao.updateAppStatus(paramMap);
	}
	 
	 //보류 공고 모음
	 @Override
	public List<ManagepostModel> getPendingList(Map<String, Object> paramMap) {
		return managepostDao.getPendingList(paramMap);
	}
	 @Override
	public int pendingPostListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return managepostDao.pendingpostListCnt(paramMap);
	}
	
	 //승인 공고 모음
	 @Override
	public List<ManagepostModel> getApprovalList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return managepostDao.getApprovalList(paramMap);
	}
	 @Override
	public int approvalPostListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return managepostDao.approvalPostListCnt(paramMap);
	}
	 
	 
	///////////////////////////////
	////////////2024.11////////////
	////////////TO   BE////////////
	///////////////////////////////
	 
	@Override
	public ManagepostModel managePostDetailSearchByPostIdx(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return managepostDao.managePostDetailSearchByPostIdx(paramMap);
	}
		
}

