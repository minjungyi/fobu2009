package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.DummySoldoutVO;
import main.java.fobu.admin.product.service.EnterpriseOrderVO;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
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
public class ShopManagerDAO extends AbstractDao {
	
	
	/**
	 * 오픈마켓 가격책정 목록 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<OpenMarketMarginVO> listOpenMarketMargin(Map paramMap) throws SQLException {		
		return (List<OpenMarketMarginVO>) list("ShopManagerDAO.listOpenMarketMargin", paramMap);
	}
	
	/**
	 * 오픈마켓 가격책정 목록 갯수 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public int listOpenMarketMarginCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("ShopManagerDAO.listOpenMarketMarginCount", paramMap));
	}
	
	/**
	 * 거래처(업체) 수정
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void updateOpenMarketMargin(OpenMarketMarginVO openMarketMargin) throws SQLException {	
		
		update("ShopManagerDAO.updateOpenMarketMargin", openMarketMargin);
	}
	
	/**
	 * 오픈마켓 가격책성 저장
	 * @param openMarketMargin
	 * @throws SQLException
	 */
	public void saveOpenMarketMargin(OpenMarketMarginVO openMarketMargin) throws SQLException {
		update("ShopManagerDAO.saveOpenMarketMargin", openMarketMargin);
	}
	
	/**
	 * 오픈마켓 추천리스트 목록(Iframe)
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<OpenMarketMarginVO> listRecommendOpenMarket(Map paramMap) throws SQLException {		
		return (List<OpenMarketMarginVO>) list("ShopManagerDAO.listRecommendOpenMarket", paramMap);
	}
	
	/**
	 * 오픈마켓 추천리스트 2차 카테고리 목록(Iframe)
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<ProductCategoryVO> listRecommendOpenMarketCategory(Map paramMap) throws SQLException {		
		return (List<ProductCategoryVO>) list("ShopManagerDAO.listRecommendOpenMarketCategory", paramMap);
	}
	
	/**
	 *	오픈마켓 key 확인
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	public Object checkOpenMarketSeq(OpenMarketMarginVO openMarketMargin) throws SQLException {		
		return (Object) getSqlMapClientTemplate().queryForObject("ShopManagerDAO.listCheckOpenMarket", openMarketMargin);
	}	
	
	/**
	 * 오픈마켓 추천리스트 목록(Iframe)
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<OpenMarketMarginVO> listRecommendOpenMarket2(Map paramMap) throws SQLException {		
		return (List<OpenMarketMarginVO>) list("ShopManagerDAO.listRecommendOpenMarket2", paramMap);
	}
	
	/**
	 * 오픈마켓별 조회수 업데이트
	 * @param paramMap
	 * @throws SQLException
	 */
	public void updateOpenMarketHitCount(Map paramMap) throws SQLException {	
		
		update("ShopManagerDAO.updateOpenMarketHitCount", paramMap);
	}
	
	/**
	 * 오픈 마켓별 품절연동 동기화 
	 * @param paramMap
	 * @throws SQLException
	 */
	public void updateSoldOutUrl(Map paramMap) throws SQLException {	
		
		if(paramMap.get("marketType").equals("sun")){
			update("ShopManagerDAO.updateSoldOutUrl2", paramMap);
		}else{
			update("ShopManagerDAO.updateSoldOutUrl", paramMap);
		}
		
	}
	
	/**
	 * 품절연동을 위한 오픈마켓별 상품번호 가져오기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	public List<OpenMarketMarginVO> listSoldOutUrl(Map paramMap) throws SQLException {		
		return (List<OpenMarketMarginVO>) list("ShopManagerDAO.listSoldOutUrl", paramMap);
	}
	
	/**
	 * 오픈마켓/관리자 삭제목록 항목 저장.(오픈마켓에 판매중인 항목 dummy저장)
	 * @param dummySoldout
	 * @throws SQLException
	 */
	public void saveDummySoldout(DummySoldoutVO dummySoldout) throws SQLException {
		update("ShopManagerDAO.saveDummySoldout", dummySoldout);
	}
	
	public void deleteDummySoldout() throws SQLException {	
		delete("ShopManagerDAO.deleteDummySoldout","");
	}
	
	@SuppressWarnings("unchecked")
	public List<DummySoldoutVO> listDummySoldout2(Map paramMap) throws SQLException {		
		return (List<DummySoldoutVO>) list("ShopManagerDAO.listDummySoldout2", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<DummySoldoutVO> listDummySoldout1(Map paramMap) throws SQLException {		
		return (List<DummySoldoutVO>) list("ShopManagerDAO.listDummySoldout1", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<DummySoldoutVO> listDummySoldout3(Map paramMap) throws SQLException
	{
		return  (List<DummySoldoutVO>)list("ShopManagerDAO.listDummySoldout3", paramMap);
	}
	
	public void updateDummySoldout(Map paramMap) throws SQLException {	
		update("ShopManagerDAO.updateDummySoldout", paramMap);
	}
	
	public void updateDummySoldout2(Map paramMap) throws SQLException
	{
		update("ShopManagerDAO.updateDummySoldout2", paramMap);
	}
}
