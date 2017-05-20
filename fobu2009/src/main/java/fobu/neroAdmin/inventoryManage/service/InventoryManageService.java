package main.java.fobu.neroAdmin.inventoryManage.service;

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
public interface InventoryManageService {	
	
	/**
	 * 네로재고목록검색
	 * @param paramMap
	 * @return InventoryManageVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<InventoryManageVO> listInventoryManage(Map paramMap) throws SQLException;
	
	/**
	 * 네로재고목록검색 총건수
	 * @param paramMap
	 * @return int
	 * @throws SQLException 
	 */
	int listInventoryManageCount(Map paramMap) throws SQLException;
}
