package main.java.fobu.admin.product.web;

import main.java.fobu.common.Constant;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.AjaxPageSplit;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.product.service.OpenMarketMarginListVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.OpenmarketManagerService;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.admin.product.service.ShopManagerService;
import main.java.fobu.common.util.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class OpenmarketManagerController {
	
	//private String listScale ="20";
		
	@Resource(name = "openmarketManagerServiceImpl")
	private OpenmarketManagerService openmarketManagerService;
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	/**
	 * The Constructor
	 */
	public OpenmarketManagerController() {
		//logger = LogFactory.getLog(this.getClass());
	}
	/**
	 * 오픈마켓 제품 목록 Html
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/openmarket_manager.html")
	public String shopManagerList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	    
	    model.addAttribute("listCompany", listCompany);
	    model.addAttribute("titleImgPath", Constant.imageSmallPath);
	    model.addAttribute("titleImgPath2", Constant.imageTitlePath);
	    model.addAttribute("detailImgPath", Constant.imageDetailPath);
	    
		return "/fobu/admin/product/openmarket_manager";
	}
	
	/**
	 *  오픈마켓 제품 목록 Action
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/product/openmarketManager_list.action")
	public ModelAndView listOpenmarketManager(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav, ModelMap model) throws Exception {	
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		paramMap.put("userId", userInfo.getUserId());
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		
		//paramMap.put("listScale", listScale);
		//System.out.println("**************************"+paramMap);
		int listOpenMarketMarginCount = openmarketManagerService.listOpenmarketManagerCount(paramMap);
	    List<OpenMarketMarginVO> listOpenMarketMargin = openmarketManagerService.listOpenmarketManager(paramMap);
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(listOpenMarketMarginCount, pageNum, listScale, 15, "");
		String marketTypeUrl = "";
		if(paramMap.get("marketType").toString().equals("aut")){
			marketTypeUrl = Constant.autLinkUrl;
		}else if(paramMap.get("marketType").toString().equals("gmk")){
			marketTypeUrl = Constant.gmkLinkUrl;
		}else if(paramMap.get("marketType").toString().equals("itp")){
			marketTypeUrl = Constant.itpLinkUrl;
		}else if(paramMap.get("marketType").toString().equals("cyw")){
			marketTypeUrl = Constant.cywLinkUrl;
		}else{
			marketTypeUrl = Constant.shnLinkUrl +convertShnId(userInfo.getUserId())+"/products/";
		}	   
		
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("pageSplit" , pageSplit);
		hmap.put("marketTypeUrl", marketTypeUrl);
		hmap.put("listOpenMarketMarginCount" , listOpenMarketMarginCount);
		hmap.put("listOpenMarketMargin"   , JSONArray.fromObject(listOpenMarketMargin));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	private String convertShnId(String userID){
		String shnId = "";
		
		if(userID.equals("fobu")){
			shnId="fobu";
		}else if(userID.equals("good")){
			shnId="good";
		}else if(userID.equals("choco")){
			shnId="choco";
		}else if(userID.equals("min")){
			shnId="min";
		}else{
			shnId="twinmall";
		} 
		
		return shnId;
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
