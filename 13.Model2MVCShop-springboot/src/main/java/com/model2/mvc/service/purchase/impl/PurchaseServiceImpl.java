package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductDao;
//import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{
	
	///Field

	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;
	
	@Autowired
	@Qualifier("purchaseDao")
	private PurchaseDao purchaseDao;
	
	public PurchaseServiceImpl() {

	}
	
	public Map<String, Object> addPurchaseView() throws Exception{
		
		
		return null;
	}

	public Purchase getPurchase(int tranNo) throws Exception {
		//System.out.println(purchaseDAO.findPurchase(prodNo).getPurchaseProd());
		
		return purchaseDao.findPurchase(tranNo);
	}

	@Override
	public void addPurchase(Purchase purchase) throws Exception{
		// TODO Auto-generated method stub
		purchaseDao.insertPurchase(purchase);
		System.out.println();
		purchaseDao.insertPurchaseAddr(purchase);
	}


	@Override
	public Map<String, Object> getPurchaseList(Search search, User user) throws Exception {
		System.out.println(user);
		List<Purchase> list = purchaseDao.getPurchaseList(search, user);
		//System.out.println("getPurchaseList수행 완료");
		int totalCount = purchaseDao.getTotalCount(user);
		//System.out.println("getTotalCount수행완료");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override
	public Map<String, Object> getSaleList(Search searchvo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		purchaseDao.updatePurchase(purchase);	
	}

	@Override
	public void updateTranCodeByProd(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		purchaseDao.updateTranCodeByProd(purchase);	
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(purchase.getTranNo());
		purchaseDao.updateTranCode(purchase);
	}

	@Override
	public Map<String, Object> getTranAddr() throws Exception {
		// TODO Auto-generated method stub
		List<Purchase> list= purchaseDao.getTranAddr();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list );

		return map;
	}

	@Override
	public Map<String, Object> getTranAddrNew(Map<String, String> mapBounds) throws Exception {
		// TODO Auto-generated method stub
		List<Purchase> list= purchaseDao.getTranAddrNew(mapBounds);
		System.out.println(list);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list );

		return map;
	}

}
