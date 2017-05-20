package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import main.java.fobu.admin.product.service.ProductBrandService;
import main.java.fobu.admin.product.service.ProductBrandVO;
import main.java.fobu.common.service.UserVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * ProductBrand Service Implementation
 *
 * @author min
 * @since 2011. 10. 12.
 */
@Service
public class ProductBrandServiceImpl implements ProductBrandService {
	
	// Logger
	@SuppressWarnings("unused")
	private Log logger;
	
	@Resource(name = "productBrandDAO")
	private ProductBrandDAO productBrandDAO;
	
	/**
	 * The Constructor
	 */
	public ProductBrandServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ProductBrandVO> listBrand(Map paramMap) throws SQLException {
		List<ProductBrandVO> listBrand = productBrandDAO.listBrand(paramMap);
		return listBrand;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ProductBrandVO> listBrandDetail(Map paramMap) throws SQLException {
		List<ProductBrandVO> listBrandDetail = productBrandDAO.listBrandDetail(paramMap);
		return listBrandDetail;
	}
	
	@Override
	public int saveProductBrand(ProductBrandVO ProductBrand) throws SQLException {	
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
    	    	
		try{
			if(ProductBrand.getCode() == null || ProductBrand.getCode().equals("")){
				int codeTmp = 0;
				Object obj = productBrandDAO.getLastInsertID();
				if(obj != null) codeTmp = Integer.parseInt(obj.toString());
		    	//UserVO userVO = (UserVO)session.getAttribute("userInfo");	
				codeTmp++;
				ProductBrand.setCode(Integer.toString(codeTmp));
				ProductBrand.setCreator(userInfo.getUserId());
				productBrandDAO.insertProductBrand(ProductBrand);		
			}else{
				ProductBrand.setModifier(userInfo.getUserId());
				productBrandDAO.updateProductBrand(ProductBrand);		
			}		
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}	
}
