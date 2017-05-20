package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.product.service.ProductSizeOptListVO;
import main.java.fobu.admin.product.service.ProductSizeOptVO;
import main.java.fobu.admin.product.service.ProductStockService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * ProductCategory Service Implementation
 *
 * @author min
 * @since 2011. 10. 12.
 */
@Service
public class ProductStockServiceImpl implements ProductStockService {
	
	// Logger
	@SuppressWarnings("unused")
	private Log logger;
	
	@Resource(name = "productStockDAO")
	private ProductStockDAO productStockDAO;
	
	@Resource(name = "productDAO")
	private ProductDAO productDAO;
	/**
	 * The Constructor
	 */
	public ProductStockServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}	
	
	@Override
	public List<ProductSizeOptVO> listStock(Map paramMap) throws SQLException {
		List<ProductSizeOptVO> listStock = productStockDAO.listStock(paramMap);
		return listStock;
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public int updateProductStock(ProductSizeOptListVO productStock,Map paramMap) throws SQLException {		
		
		try{		
			productStockDAO.deleteProductStock(paramMap);
			productStockDAO.updateProductStock(paramMap);
			
			if(productStock.getSizeOptStock() != null){
				for(int i = 0; i < productStock.getSizeOptStock().length;i++){
					ProductSizeOptVO productSizeOpt = new ProductSizeOptVO();
					
					productSizeOpt.setSizeOpt(productStock.getSizeOpt()[i]);
					productSizeOpt.setSizeOptStock(productStock.getSizeOptStock()[i]);
					productSizeOpt.setuSeq(paramMap.get("uSeq").toString());
					//productSizeOpt.setuSeq(productStock.getuSeq()[i]);
					productSizeOpt.setSeq(productStock.getSeq()[i]);
					
					productDAO.saveProductSizeOpt(productSizeOpt);				
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
}
