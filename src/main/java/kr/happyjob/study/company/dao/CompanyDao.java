package kr.happyjob.study.company.dao;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.company.model.CompanyModel;

public interface CompanyDao {
	// 채용담당자가 회사를 등록하는 Dao
	int companySave(@RequestParam Map<String, Object> paramMap) throws Exception;

	// 채용담당자가 회사를 수정하는 Dao
	int companyUpdate(@RequestParam Map<String, Object> paramMap) throws Exception;

	// 채용담당자가 회사를 삭제하는 Dao
	int companyDelete(@Param("loginId") String loginId) throws Exception;

	// 채용담당자가 등록한 회사를 조회하는 Dao 
	// 회원들이 조회
	CompanyModel companyDetail(@RequestParam Map<String, Object> paramMap) throws Exception;
	
	//채용담당자가 회사를 등록했는지 안했는지 체크하기위해 db 아이디 조회
	String companyCkId(@Param("loginId") String loginId) throws Exception;
	
	//채용담당자가 등록회사 수정하기 위해 데이터 뿌려주기위해 select
	CompanyModel companyDetailId(@Param("loginId") String loginId) throws Exception;
	
	//채용담당자가 등록회사 수정하기 위해 데이터 뿌려주기위해 select
	CompanyModel companyDetail(int bizIdx) throws Exception;
	
	//managepost에 사용
	//고유값을 불러옴 index
	int companyGetIndex(@Param("loginId") String loginId) throws Exception;
		
}
