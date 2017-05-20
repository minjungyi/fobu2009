package main.java.fobu.admin.orderManage.web;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.orderManage.service.OrderExcelService;
import main.java.fobu.admin.orderManage.service.OrderExcelVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.common.Constant;
import main.java.fobu.common.service.UserVO;
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
public class OrderExcelController {
	
	//private String listScale ="20";
		
	@Resource(name = "orderExcelServiceImpl")
	private OrderExcelService orderExcelService;
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	/**
	 * The Constructor
	 */
	public OrderExcelController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 업체발주통합검색 - 업체발주 엑셀 목록
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/excel/order_excellist.html")
	public String viewExcel(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		//System.out.println("viewExcel paramMap=====>"+paramMap);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("paging", 0);
		paramMap.put("listScale", 100000);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		
		List<OrderExcelVO> totalOrderList = orderExcelService.listOrderExcel(paramMap);
		model.addAttribute("titleImgPath", Constant.imageMediumPath);
		model.addAttribute("enterpriseOrderExcelList", totalOrderList);
		model.addAttribute("hostURL",Constant.hostURL );
		List<OrderExcelVO> listCompany = orderExcelService.listOrderCompanyExcel(paramMap);
		List<OrderExcelVO> listCompanySum = orderExcelService.listOrderCompanySumExcel(paramMap);
		model.addAttribute("listCompany", listCompany);
		model.addAttribute("listCompanySum", listCompanySum);
	    
		return "/fobu/admin/excel/order_excellist";
	}
	
	/**
	 * 업체발주통합검색 - 업체발주 엑셀 목록
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/excel/deposit_excellist.html")
	public String viewDepositExcel(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		//System.out.println("viewExcel paramMap=====>"+paramMap);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("paging", 0);
		paramMap.put("listScale", 100000);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		
		List<OrderExcelVO> totalOrderList = orderExcelService.listDepositExcel(paramMap);
		model.addAttribute("titleImgPath", Constant.imageMediumPath);
		model.addAttribute("enterpriseOrderExcelList", totalOrderList);
		model.addAttribute("hostURL",Constant.hostURL );
		List<OrderExcelVO> listCompany = orderExcelService.listDepositCompanyExcel(paramMap);
		model.addAttribute("listCompany", listCompany);
	    
		return "/fobu/admin/excel/deposit_excellist";
	}
}
