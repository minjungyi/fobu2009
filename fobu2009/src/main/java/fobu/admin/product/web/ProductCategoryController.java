package main.java.fobu.admin.product.web;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.product.service.InfoCategoryService;
import main.java.fobu.admin.product.service.InfoCategoryVO;
import main.java.fobu.admin.product.service.ProductBrandService;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductCategoryService;
import main.java.fobu.admin.product.service.ProductVO;

import main.java.fobu.common.util.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Controller
 *
 * @author min 
 * @since 2011. 10. 12.
 */
@Controller
public class ProductCategoryController {
		
	@Resource(name = "productCategoryServiceImpl")
	private ProductCategoryService productCategoryService;		
	
	@Resource(name = "infoCategoryServiceImpl")
	private InfoCategoryService infoCategoryService;	
	/**
	 * The Constructor
	 */
	public ProductCategoryController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 
	 * 카테고리 호출
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_category.html")
	public String view2(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    
		return "/fobu/admin/product/product_category";
	}
	
	
	/**
	 * 
	 * 카테고리팝업 호출
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/product/product_categoryP.html")
	public String viewDetail(HttpServletRequest request, String category, String code, String status, HttpServletResponse response, 
			ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		List<ProductCategoryVO> listCategory = new ArrayList<ProductCategoryVO>();
		ProductCategoryVO prodCategory = new ProductCategoryVO();
		List<InfoCategoryVO>listInfoCategory = infoCategoryService.listInfoCategory(paramMap);
		
		if(status.equals("I")){
			prodCategory.setCategory(category);
			prodCategory.setCode(code);
			prodCategory.setStatus(status);
			prodCategory.setSort("1");
			listCategory.add(0, prodCategory);
		}else{
			listCategory = productCategoryService.listCategory(paramMap);
			listCategory.get(0).setStatus(status);
		}
		model.addAttribute("listCategory", listCategory);
		model.addAttribute("rtnVal", 0);
		model.addAttribute("depth", paramMap.get("depth"));
		model.addAttribute("category", paramMap.get("category"));
		model.addAttribute("listInfoCategory", listInfoCategory);
		return "/fobu/admin/product/product_categoryP";
	}
	
	/**
	 * 카테고리 검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/product/product_category.action")
	public ModelAndView listCategory(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav, ModelMap model) throws Exception {	
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		//System.out.println("**************************"+paramMap);
		
	    List<ProductCategoryVO> listCategory = productCategoryService.listCategory(paramMap);
	   
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("listCategory"   , JSONArray.fromObject(listCategory));
		//hmap.put("listCompany"   , JSONArray.fromObject(listCompany));
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	/**
	 * 카테고리 저장	 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	
	@RequestMapping(value = "/admin/product/product_Category_save.action")
	public ModelAndView productCategorySave(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductCategory")ProductCategoryVO ProductCategory) throws SQLException {
		
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		int rtnVal = productCategoryService.saveProductCategory(ProductCategory);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.addObject("depth", paramMap.get("depth"));
		mav.addObject("category", paramMap.get("category"));
		mav.setViewName("/fobu/admin/product/product_categoryP");
		
		return mav;
	}
	
	/**
	 * 
	 * 카테고리 팝업(리스트상에서 카테고리 변경할때)
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_categoryPop.html")
	public ModelAndView view3(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    
	    ModelAndView mav = new ModelAndView();
	    model.addAttribute("cate1", paramMap.get("cate1"));
	    model.addAttribute("cate2", paramMap.get("cate2"));
	    model.addAttribute("cate3", paramMap.get("cate3"));
	    model.addAttribute("seq", paramMap.get("seq"));
	    model.addAttribute("rtnVal", "0");
	    mav.setViewName("/fobu/admin/product/product_categoryPop");
		
		return mav;
	}
	
	@RequestMapping(value = "/admin/product/product_CategoryPop_save.action")
	public ModelAndView updateProductCategory2(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("Product")ProductVO Product) throws SQLException {
		
		@SuppressWarnings("unused")
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		int rtnVal = productCategoryService.updateProductCategory2(Product);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_categoryPop");
		
		return mav;
	}
	
	/**
	 * 카테고리 검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/product/product_category_sort_change.action")
	public ModelAndView categorySortChange(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav, ModelMap model) throws Exception {	
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		//System.out.println("**************************"+paramMap);
		
	    List<ProductCategoryVO> listCategory = productCategoryService.listCategory(paramMap);
	   
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("listCategory"   , JSONArray.fromObject(listCategory));
		//hmap.put("listCompany"   , JSONArray.fromObject(listCompany));
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	@RequestMapping(value = "/admin/product/product_category_init.action")
	public ModelAndView categoryInit(HttpServletRequest request, HttpServletResponse response)throws Exception{
		
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		int rtnVal = productCategoryService.updateProductCategoryInit(paramMap);
		
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("rtnVal"   , rtnVal);		
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
