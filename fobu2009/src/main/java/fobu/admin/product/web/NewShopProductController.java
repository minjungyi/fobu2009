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

import main.java.fobu.admin.product.service.NewShopProductListVO;
import main.java.fobu.admin.product.service.NewShopProductService;
import main.java.fobu.admin.product.service.NewShopProductVO;
import main.java.fobu.admin.product.service.OpenMarketMarginListVO;
import main.java.fobu.admin.product.service.ProductBrandService;
import main.java.fobu.admin.product.service.ProductBrandVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductService;
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
public class NewShopProductController {
	
	//private String listScale ="20";
		
	@Resource(name = "newShopProductServiceImpl")
	private NewShopProductService newShopProductService;
	
	@Resource(name = "productBrandServiceImpl")
	private ProductBrandService productBrandService;
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	@Autowired
	private FileService fileService;
	
	/**
	 * The Constructor
	 */
	public NewShopProductController() {
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
	
	@RequestMapping(value = "/admin/product/new_shop_product.html")
	public String newShopProductList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    paramMap.put("category", "0001");
		paramMap.put("useYN", "Y");
		
	    List<ProductBrandVO> listBrand = productBrandService.listBrand(paramMap);
	    List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	    model.addAttribute("listCompany", listCompany);
	    model.addAttribute("listBrand", listBrand);
	    model.addAttribute("titleImgPath", Constant.imageSmallPath);
	    model.addAttribute("titleImgPath2", Constant.imageTitlePath);
	    model.addAttribute("detailImgPath", Constant.imageDetailPath);
	    
		return "/fobu/admin/product/new_shop_product";
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
	@RequestMapping(value = "/admin/product/new_shop_product.action")
	public ModelAndView newShopProductList(HttpServletRequest request, HttpServletResponse response, 
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
		int listNewShopProductCNT = newShopProductService.listNewShopProductCount(paramMap);
	    List<NewShopProductVO> listNewShopProduct = newShopProductService.listNewShopProduct(paramMap);
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(listNewShopProductCNT, pageNum, listScale, 15, "");
		
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("pageSplit" , pageSplit);
		hmap.put("listNewShopProductCount" , listNewShopProductCNT);
		hmap.put("listNewShopProduct"   , JSONArray.fromObject(listNewShopProduct));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	@RequestMapping(value = "/admin/product/new_shop_product_save.action")
	public ModelAndView newShopProductUpdate(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("NewShopProductList")NewShopProductListVO newShopProductList) throws SQLException {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = newShopProductService.updateNewShopBrandList(newShopProductList,paramMap);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result");
		
		return mav;
	}
	
	
	
	/**
	 * 신제품 등록 엑셀 관련 팝업창(신규제품 다운로드/신규제품업로드)
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/product/new_shop_excel_registPop.html")
	public ModelAndView view3(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    
	    ModelAndView mav = new ModelAndView();
	   
	    model.addAttribute("marketType", paramMap.get("marketType"));
	    model.addAttribute("companyCategory", paramMap.get("companyCategory"));
	    model.addAttribute("rtnVal", "0");
	    mav.setViewName("/fobu/admin/product/new_shop_excel_registPop");
		
		return mav;
	}
	
	/**
	 * 제품 파일업로드
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/productUpload.action")
	public String productUpload(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		CommonFileVO fileBean = null;
        //int res = 0;
        ServletContext context = request.getSession().getServletContext();
    	System.out.println("context.getRealPath--->"+context.getRealPath("/view/fobu/admin/excel"));
    	String path = context.getRealPath("/view/fobu/admin/excel");
        try {
        	//path = C:\\Users\\min\\workspace\\fobu2009\\WebContent\\view\\fobu\\excel
			fileBean = fileService.getUploadFileList(request, 2, path);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		newShopProductService.updateRelateOpenMarket(paramMap, fileBean, path);
	    return "/fobu/admin/product/new_shop_excel_registPop";
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
