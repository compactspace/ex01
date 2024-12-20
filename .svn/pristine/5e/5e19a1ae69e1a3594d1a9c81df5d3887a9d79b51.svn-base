package kr.happyjob.study.managehire.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.managepost.model.ApplicantModel;
import kr.happyjob.study.managepost.model.ManagepostModel;


public interface ApplicantDao {
	List<ApplicantModel> applicantList(@RequestParam Map<String,Object> paramMap) throws Exception;
	int applicantCount(@RequestParam Map<String,Object> paramMap) throws Exception;
	int statusUpdate(@RequestParam Map<String,Object> paramMap) throws Exception; // 지원자가 합격과 불합격을 받을경우 status수정
	int viewUpdate(@RequestParam Map<String,Object> paramMap) throws Exception; // 담당자가 이력서를 확인할경우 1로 수정
	int statusUpdateStart(int postIdx) throws Exception; // 초기 지원자의 status를 지원완료에서 서류심사중으로 수정
	int statusUpdateStartRest(@Param("postIdx") int postIdx,@Param("firstProc") String firstProc) throws Exception;
	List<ApplicantModel> managehireDetailBiz(int bizIdx) throws Exception; 
	
	//String hiringProcSerch(int postingId)throws Exception;
}
