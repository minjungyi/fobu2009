package main.java.fobu.admin.operationBbs.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.operationBbs.service.OperationBbsVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class OperationBbsDAO extends AbstractDao {
	
	/**
	 * 작업요청게시판 검색
	 * @param 
	 * @return OperationBbsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<OperationBbsVO> listOperationBbs(Map paramMap) throws SQLException {		
		return (List<OperationBbsVO>) list("OperationBbsDAO.listOperationBbs", paramMap);
	}
	
	/**
	 * 작업요청게시판 상세검색
	 * @param 
	 * @return OperationBbsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<OperationBbsVO> listDetailOperationBbs(Map paramMap) throws SQLException {		
		return (List<OperationBbsVO>) list("OperationBbsDAO.listDetailOperationBbs", paramMap);
	}
	
	/**
	 * 작업요청게시판 Count
	 * @param 
	 * @return OperationBbsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listOperationBbsCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("OperationBbsDAO.listOperationBbsCount", paramMap));
	}
	
	/**
	 * 작업요청게시판 insert
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void insertOperationBbs(Map paramMap) throws SQLException {		
		update("OperationBbsDAO.insertOperationBbs", paramMap);
	}
	
	/**
	 * 작업요청게시판 insert Reply
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void insertReplyOperationBbs(Map paramMap) throws SQLException {		
		update("OperationBbsDAO.insertReplyOperationBbs", paramMap);
	}
	
	/**
	 * 작업요청게시판 update
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void updateOperationBbs(Map paramMap) throws SQLException {		
		update("OperationBbsDAO.updateOperationBbs", paramMap);
	}
	
	/**
	 * 작업요청게시판 delete
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void deleteOperationBbs(Map paramMap) throws SQLException {		
		update("OperationBbsDAO.deleteOperationBbs", paramMap);
	}
}
