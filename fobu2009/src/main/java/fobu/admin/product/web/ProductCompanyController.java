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

import main.java.fobu.admin.product.service.ProductCompanyService;
import main.java.fobu.admin.product.service.ProductCompanyVO;
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
 * @since 2010. 09. 08.
 */
@Controller
public class ProductCompanyController {
	
	//private String listScale ="20";
		
	@Resource(name = "productCompanyServiceImpl")
	private ProductCompanyService productCompanyService;
	
	/**
	 * The Constructor
	 */
	public ProductCompanyController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	
	/**
	 * 
	 * 업체 등록 페이지 초기화면
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_company.html")
	public String view3(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    
		return "/fobu/admin/product/product_company";
	}
	
	/**
	 * 
	 * 업체 등록 페이지 상세보기 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_company2.action")
	public String view4(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws Exception {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
	    List<ProductCompanyVO> listCompany = productCompanyService.listCompany2(paramMap);
	   
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("listCompany"   , JSONArray.fromObject(listCompany));
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	@RequestMapping(value = "/admin/product/product_company_save.action")
	public ModelAndView saveProductCompany(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductCompany")ProductCompanyVO productCompany) throws SQLException {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = 0;
		if(StringUtil.isNull(productCompany.getSeq())){
			rtnVal = productCompanyService.saveProductCompany(productCompany);
		}
		else{
			rtnVal = productCompanyService.updateProductCompany(productCompany);
		}
		
		
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
