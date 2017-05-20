package main.java.fobu.admin.statisticsManage.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.statisticsManage.service.StatisticsService;
import main.java.fobu.admin.statisticsManage.service.StatisticsVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class StatisticsServiceImpl implements StatisticsService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "statisticsDAO")
	private StatisticsDAO statisticsDao;
	
	/**
	 * The Constructor
	 */
	public StatisticsServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public List<StatisticsVO> listStatistics(Map paramMap) throws SQLException {
		List<StatisticsVO> listStatistics = statisticsDao.listStatistics(paramMap);
		return listStatistics;
	}	
	
	@Override
	public int listStatisticsCount(Map paramMap) throws SQLException {
		int statisticsCount = statisticsDao.listStatisticsCount(paramMap);
		return statisticsCount;
	}
	
	@Override
	public List<StatisticsVO> listStatisticsDaily(Map paramMap) throws SQLException {
		List<StatisticsVO> listStatistics = statisticsDao.listStatisticsDaily(paramMap);
		return listStatistics;
	}	
	
	@Override
	public int listStatisticsDailyCount(Map paramMap) throws SQLException {
		int statisticsCount = statisticsDao.listStatisticsDailyCount(paramMap);
		return statisticsCount;
	}
	
	@Override
	public List<StatisticsVO> listStatisticsProduct(Map paramMap) throws SQLException {
		List<StatisticsVO> listStatisticsProduct = statisticsDao.listStatisticsProduct(paramMap);
		return listStatisticsProduct;
	}	
	
	@Override
	public int listStatisticsProductCount(Map paramMap) throws SQLException {
		int statisticsProductCount = statisticsDao.listStatisticsProductCount(paramMap);
		return statisticsProductCount;
	}
	
	@Override
	public List<StatisticsVO> listStatisticsDelivery(Map paramMap) throws SQLException {
		List<StatisticsVO> listStatisticsDelivery = statisticsDao.listStatisticsDelivery(paramMap);
		return listStatisticsDelivery;
	}	
	
	@Override
	public int listStatisticsDeliveryCount(Map paramMap) throws SQLException {
		int statisticsDeliveryCount = statisticsDao.listStatisticsDeliveryCount(paramMap);
		return statisticsDeliveryCount;
	}
}
