package com.model2.mvc.service.product;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

@Mapper
public interface ProductDao {

	public void insertProduct(Product product) throws Exception;
	
	public Product findProduct(int prodNo) throws Exception ;
	
	public void updateProduct(Product product) throws Exception;
	
	public List<Product> getProductList(Search search) throws Exception;
	
	public int getTotalCount(Search search) throws Exception ;
	
	public String makeCurrentPageSql(String sql , Search search) throws Exception ;
	
	public List<String> autocompleteProductName() throws Exception;
	
	public List<String> autocompleteProductNo() throws Exception;
	
	public List<String> autocompleteProductPrice() throws Exception;
	
}
