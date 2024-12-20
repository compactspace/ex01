package kr.happyjob.study.board.controller.as_is;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.board.model.QnaModel;
import kr.happyjob.study.board.service.QnaService;

@Controller
@RequestMapping("/board/")
public class QnaController {

	@Autowired
	private QnaService qnaService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("qna.do")
	public String init() throws Exception {
		return "qna/qna";
	}

	@RequestMapping("qnaList.do") 
	public String getQnaList(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		logger.info("paramMap: " + paramMap);
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		int startSeq = (currentPage - 1) * pageSize;
		
		String qna_type = (String) paramMap.get("qna_type");
		String requestType = (String) paramMap.get("requestType");
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		paramMap.put("qna_type", qna_type);

		List<QnaModel> qnaList;
		if ("my".equals(requestType)) {
			qnaList = qnaService.qnaMyList(paramMap); 
		} else {
			qnaList = qnaService.qnaList(paramMap); 
		}
		int qnaCnt = qnaService.qnaListCnt(paramMap);

		model.addAttribute("qna", qnaList);
		model.addAttribute("qnaCnt", qnaCnt);
		
		return "qna/qnaList";
	}

	@RequestMapping("qnaDelete.do")
	@ResponseBody
	public Map<String, String> deteleQna(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveQna: " + paramMap);

		int result = qnaService.deleteQna(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("qnaFileSave.do")
	@ResponseBody
	public Map<String, String> qnaFileSave(@RequestParam Map<String, Object> paramMap, HttpServletRequest req,
			HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int result = qnaService.saveFileQna(paramMap, req);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("qnaDetailFile.do")
	@ResponseBody
	public Map<String, Object> qnaDetailFile(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		logger.info("qnaDetail: " + paramMap);

		String userType = (String) session.getAttribute("userType");
		
		QnaModel detailValue = qnaService.qnaDetailFile(paramMap);
		
		// 관리자인 경우 비밀번호 확인 없이 바로 성공 처리
	    if ("M".equals(userType)) {
	        resultMap.put("result", "success");
	        resultMap.put("detail", detailValue);
	    } else {
	    	// 그 외 사용자의 경우 비밀번호 확인
	    	if(detailValue != null && detailValue.getPassword().equals(paramMap.get("password"))){
				resultMap.put("result", "success");
				resultMap.put("detail", detailValue);
				logger.info("detailValue========="+detailValue);
				} else {
				resultMap.put("result", "fail");
			}
	    }
		return resultMap;
	}

	@RequestMapping("qnaFileUpdate.do")
	@ResponseBody
	public Map<String, String> qnaFileUpdate(@RequestParam Map<String, Object> paramMap, HttpServletRequest req,
			HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int result = qnaService.updateFileQna(paramMap, req);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("qnaFileDelete.do")
	@ResponseBody
	public Map<String, String> qnaFileDelete(@RequestParam Map<String, Object> paramMap, HttpServletRequest req,
			HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int result = qnaService.deleteFileQna(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	// 다운로드
	@RequestMapping("qnaDownload.do")
	public void qnaDownload(@RequestParam Map<String, Object> paramMap, HttpServletResponse res) throws Exception {
		QnaModel qna = qnaService.qnaDetailFile(paramMap);

		String filePath = qna.getPhsycalPath();
		byte bytes[] = FileUtils.readFileToByteArray(new File(filePath));

		res.setContentType("application/octet-stream");
		res.setContentLength(bytes.length);
		res.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(qna.getFileName(), "UTF-8") + "\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		res.getOutputStream().write(bytes);
		res.getOutputStream().flush();
		res.getOutputStream().close();
	}
}