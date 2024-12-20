package kr.happyjob.study.board.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.board.dao.NoticeDao;
import kr.happyjob.study.board.model.NoticeModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.common.comnUtils.FileUtilMultipartFile;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;

	@Value("${fileUpload.noticePath}")
	private String noticePath;

	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;

	@Override
	public List<NoticeModel> noticeList(Map<String, Object> paramMap) throws Exception {
		return noticeDao.noticeList(paramMap);
	}

	@Override
	public int noticeListCnt(Map<String, Object> paramMap) throws Exception {
		return noticeDao.noticeListCnt(paramMap);
	}

	@Override
	public int saveNotice(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return noticeDao.saveNotice(paramMap);
	}

	@Override
	public NoticeModel noticeDetail(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return noticeDao.noticeDetailFile(paramMap);
	}

	@Override
	public int updateNotice(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return noticeDao.updateNotice(paramMap);
	}

	@Override
	public int deleteNotice(Map<String, Object> paramMap) throws Exception {

		NoticeModel getDetail = noticeDao.noticeDetailFile(paramMap);

		if (getDetail.getFileName() != null) {
			File oldFile = new File(getDetail.getPhsycalPath());
			oldFile.delete();
		}

		return noticeDao.deleteNotice(paramMap);
	}

	@Override
	public int saveFileNotice(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;

		String itemFilePath = noticePath + File.separator;

		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);

		Map<String, Object> fileInfo = fileUpload.uploadFiles();

		if (fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}

		return noticeDao.saveFileNotice(paramMap);
	}

	@Override
	public NoticeModel noticeDetailFile(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return noticeDao.noticeDetailFile(paramMap);
	}

	@Override
	public int updateFileNotice(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		NoticeModel getDetail = noticeDao.noticeDetailFile(paramMap);
		System.out.println("Notice File getDetail::::::::::::::::::::::::::" + getDetail);

		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;
		String itemFilePath = noticePath + File.separator;
		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);

		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		System.out.println("Notice File fileInfo::::::::::::::::::::::::::" + fileInfo);

		if (fileInfo != null && fileInfo.get("file_nm") != null) {
			if (getDetail.getFileName() != null && !(getDetail.getFileName().equals(fileInfo.get("file_nm")))) {
				File oldFile = new File(getDetail.getPhsycalPath());
				oldFile.delete();
			}
		}

		if (fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}

		return noticeDao.updateFileNotice(paramMap);
	}

	@Override
	public int deleteFileNotice(Map<String, Object> paramMap) throws Exception {
		NoticeModel getDetail = noticeDao.noticeDetailFile(paramMap);

		if (getDetail.getFileName() != null) {
			File oldFile = new File(getDetail.getPhsycalPath());
			oldFile.delete();
		}
		return noticeDao.deleteNotice(paramMap);
	}
	
	@Override
	public int noticeSaveFileForm(MultipartFile[] files, Map<String, Object> paramMap) throws Exception {
		String itemFilePath = noticePath + File.separator;
		FileUtilMultipartFile fileUpload = new FileUtilMultipartFile(files, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		if (!fileInfo.isEmpty()) {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		} else {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		}

		return noticeDao.saveFileNoticeForm(paramMap);
	}

	@Override
	public int noticeUpdateFileForm(MultipartFile[] files, Map<String, Object> paramMap) throws Exception {
		NoticeModel getDetail = noticeDao.noticeDetailFile(paramMap);

		if (getDetail.getFileName() != null) {
			File oldFile = new File(getDetail.getPhsycalPath());
			oldFile.delete();
		}

		String itemFilePath = noticePath + File.separator;
		FileUtilMultipartFile fileUpload = new FileUtilMultipartFile(files, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		if (!fileInfo.isEmpty()) {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		} else {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		}
		return noticeDao.updateFileNoticeForm(paramMap);
	}

}
