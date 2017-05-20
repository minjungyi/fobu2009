package main.java.fobu.admin.bbs.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jxl.write.WriteException;

import main.java.fobu.admin.product.service.ProductListVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.CommonFileVO;


/**
 * Bbs Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface BbsService {	
	
	/**
	 * BBS 검색
	 * @param 
	 * @return BbsVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<BbsVO> listBbs(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	/**
	 * BBS 상세검색
	 * @param 
	 * @return BbsVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<BbsVO> listDetailBbs(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	/**
	 * BBS Count
	 * @param 
	 * @return int
	 * @throws SQLException 
	 */
	int listBbsCount(Map paramMap) throws SQLException;
	
	/**
	 * BBS insert
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void insertBbs(Map paramMap) throws SQLException;
	
	/**
	 * BBS insert Reply
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void insertReplyBbs(Map paramMap) throws SQLException;
	
	/**
	 * BBS update
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void updateBbs(Map paramMap) throws SQLException;
	
	/**
	 * BBS delete
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void deleteBbs(Map paramMap) throws SQLException;
	
}
