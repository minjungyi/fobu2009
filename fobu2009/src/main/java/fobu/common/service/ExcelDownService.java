package main.java.fobu.common.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;


import jxl.write.WriteException;


public interface ExcelDownService {
	
	//엑셀다운
	/**
	 * 
	 * @param 
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	@SuppressWarnings("unchecked")
	void deliveryCompleteExcel(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	@SuppressWarnings("unchecked")
	void exportDeliveryExcel(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	@SuppressWarnings("unchecked")
	void enterpriseOrderExcel(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	@SuppressWarnings("unchecked")
	void enterpriseOrderExcelEtc(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	@SuppressWarnings("unchecked")
	void enterpriseDepositExcel(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	@SuppressWarnings("unchecked")
	void productListExce(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException;
	
}
