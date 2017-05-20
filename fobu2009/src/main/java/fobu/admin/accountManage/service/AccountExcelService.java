package main.java.fobu.admin.accountManage.service;

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
public interface AccountExcelService {	
	
	/**
	 * 정산목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<AccountVO> listAccountExcel(Map paramMap) throws SQLException;
	
	/**
	 * 정산상태검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<AccountVO> listAccountStat(Map paramMap) throws SQLException;
	
	/**
	 * 정산 후 변경 목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<AccountVO> listAccountAccidentExcel(Map paramMap) throws SQLException;
	
	/**
	 * 정산 후 변경 상태검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<AccountVO> listAccountAccidentStat(Map paramMap) throws SQLException;
}
