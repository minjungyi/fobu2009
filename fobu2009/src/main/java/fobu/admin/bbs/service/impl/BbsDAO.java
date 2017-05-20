package main.java.fobu.admin.bbs.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.bbs.service.BbsVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class BbsDAO extends AbstractDao {
	
	/**
	 * BBS 검색
	 * @param 
	 * @return BbsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<BbsVO> listBbs(Map paramMap) throws SQLException {		
		return (List<BbsVO>) list("BbsDAO.listBbs", paramMap);
	}
	
	/**
	 * BBS 상세검색
	 * @param 
	 * @return BbsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<BbsVO> listDetailBbs(Map paramMap) throws SQLException {		
		return (List<BbsVO>) list("BbsDAO.listDetailBbs", paramMap);
	}
	
	/**
	 * BBS Count
	 * @param 
	 * @return BbsVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listBbsCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("BbsDAO.listBbsCount", paramMap));
	}
	
	/**
	 * BBS insert
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void insertBbs(Map paramMap) throws SQLException {		
		update("BbsDAO.insertBbs", paramMap);
	}
	
	/**
	 * BBS insert Reply
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void insertReplyBbs(Map paramMap) throws SQLException {		
		update("BbsDAO.insertReplyBbs", paramMap);
	}
	
	/**
	 * BBS update
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void updateBbs(Map paramMap) throws SQLException {		
		update("BbsDAO.updateBbs", paramMap);
	}
	
	/**
	 * BBS delete
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void deleteBbs(Map paramMap) throws SQLException {		
		update("BbsDAO.deleteBbs", paramMap);
	}
}
