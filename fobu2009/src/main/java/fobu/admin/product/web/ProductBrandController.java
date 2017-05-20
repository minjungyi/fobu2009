package main.java.fobu.admin.product.web;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.product.service.ProductBrandVO;
import main.java.fobu.admin.product.service.ProductBrandService;
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
public class ProductBrandController {
		
	@Resource(name = "productBrandServiceImpl")
	private ProductBrandService productBrandService;
		
	/**
	 * The Constructor
	 */
	public ProductBrandController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 
	 * 브랜드화면 호출 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_brand.html")
	public String view(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
		
	    @SuppressWarnings("unused")
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    
		return "/fobu/admin/product/product_brand";
	}
	
	/**
	 * 브랜드 검색	 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/product/product_brand.action")
	public ModelAndView listBrand(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav, ModelMap model) throws Exception {	
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		//System.out.println("**************************"+paramMap);
		
	    List<ProductBrandVO> listBrand = productBrandService.listBrand(paramMap);
	    //List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	   
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("listBrand"   , JSONArray.fromObject(listBrand));
		//hmap.put("listCompany"   , JSONArray.fromObject(listCompany));
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	/**
	 * 
	 * 브랜드 페이지 상세보기 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_brand_detail.action")
	public String viewDetail(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws Exception {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
	    List<ProductBrandVO> listBrandDetail = productBrandService.listBrandDetail(paramMap);
	   
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("listBrandDetail"   , JSONArray.fromObject(listBrandDetail));
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	/**
	 * 브랜드 저장	 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */
	
	@RequestMapping(value = "/admin/product/product_brand_save.action")
	public ModelAndView productBrandSave(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductBrand")ProductBrandVO ProductBrand) throws SQLException {
		
		@SuppressWarnings("unused")
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = productBrandService.saveProductBrand(ProductBrand);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result");
		
		return mav;
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
