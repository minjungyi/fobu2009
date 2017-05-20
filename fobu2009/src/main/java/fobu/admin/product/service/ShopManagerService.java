package main.java.fobu.admin.product.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.OpenMarketMarginListVO;
import main.java.fobu.common.service.CommonFileVO;


/**
 * TotalOrder Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface ShopManagerService {
	
	public List<OpenMarketMarginVO> listOpenMarketMargin(Map paramMap) throws SQLException;
	public int listOpenMarketMarginCount(Map paramMap) throws SQLException;
	public int updateOpenMarketMarginList(OpenMarketMarginListVO openMarketMarginList) throws SQLException;
	public List<OpenMarketMarginVO> listRecommendOpenMarket(Map paramMap) throws SQLException;
	public List<OpenMarketMarginVO> listRecommendOpenMarket2(Map paramMap) throws SQLException;
	public List<OpenMarketMarginVO> listSoldOutUrl(Map paramMap) throws SQLException;
	public int updateSoldOutUrl(Map paramMap) throws SQLException;
	public void saveDummySoldout(Map paramMap, CommonFileVO fileBean, String path) throws SQLException;
	public List<DummySoldoutVO> listDummySoldout1(Map paramMap) throws SQLException;
	public List<DummySoldoutVO> listDummySoldout2(Map paramMap) throws SQLException;
	public List<DummySoldoutVO> listDummySoldout3(Map paramMap) throws SQLException;
	public int updateDummySoldout(Map paramMap) throws SQLException;
	public int updateDummySoldout2(Map paramMap) throws SQLException;
}
