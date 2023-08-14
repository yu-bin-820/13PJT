package com.model2.mvc.service.branch;

import java.util.Map;

import com.model2.mvc.service.domain.Branch;


//==> 회원관리에서 서비스할 내용 추상화/캡슐화한 Service  Interface Definition  
public interface BranchService {
	
	// 지점생성
	public void addBranch(Branch branch) throws Exception;
	
	// 내정보확인 / 로그인
	public Branch getBranch(int branchNo) throws Exception;
	
	// 회원정보리스트 
	public Map<String , Object> getBranchList() throws Exception;
	
	// 회원정보수정
	public void updateBranch(Branch branch) throws Exception;
	
	
}