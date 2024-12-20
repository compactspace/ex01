package kr.happyjob.study.apply.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.apply.dao.HistoryDao;
import kr.happyjob.study.apply.dao.ResumeDao;
import kr.happyjob.study.apply.model.HistoryModel;
import kr.happyjob.study.apply.model.ResumeModel;

@Service
public class HistoryServiceImpl implements HistoryService{
	
	@Autowired
	private HistoryDao historyDao;
	
	@Autowired
	private ResumeDao resumeDao;
	
	@Override
	public List<HistoryModel> getApplyHistoryList(Map<String, String> paramMap) throws Exception {
		return historyDao.getApplyHistoryList(paramMap);
	}
	
	@Override
	public List<HistoryModel> getApplyHistoryListByFilter(Map<String, String> paramMap) throws Exception {
		return historyDao.getApplyHistoryListByFilter(paramMap);
	}
	
	@Override
	public List<HistoryModel> getApplyHistoryListByFilterRest(Map<String, Object> paramMap) throws Exception {
		return historyDao.getApplyHistoryListByFilterRest(paramMap);
	}
	
	@Override
	public int historyListCnt(Map<String, Object> paramMap) throws Exception{
		return historyDao.historyListCnt(paramMap);
	}
	
	@Override
	public int cancleApply(Map<String, Object> paramMap) throws Exception {
		return historyDao.cancleApply(paramMap);
	}

	@Override
	public void deleteResume(Map<String, Object> paramMap) {
		int resIdx = resumeDao.findResIdxByAppId(paramMap);

		System.out.println("ServiceImpl resIdx :" + resIdx);
		
        ResumeModel resume = resumeDao.getResumeInfo(resIdx);
        // 첨부 파일이 있을 경우, 해당 파일 삭제
        if (resume.getFileSize() != 0) {
            File fileToDelete = new File(resume.getPhsycalPath());
            fileToDelete.delete();
        }
        
        paramMap.put("resIdx", resIdx);
        
        resumeDao.deleteAllCert(paramMap);
        resumeDao.deleteAllSkill(paramMap);
        resumeDao.deleteAllEdu(paramMap);
        resumeDao.deleteAllCareer(paramMap);
        resumeDao.deleteResumeByResIdx(paramMap);		
	}

}
