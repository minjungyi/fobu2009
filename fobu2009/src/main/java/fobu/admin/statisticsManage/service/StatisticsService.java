package main.java.fobu.admin.statisticsManage.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jxl.write.WriteException;


/**
 * TotalOrder Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface StatisticsService {	
	
	/**
	 * 월별통계목록검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<StatisticsVO> listStatistics(Map paramMap) throws SQLException;
	
	/**
	 * 월별통계목록검색 총건수
	 * @param 
	 * @return int
	 * @throws SQLException 
	 */
	int listStatisticsCount(Map paramMap) throws SQLException;
	
	/**
	 * 일별통계목록검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<StatisticsVO> listStatisticsDaily(Map paramMap) throws SQLException;
	
	/**
	 * 일별통계목록검색 총건수
	 * @param 
	 * @return int
	 * @throws SQLException 
	 */
	int listStatisticsDailyCount(Map paramMap) throws SQLException;
	
	/**
	 * 상품별통계목록검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<StatisticsVO> listStatisticsProduct(Map paramMap) throws SQLException;
	
	/**
	 * 상품별통계목록검색 총건수
	 * @param 
	 * @return int
	 * @throws SQLException 
	 */
	int listStatisticsProductCount(Map paramMap) throws SQLException;
	
	/**
	 * 배송별통계목록검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<StatisticsVO> listStatisticsDelivery(Map paramMap) throws SQLException;
	
	/**
	 * 배송별통계목록검색 총건수
	 * @param 
	 * @return int
	 * @throws SQLException 
	 */
	int listStatisticsDeliveryCount(Map paramMap) throws SQLException;
	
}
