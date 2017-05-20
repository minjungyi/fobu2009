package main.java.fobu.neroAdmin.inventoryManage.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.common.service.impl.AbstractDao;
import main.java.fobu.neroAdmin.inventoryManage.service.InventoryManageVO;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min™
 * @since 2010. 09. 10.
 */
@Repository
public class InventoryManageDAO extends AbstractDao {
	
	/**
	 * 네로재고목록검색
	 * @param paramMap
	 * @return InventoryManageVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<InventoryManageVO> listInventoryManage(Map paramMap) throws SQLException {
		return (List<InventoryManageVO>) list("InventoryManageDAO.listInventoryManage", paramMap);
	}
	
	/**
	 * 네로재고목록검색 총건수
	 * @param paramMap
	 * @return InventoryManageVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listInventoryManageCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("InventoryManageDAO.listInventoryManageCount", paramMap));
	}
}
