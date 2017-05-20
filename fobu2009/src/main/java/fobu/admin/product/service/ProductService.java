package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.OpenMarketMarginListVO;
import main.java.fobu.common.service.CommonFileVO;


/**
 * TotalOrder Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface ProductService {
	
	public int saveProduct(ProductVO paramMap, List<CommonFileVO> fileBeanList) throws SQLException;
	public int updateProduct(ProductVO paramMap, List<CommonFileVO> fileBeanList) throws SQLException;
	public List<ProductCompanyVO> listCompany(Map paramMap) throws SQLException;
	public int listProductCount(Map paramMap) throws SQLException;
	public List<ProductVO> listProduct(Map paramMap) throws SQLException;
	public int updateProductList(ProductListVO productList) throws SQLException;
	public List<ProductVO> listProductDetail(String seq) throws SQLException;
	public int getProductLastSeq() throws SQLException;
	public int insertEnterpriseOrderList(ProductListVO productList) throws SQLException;
	public int updateProductList2(ProductListVO productList) throws SQLException;
	public int saveNewProductExcel(Map paramMap, CommonFileVO fileBean, String path) throws SQLException ;
	
	
}
