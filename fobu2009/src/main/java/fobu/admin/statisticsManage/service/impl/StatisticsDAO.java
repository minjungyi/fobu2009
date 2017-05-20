package main.java.fobu.admin.statisticsManage.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.statisticsManage.service.StatisticsVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class StatisticsDAO extends AbstractDao {
	
	/**
	 * 월별통계목록검색   
	 * @param 
	 * @param 
	 * @return StatisticsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<StatisticsVO> listStatistics(Map paramMap) throws SQLException {
		return (List<StatisticsVO>) list("StatisticsDAO.listStatistics", paramMap);
	}
	
	/**
	 * 월별통계목록검색 총건수
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listStatisticsCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("StatisticsDAO.listStatisticsCount", paramMap));
	}
	
	/**
	 * 일별통계목록검색   
	 * @param 
	 * @param 
	 * @return StatisticsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<StatisticsVO> listStatisticsDaily(Map paramMap) throws SQLException {
		return (List<StatisticsVO>) list("StatisticsDAO.listStatisticsDaily", paramMap);
	}
	
	/**
	 * 일별통계목록검색 총건수
	 * @param 
	 * @return StatisticsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listStatisticsDailyCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("StatisticsDAO.listStatisticsDailyCount", paramMap));
	}
	
	/**
	 * 상품별통계목록검색   
	 * @param 
	 * @param 
	 * @return StatisticsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<StatisticsVO> listStatisticsProduct(Map paramMap) throws SQLException {
		return (List<StatisticsVO>) list("StatisticsDAO.listStatisticsProduct", paramMap);
	}
	
	/**
	 * 상품별통계목록검색 총건수
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listStatisticsProductCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("StatisticsDAO.listStatisticsProductCount", paramMap));
	}
	
	/**
	 * 배송별통계목록검색   
	 * @param 
	 * @param 
	 * @return StatisticsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<StatisticsVO> listStatisticsDelivery(Map paramMap) throws SQLException {
		return (List<StatisticsVO>) list("StatisticsDAO.listStatisticsDelivery", paramMap);
	}
	
	/**
	 * 배송별통계목록검색 총건수
	 * @param 
	 * @return StatisticsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listStatisticsDeliveryCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("StatisticsDAO.listStatisticsDeliveryCount", paramMap));
	}
}
