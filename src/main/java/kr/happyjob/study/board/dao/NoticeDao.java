package kr.happyjob.study.board.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.board.model.NoticeModel;

public interface NoticeDao {
	List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception;

	int noticeListCnt(Map<String, Object> paramMap) throws Exception;

	int saveNotice(Map<String, Object> paramMap) throws Exception;

	int saveFileNoticeForm(Map<String, Object> paramMap) throws Exception;

	int updateNotice(Map<String, Object> paramMap) throws Exception;

	int deleteNotice(Map<String, Object> paramMap) throws Exception;

	NoticeModel noticeDetail(Map<String, Object> paramMap) throws Exception;

	NoticeModel noticeDetailFile(Map<String, Object> paramMap) throws Exception;

	int saveFileNotice(Map<String, Object> paramMap) throws Exception;

	int updateFileNotice(Map<String, Object> paramMap) throws Exception;

	int updateFileNoticeForm(Map<String, Object> paramMap) throws Exception;
}
