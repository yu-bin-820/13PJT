package com.model2.mvc.web.branches;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.branch.BranchService;
import com.model2.mvc.service.domain.Branch;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/branches/*")
public class BranchesRestController {
	
	///Field
	@Autowired
	@Qualifier("branchServiceImpl")
	private BranchService branchService;
	//setter Method 구현 않음
		
	@Value("${pageSize}")
	int pageSize;
	
	public BranchesRestController(){
		System.out.println(this.getClass());
	}
	
	@GetMapping("json/getBranch/{branchId}")
	public Branch getBranch( @PathVariable int branchId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return branchService.getBranch(branchId);
	}
	
	@PostMapping("json/addBranch")
	public void addBranch( @RequestBody Branch branch ) throws Exception {

		System.out.println("/json/addBrach : POST");
		//Business Logic
		branchService.addBranch(branch);
		
	}
	
	@PostMapping("json/updateBranch")
	public void updateBranch( @RequestBody Branch branch ) throws Exception{

		System.out.println("/json/updateBranch : POST");
		//Business Logic
		branchService.updateBranch(branch);
		
//		String sessionId=((User)session.getAttribute("user")).getUserId();
//		if(sessionId.equals(user.getUserId())){
//			session.setAttribute("user", user);
//		}
		
	}
	
	
	@GetMapping( value="json/listBranch" )
	public List listUser() throws Exception{
		
		System.out.println("/json/listBranch : GET");
		// Business logic 수행
		Map<String , Object> map=branchService.getBranchList();
		List<Branch> list = (List<Branch>) map.get("list");
		//Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(list);
		
		
		return list;
	}
}