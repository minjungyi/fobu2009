package main.java.fobu.admin.product.service.impl;
 
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.NewShopProductListVO;
import main.java.fobu.admin.product.service.NewShopProductVO;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class NewShopProductDAO extends AbstractDao {
	
	
	/**
	 * 대형몰 신제품 관리 정보 조회하기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<NewShopProductVO> listNewShopProduct(Map paramMap) throws SQLException {		
		return (List<NewShopProductVO>) list("NewShopProductDAO.listNewShopProduct", paramMap);
	}
	
	/**
	 * 대형몰 신제품 관리 정보 갯수 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int listNewShopProductCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("NewShopProductDAO.listNewShopProductCount", paramMap));
	}
	
	/**
	 * 대형몰 신제품 관리 브랜드 매핑
	 * @param product
	 * @throws SQLException
	 */
	
	public void updateNewShopBrandList(ProductVO product) throws SQLException {	
		update("NewShopProductDAO.updateNewShopBrandList", product);
	}
	
	/**
	 * 대형몰 신제품 목록 조회(엑셀용)
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<NewShopProductVO> listExcelNewProduct(Map paramMap) throws SQLException {		
		return (List<NewShopProductVO>) list("NewShopProductDAO.listExcelNewProduct", paramMap);
	}
	
	/**
	 * 대형몰 가격연동(샵링커에서 다운받은 엑셀 정보 저장)
	 * @param openMarketMarginVO
	 * @throws SQLException
	 */
	public void updateRelateOpenMarket(OpenMarketMarginVO openMarketMarginVO) throws SQLException {		
		update("NewShopProductDAO.updateRelateOpenMarket", openMarketMarginVO);
	}
	
}
