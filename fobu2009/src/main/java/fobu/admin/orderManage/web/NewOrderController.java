package main.java.fobu.admin.orderManage.web;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.orderManage.service.NewOrderListVO;
import main.java.fobu.admin.orderManage.service.NewOrderService;
import main.java.fobu.admin.orderManage.service.PackageInfoListVO;
import main.java.fobu.admin.orderManage.service.TotalOrderService;
import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.common.Constant;
import main.java.fobu.common.service.FileService;
import main.java.fobu.common.util.AjaxPageSplit;
import main.java.fobu.common.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Controller
 *
 * @author min™ 
 * @since 2012. 03. 10.
 */
@Controller
public class NewOrderController {
	
	//private String listScale ="20";
		
	@Resource(name = "newOrderServiceImpl")
	private NewOrderService newOrderService;
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
		
	/**
	 * The Constructor
	 */
	public NewOrderController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 신규주문 (직송요청)
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/orderManage/orderProductT.html")
	public String viewDetailPop(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		return "/fobu/admin/orderManage/orderProductT";
	}	
	
	/**
	 * 주문정보 상품변경2
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/orderManage/orderProductC2.html")
	public String viewProductChangePop(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
		model.addAttribute("titleImgPath", Constant.imageSmallPath);
		model.addAttribute("listCompany", listCompany);
		return "/fobu/admin/orderManage/orderProductC2";
	}
	
	/**
	 * 신규주문 (직송요청) 상세 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveNewOrderProduct.action")
	public ModelAndView saveNewOrderProduct(HttpServletRequest request, HttpServletResponse response, 
			@ModelAttribute("NewOrderList")NewOrderListVO NewOrderList, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);		
		System.out.println("=================================NewOrderController saveNewOrderProduct=====================================");
		int rtnVal = newOrderService.saveNewOrderProduct(NewOrderList);

		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.addObject("msg", "신규주문(직송요청)이");
		mav.addObject("pageNumPop", "1");
		mav.addObject("trIndex", "1");
		mav.setViewName("/fobu/admin/orderManage/order_result");
		return mav;
	}
}
