package main.java.fobu.neroAdmin.companyInventory.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.common.service.UserVO;
import main.java.fobu.neroAdmin.companyInventory.service.CompanyInventoryService;
import main.java.fobu.neroAdmin.companyInventory.service.CompanyInventoryVO;
import main.java.fobu.neroAdmin.productInventory.service.ProductInventoryVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class CompanyInventoryServiceImpl implements CompanyInventoryService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "companyInventoryDAO")
	private CompanyInventoryDAO companyInventoryDao;
	
	/**
	 * The Constructor
	 */
	public CompanyInventoryServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public List<CompanyInventoryVO> listCompanyInfo(Map paramMap) throws SQLException {
		List<CompanyInventoryVO> listCompanyInfo = companyInventoryDao.listCompanyInfo(paramMap);
		return listCompanyInfo;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveCompanyInfo(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifiers", userInfo.getUserId());
		} else {
			paramMap.put("modifiers", "SYSTEM");
		}
		
	    String companySeq = paramMap.get("companySeq").toString();
	    if(companySeq.equals("") || companySeq == null){
	    	companyInventoryDao.insertCompanyInfo(paramMap);	    	
	    }else{
	    	companyInventoryDao.updateCompanyInfo(paramMap);
	    }
	}
	
	@Override
	public List<CompanyInventoryVO> listCompanyInventory(Map paramMap) throws SQLException {
		List<CompanyInventoryVO> listCompanyInventory = companyInventoryDao.listCompanyInventory(paramMap);
		return listCompanyInventory;
	}	
	
	@Override
	public int listCompanyInventoryCount(Map paramMap) throws SQLException {
		int companyInventoryCount = companyInventoryDao.listCompanyInventoryCount(paramMap);
		return companyInventoryCount;
	}
}

