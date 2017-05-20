package main.java.fobu.neroAdmin.productInventory.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.neroAdmin.productInventory.service.ProductInventoryService;
import main.java.fobu.neroAdmin.productInventory.service.ProductInventoryVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class ProductInventoryServiceImpl implements ProductInventoryService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "productInventoryDAO")
	private ProductInventoryDAO productInventoryDao;
	
	/**
	 * The Constructor
	 */
	public ProductInventoryServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public List<ProductInventoryVO> listProductInfo(Map paramMap) throws SQLException {
		List<ProductInventoryVO> listProductInfo = productInventoryDao.listProductInfo(paramMap);
		return listProductInfo;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveProductInfo(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifiers", userInfo.getUserId());
		} else {
			paramMap.put("modifiers", "SYSTEM");
		}
		
	    String productSeq = paramMap.get("productSeq").toString();
	    if(productSeq.equals("") || productSeq == null){
	    	productInventoryDao.insertProductInfo(paramMap);	    	
	    }else{
	    	productInventoryDao.updateProductInfo(paramMap);
	    }
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveInventoryInfo(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifiers", userInfo.getUserId());
		} else {
			paramMap.put("modifiers", "SYSTEM");
		}
		
	    productInventoryDao.saveInventoryInfo(paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void updateInventoryInfo(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifiers", userInfo.getUserId());
		} else {
			paramMap.put("modifiers", "SYSTEM");
		}
		
	    productInventoryDao.updateInventoryInfo(paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void deleteInventoryInfo(Map paramMap) throws SQLException {
	    productInventoryDao.deleteInventoryInfo(paramMap);
	}
	
	@Override
	public List<ProductInventoryVO> listProductInventory(Map paramMap) throws SQLException {
		List<ProductInventoryVO> listProductInventory = productInventoryDao.listProductInventory(paramMap);
		return listProductInventory;
	}	
	
	@Override
	public int listProductInventoryCount(Map paramMap) throws SQLException {
		int productInventoryCount = productInventoryDao.listProductInventoryCount(paramMap);
		return productInventoryCount;
	}
}

