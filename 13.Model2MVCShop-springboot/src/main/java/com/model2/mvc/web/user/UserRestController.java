package com.model2.mvc.web.user;

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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	@Value("${pageSize}")
	int pageSize;
	
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}
	
	@RequestMapping( value="json/addUser", method=RequestMethod.POST )
	public void addUser( @RequestBody User user ) throws Exception {

		System.out.println("/json/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
	}
	
	@RequestMapping( value="json/updateUser", method=RequestMethod.POST )
	public void updateUser( @RequestBody User user ) throws Exception{

		System.out.println("/json/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
//		String sessionId=((User)session.getAttribute("user")).getUserId();
//		if(sessionId.equals(user.getUserId())){
//			session.setAttribute("user", user);
//		}
		
	}

	@PostMapping( "json/login" )
	public String login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		////////////////////////////////////////////////////////////////////////////////
		// 아이디가 없다면.
		if( dbUser==null ) {
		dbUser = new User();
		return "아이디가 없습니다.";
		}
		/////////////////////////////////////////////////////////////////////////////////
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		} else {
			return "비밀번호가 틀렸습니다.";
		}
		System.out.println(dbUser);
		return "OK";
	}
	
	@RequestMapping( value="json/logout", method=RequestMethod.GET )
	public void logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/json/logout : POST");
		
		session.invalidate();
		
	}
	
	@GetMapping( "json/login" )
	public User loginData( HttpSession session) throws Exception{
		
		User sessionUser = (User) session.getAttribute("user");
		if(sessionUser == null) {
			return new User();
		}
		
		return sessionUser;
	}
	
	
	@RequestMapping( value="json/listUser" )
	public List listUser( @RequestBody Search search ) throws Exception{
		
		System.out.println("/json/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		List<User> list = (List<User>) map.get("list");
		//Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(list);
		
		
		return list;
	}
}