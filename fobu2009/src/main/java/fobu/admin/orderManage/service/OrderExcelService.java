package main.java.fobu.admin.orderManage.service;

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
public interface OrderExcelService {

	
	/**
	 * 업체발주통합검색 - 업체발주 엑셀 목록
	 * @param 
	 * @return OrderExcelVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<OrderExcelVO> listOrderExcel(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	List<OrderExcelVO> listOrderCompanyExcel(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	List<OrderExcelVO> listOrderCompanySumExcel(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	/**
	 * 업체입금검색 - 업체입금 엑셀 목록
	 * @param 
	 * @return OrderExcelVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<OrderExcelVO> listDepositExcel(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	List<OrderExcelVO> listDepositCompanyExcel(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
}
