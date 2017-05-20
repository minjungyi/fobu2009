package main.java.fobu.admin.shoplinker.web;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.ShopManagerService;
import main.java.fobu.admin.shoplinker.service.ShoplinkerInitService;
import main.java.fobu.common.Constant;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.AjaxPageSplit;
import main.java.fobu.common.util.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class shoplinkerInitController {
	
		
	
	@Resource(name = "shopManagerServiceImpl")
	private ShopManagerService shopManagerService;
	
	@Resource(name = "shoplinkerInitServiceImpl")
	private ShoplinkerInitService shoplinkerInitService;
	/**
	 * The Constructor
	 */
	public shoplinkerInitController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/shoplinker/shoplinker_init.html")
	public String view1(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {
		
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		String return_url = "";
		if(paramMap.get("face").toString().equals("upload")){
			return_url = "http://admin.shoplinker.co.kr/Product/batch_file_input.html";
		}else{
			String marketType = paramMap.get("marketType").toString();
			String companyCategory = paramMap.get("companyCategory").toString();
			String face = paramMap.get("face").toString();
			return_url = Constant.hostURL+ "/admin/shoplinker/shoplinker_statusLink.html?val="+face+"-"+marketType+"-"+companyCategory;
		}
		
		model.addAttribute("return_url", return_url);
		model.addAttribute("user_id", "fobu2009");
		model.addAttribute("password", "vhqn2323");		
		return "/fobu/admin/shoplinker/shoplinker_init";
	}
	
	@RequestMapping(value = "/admin/shoplinker/shoplinker_statusLink.html")
	public String view2(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {
		
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int listScale = 1000;		
		int pageNum = Integer.parseInt(paramMap.get("pageNum")!= null ? paramMap.get("pageNum").toString():"1");		
		int paging = (pageNum-1)*listScale;
		
		String selectedTable = paramMap.get("selectedTable")!=null ? paramMap.get("selectedTable").toString():"fb_openmarket_margin_"+userInfo.getUserId();		
		String[] arrParam = paramMap.get("val").toString().split("-",3);
		
		paramMap.put("face", arrParam[0]);
		paramMap.put("marketType", arrParam[1]);
		paramMap.put("companyCategory", arrParam[2]);
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		paramMap.put("table", selectedTable);
		
		String mode = paramMap.get("mode")!= null ? paramMap.get("mode").toString():"select";
		if(mode.equals("update")){
			shoplinkerInitService.updateSoldOutOpenMarket(paramMap);
		}
		//paramMap.put("listScale", listScale);
		//System.out.println("**************************"+paramMap);
		int listOpenMarketMarginCount = shopManagerService.listOpenMarketMarginCount(paramMap);
	    List<OpenMarketMarginVO> listOpenMarketMargin = shopManagerService.listOpenMarketMargin(paramMap);
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(listOpenMarketMarginCount, pageNum, listScale, 15, "");
		
		
		model.addAttribute("pageSplit" , pageSplit);
		model.addAttribute("listOpenMarketMarginCount", listOpenMarketMarginCount);
		model.addAttribute("listOpenMarketMargin", listOpenMarketMargin);
		model.addAttribute("selectedTable", selectedTable);
		model.addAttribute("val", paramMap.get("val").toString());
		
		model.addAttribute("statusVal", "005");
			
		return "/fobu/admin/shoplinker/shoplinker_statusLink";
	}	
	
	@RequestMapping(value = "/admin/shoplinker/shoplinker_statusLink2.html")
	public String view3(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {
		
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int listScale = 1000;		
		int pageNum = Integer.parseInt(paramMap.get("pageNum")!= null ? paramMap.get("pageNum").toString():"1");		
		int paging = (pageNum-1)*listScale;
		
		String selectedTable = paramMap.get("selectedTable")!=null ? paramMap.get("selectedTable").toString():"fb_openmarket_margin_"+userInfo.getUserId();		
		String[] arrParam = paramMap.get("val").toString().split("-",3);
		
		paramMap.put("face", arrParam[0]);
		paramMap.put("marketType", arrParam[1]);
		paramMap.put("companyCategory", arrParam[2]);
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		paramMap.put("table", selectedTable);
		
		String mode = paramMap.get("mode")!= null ? paramMap.get("mode").toString():"select";
		if(mode.equals("update")){
			shoplinkerInitService.updateSoldOutOpenMarket(paramMap);
		}
		//paramMap.put("listScale", listScale);
		//System.out.println("**************************"+paramMap);
		int listOpenMarketMarginCount = shopManagerService.listOpenMarketMarginCount(paramMap);
	    List<OpenMarketMarginVO> listOpenMarketMargin = shopManagerService.listOpenMarketMargin(paramMap);
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(listOpenMarketMarginCount, pageNum, listScale, 15, "");
		
		
		model.addAttribute("pageSplit" , pageSplit);
		model.addAttribute("listOpenMarketMarginCount", listOpenMarketMarginCount);
		model.addAttribute("listOpenMarketMargin", listOpenMarketMargin);
		model.addAttribute("selectedTable", selectedTable);
		model.addAttribute("val", paramMap.get("val").toString());
		
		model.addAttribute("statusVal", "001");
			
		return "/fobu/admin/shoplinker/shoplinker_statusLink";
	}	
	
}
