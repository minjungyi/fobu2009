package main.java.fobu.admin.operationBbs.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.operationBbs.service.OperationBbsService;
import main.java.fobu.admin.operationBbs.service.OperationBbsVO;
import main.java.fobu.common.service.UserVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * OperationBbs Service Implementation
 *
 * @author min
 * @since 2012. 03. 10.
 */
@Service
public class OperationBbsServiceImpl implements OperationBbsService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "operationBbsDAO")
	private OperationBbsDAO operationBbsDao;
	
	/**
	 * The Constructor
	 */
	public OperationBbsServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public List<OperationBbsVO> listOperationBbs(Map paramMap) throws SQLException {
		List<OperationBbsVO> listOperationBbs = operationBbsDao.listOperationBbs(paramMap);
		return listOperationBbs;
	}
	
	@Override
	public List<OperationBbsVO> listDetailOperationBbs(Map paramMap) throws SQLException {
		List<OperationBbsVO> listOperationBbs = operationBbsDao.listDetailOperationBbs(paramMap);
		return listOperationBbs;
	}
	
	@Override
	public int listOperationBbsCount(Map paramMap) throws SQLException {
		int operationBbsCount = operationBbsDao.listOperationBbsCount(paramMap);
		return operationBbsCount;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void insertOperationBbs(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifier", userInfo.getUserId());
		} else {
			paramMap.put("modifier", "SYSTEM");
		}
		operationBbsDao.insertOperationBbs(paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void insertReplyOperationBbs(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifier", userInfo.getUserId());
		} else {
			paramMap.put("modifier", "SYSTEM");
		}
		operationBbsDao.insertReplyOperationBbs(paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void updateOperationBbs(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifier", userInfo.getUserId());
		} else {
			paramMap.put("modifier", "SYSTEM");
		}
		operationBbsDao.updateOperationBbs(paramMap);
	}
	
	@Override
	public void deleteOperationBbs(Map paramMap) throws SQLException {
		operationBbsDao.deleteOperationBbs(paramMap);
	}
}
