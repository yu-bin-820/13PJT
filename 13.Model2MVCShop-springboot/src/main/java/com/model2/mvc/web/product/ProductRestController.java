package com.model2.mvc.web.product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	@Value("${pageSize}")
	int pageSize;
	
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct( @PathVariable int prodNo ) throws Exception{
		
		System.out.println("/product/json/getProduct : GET");
		
		//Business Logic
		return productService.findProduct(prodNo);
	}

	@RequestMapping( value="json/addProduct", method=RequestMethod.POST )
	public void addProduct(		@RequestBody Product product ) throws Exception{
	
		System.out.println("/product/json/addProduct : POST");
		
		//Business Logic
		System.out.println("::"+product);
		productService.insertProduct(product);
		
	}
	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
	public void updateProduct(		@RequestBody Product product ) throws Exception{
	
		System.out.println("/product/json/updateProduct : POST");
		//Business Logic
		System.out.println("::"+product);
		productService.updateProduct(product);
		
	}
	
//	@RequestMapping( value="json/listProduct" , method=RequestMethod.POST)
//	public Map listProduct(	@RequestBody Search search ) throws Exception{
//	
//		System.out.println("/product/json/listProduct : POST");
//		//Business Logic
//		System.out.println("::"+search);
//		Map<String, Object> map =productService.getProductList(search);
//		
//		System.out.println(map);
//		return map;
//	}
	
	@RequestMapping( value="json/listProduct" , method=RequestMethod.POST)
	public List listproduct(		@RequestBody Search search ) throws Exception{
	
		System.out.println("/product/json/listProduct : POST");
		//Business Logic
		System.out.println("::"+search);
		search.setPageSize(pageSize);
		Map<String, Object> map =productService.getProductList(search);
		List<Product> list=  (List<Product>) map.get("list");
		System.out.println(list);
		return list;
	}
	
	
	@RequestMapping( value="json/autocompleteProduct/{searchCondition}" , method=RequestMethod.GET)
	public List autocompleteProduct(@PathVariable int searchCondition) throws Exception{
	
		System.out.println("/product/json/autocompleteProduct : GET");
		//Business Logic
		List<String> list = null;
		if(searchCondition == 0 ) {
			list =productService.autocompleteProductNo();
		}else if(searchCondition ==  1) {
			list =productService.autocompleteProductName();
		}else if(searchCondition == 2) {
			list =productService.autocompleteProductPrice();
		}
		
		System.out.println(list);
		return list;
	}
}