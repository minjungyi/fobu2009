package main.java.fobu.admin.product.service.impl;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import main.java.fobu.admin.product.service.EnterpriseOrderService;
import main.java.fobu.admin.product.service.EnterpriseOrderVO;
import main.java.fobu.admin.product.service.NewShopProductVO;
import main.java.fobu.admin.product.service.ProductListVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.UserVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;


/**
 * 2012.10.02
 * @author psycoder
 *
 */
@Service
public class EnterpriseOrderServiceImpl implements EnterpriseOrderService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "enterpriseOrderDAO")
	private EnterpriseOrderDAO enterpriseOrderDAO;
	
	/**
	 * The Constructor
	 */
	public EnterpriseOrderServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<ProductVO> listEnterpriseOrder(Map paramMap) throws SQLException {
		//paramMap.put("startDay", paramMap.get("startDay").toString().replace("-", ""));
		List<ProductVO> listEnterpriseOrder = enterpriseOrderDAO.listEnterpriseOrder(paramMap);
		return listEnterpriseOrder;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public int listEnterpriseOrderCount(Map paramMap) throws SQLException {
		//paramMap.put("startDay", paramMap.get("startDay").toString().replace("-", ""));
		int listEnterpriseOrder = enterpriseOrderDAO.listEnterpriseOrderCount(paramMap);
		return listEnterpriseOrder;
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public int updateEnterpriseOrderStatus(ProductListVO productList, String status) throws SQLException {	
		try{
						
			for(int i = 0 ; i < productList.getEnterpriseOrderSeq().length ; i++){
				if(productList.getCheckbox()[i].toString().equals("true")){
					EnterpriseOrderVO enterprise = new EnterpriseOrderVO();	
					
					enterprise.setEnterpriseOrderSeq(productList.getEnterpriseOrderSeq()[i].toString());
					enterprise.setEnterpriseOrderStatus(status);					
					enterpriseOrderDAO.updateEnterpriseOrderStatus(enterprise);
					
					if(status.equals("9999")){
						enterpriseOrderDAO.updateProductOrderStock(enterprise);						
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@Override
	public int updateEnterpriseOrderQy(ProductListVO productList) throws SQLException {	
		try{
						
			for(int i = 0 ; i < productList.getEnterpriseOrderSeq().length ; i++){
				if(productList.getCheckbox()[i].toString().equals("true")){
					EnterpriseOrderVO enterprise = new EnterpriseOrderVO();	
					
					enterprise.setEnterpriseOrderSeq(productList.getEnterpriseOrderSeq()[i].toString());
					enterprise.setEnterpriseOrderQy(productList.getEnterpriseOrderQy()[i].toString());
					enterprise.setRemark(productList.getRemark()[i].toString());
					
					enterpriseOrderDAO.updateEnterpriseOrderQy(enterprise);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
}
