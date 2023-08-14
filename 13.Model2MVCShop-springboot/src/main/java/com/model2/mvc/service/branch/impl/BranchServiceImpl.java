package com.model2.mvc.service.branch.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.branch.BranchDao;
import com.model2.mvc.service.branch.BranchService;
import com.model2.mvc.service.domain.Branch;


//==> 회원관리 서비스 구현
@Service("branchServiceImpl")
public class BranchServiceImpl implements BranchService{
	
	///Field
	@Autowired
	@Qualifier("branchDao")
	private BranchDao branchDao;
	public void setBranchDao(BranchDao branchDao) {
		this.branchDao = branchDao;
	}
	
	///Constructor
	public BranchServiceImpl() {
		System.out.println(this.getClass());
	}


	@Override
	public void addBranch(Branch branch) throws Exception {
		branchDao.addBranch(branch);
		
	}

	@Override
	public Branch getBranch(int branchNo) throws Exception {
		// branchDao.getBranch(branchNo);
		return null;
	}

	@Override
	public Map<String, Object> getBranchList() throws Exception {
		System.out.println("BranchService");

		List<Branch> list= branchDao.getBranchList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		
		return map;
	}

	@Override
	public void updateBranch(Branch branch) throws Exception {
		// branchDao.updateBranch(branch);
		
	}
}