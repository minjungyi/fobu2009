package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import main.java.fobu.admin.product.service.ProductCategoryService;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.UserVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * ProductCategory Service Implementation
 *
 * @author min
 * @since 2011. 10. 12.
 */
@Service
public class ProductCategoryServiceImpl implements ProductCategoryService {
	
	// Logger
	@SuppressWarnings("unused")
	private Log logger;
	
	@Resource(name = "productCategoryDAO")
	private ProductCategoryDAO productCategoryDAO;
	
	/**
	 * The Constructor
	 */
	public ProductCategoryServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}	
	
	@Override
	public List<ProductCategoryVO> listCategory(Map paramMap) throws SQLException {
		List<ProductCategoryVO> listCategory = productCategoryDAO.listCategory(paramMap);
		return listCategory;
	}
	
	@Override
	public int saveProductCategory(ProductCategoryVO ProductCategory) throws SQLException {	
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
    	    	
		try{
			if(ProductCategory.getStatus().equals("I")){
				int codeTmp = 0;
				Object obj = productCategoryDAO.getLastInsertID();
				if(obj != null) codeTmp = Integer.parseInt(obj.toString());
		    	//UserVO userVO = (UserVO)session.getAttribute("userInfo");	
				codeTmp++;
				ProductCategory.setCode(Integer.toString(codeTmp));
				ProductCategory.setCreator(userInfo.getUserId());				
				productCategoryDAO.insertProductCategory(ProductCategory);		
			}else if(ProductCategory.getStatus().equals("U")){
				ProductCategory.setModifier(userInfo.getUserId());
				//ProductCategory.setModifier("newsun");
				productCategoryDAO.updateProductCategory(ProductCategory);		
			}else{
				productCategoryDAO.deleteProductCategory(ProductCategory);	
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@Override
	public int updateProductCategory2(ProductVO product) throws SQLException {		
		
		try{	
			productCategoryDAO.updateProductCategory2(product);
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@Override
	public int updateProductCategorySort(ProductCategoryVO ProductCategory) throws SQLException {		
		
		try{	
			productCategoryDAO.updateProductCategorySort(ProductCategory);
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public int updateProductCategoryInit(Map paramMap) throws SQLException {		
		
		try{	
			UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
			paramMap.put("userId", userInfo.getLoginId());
			
			productCategoryDAO.updateProductCategoryInit(paramMap);
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
}
