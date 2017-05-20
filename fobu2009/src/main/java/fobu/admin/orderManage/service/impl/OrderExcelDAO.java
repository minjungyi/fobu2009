package main.java.fobu.admin.orderManage.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.orderManage.service.OrderExcelVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class OrderExcelDAO extends AbstractDao {
	
	/**
	 * 업체발주통합검색 - 업체발주 엑셀 목록
	 * @param 
	 * @return OrderExcelVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<OrderExcelVO> listOrderExcel(Map paramMap) throws SQLException {		
		return (List<OrderExcelVO>) list("OrderExcelDAO.listOrderExcel", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<OrderExcelVO> listOrderCompanyExcel(Map paramMap) throws SQLException {		
		return (List<OrderExcelVO>) list("OrderExcelDAO.listOrderCompanyExcel", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<OrderExcelVO> listOrderCompanySumExcel(Map paramMap) throws SQLException {		
		return (List<OrderExcelVO>) list("OrderExcelDAO.listOrderCompanySumExcel", paramMap);
	}
	
	/**
	 * 업체입금검색 - 업체입금 엑셀 목록
	 * @param 
	 * @return OrderExcelVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<OrderExcelVO> listDepositExcel(Map paramMap) throws SQLException {		
		return (List<OrderExcelVO>) list("OrderExcelDAO.listDepositExcel", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public List<OrderExcelVO> listDepositCompanyExcel(Map paramMap) throws SQLException {		
		return (List<OrderExcelVO>) list("OrderExcelDAO.listDepositCompanyExcel", paramMap);
	}
}
