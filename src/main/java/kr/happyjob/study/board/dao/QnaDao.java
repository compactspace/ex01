package kr.happyjob.study.board.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.board.model.QnaModel;

public interface QnaDao {
	List<QnaModel> qnaList(Map<String, Object> paramMap) throws Exception;
	
	List<QnaModel> qnaMyList(Map<String, Object> paramMap) throws Exception;

	int qnaListCnt(Map<String, Object> paramMap) throws Exception;

	int deleteQna(Map<String, Object> paramMap) throws Exception;

	QnaModel qnaDetailFile(Map<String, Object> paramMap) throws Exception;

	int saveFileQna(Map<String, Object> paramMap) throws Exception;

	int updateFileQna(Map<String, Object> paramMap) throws Exception;
	
	int updateFileQnaForm(Map<String, Object> paramMap) throws Exception;
}
