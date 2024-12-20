package kr.happyjob.study.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.board.model.QnaModel;

public interface QnaService {
	List<QnaModel> qnaList(Map<String, Object> paramMap) throws Exception;
	
	List<QnaModel> qnaMyList(Map<String, Object> paramMap) throws Exception;

	int qnaListCnt(Map<String, Object> paramMap) throws Exception;

	int deleteQna(Map<String, Object> paramMap) throws Exception;

	QnaModel qnaDetailFile(Map<String, Object> paramMap) throws Exception;

	int saveFileQna(Map<String, Object> paramMap, HttpServletRequest req) throws Exception;

	int updateFileQna(Map<String, Object> paramMap, HttpServletRequest req) throws Exception;

	int deleteFileQna(Map<String, Object> paramMap) throws Exception;
	
	int qnaSaveFileForm(MultipartFile[] files, Map<String, Object> text) throws Exception;
	
	int qnaUpdateFileForm(MultipartFile[] files, Map<String, Object> text) throws Exception;
}
