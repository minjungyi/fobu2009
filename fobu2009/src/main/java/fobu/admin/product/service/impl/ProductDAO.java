package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductSizeOptVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class ProductDAO extends AbstractDao {
	
	/**
	 * 제품 등록 시퀀스 가져오기
	 * @return
	 * @throws SQLException
	 */
	public int getProductLastSeq() throws SQLException{
		int seq = 0;
		Object obj = getSqlMapClientTemplate().queryForObject("ProductDAO.getLastInsertID", null);
		
		if(obj != null) seq = (Integer)obj;
		seq++;
		return seq;
	}
	
	/**
	 * 제품 등록
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void saveProduct(ProductVO product) throws SQLException {			
		
		update("ProductDAO.saveProduct", product);		
	}
	
	/**
	 * 제품 사이즈 별 정보(수량) 등록
	 * @param product
	 * @return
	 * @throws SQLException
	 */
	public void saveProductSizeOpt(ProductSizeOptVO productSizeOpt) throws SQLException {		
		
		update("ProductDAO.saveProductSizeOpt", productSizeOpt);

	}
	
	/**
	 * 제품 수정
	 * @param 
	 * @return ProductVO List
	 * @throws SQLException 
	 */
	public void updateProduct(ProductVO product) throws SQLException {	
		
		update("ProductDAO.updateProduct", product);
		
		return;
	}
	
	/**
	 * 제품 재고 발수 원가 판매가 소비자가 수정
	 * @param product
	 * @throws SQLException
	 */
	public void updateProductList(ProductVO product) throws SQLException {	
		
		update("ProductDAO.updateProductList", product);
	}
	
	/**
	 * 제품 재고 발수 원가 판매가 소비자가 수정
	 * @param product
	 * @throws SQLException
	 */
	public void updateProductList2(ProductVO product) throws SQLException {	
		
		update("ProductDAO.updateProductList2", product);
	}
	
	
	

	/**
	 *	업체 정보 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ProductCompanyVO> listCompany(Map paramMap) throws SQLException {		
		return (List<ProductCompanyVO>) list("ProductDAO.listCompany", paramMap);
	}
	
	
	/**
	 * 제품통합검색 총건수
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int listProductCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("ProductDAO.listProductCount", paramMap));
	}
	
	/**
	 * 제품통합검색
	 * @param 
	 * @return ProductVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<ProductVO> listProduct(Map paramMap) throws SQLException {		
		return (List<ProductVO>) list("ProductDAO.listProduct", paramMap);
	}
		
	
	/**
	 *	제품 상세정보 가져오기(단건)
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ProductVO> listProductDetail(String seq) throws SQLException {	
		Map<String, String> param = new HashMap<String, String>();
		param.put("seq", seq);
		return (List<ProductVO>) list("ProductDAO.listProductDetail", param);
	}

	/**
	 * 제품통합검색(엑셀)
	 * @param 
	 * @return ProductVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<ProductVO> listProductExcel(Map paramMap) throws SQLException {		
		return (List<ProductVO>) list("ProductDAO.listProductExcel", paramMap);
	}
}
