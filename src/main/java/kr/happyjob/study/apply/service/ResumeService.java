package kr.happyjob.study.apply.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.apply.model.CareerModel;
import kr.happyjob.study.apply.model.CertificationModel;
import kr.happyjob.study.apply.model.EducationModel;
import kr.happyjob.study.apply.model.ResumeModel;
import kr.happyjob.study.apply.model.SkillModel;

public interface ResumeService {

	public List<ResumeModel> getResumeList(Map<String, Object> paramMap) throws Exception;

	public void createResume(Map<String, Object> paramMap) throws Exception;

	public ResumeModel getResumeInfo(int resIdx) throws Exception;

	public int copyResume(Map<String, Object> paramMap) throws Exception;

	public int deleteResume(Map<String, Object> paramMap) throws Exception;

	public List<CareerModel> getCrrList(Map<String, Object> paramMap) throws Exception;

	public List<EducationModel> getEduList(Map<String, Object> paramMap) throws Exception;

	public List<SkillModel> getSkillList(Map<String, Object> paramMap) throws Exception;

	public List<CertificationModel> getCertList(Map<String, Object> paramMap) throws Exception;

	public int insertCareer(Map<String, Object> paramMap) throws Exception;

	public int insertEdu(Map<String, Object> paramMap) throws Exception;

	public int insertSkill(Map<String, Object> paramMap) throws Exception;

	public int insertCert(Map<String, Object> paramMap) throws Exception;
	
	public int deleteOneCareer(Map<String, Object> paramMap) throws Exception;
	
	public int deleteOneEdu(Map<String, Object> paramMap) throws Exception;
	
	public int deleteOneSkill(Map<String, Object> paramMap) throws Exception;
	
	public int deleteOneCert(Map<String, Object> paramMap) throws Exception;

	public int updateResume(Map<String, Object> paramMap) throws Exception;
	
	public int deleteAttach(Map<String, Object> paramMap)throws Exception;

//	to-be
	public int copyResumeAndGetNewResumeIdx(Map<String, Object> paramMap) throws Exception;
}
