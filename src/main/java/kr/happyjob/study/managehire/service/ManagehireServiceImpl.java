package kr.happyjob.study.managehire.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.common.comnUtils.FileUtilMultipartFile;
import kr.happyjob.study.company.dao.CompanyDao;
import kr.happyjob.study.managehire.dao.ManagehireDao;
import kr.happyjob.study.managepost.model.ManagepostModel;

@Service
public class ManagehireServiceImpl implements ManagehireService {
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

//	// Get class name for logger
//	private final String className = this.getClass().toString();

	@Value("${fileUpload.managehirePath}")
	private String managehirePath;

	@Value("${fileUpload.rootPath}")
	private String rootPath;

	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;

	@Autowired
	private ManagehireDao managehireDao;
	@Autowired
	private CompanyDao companyDao;

	
	// -------------------- AS-IS --------------------
	// Original code goes here

	// 공고list
	public List<ManagepostModel> managehireList(@RequestParam Map<String, Object> paramMap) throws Exception {
		return managehireDao.managehireList(paramMap);
	}

	// 공고listCount
	public int managehireCount(@RequestParam Map<String, Object> paramMap) throws Exception {
		return managehireDao.managehireCount(paramMap);
	}

	// 채용공고 저장
	@Override
	public int managehireSave(@RequestParam Map<String, Object> paramMap, HttpServletRequest req) throws Exception {
		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req; // 여러개
																					// 파일할때도
																					// 사용가능
		String itemFilePath = managehirePath + File.separator;
		logger.info("service itemFilePath ==" + itemFilePath);
		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath); // 파일업로드를
		logger.info("service fileUpload ==" + fileUpload);

		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		logger.info("service fileInfo ==" + fileInfo);

		logger.info("service file_nm ==" + fileInfo.get("file_nm"));
		if (fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}
		return managehireDao.managehireSave(paramMap);
	}

	// 채용담당자가 회사를 등록했는지 안했는지 와 공고등록 체크
	@Override
	public int companyCkId(@Param("loginId") String loginId) throws Exception {
		// 채용관리자(회원이) 회사를 등록했는지 체크
		// 테이블에 아이디가 검색이 되면 존재
		String BdId = companyDao.companyCkId(loginId); // 회사db
		logger.info("BdId....." + BdId);
		// 채용관리자(회원이) 공고를 등록했는지 체크
		// 테이블에 회사index가 검색이 되면 존재
		int BizIndex = companyDao.companyGetIndex(loginId); // BizIndex 를 꺼내옴
		if (BdId == null || BdId.isEmpty()) {
			return 0; // 회사가 등록되지 않은 경우
		} else {
			return BizIndex;
		}

	}

	@Override
	public int managehireUpdate(@RequestParam Map<String, Object> paramMap, int bizIdx, HttpServletRequest req)
			throws Exception {

		// 1. 기존 회사 정보 조회
		ManagepostModel getDetailId = managehireDao.managehireDetail(paramMap);

		// 2. 기존 로고 파일이 있을 경우 삭제
		if (getDetailId != null && getDetailId.getFileName() != null) {
			File oldFile = new File(getDetailId.getPhsycalPath());
			if (oldFile.exists() && !oldFile.delete()) {
				throw new IOException("기존 로고 파일 삭제 실패: " + oldFile.getAbsolutePath());
			}
		}

		// 3. 파일 업로드 처리
		MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req;
		String itemFilePath = managehirePath + File.separator;

		FileUtilCho fileUpload = new FileUtilCho(multiFile, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUpload.uploadFiles();

		// 4. 파일 정보에 따른 paramMap 설정
		if (fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}

		// 5. 공고 정보 업데이트 실행 및 반환 값 처리
		int result = managehireDao.managehireUpdate(paramMap);

		if (result == 0) {
			logger.warn("업데이트할 내용이 없습니다.");
		} else {
			logger.info("공고가 성공적으로 업데이트되었습니다.");
		}
		return result;
	}

	// 공고삭제
	@Override
	public int managehireDelete(@RequestParam Map<String, Object> paramMap) throws Exception {
		// 1. 기존 회사 정보 조회
		ManagepostModel getDetailId = managehireDao.managehireDetail(paramMap);
		int postIdx = getDetailId.getPostIdx();
		// 2. 기존 로고 파일이 있을 경우 삭제
		if (getDetailId != null && getDetailId.getFileName() != null) {
			File oldFile = new File(getDetailId.getPhsycalPath());
			if (oldFile.exists() && !oldFile.delete()) {
				throw new IOException("기존 로고 파일 삭제 실패: " + oldFile.getAbsolutePath());
			}
		}
		managehireDao.deleteAllScrap(postIdx); // 스크랩데이터 삭제
		managehireDao.deleteAllApply(postIdx); // 채용자 삭제
		return managehireDao.managehireDelete(paramMap);
	}

	// fk(회사등록 고유값 가져옴
	@Override
	public int managehireCkIndex(String loginId) throws Exception {
		int BizIndex = companyDao.companyGetIndex(loginId);
		return BizIndex;
	}

	@Override
	public ManagepostModel managehireDetail(Map<String, Object> paramMap) throws Exception {
		return managehireDao.managehireDetail(paramMap);
	}

	// -------------------- TO-BE (2024-11) --------------------
	// Transitioned code as of 2024-11
	
	@Override
	public List<ManagepostModel> getHirePostListByLoginId(Map<String, Object> paramMap) throws Exception {
		return managehireDao.getHirePostListByLoginId(paramMap);
	}
	
	@Override
	public int createHirePost(Map<String, Object> text, MultipartFile[] files) throws Exception {

		String itemFilePath = managehirePath + File.separator;
		FileUtilMultipartFile fileUpload = new FileUtilMultipartFile(files, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		if (!fileInfo.isEmpty()) {
			text.put("fileYn", "Y");
			text.put("fileInfo", fileInfo);
		} else {
			text.put("fileYn", "N");
			text.put("fileInfo", null);
		}
		
	    text.put("appStatus","대기중");
	    
	    managehireDao.createHirePost(text);
	    return (int) text.get("postIdx");
	}

	@Override
	public int getBizIdxByLoginId(String LoginId) throws Exception {
		return managehireDao.findBizIdxByLoginId(LoginId);
	}

	@Override
	public int updateHirePost(Map<String, Object> text, MultipartFile[] files) throws Exception {
		String itemFilePath = managehirePath + File.separator;
		FileUtilMultipartFile fileUpload = new FileUtilMultipartFile(files, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		if (!fileInfo.isEmpty()) {
			text.put("fileYn", "Y");
			text.put("fileInfo", fileInfo);
		} else {
			text.put("fileYn", "N");
			text.put("fileInfo", null);
		}
			
		return managehireDao.updateHirePost(text);
	}

	@Override
	public int delelteAttachment(Map<String, Object> paramMap) throws Exception {
		// 1. 기존 회사 정보 조회
		ManagepostModel getDetailId = managehireDao.managehireDetail(paramMap);

		// 2. 기존 로고 파일이 있을 경우 삭제
		if (getDetailId != null && getDetailId.getFileName() != null) {
			File oldFile = new File(getDetailId.getPhsycalPath());
			if (oldFile.exists() && !oldFile.delete()) {
				throw new IOException("기존 로고 파일 삭제 실패: " + oldFile.getAbsolutePath());
			}
		}
		
		// 3. 파일 정보 X
		paramMap.put("fileYn", "N");
		paramMap.put("fileInfo", null);
		
		return managehireDao.managehireUpdate(paramMap);
	}
}
