package kr.happyjob.study.apply.controller.as_is;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.apply.model.CareerModel;
import kr.happyjob.study.apply.model.CertificationModel;
import kr.happyjob.study.apply.model.EducationModel;
import kr.happyjob.study.apply.model.ResumeModel;
import kr.happyjob.study.apply.model.SkillModel;
import kr.happyjob.study.apply.service.ResumeService;
import kr.happyjob.study.common.comnUtils.ApiResponseUtil;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.jobs.service.ApplyService;

/**
 * 이력서 관리 기능을 담당하는 컨트롤러 클래스
 * 각종 이력서 데이터 조회, 생성, 업데이트 및 파일 처리 기능을 제공.
 */
@Controller
@RequestMapping("/apply/")
public class ResumeController {

	@Autowired
	private ResumeService resumeService;
	
	// 파일 업로드 경로 주입
	@Value("${fileUpload.resumePath}")
	private String resumePath;

	@Value("${fileUpload.rootPath}")
	private String rootFilePath;

	@Value("${fileUpload.virtualRootPath}")
	private String virtualrootPath;

	private final Logger logger = LogManager.getLogger(this.getClass());

	private final String className = this.getClass().toString();

	
	/**
	 * 이력서 리스트 페이지 이동
	 * @param session - 로그인 때 저장된 session정보를 받아와 userIdx 조회에 사용  
	 */
	@GetMapping("resume.do")
	public String getResumeList(Model model, HttpSession session) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		paramMap.put("userNm", (String) session.getAttribute("userNm"));
		paramMap.put("userType", (String) session.getAttribute("userType"));
		List<ResumeModel> result = resumeService.getResumeList(paramMap);
		model.addAttribute("result", result);
		return "/apply/resumeMain";
	}

	
	/**
	 * 이력서 상세보기
	 * @param resumeNum 이력서의 시퀀스(seq) 번호
	 */
	@GetMapping("resume-detail.do")
	public String resumeDetailByResumeSeq(@RequestParam int resumeNum, Model model)
			throws Exception {
		int resIdx = resumeNum;
		ResumeModel result = resumeService.getResumeInfo(resIdx);
		model.addAttribute("result", result);
		return "/apply/resumeDetail";
	}
	
	
	
	/**
	 * 첨부 파일을 다운로드 처리.
	 * @param resumeNum 다운로드할 이력서 번호
	 * @param request   HttpServletRequest 객체로, MIME 타입 설정에 사용됩니다.
	 * @return 파일이 존재하지 않을 경우 404 상태를 반환하고, 파일이 존재할 경우 첨부 파일과 함께 ResponseEntity를 반환합니다.
	 */
	@GetMapping("attachment-download")
	public ResponseEntity<Resource> downAttach(@RequestParam int resumeNum, HttpServletRequest request)
	        throws Exception {
	    // 이력서 정보를 가져옴
	    ResumeModel result = resumeService.getResumeInfo(resumeNum);
	    String filePath = result.getPhsycalPath();
	    File file = new File(filePath);

	    // 파일이 존재하지 않을 경우 404 상태 반환
	    if (!file.exists()) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	    }

	    // 파일을 InputStreamResource로 감싸서 반환
	    FileInputStream fileInputStream = new FileInputStream(file);
	    InputStreamResource resource = new InputStreamResource(fileInputStream);

	    // 파일 이름을 UTF-8로 인코딩
	    String encodedFileName = URLEncoder.encode(result.getFileName(), StandardCharsets.UTF_8.toString())
	            .replaceAll("\\+", "%20");

	    // HTTP 헤더 설정
	    HttpHeaders headers = new HttpHeaders();
	    headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFileName);
	    headers.add(HttpHeaders.CONTENT_LENGTH, String.valueOf(file.length()));

	    // MIME 타입 설정
	    String mimeType = request.getServletContext().getMimeType(file.getAbsolutePath());
	    if (mimeType == null) {
	        mimeType = "application/octet-stream";
	    }
	    headers.add(HttpHeaders.CONTENT_TYPE, mimeType);

	    // ResponseEntity를 사용해 파일을 반환
	    return ResponseEntity.ok().headers(headers).body(resource);
	}

	/**
	 * 이력서를 복사.
	 * @param paramMap 이력서의 seq(시퀀스) 정보를 포함한 파라미터 맵 
	 */ 
	@PostMapping("resumeCopy.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> resumeCopyByResumeSeq(@RequestParam Map<String, Object> paramMap)
			throws Exception {
		int copyResult = resumeService.copyResume(paramMap);
		if (copyResult > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 이력서를 삭제.
	 * @param paramMap 이력서의 seq(시퀀스) 정보를 포함한 파라미터 맵 
	 */ 
	@PostMapping("resumeDelete.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> resumeDeleteByResumeSeq(@RequestParam Map<String, Object> paramMap)
			throws Exception {
		int deleteResult = resumeService.deleteResume(paramMap);
		if (deleteResult > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 이력서 새로 생성.
	 */
	@GetMapping("resume-new.do")
	public String resumeNew(Model model, HttpSession session) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		paramMap.put("userNm", (String) session.getAttribute("userNm"));
		paramMap.put("userType", (String) session.getAttribute("userType"));
		resumeService.createResume(paramMap);
		int resIdx = Integer.parseInt(String.valueOf(paramMap.get("resIdx")));
		ResumeModel result = resumeService.getResumeInfo(resIdx);
		model.addAttribute("result", result);
		return "/apply/resumeDetail";
	}

	/**
	 * 경력 정보 불러오기.
	 * paramMap 이력서의 seq(시퀀스) 정보를 포함한 파라미터 맵 
	 * 
	 */
	@PostMapping("careerList.do")
	public String getCrrList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		List<CareerModel> resultList = resumeService.getCrrList(paramMap);
		model.addAttribute("result", resultList);
		return "/apply/careerList";
	}
	
	/**
	 * 학력 정보 불러오기.
	 * paramMap 이력서의 seq(시퀀스) 정보를 포함한 파라미터 맵 
	 * 
	 */
	@PostMapping("EduList.do")
	public String getEduList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		List<EducationModel> resultList = resumeService.getEduList(paramMap);
		model.addAttribute("result", resultList);
		return "/apply/eduList";
	}

	/**
	 * 스킬 정보 불러오기.
	 * paramMap 이력서의 seq(시퀀스) 정보를 포함한 파라미터 맵 
	 * 
	 */
	@PostMapping("skillList.do")
	public String getSkillList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		List<SkillModel> resultList = resumeService.getSkillList(paramMap);
		model.addAttribute("result", resultList);
		return "/apply/skillList";
	}

	/**
	 * 경력 정보 불러오기.
	 * paramMap 이력서의 seq(시퀀스) 정보를 포함한 파라미터 맵 
	 * 
	 */
	@PostMapping("certList.do")
	public String getCertList(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		List<CertificationModel> resultList = resumeService.getCertList(paramMap);
		model.addAttribute("result", resultList);
		return "/apply/certList";
	}

	/**
	 * 자격증 정보를 삽입.
	 */
	@PostMapping("insertCareer")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> insertCareer(@RequestParam Map<String, Object> paramMap)
			throws Exception {
		int result = resumeService.insertCareer(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 학력 정보를 삽입.
	 */
	@PostMapping("insertEdu")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> insertEdu(@RequestParam Map<String, Object> paramMap) throws Exception {
		int result = resumeService.insertEdu(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 스킬 정보를 삽입.
	 */
	@PostMapping("insertSkill")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> insertSkill(@RequestParam Map<String, Object> paramMap)
			throws Exception {
		int result = resumeService.insertSkill(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 자격증 정보를 삽입.
	 */
	@PostMapping("insertCert")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> insertCert(@RequestParam Map<String, Object> paramMap) throws Exception {
		int result = resumeService.insertCert(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 경력 정보를 삭제.
	 * @param paramMap 경력테이블 의 seq(시퀀스) 정보를 포함한 파라미터 맵  
	 */
	@PostMapping("deleteCareer")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deleteCareer(@RequestParam Map<String, Object> paramMap)
			throws Exception {
		int result = resumeService.deleteOneCareer(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 학력 정보를 삭제.
	 * @param paramMap 학력테이블 의 seq(시퀀스) 정보를 포함한 파라미터 맵  
	 */
	@PostMapping("deleteEdu")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deleteEdu(@RequestParam Map<String, Object> paramMap) throws Exception {
		int result = resumeService.deleteOneEdu(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 스킬 정보를 삭제.
	 * @param paramMap 스킬테이블 의 seq(시퀀스) 정보를 포함한 파라미터 맵  
	 */
	@PostMapping("deleteSkill")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deleteSkill(@RequestParam Map<String, Object> paramMap)
			throws Exception {
		int result = resumeService.deleteOneSkill(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 자격증 정보를 삭제.
	 * @param paramMap 자격증테이블 의 seq(시퀀스) 정보를 포함한 파라미터 맵  
	 */
	@PostMapping("deleteCert")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> deleteCert(@RequestParam Map<String, Object> paramMap) throws Exception {
		int result = resumeService.deleteOneCert(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	/**
	 * 이력서 업데이트.
	 */
	@PostMapping("updateResume")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateResume(@RequestParam Map<String, Object> paramMap,
			MultipartHttpServletRequest multifile, HttpSession session) throws Exception {

		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		paramMap.put("userNm", (String) session.getAttribute("userNm"));
		paramMap.put("userType", (String) session.getAttribute("userType"));

		// 파일 업로드 처리
		String itemFilePath = resumePath + File.separator;
		FileUtilCho fileUpload = new FileUtilCho(multifile, rootFilePath, virtualrootPath, itemFilePath);
		Map<String, Object> fileInfo = fileUpload.uploadFiles();
		if (fileInfo.get("file_nm") == null) {
			paramMap.put("fileYn", "N");
			paramMap.put("fileInfo", null);
		} else {
			paramMap.put("fileYn", "Y");
			paramMap.put("fileInfo", fileInfo);
		}

		int result = resumeService.updateResume(paramMap);

		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	
	
	/**
	 * 첨부파일 삭제
	 * @param paramMap 이력서의 seq(시퀀스) 정보를 포함한 파라미터 맵 
	 */
	@PostMapping("deleteAttach")
	public ResponseEntity<Map<String, Object>> deleteAttach(@RequestParam Map<String, Object> paramMap)
			throws Exception {
		int result = resumeService.deleteAttach(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/**
	 * 이력서 미리보기
	 */
	@PostMapping("previewResume.do")
	public String previewResume(@RequestParam Map<String, Object> paramMap, Model model) throws Exception {
		int resIdx = Integer.valueOf(String.valueOf(paramMap.get("resIdx")));
		ResumeModel resumeInfo = resumeService.getResumeInfo(resIdx);
		List<CareerModel> careerInfo = resumeService.getCrrList(paramMap);
		List<EducationModel> eduInfo = resumeService.getEduList(paramMap);
		List<SkillModel> skillInfo = resumeService.getSkillList(paramMap);
		List<CertificationModel> certInfo = resumeService.getCertList(paramMap);
		model.addAttribute("resumeInfo", resumeInfo);
		model.addAttribute("careerInfo", careerInfo);
		model.addAttribute("eduInfo", eduInfo);
		model.addAttribute("skillInfo", skillInfo);
		model.addAttribute("certInfo", certInfo);
		return "/apply/previewResume";
	}
	
}
