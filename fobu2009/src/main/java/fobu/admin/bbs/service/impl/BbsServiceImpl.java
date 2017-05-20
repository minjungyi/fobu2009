package main.java.fobu.admin.bbs.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.admin.bbs.service.BbsService;
import main.java.fobu.admin.bbs.service.BbsVO;
import main.java.fobu.common.service.UserVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * Bbs Service Implementation
 *
 * @author min
 * @since 2012. 03. 10.
 */
@Service
public class BbsServiceImpl implements BbsService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "bbsDAO")
	private BbsDAO bbsDao;
	
	/**
	 * The Constructor
	 */
	public BbsServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public List<BbsVO> listBbs(Map paramMap) throws SQLException {
		List<BbsVO> listBbs = bbsDao.listBbs(paramMap);
		return listBbs;
	}
	
	@Override
	public List<BbsVO> listDetailBbs(Map paramMap) throws SQLException {
		List<BbsVO> listBbs = bbsDao.listDetailBbs(paramMap);
		return listBbs;
	}
	
	@Override
	public int listBbsCount(Map paramMap) throws SQLException {
		int bbsCount = bbsDao.listBbsCount(paramMap);
		return bbsCount;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void insertBbs(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifier", userInfo.getUserId());
		} else {
			paramMap.put("modifier", "SYSTEM");
		}
		bbsDao.insertBbs(paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void insertReplyBbs(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifier", userInfo.getUserId());
		} else {
			paramMap.put("modifier", "SYSTEM");
		}
		bbsDao.insertReplyBbs(paramMap);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void updateBbs(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifier", userInfo.getUserId());
		} else {
			paramMap.put("modifier", "SYSTEM");
		}
		bbsDao.updateBbs(paramMap);
	}
	
	@Override
	public void deleteBbs(Map paramMap) throws SQLException {
		bbsDao.deleteBbs(paramMap);
	}
}
