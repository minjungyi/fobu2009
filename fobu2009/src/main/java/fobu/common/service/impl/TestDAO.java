package main.java.fobu.common.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class TestDAO extends AbstractDao {
	
	/**
	 *
	 * @param realmCode
	 * @param odrId
	 * @return TestVO List
	 * @throws SQLException 
	 */
	public String searchTestViewList() throws SQLException {
		Map<String, String> param = new HashMap<String, String>();
		System.out.println("3");
		return (String) getSqlMapClientTemplate().queryForObject("TestDAO.searchTestViewList", param);
	}
}
