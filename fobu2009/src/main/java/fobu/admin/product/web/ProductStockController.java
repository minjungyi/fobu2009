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

import main.java.fobu.admin.product.service.ProductBrandService;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductCategoryService;
import main.java.fobu.admin.product.service.ProductListVO;
import main.java.fobu.admin.product.service.ProductSizeOptListVO;
import main.java.fobu.admin.product.service.ProductSizeOptVO;
import main.java.fobu.admin.product.service.ProductStockService;
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
public class ProductStockController {
		
	@Resource(name = "productStockServiceImpl")
	private ProductStockService productStockService;		
	
	/**
	 * The Constructor
	 */
	public ProductStockController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 
	 * 재고량 조회 호출
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_stockPop.html")
	public String view2(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    
	    List<ProductSizeOptVO> listStock = productStockService.listStock(paramMap);
	    model.addAttribute("listStock", listStock);
	    model.addAttribute("uSeq", paramMap.get("uSeq"));
	    model.addAttribute("realStock", paramMap.get("realStock"));
	    model.addAttribute("rtnVal", "0");
		return "/fobu/admin/product/product_stockPop";
	}
	
	@RequestMapping(value = "/admin/product/product_stockPop_save.action")
	public ModelAndView productStockSave(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductStockList")ProductSizeOptListVO productStockList) throws SQLException {
		
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		int rtnVal = productStockService.updateProductStock(productStockList,paramMap);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_stockPop");
		
		return mav;
	}
	
}
