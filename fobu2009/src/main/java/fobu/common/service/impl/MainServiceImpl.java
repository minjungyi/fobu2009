package main.java.fobu.common.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import main.java.fobu.common.service.MainService;
import main.java.fobu.common.service.MainVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * Main Service Implementation
 *
 * @author min
 * @since 2012. 03. 10.
 */
@Service
public class MainServiceImpl implements MainService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "mainDAO")
	private MainDAO mainDao;
	
	/**
	 * The Constructor
	 */
	public MainServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public List<MainVO> listMainDaily(Map paramMap) throws SQLException {
		List<MainVO> listMain = mainDao.listMainDaily(paramMap);
		return listMain;
	}
	
	@Override
	public List<MainVO> listMainMonth(Map paramMap) throws SQLException {
		List<MainVO> listMain = mainDao.listMainMonth(paramMap);
		return listMain;
	}
}
