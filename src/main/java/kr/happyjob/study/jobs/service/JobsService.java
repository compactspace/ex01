package kr.happyjob.study.jobs.service;

import java.util.Map;

public interface JobsService {

	boolean isScraped(Map<String, Object> paramMap);

	boolean isApplyed(Map<String, Object> paramMap);

}