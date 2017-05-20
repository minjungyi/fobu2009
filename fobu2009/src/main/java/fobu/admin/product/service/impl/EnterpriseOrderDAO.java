package main.java.fobu.admin.product.service.impl;
 
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.product.service.EnterpriseOrderVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.impl.AbstractDao;
import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2012. 10. 01.
 */
@Repository
public class EnterpriseOrderDAO extends AbstractDao {
	
	/**
	 * 발주 수량 저장
	 * @param enterprise
	 * @throws SQLException
	 */	
	public void insertEnterpriseOrder(EnterpriseOrderVO enterprise) throws SQLException {	
		
		update("EnterpriseOrderDAO.insertEnterpriseOrder", enterprise);
	}
	
	/**
	 * 발주 요청 목록
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	
	@SuppressWarnings("unchecked")
	public List<ProductVO> listEnterpriseOrder(Map paramMap) throws SQLException {		
		return (List<ProductVO>) list("EnterpriseOrderDAO.listEnterpriseOrder", paramMap);
	}
	
	/**
	 * 발주 요청 목록
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	
	@SuppressWarnings("unchecked")
	public int listEnterpriseOrderCount(Map paramMap) throws SQLException {	
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("EnterpriseOrderDAO.listEnterpriseOrderCount", paramMap));
	}
	
	/**
	 * 발주 상태 변경
	 * @param enterprise
	 * @throws SQLException
	 */	
	public void updateEnterpriseOrderStatus(EnterpriseOrderVO enterprise) throws SQLException {	
		
		update("EnterpriseOrderDAO.updateEnterpriseOrderStatus", enterprise);
	}
	
	/**
	 * 발주 수량 변경
	 * @param enterprise
	 * @throws SQLException
	 */	
	public void updateEnterpriseOrderQy(EnterpriseOrderVO enterprise) throws SQLException {	
		
		update("EnterpriseOrderDAO.updateEnterpriseOrderQy", enterprise);
	}
	
	/**
	 * 발주 수량 변경
	 * @param enterprise
	 * @throws SQLException
	 */	
	public void updateProductOrderStock(EnterpriseOrderVO enterprise) throws SQLException {	
		
		update("EnterpriseOrderDAO.updateProductOrderStock", enterprise);
	}
	
	/**
	 * 발주 수량 변경
	 * @param enterprise
	 * @throws SQLException
	 */	
	public void addEnterpriseOrderQy(EnterpriseOrderVO enterprise) throws SQLException {	
		
		update("EnterpriseOrderDAO.addEnterpriseOrderQy", enterprise);
	}
	
	
	/**
	 * 업체발주중복조회
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public int listDupOrder(String productCode) throws SQLException {		
		Map<String, String> param = new HashMap<String, String>();
		param.put("productCode", productCode);
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("TotalOrderDAO.listDupOrder", param));
	}
	
}
