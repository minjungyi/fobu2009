package main.java.fobu.admin.accountManage.web;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.accountManage.service.AccountExcelService;
import main.java.fobu.admin.accountManage.service.AccountVO;
import main.java.fobu.common.Constant;
import main.java.fobu.common.util.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class AccountExcelController {
		
	@Resource(name = "accountExcelServiceImpl")
	private AccountExcelService accountExcelService;
	
	/**
	 * The Constructor
	 */
	public AccountExcelController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 정산그룹 목록검색 - 정산그룹 목록 엑셀 목록
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/excel/account_excellist.html")
	public String viewExcel(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		System.out.println("viewExcel paramMap=====>"+paramMap);
		paramMap.put("paging", 0);
		paramMap.put("listScale", 100000);
		
		List<AccountVO> accountExcelList = accountExcelService.listAccountExcel(paramMap);
		List<AccountVO> accountStatList = accountExcelService.listAccountStat(paramMap);
		model.addAttribute("accountExcelList", accountExcelList);
		model.addAttribute("accountStatList", accountStatList);
	    
		return "/fobu/admin/excel/account_excellist";
	}
	
	/**
	 * 정산 후 변경 그룹 목록검색 - 정산 후 변경 그룹 목록 엑셀 목록
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/excel/accountAccident_excellist.html")
	public String viewAccidentExcel(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		System.out.println("viewExcel paramMap=====>"+paramMap);
		paramMap.put("paging", 0);
		paramMap.put("listScale", 100000);
		
		List<AccountVO> accountExcelList = accountExcelService.listAccountAccidentExcel(paramMap);
		List<AccountVO> accountStatList = accountExcelService.listAccountAccidentStat(paramMap);
		System.out.println("viewExcel accountExcelList=====>"+accountExcelList);
		System.out.println("viewExcel accountStatList=====>"+accountStatList);
		model.addAttribute("accountExcelList", accountExcelList);
		model.addAttribute("accountStatList", accountStatList);
	    
		return "/fobu/admin/excel/accountAccident_excellist";
	}
}
