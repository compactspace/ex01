package kr.happyjob.study.jobs.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.jobs.model.ScrapModel;

public interface ScrapDao {
	
	List<ScrapModel> scrapList(Map<String, Object> paramMap) throws Exception;

	int scrapListCnt(Map<String, Object> paramMap) throws Exception;
	
	int saveScrap(Map<String, Object> paramMap) throws Exception;
	
	int deleteScrapList(List<Integer> list) throws Exception;
	
	int updateScrap(Map<String, Object> paramMap) throws Exception;
	
	ScrapModel selectScrapExist(Map<String, Object> paramMap) throws Exception;

	int deleteScrap(Map<String, Object> paramMap);
}
