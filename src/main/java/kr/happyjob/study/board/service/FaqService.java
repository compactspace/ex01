package kr.happyjob.study.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.board.model.FaqModel;

public interface FaqService {
	List<FaqModel> faqList(Map<String, Object> paramMap) throws Exception;

	int faqListCnt(Map<String, Object> paramMap) throws Exception;

	int saveFaq(Map<String, Object> paramMap) throws Exception;

	int updateFaq(Map<String, Object> paramMap) throws Exception;

	int deleteFaq(Map<String, Object> paramMap) throws Exception;

	FaqModel faqDetail(Map<String, Object> paramMap) throws Exception;
}
