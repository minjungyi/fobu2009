package main.java.fobu.common.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import jxl.write.WriteException;

/**
 * Test Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface TestService {
	
	/**
	 * 
	 * @param 
	 * @return TestVO List
	 * @throws SQLException 
	 */
	String getTestViewList() throws SQLException;	
	
	/**
	 * 
	 * @param 
	 * @return TestVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	void downExcle(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
}
