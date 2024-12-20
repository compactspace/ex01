package kr.happyjob.study.company.service;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.board.model.NoticeModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.company.dao.CompanyDao;
import kr.happyjob.study.company.model.CompanyModel;
import lombok.Builder.ObtainVia;


@Service
public class CompanyServiceImpl implements CompanyService{
	// Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());
	   
	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   @Value("${fileUpload.companyPath}")
	   private String companyPath;
	   
	   @Value("${fileUpload.rootPath}")
	   private String rootPath;
	   
	   @Value("${fileUpload.virtualRootPath}")
	   private String virtualRootPath;
	   
	   @Autowired 
		public CompanyDao companyDao;

	// 채용담당자가 회사를 등록하는 Service
	   @Override
	   public int companySave(@RequestParam Map<String,Object> paramMap, HttpServletRequest req) throws Exception{
		   MultipartHttpServletRequest multiFile =(MultipartHttpServletRequest) req; //여러개 파일할때도 사용가능
			String itemFilePath = companyPath + File.separator;
			FileUtilCho fileUpload = new FileUtilCho(multiFile,rootPath,virtualRootPath,itemFilePath); //파일업로드를 
			
			Map<String,Object> fileInfo = fileUpload.uploadFiles();
			if(fileInfo.get("file_nm")==null){
				paramMap.put("fileYn", "N");
				paramMap.put("fileInfo", null);
			}else{
				paramMap.put("fileYn", "Y");
				paramMap.put("fileInfo", fileInfo);
			}		   
		   return companyDao.companySave(paramMap);
		}
	   
	// 채용담당자가 회사를 수정하는 Service
	   @Override
	   public int companyUpdate(@RequestParam Map<String, Object> paramMap, HttpServletRequest req, String loginId) throws Exception {

	       // 1. 기존 회사 정보 조회
	       CompanyModel getDetailId = companyDao.companyDetailId(loginId);

	    // 2. 기존 로고 파일이 있을 경우 삭제
	       if (getDetailId != null && getDetailId.getBizLogo() != null) {
	           File oldFile = new File(getDetailId.getPhsycalPath());
	           if (oldFile.exists()) {
	               if (!oldFile.delete()) {
	                   throw new IOException("기존 로고 파일 삭제 실패: " + oldFile.getAbsolutePath());
	               }
	           }
	       }

	       // 3. 파일 업로드 처리
	       MultipartHttpServletRequest multiFile = (MultipartHttpServletRequest) req; 
	       String itemFilePath = companyPath + File.separator;

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

	       // 5. 회사 정보 업데이트 실행 및 반환 값 처리
	       int result = companyDao.companyUpdate(paramMap);

	       if (result == 0) {
	           logger.warn("업데이트할 내용이 없습니다. (loginId: " + loginId + ")");
	       } else {
	           logger.info("회사 정보가 성공적으로 업데이트되었습니다. (loginId: " + loginId + ")");
	       }

	       return result;
	   }
	   // 채용담당자가 회사를 삭제하는 Service
		@Override
		public int companyDelete(@RequestParam Map<String,Object> paramMap,@Param("loginId") String loginId) throws Exception{
			CompanyModel getDetail = companyDetailId(loginId);

			if (getDetail.getBizLogo() != null) {
				File oldFile = new File(getDetail.getPhsycalPath());
				oldFile.delete();
			}
			return companyDao.companyDelete(loginId);
		}
		
		// 채용담당자가 등록한 회사를 조회하는 Service
		// 회원들이 조회
		@Override
		public CompanyModel companyDetail(@RequestParam Map<String,Object> paramMap) throws Exception{
			return companyDao.companyDetail(paramMap);
		}
		
		//채용담당자가 회사를 등록했는지 안했는지 체크하기위해 db 아이디 조회
		@Override
		public int companyCkId(@Param("loginId") String loginId) throws Exception{
			logger.info("여기는 companyCkId 입니다." );
			//Db에 아이디
			String BdId = companyDao.companyCkId(loginId);
			logger.info("companyCkId Dao 에서오는 " + BdId);
			int DbIdCk = 0;
			if(BdId == null || "".equals(BdId)){
				//db에 아이디가 없을때
				DbIdCk = 1;
			}else{
				//db에 아이디가 있을때
				DbIdCk = 0;
			}
			return DbIdCk;
		}
		
		
		//채용담당자가 등록회사 수정하기 위해 데이터 뿌려주기위해 select
		@Override
		public CompanyModel companyDetailId(@Param("loginId") String loginId) throws Exception{
			return companyDao.companyDetailId(loginId);
		}
		//채용담당자가 등록회사 수정하기 위해 데이터 뿌려주기위해 select
		@Override
		public CompanyModel companyDetail(int bizIdx) throws Exception{
			return companyDao.companyDetail(bizIdx);
		}
		

	
}
