package kr.happyjob.study.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.board.model.NoticeModel;

public interface NoticeService {
	List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception;

	int noticeListCnt(Map<String, Object> paramMap) throws Exception;

	int saveNotice(Map<String, Object> paramMap) throws Exception;

	int updateNotice(Map<String, Object> paramMap) throws Exception;

	int deleteNotice(Map<String, Object> paramMap) throws Exception;

	NoticeModel noticeDetail(Map<String, Object> paramMap) throws Exception;

	NoticeModel noticeDetailFile(Map<String, Object> paramMap) throws Exception;

	int saveFileNotice(Map<String, Object> paramMap, HttpServletRequest req) throws Exception;

	int updateFileNotice(Map<String, Object> paramMap, HttpServletRequest req) throws Exception;

	int deleteFileNotice(Map<String, Object> paramMap) throws Exception;

	int noticeSaveFileForm(MultipartFile[] files, Map<String, Object> text) throws Exception;

	int noticeUpdateFileForm(MultipartFile[] files, Map<String, Object> text) throws Exception;
}
