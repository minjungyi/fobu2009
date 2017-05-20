package main.java.fobu.neroAdmin.inventoryManage.web;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.common.util.AjaxPageSplit;
import main.java.fobu.common.util.StringUtil;
import main.java.fobu.neroAdmin.inventoryManage.service.InventoryManageService;
import main.java.fobu.neroAdmin.inventoryManage.service.InventoryManageVO;
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
public class InventoryManageController {
		
	@Resource(name = "inventoryManageServiceImpl")
	private InventoryManageService inventoryManageService;
	
	
	/**
	 * The Constructor
	 */
	public InventoryManageController() {
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
	@RequestMapping(value = "/neroAdmin/inventoryManage/inventoryManage.html")
	public String view(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		return "/fobu/neroAdmin/inventoryManage/inventoryManage";
	}	
	
	/**
	 * 네로재고목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/neroAdmin/inventoryManageManage/init.action")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int inventoryManageCount = inventoryManageService.listInventoryManageCount(paramMap);
	    List<InventoryManageVO> inventoryManageList = inventoryManageService.listInventoryManage(paramMap);
		mav.setViewName("/fobu/admin/inventoryManageManage/inventoryManageList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(inventoryManageCount, pageNum, listScale, 15, "");
				 
		hmap.put("inventoryManageList"   , JSONArray.fromObject(inventoryManageList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("inventoryManageCount" , inventoryManageCount);
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
