package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService {

	///Field
	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;
	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}
	
	//Constructor
	public ProductServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void insertProduct(Product product) throws Exception {
		productDao.insertProduct(product);
	}

	@Override
	public Product findProduct(int prodNo) throws Exception {
		return productDao.findProduct(prodNo);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		productDao.updateProduct(product);
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		List<Product> list= productDao.getProductList(search);
		int totalCount = productDao.getTotalCount(search);
		
		System.out.println("service"+list);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public List<String> autocompleteProductName() throws Exception {
		List<String> list = productDao.autocompleteProductName();
		
		System.out.println("productServiceImpl:"+list);
		
		return list;
	}
	
	@Override
	public List<String> autocompleteProductNo() throws Exception {
		List<String> list = productDao.autocompleteProductNo();
		
		System.out.println("productServiceImpl:"+list);
		
		return list;
	}
	
	@Override
	public List<String> autocompleteProductPrice() throws Exception {
		List<String> list = productDao.autocompleteProductPrice();
		
		System.out.println("productServiceImpl:"+list);
		
		return list;
	}

}
