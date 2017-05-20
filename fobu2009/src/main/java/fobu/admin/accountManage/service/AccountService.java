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
public interface AccountService {	
	
	/**
	 * 정산목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<AccountVO> listAccount(Map paramMap) throws SQLException;
	
	/**
	 * 정산목록검색 총건수
	 * @param paramMap
	 * @return int
	 * @throws SQLException 
	 */
	int listAccountCount(Map paramMap) throws SQLException;
	
	/**
	 * 정산상태값 수정
	 * @param paramMap
	 * @return 
	 * @throws SQLException 
	 */
	void saveAccountStat(Map paramMap) throws SQLException;
	
	/**
	 * 정산목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<AccountVO> listAccountGroup(Map paramMap) throws SQLException;
	
	/**
	 * 정산목록검색 총건수
	 * @param paramMap
	 * @return int
	 * @throws SQLException 
	 */
	int listAccountGroupCount(Map paramMap) throws SQLException;
	
	
	
	
	
	
	
	
	
	/**
	 * 정산 후 변경 목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<AccountVO> listAccountAccident(Map paramMap) throws SQLException;
	
	/**
	 * 정산 후 변경 목록검색 총건수
	 * @param paramMap
	 * @return int
	 * @throws SQLException 
	 */
	int listAccountAccidentCount(Map paramMap) throws SQLException;
	
	/**
	 * 정산 후 변경 상태값 수정
	 * @param paramMap
	 * @return 
	 * @throws SQLException 
	 */
	void saveAccountAccidentStat(Map paramMap) throws SQLException;
	
	/**
	 * 정산 후 변경 목록검색
	 * @param paramMap
	 * @return AccountVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<AccountVO> listAccountAccidentGroup(Map paramMap) throws SQLException;
	
	/**
	 * 정산목록검색 총건수
	 * @param paramMap
	 * @return int
	 * @throws SQLException 
	 */
	int listAccountAccidentGroupCount(Map paramMap) throws SQLException;
}
