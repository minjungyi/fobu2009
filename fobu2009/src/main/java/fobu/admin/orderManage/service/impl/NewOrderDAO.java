package main.java.fobu.admin.orderManage.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.orderManage.service.NewOrderListVO;
import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min™
 * @since 2012. 03. 10.
 */
@Repository
public class NewOrderDAO extends AbstractDao {	
	
	
	/**
	 * 신규주문 (직송요청) 상세 저장
	 * @param 
	 * @return NewOrderListVO List
	 * @throws SQLException 
	 */
	public void saveNewOrderProduct(TotalOrderVO totalOrderVO) throws SQLException {		
		insert("NewOrderDAO.saveNewOrderProduct", totalOrderVO);
	}
}
