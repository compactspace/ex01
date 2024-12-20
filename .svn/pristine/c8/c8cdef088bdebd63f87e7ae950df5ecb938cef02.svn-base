package kr.happyjob.study.jobs.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.jobs.model.ApplyModel;



public interface ApplyService {
	
	int saveApply(Map<String, Object> paramMap) throws Exception;
    
	// 입사지원 디테일이 아니라 입사지원 화면에 출력할 페이지 디테일
	//기업정보-기업 이름/공고정보-공고 이름
	ApplyModel ApplyBizPostDetail (Map<String, Object> paramMap) throws Exception;
		
	//사용자 정보-사용자 아이디, 이메일, 핸드폰 번호/이력서 정보-이력서 번호, 이력서 제목
	List<ApplyModel> ApplyUserResumeDetail(Map<String, Object> paramMap) throws Exception;

	ApplyModel selectApplyExist(Map<String, Object> paramMap) throws Exception;
	
	// to-be //
	
	int getUserIdxByLoginId(String loginId) throws Exception;
}
