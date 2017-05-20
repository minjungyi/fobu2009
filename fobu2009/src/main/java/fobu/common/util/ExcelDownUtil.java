package main.java.fobu.common.util;

import java.io.*;
import org.springframework.stereotype.Repository;
import jxl.*;
import jxl.write.*;

@Repository
public class ExcelDownUtil {
	// Logger
	//private static Log logger;
	
	public ExcelDownUtil(){
		super();
		//logger = LogFactory.getLog(this.getClass());
	}
	
	public void doExcelDown(String[][] columnData, String[] columnName, String path, String[] columnSize) throws FileNotFoundException, IOException, WriteException{
				
		File fileTmp = new File(path);	
		if(fileTmp.isFile()){
			fileTmp.delete();
		}
		
		WritableWorkbook workbook = Workbook.createWorkbook(fileTmp);
		WritableSheet sheet = workbook.createSheet("Sheet1", 0);
		
		WritableCellFormat format = new WritableCellFormat();
		WritableCellFormat format0 = new WritableCellFormat();
		
		format.setBackground(jxl.format.Colour.GRAY_25);
		format.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
		format.setAlignment(jxl.format.Alignment.CENTRE);
		//format.setWrap(true);
		
		format0.setBackground(jxl.format.Colour.WHITE);
		format0.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
		format0.setAlignment(jxl.format.Alignment.CENTRE);
		//format0.setWrap(true);
		
		jxl.write.Label label = null;
		for(int i = 0 ; i < columnName.length; i++){
			label = new jxl.write.Label(i, 0, columnName[i], format);
			sheet.addCell(label);
			sheet.setColumnView(i, Integer.parseInt(columnSize[i]));
		}
		for(int h = 0; h < columnData.length; h++){
			for(int i = 0; i < columnName.length ; i++){
				label = new jxl.write.Label(i,h+1,columnData[h][i],format0);
				sheet.addCell(label);
			}
		}
		
		workbook.write();
		workbook.close();
	}
	
	public void doExcelDownNoHead(String[][] columnData, String[] columnName, String path, String[] columnSize) throws FileNotFoundException, IOException, WriteException{
		
		File fileTmp = new File(path);	
		if(fileTmp.isFile()){
			fileTmp.delete();
		}
		
		WritableWorkbook workbook = Workbook.createWorkbook(fileTmp);
		WritableSheet sheet = workbook.createSheet("Sheet1", 0);
		
		WritableCellFormat format = new WritableCellFormat();
		WritableCellFormat format0 = new WritableCellFormat();
		
		format.setBackground(jxl.format.Colour.GRAY_25);
		format.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
		format.setAlignment(jxl.format.Alignment.CENTRE);
		//format.setWrap(true);
		
		format0.setBackground(jxl.format.Colour.WHITE);
		format0.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
		format0.setAlignment(jxl.format.Alignment.CENTRE);
		//format0.setWrap(true);
		
		jxl.write.Label label = null;
		
		for(int h = 0; h < columnData.length; h++){
			for(int i = 0; i < columnName.length ; i++){
				label = new jxl.write.Label(i,h,columnData[h][i],format0);
				sheet.addCell(label);
				sheet.setColumnView(i, Integer.parseInt(columnSize[i]));
			}
		}
		
		workbook.write();
		workbook.close();
	}
}