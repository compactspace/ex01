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

import kr.happyjob.study.board.model.NoticeModel;
import kr.happyjob.study.board.service.NoticeService;

@Controller
@RequestMapping("/board/")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("notice.do")
	public String init() throws Exception {
		return "notice/notice";
	}

	@RequestMapping("noticeList.do")
	public String getNoticeList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap: " + paramMap);

		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		int startSeq = (currentPage - 1) * pageSize;

		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);

		List<NoticeModel> noticeList = noticeService.noticeList(paramMap);
		int noticeCnt = noticeService.noticeListCnt(paramMap);

		model.addAttribute("notice", noticeList);
		model.addAttribute("noticeCnt", noticeCnt);
		return "notice/noticeList";
	}

	@RequestMapping("noticeSave.do")
	@ResponseBody
	public Map<String, String> saveNotice(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveNotice: " + paramMap);

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int result = noticeService.saveNotice(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("noticeUpdate.do")
	@ResponseBody
	public Map<String, String> updateNotice(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("updateNotice: " + paramMap);

		int result = noticeService.updateNotice(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("noticeDelete.do")
	@ResponseBody
	public Map<String, String> deteleNotice(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveNotice: " + paramMap);

		int result = noticeService.deleteNotice(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("noticeDetail.do")
	@ResponseBody
	public Map<String, Object> noticeDetail(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		logger.info("noticeDetail: " + paramMap);

		NoticeModel detailValue = noticeService.noticeDetail(paramMap);
		resultMap.put("detail", detailValue);

		return resultMap;
	}

	@RequestMapping("noticeFileSave.do")
	@ResponseBody
	public Map<String, String> noticeFileSave(@RequestParam Map<String, Object> paramMap, HttpServletRequest req,
			HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int result = noticeService.saveFileNotice(paramMap, req);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("noticeDetailFile.do")
	@ResponseBody
	public Map<String, Object> noticeDetailFile(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		logger.info("noticeDetail: " + paramMap);

		NoticeModel detailValue = noticeService.noticeDetailFile(paramMap);
		resultMap.put("detail", detailValue);

		return resultMap;
	}

	@RequestMapping("noticeFileUpdate.do")
	@ResponseBody
	public Map<String, String> noticeFileUpdate(@RequestParam Map<String, Object> paramMap, HttpServletRequest req,
			HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int result = noticeService.updateFileNotice(paramMap, req);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("noticeFileDelete.do")
	@ResponseBody
	public Map<String, String> noticeFileDelete(@RequestParam Map<String, Object> paramMap, HttpServletRequest req,
			HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int result = noticeService.deleteFileNotice(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	// 다운로드
	@RequestMapping("noticeDownload.do")
	public void noticeDownload(@RequestParam Map<String, Object> paramMap, HttpServletResponse res) throws Exception {
		NoticeModel notice = noticeService.noticeDetailFile(paramMap);

		String filePath = notice.getPhsycalPath();
		byte bytes[] = FileUtils.readFileToByteArray(new File(filePath));

		res.setContentType("application/octet-stream");
		res.setContentLength(bytes.length);
		res.setHeader("Content-Disposition",
				"attachment; fileName=\"" + URLEncoder.encode(notice.getFileName(), "UTF-8") + "\";");
		res.setHeader("Content-Transfer-Encoding", "binary");
		res.getOutputStream().write(bytes);
		res.getOutputStream().flush();
		res.getOutputStream().close();
	}
}
