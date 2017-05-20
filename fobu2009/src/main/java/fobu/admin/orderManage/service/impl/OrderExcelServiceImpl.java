package main.java.fobu.admin.orderManage.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.orderManage.service.OrderExcelService;
import main.java.fobu.admin.orderManage.service.OrderExcelVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2012. 03. 10.
 */
@Service
public class OrderExcelServiceImpl implements OrderExcelService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "orderExcelDAO")
	private OrderExcelDAO orderExcelDao;
	
	/**
	 * The Constructor
	 */
	public OrderExcelServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}	
	
	@Override
	public List<OrderExcelVO> listOrderExcel(Map paramMap) throws SQLException {
		List<OrderExcelVO> listTotalOrder = orderExcelDao.listOrderExcel(paramMap);
		return listTotalOrder;
	}
	
	@Override
	public List<OrderExcelVO> listOrderCompanyExcel(Map paramMap) throws SQLException {
		List<OrderExcelVO> listCompany = orderExcelDao.listOrderCompanyExcel(paramMap);
		return listCompany;
	}
	
	@Override
	public List<OrderExcelVO> listOrderCompanySumExcel(Map paramMap) throws SQLException {
		List<OrderExcelVO> listCompanySum = orderExcelDao.listOrderCompanySumExcel(paramMap);
		return listCompanySum;
	}
	
	@Override
	public List<OrderExcelVO> listDepositExcel(Map paramMap) throws SQLException {
		List<OrderExcelVO> listTotalOrder = orderExcelDao.listDepositExcel(paramMap);
		return listTotalOrder;
	}
	
	@Override
	public List<OrderExcelVO> listDepositCompanyExcel(Map paramMap) throws SQLException {
		List<OrderExcelVO> listCompany = orderExcelDao.listDepositCompanyExcel(paramMap);
		return listCompany;
	}
}
