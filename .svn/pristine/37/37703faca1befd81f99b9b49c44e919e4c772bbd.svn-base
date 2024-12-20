package kr.happyjob.study.company.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.company.model.CompanyModel;

public interface CompanyService {
	// 채용담당자가 회사를 등록하는 Service
	int companySave(@RequestParam Map<String,Object> paramMap, HttpServletRequest req) throws Exception;
	// 채용담당자가 회사를 수정하는 Service
	int companyUpdate(@RequestParam Map<String,Object> paramMap, HttpServletRequest req, @Param("loginId") String loginId) throws Exception;
	// 채용담당자가 회사를 삭제하는 Service
	int companyDelete(@RequestParam Map<String,Object> paramMap, @Param("loginId") String loginId) throws Exception;
	
	// 채용담당자가 등록한 회사를 조회하는 Service
	// 회원들이 조회
	CompanyModel companyDetail(@RequestParam Map<String,Object> paramMap) throws Exception;
		
	//채용담당자가 회사를 등록했는지 안했는지 체크하기위해 db 아이디 조회
	int companyCkId(@Param("loginId") String loginId) throws Exception;
	
	//채용담당자가 등록회사 수정하기 위해 데이터 뿌려주기위해 select
	CompanyModel companyDetailId(@Param("loginId") String loginId) throws Exception;
	
	//채용담당자가 등록회사 수정하기 위해 데이터 뿌려주기위해 select
	CompanyModel companyDetail(int bizIdx) throws Exception;
	
}
 