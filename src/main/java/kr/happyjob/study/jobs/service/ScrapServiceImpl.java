package kr.happyjob.study.jobs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.jobs.dao.ScrapDao;
import kr.happyjob.study.jobs.model.ScrapModel;

@Service
public class ScrapServiceImpl implements ScrapService {
   
	@Autowired
	private ScrapDao scrapDao;
	
	@Override
	public List<ScrapModel> scrapList(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return scrapDao.scrapList(paramMap);
	}
	
	@Override
	public int scrapListCnt(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return scrapDao.scrapListCnt(paramMap);
	}	
	
	@Override
	public ScrapModel selectScrapExist(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return scrapDao.selectScrapExist(paramMap);
	}
	
	@Override
	public int saveScrap(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return scrapDao.saveScrap(paramMap);
	}
		
	@Override
	public int deleteScrapList(List<Integer> scrapIdxList) throws Exception {
		// TODO Auto-generated method stub
		return scrapDao.deleteScrapList(scrapIdxList);
	}

	
	@Override
	public int updateScrap(Map<String, Object> paramMap) throws Exception {
		// TODO Auto-generated method stub
		return scrapDao.updateScrap(paramMap);
	}

	@Override
	public int deleteScrap(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return scrapDao.deleteScrap(paramMap);
	}
}
