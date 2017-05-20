package main.java.fobu.admin.product.web;

import main.java.fobu.common.Constant;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.FileService;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.AjaxPageSplit;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.product.service.DummySoldoutVO;
import main.java.fobu.admin.product.service.OpenMarketMarginListVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.ProductBrandVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductListVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.admin.product.service.ShopManagerService;
import main.java.fobu.common.util.StringUtil;

import org.springframework.beans.factory.annotation.Autowired;
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
public class ShopManagerController {
	
	//private String listScale ="20";
		
	@Resource(name = "shopManagerServiceImpl")
	private ShopManagerService shopManagerService;
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	@Autowired
	private FileService fileService;
	/**
	 * The Constructor
	 */
	public ShopManagerController() {
		//logger = LogFactory.getLog(this.getClass());
	}
	/**
	 * 가격관리 목록 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/shop_manager.html")
	public String shopManagerList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	    
	    model.addAttribute("listCompany", listCompany);
	    model.addAttribute("titleImgPath", Constant.imageSmallPath);
	    model.addAttribute("titleImgPath2", Constant.imageTitlePath);
	    model.addAttribute("detailImgPath", Constant.imageDetailPath);
	    
		return "/fobu/admin/product/shop_manager";
	}
	
	/**
	 *  제품통합검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/product/openMarketMargin_list.action")
	public ModelAndView openMarketMarginList(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav, ModelMap model) throws Exception {	
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		
		//paramMap.put("listScale", listScale);
		//System.out.println("**************************"+paramMap);
		int listOpenMarketMarginCount = shopManagerService.listOpenMarketMarginCount(paramMap);
	    List<OpenMarketMarginVO> listOpenMarketMargin = shopManagerService.listOpenMarketMargin(paramMap);
		
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
			marketTypeUrl = Constant.sunLinkUrl;
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
	
	@RequestMapping(value = "/admin/product/openMarketMargin_save.action")
	public ModelAndView openMarketMarginUpdate(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("OpenMarketMargin")OpenMarketMarginListVO openMarketMarginList) throws SQLException {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = shopManagerService.updateOpenMarketMarginList(openMarketMarginList);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result");
		
		return mav;
	}
	@RequestMapping(value = "/admin/product/popup_soldout.html")
	public ModelAndView productSold(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
				
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);		
		String strTable = paramMap.get("table").toString();
		
		paramMap.put("table", "fb_openmarket_margin_"+strTable);
		paramMap.put("marketType", "aut");		
		List<OpenMarketMarginVO> marketAut = shopManagerService.listSoldOutUrl(paramMap);
		paramMap.put("marketType", "gmk");
		List<OpenMarketMarginVO> marketGmk = shopManagerService.listSoldOutUrl(paramMap);
		paramMap.put("marketType", "itp");
		List<OpenMarketMarginVO> marketItp = shopManagerService.listSoldOutUrl(paramMap);
		paramMap.put("marketType", "cyw");
		List<OpenMarketMarginVO> marketCyw = shopManagerService.listSoldOutUrl(paramMap);		
		paramMap.put("marketType", "shn");
		List<OpenMarketMarginVO> marketShn = shopManagerService.listSoldOutUrl(paramMap);	
		paramMap.put("marketType", "sun");
		List<OpenMarketMarginVO> marketSun = shopManagerService.listSoldOutUrl(paramMap);	
		 
		ModelAndView mav = new ModelAndView();
		mav.addObject("marketAutCnt", marketAut.size());
		mav.addObject("marketGmkCnt", marketGmk.size());
		mav.addObject("marketItpCnt", marketItp.size());
		mav.addObject("marketCywCnt", marketCyw.size());
		mav.addObject("marketShnCnt", marketShn.size());
		mav.addObject("marketSunCnt", marketSun.size());
		mav.addObject("marketAut", marketAut);
		mav.addObject("marketGmk", marketGmk);
		mav.addObject("marketItp", marketItp);
		mav.addObject("marketCyw", marketCyw);
		mav.addObject("marketShn", marketShn);
		mav.addObject("marketSun", marketSun);
		mav.addObject("table", strTable);
		
		mav.setViewName("/fobu/admin/product/popup_soldout");
		
		return mav;
	}
	
	@RequestMapping(value = "/admin/product/popup_soldout.action")
	public ModelAndView updateSoldOutUrl(HttpServletRequest request, HttpServletResponse response, 
			ModelMap mode) throws Exception {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		String strTable = paramMap.get("table").toString();
		
		paramMap.put("table", "fb_openmarket_margin_"+strTable);
		int rtnVal = shopManagerService.updateSoldOutUrl(paramMap);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result");
		
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("result" , rtnVal);
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		return null;
	}
	
	@RequestMapping(value = "/admin/product/popup_soldout2.html")
	public ModelAndView productSold2(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
				
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);		
		String strTable = paramMap.get("table").toString();
		
		paramMap.put("table", "fb_openmarket_margin_"+strTable);
		paramMap.put("marketType", "aut");		
		List<OpenMarketMarginVO> marketAut = shopManagerService.listSoldOutUrl(paramMap);
		paramMap.put("marketType", "gmk");
		List<OpenMarketMarginVO> marketGmk = shopManagerService.listSoldOutUrl(paramMap);
		paramMap.put("marketType", "itp");
		List<OpenMarketMarginVO> marketItp = shopManagerService.listSoldOutUrl(paramMap);
		paramMap.put("marketType", "cyw");
		List<OpenMarketMarginVO> marketCyw = shopManagerService.listSoldOutUrl(paramMap);		
		paramMap.put("marketType", "shn");
		List<OpenMarketMarginVO> marketShn = shopManagerService.listSoldOutUrl(paramMap);		
		 
		ModelAndView mav = new ModelAndView();
		mav.addObject("marketAutCnt", marketAut.size());
		mav.addObject("marketGmkCnt", marketGmk.size());
		mav.addObject("marketItpCnt", marketItp.size());
		mav.addObject("marketCywCnt", marketCyw.size());
		mav.addObject("marketShnCnt", marketShn.size());
		mav.addObject("marketAut", marketAut);
		mav.addObject("marketGmk", marketGmk);
		mav.addObject("marketItp", marketItp);
		mav.addObject("marketCyw", marketCyw);
		mav.addObject("marketShn", marketShn);
		mav.addObject("table", strTable);
		
		mav.setViewName("/fobu/admin/product/popup_soldout2");
		
		return mav;
	}
	
	@RequestMapping(value = "/dummySoldoutFileUpload.action")
	public ModelAndView dummySoldoutFileUpload(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		CommonFileVO fileBean = null;
        //int res = 0;
        ServletContext context = request.getSession().getServletContext();
    	System.out.println("context.getRealPath--->"+context.getRealPath("/view/fobu/excel"));
    	String path = context.getRealPath("/view/fobu/excel");
        try {
        	//path = C:\\Users\\min\\workspace\\fobu2009\\WebContent\\view\\fobu\\excel
			fileBean = fileService.getUploadFileList(request, 1, path);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
        
        ModelAndView mav1 = new ModelAndView();
        mav1.addObject("rtnVal", "99");
        mav1.setViewName("/fobu/admin/product/product_result2");
        
		shopManagerService.saveDummySoldout(paramMap, fileBean, path);
	    return mav1;
	}
	
	@RequestMapping(value = "/admin/product/listDummySoldout.action")
	public ModelAndView listDummySoldout(HttpServletRequest request, HttpServletResponse response, 
			ModelMap mode) throws Exception {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		String strTable = paramMap.get("table").toString();
		
		paramMap.put("table", "fb_openmarket_margin_"+strTable);
		
		List<DummySoldoutVO> listDummySold1 = shopManagerService.listDummySoldout1(paramMap);
		List<DummySoldoutVO> listDummySold2 = shopManagerService.listDummySoldout2(paramMap);
		
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("listDummySold1" , listDummySold1);
		hmap.put("listDummySold2" , listDummySold2);
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		return null;
	}
	
	@RequestMapping({"/admin/product/listDummySoldout2.action"})
	public ModelAndView listDummySoldout2(HttpServletRequest request, HttpServletResponse response, 
			ModelMap mode)throws Exception {
		
	    Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
	    String strTable = paramMap.get("table").toString();

	    paramMap.put("table", "fb_openmarket_margin_" + strTable);
	    paramMap.put("userId", strTable);

	    List listDummySold = this.shopManagerService.listDummySoldout3(paramMap);

	    Map<String, Object> hmap = new HashMap();
	    hmap.put("listDummySold", listDummySold);

	    JSONObject jsonObject = JSONObject.fromObject(hmap);
	    sendResponse(response, jsonObject);

	    return null;
	  }
	
	
	@RequestMapping(value = "/admin/product/updateDummySoldout.action")
	public ModelAndView updateDummySoldout(HttpServletRequest request, HttpServletResponse response, 
			ModelMap mode) throws Exception {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		String strTable = paramMap.get("table").toString();
		
		paramMap.put("table", "fb_openmarket_margin_"+strTable);
		int rtnVal = shopManagerService.updateDummySoldout(paramMap);
		
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("result" , rtnVal);
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		return null;
	}
	
	@RequestMapping({"/admin/product/updateDummySoldout2.action"})
	  public ModelAndView updateDummySoldout2(HttpServletRequest request, HttpServletResponse response, ModelMap mode)
	    throws Exception
	  {
	    Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
	    String strTable = paramMap.get("table").toString();

	    paramMap.put("table", "fb_openmarket_margin_" + strTable);
	    paramMap.put("userId", strTable);

	    int rtnVal = this.shopManagerService.updateDummySoldout2(paramMap);

	    Map<String,Object> hmap = new HashMap();
	    hmap.put("result", Integer.valueOf(rtnVal));

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
