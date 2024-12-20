package kr.happyjob.study.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.board.dao.FaqDao;
import kr.happyjob.study.board.model.FaqModel;

@Service
public class FaqServiceImpl implements FaqService {

	@Autowired
	private FaqDao faqDao;

	@Override
	public List<FaqModel> faqList(Map<String, Object> paramMap) throws Exception {
		return faqDao.faqList(paramMap);
	}

	@Override
	public int saveFaq(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return faqDao.saveFaq(paramMap);
	}

	@Override
	public FaqModel faqDetail(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return faqDao.faqDetail(paramMap);
	}

	@Override
	public int updateFaq(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return faqDao.updateFaq(paramMap);
	}

	@Override
	public int deleteFaq(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return faqDao.deleteFaq(paramMap);
	}

	@Override
	public int faqListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return faqDao.faqListCnt(paramMap);
	}

}
