package main.java.fobu.admin.excel.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jxl.write.WriteException;


/**
 * ProductExcel Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface ProductExcelService {

	
	/**
	 * 발주검색 - 발주 엑셀 목록
	 * @param 
	 * @return ProductExcelVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<ProductExcelVO> listProductExcel(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	List<ProductExcelVO> listProductCompanyExcel(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	List<ProductExcelVO> listProductCompanySumExcel(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
}
