package com.model2.mvc.web.purchase;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method 구현 않음
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
		
	@Value("${pageSize}")
	int pageSize;
	
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
//	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
//	public Product getProduct( @PathVariable int prodNo ) throws Exception{
//		
//		System.out.println("/product/json/getProduct : GET");
//		
//		//Business Logic
//		return productService.findProduct(prodNo);
//	}
//
	@PostMapping("json/addPurchase")
	public void addProduct(	@RequestBody Purchase purchase ) throws Exception{
	
		System.out.println("/product/json/addPurchase : POST");
		
		System.out.println(purchase);
		
		purchase.setPurchaseProd(productService.findProduct(purchase.getProdNo()));
		purchase.setBuyer(userService.getUser(purchase.getUserId()));
		System.out.println(purchase);
		//Business Logic
		purchaseService.addPurchase(purchase);
		
	}
	
//	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
//	public void updateProduct(		@RequestBody Product product ) throws Exception{
//	
//		System.out.println("/product/json/updateProduct : POST");
//		//Business Logic
//		System.out.println("::"+product);
//		productService.updateProduct(product);
//		
//	}
	
	@RequestMapping( value="json/updateTranCodeByProd", method=RequestMethod.GET )
	public void updateTranCodeByProd(	@RequestParam("prodNo") int prodNo, 
								@RequestParam("tranCode") String tranCode ) throws Exception{
	
		System.out.println("/purchase/json/updateTranCodeByProd : GET");
		
		
		Purchase purchase = new Purchase();
		purchase.setTranCode(tranCode);
		purchase.setPurchaseProd(productService.findProduct(prodNo));
		//Business Logic
		purchaseService.updateTranCodeByProd(purchase);
		
	}
	
	@RequestMapping( value="json/updateTranCode", method=RequestMethod.GET )
	public void updateTranCode(	@RequestParam("tranNo") int tranNo, 
								@RequestParam("tranCode") String tranCode ) throws Exception{
	
		System.out.println("/purchase/json/updateTranCode : GET");
		
		
		Purchase purchase = new Purchase();
		purchase.setTranCode(tranCode);
		purchase.setTranNo(tranNo);
		System.out.println(purchase.getTranNo());
		//Business Logic
		purchaseService.updateTranCode(purchase);
		
	}
	
	@RequestMapping( value="json/getTranAddr" , method=RequestMethod.POST)
	public List getTranAddr(	@RequestBody Map mapBounds ) throws Exception{
	
		System.out.println("/purchase/json/getTranAddr : POST");

		
		//Business Logic
		Map<String , Object> map = purchaseService.getTranAddrNew(mapBounds);
		List<Purchase> list = (List<Purchase>) map.get("list");
		
		//System.out.println(list);
		return list;
	}
	
	
	@GetMapping("json/listPurchase/{userId}")
	public List listPruchase(@PathVariable String userId ) throws Exception{
	
		System.out.println("/product/json/listPurchase : Get");
		System.out.println(userId);
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(50);
		User user = userService.getUser(userId);
		//Business Logic
		Map<String, Object> map=purchaseService.getPurchaseList(search,user);
		List<Product> list=  (List<Product>) map.get("list");
		System.out.println(list);
		return list;
	}
	
//	@RequestMapping( value="json/listProduct" , method=RequestMethod.POST)
//	public List listproduct(		@RequestBody Search search ) throws Exception{
//	
//		System.out.println("/product/json/listProduct : POST");
//		//Business Logic
//		System.out.println("::"+search);
//		search.setPageSize(pageSize);
//		Map<String, Object> map =productService.getProductList(search);
//		List<Product> list=  (List<Product>) map.get("list");
//		System.out.println(list);
//		return list;
//	}
//	
//	
//	@RequestMapping( value="json/autocompleteProduct" , method=RequestMethod.GET)
//	public List autocompleteProduct() throws Exception{
//	
//		System.out.println("/product/json/autocompleteProduct : GET");
//		//Business Logic
//		List<String> list =productService.autocompleteProduct();
//		System.out.println(list);
//		return list;
//	}
}