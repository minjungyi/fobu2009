package main.java.fobu.neroAdmin.companyInventory.web;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.common.util.AjaxPageSplit;
import main.java.fobu.common.util.StringUtil;
import main.java.fobu.neroAdmin.companyInventory.service.CompanyInventoryService;
import main.java.fobu.neroAdmin.companyInventory.service.CompanyInventoryVO;
import main.java.fobu.neroAdmin.productInventory.service.ProductInventoryVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Controller
 *
 * @author min™
 * @since 2010. 09. 08.
 */
@Controller
public class CompanyInventoryController {
		
	@Resource(name = "companyInventoryServiceImpl")
	private CompanyInventoryService companyInventoryService;
	
	/**
	 * The Constructor
	 */
	public CompanyInventoryController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 네로재고목록 화면호출
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/neroAdmin/companyInventory/companyInventory.html")
	public String view(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		return "/fobu/neroAdmin/companyInventory/companyInventory";
	}	
	
	/**
	 * 
	 * 거래처 목록 보기 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/neroAdmin/companyInventory/companyList.action")
	public String companyList(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws Exception {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
	    List<CompanyInventoryVO> listCompanyInfo = companyInventoryService.listCompanyInfo(paramMap);
	   
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("listCompanyInfo"   , JSONArray.fromObject(listCompanyInfo));
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	/**
	 * 거래처 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/neroAdmin/companyInventory/saveCompanyInfo.action")
	public void saveCompanyInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		companyInventoryService.saveCompanyInfo(paramMap);
	}
	
	/**
	 * 거래처 입출고내역 목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/neroAdmin/companyInventoryManage/init.action")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int companyInventoryCount = companyInventoryService.listCompanyInventoryCount(paramMap);
	    List<CompanyInventoryVO> companyInventoryList = companyInventoryService.listCompanyInventory(paramMap);
		//mav.setViewName("/fobu/admin/productInventoryManage/productInventoryList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(companyInventoryCount, pageNum, listScale, 15, "");
		System.out.println("companyInventoryManage=======================>");
		hmap.put("companyInventoryList"   , JSONArray.fromObject(companyInventoryList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("companyInventoryCount" , companyInventoryCount);
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
