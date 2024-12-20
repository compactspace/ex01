package kr.happyjob.study.managehire.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.LogManager;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.managehire.dao.ApplicantDao;
import kr.happyjob.study.managepost.dao.ManagepostDao;
import kr.happyjob.study.managepost.model.ApplicantModel;
import kr.happyjob.study.managepost.model.ManagepostModel;


@Service
public class ApplicantServiceImpl implements ApplicantService{
	
	 private final Logger logger = LogManager.getLogger(this.getClass());

	   private final String className = this.getClass().toString();
	   
	   @Autowired
	   private ApplicantDao applicantDao;
	   
	   @Override
	   public List<ApplicantModel> applicantList(@RequestParam Map<String,Object> paramMap) throws Exception{
		   return applicantDao.applicantList(paramMap);
	   }
	   
	   @Override
	   public int applicantCount(@RequestParam Map<String,Object> paramMap) throws Exception{
		   return applicantDao.applicantCount(paramMap);
	   }
	   
	   @Override
	   public int statusUpdate(@RequestParam Map<String,Object> paramMap) throws Exception{
 	       int result = applicantDao.statusUpdate(paramMap);
 	       
 	       if (result == 0) {
 	           logger.warn("업데이트할 내용이 없습니다.");
 	       } else {
 	           logger.info("수정되었습니다.");
 	       }
 		   return result; 
	   }
	   // 지원완료를 서류심사중 으로 바꿔줌
	   @Override
	   public int statusUpdateStart(int postIdx) throws Exception{
		   int result = applicantDao.statusUpdateStart(postIdx);
		   
		   return result; 
	   }
	   
	   @Override
	   public int statusUpdateStartRest(@Param("postIdx") int postIdx,@Param("firstProc") String firstProc) throws Exception{
		   int result = applicantDao.statusUpdateStartRest(postIdx,firstProc);
		   
		   return result; 
	   }
	   
	   
	   @Override
	   public int viewUpdate(@RequestParam Map<String,Object> paramMap) throws Exception{
		   int result = applicantDao.viewUpdate(paramMap);
		   
		   if (result == 0) {
			   logger.warn("업데이트할 내용이 없습니다.");
		   } else {
			   logger.info("수정되었습니다.");
		   }
		   return result; 
	   }

	@Override
	public String hiringProcSerch(int postingId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public List<ApplicantModel> managehireDetailBiz(int bizIdx) throws Exception{
		return applicantDao.managehireDetailBiz(bizIdx);
	}
	
}
