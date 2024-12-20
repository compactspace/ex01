package kr.happyjob.study.apply.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.apply.dao.ResumeDao;
import kr.happyjob.study.apply.model.*;

/**
 * 이력서 관리 서비스 구현 클래스
 * 이력서 조회, 생성, 업데이트, 삭제 및 관련 데이터 처리를 수행.
 */
@Service
public class ResumeServiceImpl implements ResumeService {

    @Autowired
    private ResumeDao resumeDao;

    // 파일 업로드 경로 설정 값
    @Value("${fileUpload.resumePath}")
    private String resumePath;
    @Value("${fileUpload.rootPath}")
    private String rootFilePath;
    @Value("${fileUpload.virtualRootPath}")
    private String virtualrootPath;

    /**
     * 이력서 목록 조회
     * @return 이력서 목록 리스트
     */
    @Override
    public List<ResumeModel> getResumeList(Map<String, Object> paramMap) throws Exception {
        return resumeDao.getResumeList(paramMap);
    }

    /**
     * 이력서 생성
     */
    @Override
    public void createResume(Map<String, Object> paramMap) throws Exception {
        resumeDao.createResume(paramMap);
    }

    /**
     * 특정 이력서 상세 정보 조회
     * @param resIdx 조회할 이력서의 인덱스
     * @return 이력서 정보 모델
     */
    @Override
    public ResumeModel getResumeInfo(int resIdx) throws Exception {
        return resumeDao.getResumeInfo(resIdx);
    }

    /**
     * 이력서 복사
     * @param paramMap 복사할 이력서의 인덱스 정보가 담긴 파라미터 맵
     * @return 복사 결과 (성공 시 1 이상의 값)
     */
    @Override
    public int copyResume(Map<String, Object> paramMap) throws Exception {
        ResumeModel resume = resumeDao.getResumeInfo(Integer.parseInt(String.valueOf(paramMap.get("resIdx"))));
        int oldResIdx = resume.getResIdx();

        // 첨부 파일이 있는 경우, 파일 복사 수행
        if (resume.getFileSize() != 0) {
            String oldFilePath = resume.getPhsycalPath();
            String newFileName = resume.getFileName();
            String newFileExt = newFileName.substring(newFileName.lastIndexOf(".") + 1);
            String uuid = UUID.randomUUID().toString();
            String newFileName_uuid = newFileName.substring(0, newFileName.lastIndexOf(".")) + ",,," + uuid;
            String newFilePath = rootFilePath + File.separator + resumePath + File.separator + newFileName_uuid + "." + newFileExt;
            String newLogicalPath = virtualrootPath + File.separator + resumePath + File.separator + newFileName_uuid + "." + newFileExt;

            // 파일 복사 및 새로운 파일 정보 설정
            File originalFile = new File(oldFilePath);
            File copiedFile = new File(newFilePath);
            Files.copy(originalFile.toPath(), copiedFile.toPath(), StandardCopyOption.REPLACE_EXISTING);

            Long fileSize = copiedFile.length();

            resume.setFileName(newFileName);
            resume.setPhsycalPath(newFilePath);
            resume.setLogicalPath(newLogicalPath);
            resume.setFileSize(fileSize);
            resume.setFileExt(newFileExt);
        }
        int result = resumeDao.copyResume(resume);
        int newResIdx = resume.getResIdx();

        // 관련 데이터(경력, 학력, 스킬, 자격증) 복사
        Map<String, Integer> resIdxMap = new HashMap<>();
        resIdxMap.put("oldResIdx", oldResIdx);
        resIdxMap.put("newResIdx", newResIdx);
        result += resumeDao.copyCareer(resIdxMap);
        result += resumeDao.copyEdu(resIdxMap);
        result += resumeDao.copySkill(resIdxMap);
        result += resumeDao.copyCert(resIdxMap);
        return result;
    }

    /**
     * 이력서 삭제
     * @param paramMap 삭제할 이력서의 인덱스 정보가 담긴 파라미터 맵
     * @return 삭제 결과 (삭제된 행 수 합계)
     */
    @Override
    public int deleteResume(Map<String, Object> paramMap) throws Exception {
        ResumeModel resume = resumeDao.getResumeInfo(Integer.parseInt(String.valueOf(paramMap.get("resIdx"))));

        // 첨부 파일이 있을 경우, 해당 파일 삭제
        if (resume.getFileSize() != 0) {
            File fileToDelete = new File(resume.getPhsycalPath());
            fileToDelete.delete();
        }
        return resumeDao.deleteAllCert(paramMap)
                + resumeDao.deleteAllSkill(paramMap)
                + resumeDao.deleteAllEdu(paramMap)
                + resumeDao.deleteAllCareer(paramMap)
                + resumeDao.deleteResumeByResIdx(paramMap);
    }

    /**
     * 경력 목록 조회
     */
    @Override
    public List<CareerModel> getCrrList(Map<String, Object> paramMap) throws Exception {
        return resumeDao.getCrrList(paramMap);
    }

    /**
     * 학력 목록 조회
     */
    @Override
    public List<EducationModel> getEduList(Map<String, Object> paramMap) throws Exception {
        return resumeDao.getEduList(paramMap);
    }

    /**
     * 스킬 목록 조회
     */
    @Override
    public List<SkillModel> getSkillList(Map<String, Object> paramMap) throws Exception {
        return resumeDao.getSkillList(paramMap);
    }

    /**
     * 자격증 목록 조회
     */
    @Override
    public List<CertificationModel> getCertList(Map<String, Object> paramMap) throws Exception {
        return resumeDao.getCertList(paramMap);
    }

    /**
     * 경력 정보 삽입
     */
    @Override
    public int insertCareer(Map<String, Object> paramMap) throws Exception {
        return resumeDao.insertCareer(paramMap);
    }

    /**
     * 학력 정보 삽입
     */
    @Override
    public int insertEdu(Map<String, Object> paramMap) throws Exception {
        return resumeDao.insertEdu(paramMap);
    }

    /**
     * 스킬 정보 삽입
     */
    @Override
    public int insertSkill(Map<String, Object> paramMap) throws Exception {
        return resumeDao.insertSkill(paramMap);
    }

    /**
     * 자격증 정보 삽입
     */
    @Override
    public int insertCert(Map<String, Object> paramMap) throws Exception {
        return resumeDao.insertCert(paramMap);
    }

    /**
     * 특정 경력 정보 삭제
     */
    @Override
    public int deleteOneCareer(Map<String, Object> paramMap) throws Exception {
        return resumeDao.deleteOneCareer(paramMap);
    }

    /**
     * 특정 학력 정보 삭제
     */
    @Override
    public int deleteOneEdu(Map<String, Object> paramMap) throws Exception {
        return resumeDao.deleteOneEdu(paramMap);
    }

    /**
     * 특정 스킬 정보 삭제
     */
    @Override
    public int deleteOneSkill(Map<String, Object> paramMap) throws Exception {
        return resumeDao.deleteOneSkill(paramMap);
    }

    /**
     * 특정 자격증 정보 삭제
     */
    @Override
    public int deleteOneCert(Map<String, Object> paramMap) throws Exception {
        return resumeDao.deleteOneCert(paramMap);
    }

    /**
     * 이력서 정보 업데이트
     */
    @Override
    public int updateResume(Map<String, Object> paramMap) throws Exception {
        return resumeDao.updateResume(paramMap);
    }

    /**
     * 첨부 파일 삭제
     * @param paramMap 삭제할 파일의 정보가 담긴 파라미터 맵
     * @return 삭제 결과
     */
    @Override
    public int deleteAttach(Map<String, Object> paramMap) throws Exception {
        ResumeModel resume = resumeDao.getResumeInfo(Integer.parseInt(String.valueOf(paramMap.get("resIdx"))));

        // 물리적 파일 삭제
        File fileToDelete = new File(resume.getPhsycalPath());
        fileToDelete.delete();

        return resumeDao.deleteAttach(paramMap);
    }

	@Override
	public int copyResumeAndGetNewResumeIdx(Map<String, Object> paramMap) throws Exception {
        ResumeModel resume = resumeDao.getResumeInfo(Integer.parseInt(String.valueOf(paramMap.get("resIdx"))));
        int oldResIdx = resume.getResIdx();

        // 첨부 파일이 있는 경우, 파일 복사 수행
        if (resume.getFileSize() != 0) {
            String oldFilePath = resume.getPhsycalPath();
            String newFileName = resume.getFileName();
            String newFileExt = newFileName.substring(newFileName.lastIndexOf(".") + 1);
            String uuid = UUID.randomUUID().toString();
            String newFileName_uuid = newFileName.substring(0, newFileName.lastIndexOf(".")) + ",,," + uuid;
            String newFilePath = rootFilePath + File.separator + resumePath + File.separator + newFileName_uuid + "." + newFileExt;
            String newLogicalPath = virtualrootPath + File.separator + resumePath + File.separator + newFileName_uuid + "." + newFileExt;

            // 파일 복사 및 새로운 파일 정보 설정
            File originalFile = new File(oldFilePath);
            File copiedFile = new File(newFilePath);
            Files.copy(originalFile.toPath(), copiedFile.toPath(), StandardCopyOption.REPLACE_EXISTING);

            Long fileSize = copiedFile.length();

            resume.setFileName(newFileName);
            resume.setPhsycalPath(newFilePath);
            resume.setLogicalPath(newLogicalPath);
            resume.setFileSize(fileSize);
            resume.setFileExt(newFileExt);
        }
        int result = resumeDao.copyResumeApplied(resume);
        int newResIdx = resume.getResIdx();

        // 관련 데이터(경력, 학력, 스킬, 자격증) 복사
        Map<String, Integer> resIdxMap = new HashMap<>();
        resIdxMap.put("oldResIdx", oldResIdx);
        resIdxMap.put("newResIdx", newResIdx);
        result += resumeDao.copyCareer(resIdxMap);
        result += resumeDao.copyEdu(resIdxMap);
        result += resumeDao.copySkill(resIdxMap);
        result += resumeDao.copyCert(resIdxMap);
        return newResIdx;
    }

}
