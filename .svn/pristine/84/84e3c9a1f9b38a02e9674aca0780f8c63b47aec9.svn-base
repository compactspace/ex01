package kr.happyjob.study.managehire.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.managehire.model.NewPostModel;
import kr.happyjob.study.managepost.model.ApplicantModel;
import kr.happyjob.study.managepost.model.ManagepostModel;

public interface ManagehireDao {

	// -------------------- AS-IS --------------------
	// Original code goes here

	// 공고list
	List<ManagepostModel> managehireList(@RequestParam Map<String, Object> paramMap) throws Exception;

	// 공고listCount
	int managehireCount(@RequestParam Map<String, Object> paramMap) throws Exception;

	// 공고detail
	ManagepostModel managehireDetail(Map<String, Object> paramMap) throws Exception;

	// 공고수정
	int managehireUpdate(@RequestParam Map<String, Object> paramMap) throws Exception;

	// 채용공고 저장
	int managehireSave(@RequestParam Map<String, Object> paramMap) throws Exception;

	// 공고삭제
	int managehireDelete(@RequestParam Map<String, Object> paramMap) throws Exception;

	// 공고를 삭제하기 위해 스크랩 삭제
	int deleteAllScrap(int postIdx) throws Exception;

	// 공고를 삭제하기 위해 지원자관리 삭제
	int deleteAllApply(int postIdx) throws Exception;

	
	
	// -------------------- TO-BE (2024-11) --------------------
	// Transitioned code as of 2024-11

	// 공고리스트조회
	List<ManagepostModel> getHirePostListByLoginId(Map<String, Object> paramMap) throws Exception;

	int createHirePost(@RequestParam Map<String, Object> paramMap)throws Exception;
	
	int findBizIdxByLoginId(String LoginId)throws Exception;

	int updateHirePost(@RequestParam Map<String, Object> paramMa)throws Exception;
	
	

}
