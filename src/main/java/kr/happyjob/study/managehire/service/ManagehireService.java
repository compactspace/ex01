package kr.happyjob.study.managehire.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.managehire.model.NewPostModel;
import kr.happyjob.study.managepost.model.ManagepostModel;

public interface ManagehireService {
	// -------------------- AS-IS --------------------
	// Original code goes here
	
	// 공고list
	List<ManagepostModel> managehireList(@RequestParam Map<String, Object> paramMap) throws Exception;
	// 공고listCount
	int managehireCount(@RequestParam Map<String, Object> paramMap) throws Exception;
	// 공고 detail
	ManagepostModel managehireDetail(Map<String, Object> paramMap) throws Exception;
	// 공고 수정
	int managehireUpdate(@RequestParam Map<String, Object> paramMap, int bizIdx, HttpServletRequest req)
			throws Exception;
	// 공고등록
	int managehireSave(@RequestParam Map<String, Object> paramMap, HttpServletRequest req) throws Exception;
	// 공고삭제
	int managehireDelete(@RequestParam Map<String, Object> paramMap) throws Exception;
	// 채용담당자가 회사를등록했는지 확인
	int companyCkId(@Param("loginId") String loginId) throws Exception;
	// fk(회사등록 고유값 가져옴
	int managehireCkIndex(String loginId) throws Exception;

	
	
	// -------------------- TO-BE (2024-11) --------------------
	// Transitioned code as of 2024-11
	
	// 공고등록 
	int createHirePost(Map<String, Object> text, MultipartFile[] files) throws Exception;
	// 공고리스트조회 
	List<ManagepostModel> getHirePostListByLoginId(Map<String, Object> paramMap) throws Exception;
	
	int getBizIdxByLoginId(String loginId) throws Exception;
	
	int updateHirePost(Map<String, Object> text, MultipartFile[] files) throws Exception;
	// 파일삭제
	int delelteAttachment(Map<String, Object> paramMap) throws Exception;
}