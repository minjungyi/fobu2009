package main.java.fobu.neroAdmin.productInventory.web;

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
import main.java.fobu.neroAdmin.productInventory.service.ProductInventoryService;
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
public class ProductInventoryController {
		
	@Resource(name = "productInventoryServiceImpl")
	private ProductInventoryService productInventoryService;
	
	@Resource(name = "companyInventoryServiceImpl")
	private CompanyInventoryService companyInventoryService;
	
	/**
	 * The Constructor
	 */
	public ProductInventoryController() {
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
	@RequestMapping(value = "/neroAdmin/productInventory/productInventory.html")
	public String view(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		List<CompanyInventoryVO> listCompany = companyInventoryService.listCompanyInfo(paramMap);
	    model.addAttribute("listCompany", listCompany);
	    System.out.println("listCompany=======================>"+listCompany);
		return "/fobu/neroAdmin/productInventory/productInventory";
	}	
	
	/**
	 * 
	 * 제품 목록 보기 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/neroAdmin/productInventory/productList.action")
	public String productList(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws Exception {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
	    List<ProductInventoryVO> listProductInfo = productInventoryService.listProductInfo(paramMap);
	    System.out.println("listProductInfo=======================>"+listProductInfo);
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("listProductInfo"   , JSONArray.fromObject(listProductInfo));
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	/**
	 * 제품 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/neroAdmin/productInventory/saveProductInfo.action")
	public void saveProductInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		productInventoryService.saveProductInfo(paramMap);
	}
	
	/**
	 * 입출고내역 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/neroAdmin/productInventory/saveInventoryInfo.action")
	public void saveInventoryInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		productInventoryService.saveInventoryInfo(paramMap);
	}
	
	/**
	 * 입출고내역 수정
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/neroAdmin/productInventory/updateInventoryInfo.action")
	public void updateInventoryInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		productInventoryService.updateInventoryInfo(paramMap);
	}
	
	/**
	 * 입출고내역 삭제
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/neroAdmin/productInventory/deleteInventoryInfo.action")
	public void deleteInventoryInfo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		productInventoryService.deleteInventoryInfo(paramMap);
	}
	
	/**
	 * 입출고내역 목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/neroAdmin/productInventoryManage/init.action")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int productInventoryCount = productInventoryService.listProductInventoryCount(paramMap);
	    List<ProductInventoryVO> productInventoryList = productInventoryService.listProductInventory(paramMap);
		//mav.setViewName("/fobu/admin/productInventoryManage/productInventoryList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(productInventoryCount, pageNum, listScale, 15, "");
		System.out.println("productInventoryManage=======================>");
		hmap.put("productInventoryList"   , JSONArray.fromObject(productInventoryList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("productInventoryCount" , productInventoryCount);
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
