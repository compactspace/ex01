package kr.happyjob.study.apply.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.apply.model.CareerModel;
import kr.happyjob.study.apply.model.CertificationModel;
import kr.happyjob.study.apply.model.EducationModel;
import kr.happyjob.study.apply.model.ResumeModel;
import kr.happyjob.study.apply.model.SkillModel;

public interface ResumeDao {
	
	public List<ResumeModel> getResumeList(Map<String, Object> paramMap);
	
	public void createResume(Map<String, Object> paramMap);
	
	public ResumeModel getResumeInfo(int resIdx);

	
	public int copyResume(ResumeModel resume);
	public int copyResumeApplied(ResumeModel resume);
	public int copyCareer(Map<String, Integer> resIdxMap);
	public int copyEdu(Map<String, Integer> resIdxMap);
	public int copySkill(Map<String, Integer> resIdxMap);
	public int copyCert(Map<String, Integer> resIdxMap);

	
	public int deleteAllCert(Map<String, Object> paramMap);
	public int deleteAllSkill(Map<String, Object> paramMap);
	public int deleteAllEdu(Map<String, Object> paramMap);
	public int deleteAllCareer(Map<String, Object> paramMap);
	public int deleteResumeByResIdx(Map<String, Object> paramMap);
	
	
	public List<CareerModel> getCrrList(Map<String, Object> paramMap);
	
	public List<EducationModel> getEduList(Map<String, Object> paramMap);
	
	public List<SkillModel> getSkillList(Map<String, Object> paramMap);
	
	public List<CertificationModel> getCertList(Map<String, Object> paramMap);
	
	public int insertCareer(Map<String, Object> paramMap);
	
	public int insertEdu(Map<String, Object> paramMap);
	
	public int insertSkill(Map<String, Object> paramMap);
	
	public int insertCert(Map<String, Object> paramMap);
	
	public int deleteOneCareer(Map<String, Object> paramMap);
	
	public int deleteOneEdu(Map<String, Object> paramMap);
	
	public int deleteOneSkill(Map<String, Object> paramMap);
	
	public int deleteOneCert(Map<String, Object> paramMap);

	public int updateResume(Map<String, Object> paramMap);
	
	public int deleteAttach(Map<String, Object> paramMap);

	public int findResIdxByAppId(Map<String, Object> paramMap);


}
