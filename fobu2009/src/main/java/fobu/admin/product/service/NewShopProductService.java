package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.NewShopProductVO;
import main.java.fobu.admin.product.service.NewShopProductListVO;
import main.java.fobu.common.service.CommonFileVO;


/**
 * TotalOrder Service Interface
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public interface NewShopProductService {
	
	
	public List<NewShopProductVO> listNewShopProduct(Map paramMap) throws SQLException;
	
	public int listNewShopProductCount(Map paramMap) throws SQLException;
	
	public int updateNewShopBrandList(NewShopProductListVO newShopProductList,Map paramMap) throws SQLException;
	
	public List<NewShopProductVO> listExcelNewProduct(Map paramMap) throws SQLException;
	
	public List<NewShopProductVO> listExcelNewChocoMall(Map paramMap) throws SQLException;
	
	public void updateRelateOpenMarket(Map paramMap, CommonFileVO fileBean, String path) throws SQLException;
	
}
