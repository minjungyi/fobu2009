package main.java.fobu.admin.accountManage.web;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.accountManage.service.AccountService;
import main.java.fobu.admin.accountManage.service.AccountVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.common.service.FileService;
import main.java.fobu.common.util.AjaxPageSplit;
import main.java.fobu.common.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class AccountController {
		
	@Resource(name = "accountServiceImpl")
	private AccountService accountService;
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	/**
	 * The Constructor
	 */
	public AccountController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 정산목록 화면호출
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/accountManage/accountList.html")
	public String view(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
		model.addAttribute("listCompany", listCompany);
		return "/fobu/admin/accountManage/accountList";
	}	
	
	/**
	 * 정산 목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/accountManage/init.action")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int accountCount = accountService.listAccountCount(paramMap);
	    List<AccountVO> accountList = accountService.listAccount(paramMap);
		mav.setViewName("/fobu/admin/accountManage/accountList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(accountCount, pageNum, listScale, 15, "");
				 
		hmap.put("accountList"   , JSONArray.fromObject(accountList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("accountCount" , accountCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	    return null;
	}
	
	/**
	 * 정산상태값 검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/accountManage/saveAccountStat.action")
	public ModelAndView saveAccountStat(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		System.out.println("=====================saveAccountStat controller===========================================");
		System.out.println("controller paramMap : "+paramMap);
		accountService.saveAccountStat(paramMap);
		mav.setViewName("/fobu/admin/accountManage/accountList");
	    return null;
	}
	
	/**
	 * 정산그룹목록 화면호출
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/accountManage/accountGroupList.html")
	public String viewGroup(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		return "/fobu/admin/accountManage/accountGroupList";
	}	
	
	/**
	 * 정산그룹 목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/accountManage/initGroup.action")
	public ModelAndView initGroup(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int accountCount = accountService.listAccountGroupCount(paramMap);
	    List<AccountVO> accountList = accountService.listAccountGroup(paramMap);
		mav.setViewName("/fobu/admin/accountManage/accountGroupList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(accountCount, pageNum, listScale, 15, "");
				 
		hmap.put("accountGroupList"   , JSONArray.fromObject(accountList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("accountGroupCount" , accountCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	    return null;
	}
	
	/**
	 * 정산목록 화면호출
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/accountManage/accountAccidentList.html")
	public String viewAccident(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
		model.addAttribute("listCompany", listCompany);
		return "/fobu/admin/accountManage/accountAccidentList";
	}	
	
	/**
	 * 정산 목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/accountManage/initAccident.action")
	public ModelAndView initAccident(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int accountCount = accountService.listAccountAccidentCount(paramMap);
	    List<AccountVO> accountList = accountService.listAccountAccident(paramMap);
		mav.setViewName("/fobu/admin/accountManage/accountAccidentList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(accountCount, pageNum, listScale, 15, "");
				 
		hmap.put("accountList"   , JSONArray.fromObject(accountList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("accountCount" , accountCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	    return null;
	}
	
	/**
	 * 정산상태값 검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/accountManage/saveAccountAccidentStat.action")
	public ModelAndView saveAccountAccidentStat(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		System.out.println("=====================saveAccountAccidentStat controller===========================================");
		System.out.println("controller paramMap : "+paramMap);
		accountService.saveAccountAccidentStat(paramMap);
		mav.setViewName("/fobu/admin/accountManage/accountAccidentList");
	    return null;
	}
	
	/**
	 * 정산그룹목록 화면호출
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/accountManage/accountAccidentGroupList.html")
	public String viewAccidentGroup(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		return "/fobu/admin/accountManage/accountAccidentGroupList";
	}	
	
	/**
	 * 정산그룹 목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/accountManage/initAccidentGroup.action")
	public ModelAndView initAccidentGroup(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int accountCount = accountService.listAccountAccidentGroupCount(paramMap);
	    List<AccountVO> accountList = accountService.listAccountAccidentGroup(paramMap);
		mav.setViewName("/fobu/admin/accountManage/accountAccidentGroupList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(accountCount, pageNum, listScale, 15, "");
				 
		hmap.put("accountGroupList"   , JSONArray.fromObject(accountList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("accountGroupCount" , accountCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	    return null;
	}
	
	/**
	 * Ajax json 응답
	 * @param response
	 * @param jsonObject
	 * @throws Exception
	 */
	private void sendResponse(HttpServletResponse response, JSONObject jsonObject) throws Exception {
		Thread.sleep(200);
		response.setContentType("text/xml;charset=UTF-8");
		response.getWriter().print(jsonObject);
		response.getWriter().flush();
		response.getWriter().close();
    }
}
