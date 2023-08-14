package com.model2.mvc.service.branch;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Branch;
import com.model2.mvc.service.domain.User;


//==> 회원관리에서 CRUD 추상화/캡슐화한 DAO Interface Definition
@Mapper
public interface BranchDao {
	
	// INSERT
	public void addBranch(Branch branch) throws Exception ;

	// SELECT ONE
	public User getBranch(int branchNo) throws Exception ;

	// SELECT LIST
	public List<Branch> getBranchList() throws Exception ;

	// UPDATE
	public void updateBranch(Branch branch) throws Exception ;
	
	
}