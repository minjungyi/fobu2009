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

import main.java.fobu.admin.product.service.EnterpriseOrderService;
import main.java.fobu.admin.product.service.NewShopProductListVO;
import main.java.fobu.admin.product.service.NewShopProductService;
import main.java.fobu.admin.product.service.NewShopProductVO;
import main.java.fobu.admin.product.service.OpenMarketMarginListVO;
import main.java.fobu.admin.product.service.ProductBrandService;
import main.java.fobu.admin.product.service.ProductBrandVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductListVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.admin.product.service.ProductVO;
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
public class EnterpriseOrderController {
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	@Resource(name = "enterpriseOrderServiceImpl")
	private EnterpriseOrderService enterpriseOrderService;
	
	
	/**
	 * The Constructor
	 */
	public EnterpriseOrderController() {
		//logger = LogFactory.getLog(this.getClass());
	}
	

	/**
	 * 발주 재고 목록 가져오기
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/product/enterpriseOrder.html")
	public String enterpriseOrderList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	    
	    
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);

		String companyCaStr = null; 
		if(paramMap.get("companyCategory") != null){
			companyCaStr = paramMap.get("companyCategory").toString();
		}
		model.addAttribute("companyCategory", companyCaStr);
		model.addAttribute("listCompany", listCompany);
		model.addAttribute("titleImgPath", Constant.imageSmallPath);
		model.addAttribute("titleImgPath2", Constant.imageTitlePath);
		return "/fobu/admin/product/enterpriseOrder";
	}
	
	/**
	 * 발주 재고 목록 가져오기
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/admin/product/enterpriseOrder.action")
	public String enterpriseOrderList2(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	    
	    
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;		
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int listEnterpriseOrderCount = enterpriseOrderService.listEnterpriseOrderCount(paramMap);
	    List<ProductVO> listEnterpriseOrder = enterpriseOrderService.listEnterpriseOrder(paramMap);
	   
	    AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(listEnterpriseOrderCount, pageNum, listScale, 15, "");
		
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("pageSplit" , pageSplit);
		hmap.put("listEnterpriseOrderCount" , listEnterpriseOrderCount);
		hmap.put("listEnterpriseOrder"   , JSONArray.fromObject(listEnterpriseOrder));
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		return null;
	}
	
	@RequestMapping(value = "/admin/product/enterpriseOrderStatus_save.action")
	public ModelAndView enterpriseOrderStatus_save(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductList")ProductListVO productList) throws SQLException {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = enterpriseOrderService.updateEnterpriseOrderQy(productList);
		int rtnVal2 = enterpriseOrderService.updateEnterpriseOrderStatus(productList,"9999");
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal2);
		mav.setViewName("/fobu/admin/product/product_result");
		
		return mav;
	}
	
	@RequestMapping(value = "/admin/product/enterpriseOrderStatus_del.action")
	public ModelAndView enterpriseOrderStatus_del(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductList")ProductListVO productList) throws SQLException {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = enterpriseOrderService.updateEnterpriseOrderStatus(productList,"0002");
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result");
		
		return mav;
	}
	
	@RequestMapping(value = "/admin/product/enterpriseOrderStatus_update.action")
	public ModelAndView enterpriseOrderStatus_update(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductList")ProductListVO productList) throws SQLException {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = enterpriseOrderService.updateEnterpriseOrderQy(productList);
		
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
