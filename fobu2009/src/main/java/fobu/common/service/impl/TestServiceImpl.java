package main.java.fobu.common.service.impl;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.write.WriteException;

import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.orderManage.service.impl.TotalOrderDAO;
import main.java.fobu.common.service.TestService;
import main.java.fobu.common.util.ExcelDownUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * Test Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class TestServiceImpl implements TestService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "testDAO")
	private TestDAO testDao;
	
	@Resource(name = "totalOrderDAO")
	private TotalOrderDAO totalOrderDao;
	
	@Resource(name = "excelDownUtil")
	private ExcelDownUtil excelDownUtil;
	
	/**
	 * The Constructor
	 */
	public TestServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public String getTestViewList() throws SQLException {
		System.out.println("2");
		logger.debug("dfsfdsf");
		return testDao.searchTestViewList();
	}
	
	@Override
	public void downExcle(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException {
		List<TotalOrderVO> listTotalOrder = totalOrderDao.listTotalOrder(paramMap);
		String a[] = {"거래처","수집","수집일","최종변경일","상태","주문자","수령자","업체명","제품명","수량","재고","원가","판매가","마진","%","배송"};
		String columnSize[] = {"20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20"};
		String aa[][] = new String[listTotalOrder.size()][a.length];
		for(int i = 0 ; i < listTotalOrder.size() ; i++){
			aa[i][0] = "";
			aa[i][1] = listTotalOrder.get(i).getSiteCode();
			aa[i][2] = listTotalOrder.get(i).getCollectDt();
			aa[i][3] = listTotalOrder.get(i).getModifyDt();
			aa[i][4] = listTotalOrder.get(i).getOrderStat();
			aa[i][5] = listTotalOrder.get(i).getOrderer();
			aa[i][6] = listTotalOrder.get(i).getReceiver();
			aa[i][7] = "";
			aa[i][8] = listTotalOrder.get(i).getProductCode();
			aa[i][9] = listTotalOrder.get(i).getOrderQy();
			aa[i][10] = "";
			aa[i][11] = listTotalOrder.get(i).getOrderPrice();
			aa[i][12] = listTotalOrder.get(i).getOrderPrice();
			aa[i][13] = "";
			aa[i][14] = "";
			aa[i][15] = listTotalOrder.get(i).getDeliverType();			
		}
		excelDownUtil.doExcelDown(aa, a, "", columnSize);
		//return testDao.searchTestViewList();
	}
}
