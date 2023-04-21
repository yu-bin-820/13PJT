package com.model2.mvc.service.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;

@Mapper
public interface PurchaseDao {
	
	public Purchase findPurchase(int tranNo) throws Exception;
	
	public List<Purchase> getPurchaseList(Search search, String userId) throws Exception ;
	
	public void insertPurchase(Purchase purchase) throws Exception;
	
	public void updatePurchase(Purchase purchase) throws Exception;
	
	public void updateTranCodeByProd(Purchase purchase) throws Exception;
	
	public void updateTranCode(Purchase purchase) throws Exception;
	
	public int getTotalCount(String userId) throws Exception;
	
}
