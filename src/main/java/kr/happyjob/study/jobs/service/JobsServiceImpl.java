package kr.happyjob.study.jobs.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.jobs.dao.JobsDao;

@Service
public class JobsServiceImpl implements JobsService{

	@Autowired
	private JobsDao jobsDao;
	
	@Override
	public boolean isScraped(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return jobsDao.isScraped(paramMap);
	}

	@Override
	public boolean isApplyed(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return jobsDao.isApplyed(paramMap);
	}

}