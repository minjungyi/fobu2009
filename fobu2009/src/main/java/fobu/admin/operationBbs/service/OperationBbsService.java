package main.java.fobu.admin.operationBbs.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jxl.write.WriteException;


/**
 * OperationBbs Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface OperationBbsService {	
	
	/**
	 * 작업요청게시판 검색
	 * @param 
	 * @return OperationBbsVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<OperationBbsVO> listOperationBbs(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	/**
	 * 작업요청게시판 상세검색
	 * @param 
	 * @return OperationBbsVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<OperationBbsVO> listDetailOperationBbs(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	/**
	 * 작업요청게시판 Count
	 * @param 
	 * @return int
	 * @throws SQLException 
	 */
	int listOperationBbsCount(Map paramMap) throws SQLException;
	
	/**
	 * 작업요청게시판 insert
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void insertOperationBbs(Map paramMap) throws SQLException;
	
	/**
	 * 작업요청게시판 insert Reply
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void insertReplyOperationBbs(Map paramMap) throws SQLException;
	
	/**
	 * 작업요청게시판 update
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void updateOperationBbs(Map paramMap) throws SQLException;
	
	/**
	 * 작업요청게시판 delete
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void deleteOperationBbs(Map paramMap) throws SQLException;
	
}
