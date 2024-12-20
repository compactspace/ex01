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

import kr.happyjob.study.board.dao.QnaDao;
import kr.happyjob.study.board.model.QnaModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.common.comnUtils.FileUtilMultipartFile;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaDao qnaDao;

	@Value("${fileUpload.qnaPath}")
	private String qnaPath;

	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;

	@Override
	public List<QnaModel> qnaList(Map<String, Object> paramMap) throws Exception {
		return qnaDao.qnaList(paramMap);
	}
	
	@Override
	public List<QnaModel> qnaMyList(Map<String, Object> paramMap) throws Exception {
		return qnaDao.qnaMyList(paramMap);
	}

	@Override
	public int qnaListCnt(Map<String, Object> paramMap) throws Exception {
		return qnaDao.qnaListCnt(paramMap);
	}

	@Override
	public int deleteQna(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.deleteQna(paramMap);
	}

	@Override
	public int saveFileQna(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;

        String itemFilePath = qnaPath + File.separator;

        FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);

        Map<String, Object> fileInfo = fileUpload.uploadFiles();

        if (fileInfo.get("file_nm") == null) {
            paramMap.put("fileYn", "N");
            paramMap.put("fileInfo", null);
        } else {
            paramMap.put("fileYn", "Y");
            paramMap.put("fileInfo", fileInfo);
        }
        return qnaDao.saveFileQna(paramMap);
	}

	@Override
	public QnaModel qnaDetailFile(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return qnaDao.qnaDetailFile(paramMap);
	}

	@Override
	public int updateFileQna(Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		QnaModel getDetail = qnaDao.qnaDetailFile(paramMap);

		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;
		String itemFilePath = qnaPath + File.separator;
		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);

		Map<String, Object> fileInfo = fileUpload.uploadFiles();

		if(fileInfo != null && fileInfo.get("file_nm") != null){
			if (getDetail.getFileName() != null) {
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

		return qnaDao.updateFileQna(paramMap);
	}

	@Override
	public int deleteFileQna(Map<String, Object> paramMap) throws Exception {
		QnaModel getDetail = qnaDao.qnaDetailFile(paramMap);

		if (getDetail.getFileName() != null) {
			File oldFile = new File(getDetail.getPhsycalPath());
			oldFile.delete();
		}
		return qnaDao.deleteQna(paramMap);
	}
	
	@Override
	public int qnaSaveFileForm(MultipartFile[] files, Map<String, Object> paramMap) throws Exception {
		String itemFilePath = qnaPath + File.separator;
		FileUtilMultipartFile fileUpload = new FileUtilMultipartFile(files, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUpload.uploadFiles();

		if (!fileInfo.isEmpty()) {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		} else {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		}
		return qnaDao.saveFileQna(paramMap);
	}
	
	@Override
	public int qnaUpdateFileForm(MultipartFile[] files, Map<String, Object> paramMap) throws Exception {
		QnaModel getDetail = qnaDao.qnaDetailFile(paramMap);
		
		if(getDetail.getFileName() != null){
			File oldFile = new File(getDetail.getPhsycalPath());
			oldFile.delete();
		}
		
		String itemFilePath = qnaPath + File.separator;
		FileUtilMultipartFile fileUpload = new FileUtilMultipartFile(files, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		if(!fileInfo.isEmpty()){
			paramMap.put("fileYn","Y");
			paramMap.put("fileInfo", fileInfo);
		} else {
			paramMap.put("fileYn","N");
			paramMap.put("fileInfo", null);
		}
		return qnaDao.updateFileQnaForm(paramMap);
	}

}