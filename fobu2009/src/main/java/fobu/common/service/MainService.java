package main.java.fobu.common.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jxl.write.WriteException;


/**
 * Main Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface MainService {
	
	/**
	 * main 일(daily) 현황 검색
	 * @param 
	 * @return MainVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<MainVO> listMainDaily(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	/**
	 * main 월(month) 현황 검색
	 * @param 
	 * @return MainVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<MainVO> listMainMonth(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
}
