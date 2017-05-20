package main.java.fobu.admin.outView.web;

import net.sf.json.JSONObject;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.admin.product.service.ShopManagerService;
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
public class recommendProductController {
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	@Resource(name = "shopManagerServiceImpl")
	private ShopManagerService shopManagerService;
	/**
	 * The Constructor
	 */
	public recommendProductController() {
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
	
	@RequestMapping(value = "/admin/outView/recommendProduct_list.html")
	public String view1(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {		
		
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		String viewId = paramMap.get("id").toString();
		String marketTypeUrl = "";
		if(paramMap.get("marketType").toString().equals("aut")){
			marketTypeUrl = Constant.autLinkUrl;
		}else if(paramMap.get("marketType").toString().equals("gmk")){
			marketTypeUrl = Constant.gmkLinkUrl;
		}else if(paramMap.get("marketType").toString().equals("itp")){
			marketTypeUrl = Constant.itpLinkUrl;
		}else if(paramMap.get("marketType").toString().equals("cyw")){
			marketTypeUrl = Constant.cywLinkUrl;
		}else if(paramMap.get("marketType").toString().equals("shn")){
			marketTypeUrl = Constant.shnLinkUrl +convertShnId(viewId)+"/products/";
		}else{
			marketTypeUrl = Constant.sunLinkUrl;
		}	   
		paramMap.put("tableName", "fb_openmarket_margin_"+viewId);
		
		List<OpenMarketMarginVO>  listRecommendProduct = shopManagerService.listRecommendOpenMarket(paramMap);
		model.addAttribute("listRecommendProduct", listRecommendProduct);
		model.addAttribute("imgFolder", paramMap.get("id"));
		model.addAttribute("imageLargePath", Constant.imageLargePath);
		model.addAttribute("marketTypeUrl", marketTypeUrl);
		return "/fobu/admin/outView/recommendProduct_list";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/outView/recommendProduct_list3.html")
	public String view3(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {
		
		
		
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		String viewId = paramMap.get("id").toString();
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
			marketTypeUrl = Constant.shnLinkUrl +convertShnId(viewId)+"/products/";
		}	
		
		paramMap.put("tableName", "fb_openmarket_margin_"+viewId);
		
		String backColor = "";
		if(viewId.equals("tmin")){
			backColor = "f9d8d3";
		}else if(viewId.equals("choco")){
			backColor ="FAE9B6";
		}else if(viewId.equals("fobu")){
			backColor ="cdeffa";
		}else if(viewId.equals("good")){
			backColor ="d3f9d7";
		}else{
			backColor = "dafacd";
		}
		List<ProductVO> listProductDetail = productService.listProductDetail(seq);		
		paramMap.put("cal1", listProductDetail.get(0).getCategory1());
		
		List<OpenMarketMarginVO>  listRecommendProduct = shopManagerService.listRecommendOpenMarket2(paramMap);


		
		model.addAttribute("listProductDetail", listProductDetail);
		model.addAttribute("listRecommendProduct", listRecommendProduct);
		model.addAttribute("imgFolder", paramMap.get("id"));
		model.addAttribute("imageLargePath", Constant.imageLargePath);
		model.addAttribute("marketTypeUrl", marketTypeUrl);
		model.addAttribute("backColor", backColor);
		return "/fobu/admin/outView/recommendProduct_list3";
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
