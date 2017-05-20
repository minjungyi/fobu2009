package main.java.fobu.admin.orderManage.service;

import java.sql.SQLException;


/**
 * TotalOrder Service Interface
 *
 * @author min™
 * @since 2012. 03. 10.
 */
public interface NewOrderService {
	
	/**
	 * 신규주문 (직송요청) 상세 저장
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	int saveNewOrderProduct(NewOrderListVO NewOrderList) throws SQLException;
	
}
