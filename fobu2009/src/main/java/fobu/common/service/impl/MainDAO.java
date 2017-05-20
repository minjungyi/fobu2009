package main.java.fobu.common.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.common.service.MainVO;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class MainDAO extends AbstractDao {

	
	/**
	 * main 일(daily) 현황 검색
	 * @param 
	 * @return MainVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<MainVO> listMainDaily(Map paramMap) throws SQLException {		
		return (List<MainVO>) list("MainDAO.listMainDaily", paramMap);
	}
	
	/**
	 * main 월(month) 현황 검색
	 * @param 
	 * @return MainVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<MainVO> listMainMonth(Map paramMap) throws SQLException {		
		return (List<MainVO>) list("MainDAO.listMainMonth", paramMap);
	}

}
