package kr.happyjob.study.jobs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.jobs.dao.ApplyDao;
import kr.happyjob.study.jobs.model.ApplyModel;


@Service
public class ApplyServiceImpl implements ApplyService {
   
	@Autowired
	private ApplyDao applyDao;
	
	@Override
	public int saveApply(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return applyDao.saveApply(paramMap);
	}
	
	//// 입사지원 디테일이 아니라 입사지원 화면에 출력할 페이지 디테일
	//기업정보-기업 이름/공고정보-공고 이름
	@Override
	public ApplyModel ApplyBizPostDetail(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return applyDao.ApplyBizPostDetail(paramMap);
	}
	
	//사용자 정보-사용자 아이디, 이메일, 핸드폰 번호/이력서 정보-이력서 번호, 이력서 제목
	@Override
	public List<ApplyModel> ApplyUserResumeDetail(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return applyDao.ApplyUserResumeDetail(paramMap);
	}
	
	@Override
	public ApplyModel selectApplyExist(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return applyDao.selectApplyExist(paramMap);
	}

	@Override
	public int getUserIdxByLoginId(String loginId) throws Exception{
	    return applyDao.getUserIdxByLoginId(loginId);
	}
	
	
}
