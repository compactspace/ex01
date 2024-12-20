package kr.happyjob.study.mypage.service_as_is;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mypage.dao.MypageDao;
import kr.happyjob.study.mypage.model.MypageModel;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	private MypageDao mypageDao;

	@Override
	public MypageModel userDetail(Map<String, Object> paramMap) throws Exception {
		return mypageDao.getUserInfo(paramMap);
	}
	
	@Override
	public int deleteUser(Map<String, Object> paramMap) throws Exception {
		return mypageDao.deleteUser(paramMap);
	}
	
	@Override
	public int updateUserInfo(Map<String, Object> paramMap) throws Exception {
		return mypageDao.updateUserInfo(paramMap);
	}
	
	@Override
	public int updatePasswd(Map<String, Object> paramMap) throws Exception {
		return mypageDao.updatePasswd(paramMap);
	}
	
	@Override
	public MypageModel chkRegBiz(Map<String, Object> paramMap) throws Exception {
		return mypageDao.chkRegBiz(paramMap);
	}

}
