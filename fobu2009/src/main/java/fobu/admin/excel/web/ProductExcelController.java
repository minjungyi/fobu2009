package main.java.fobu.admin.excel.web;

import main.java.fobu.common.Constant;
import main.java.fobu.common.service.UserVO;


import java.sql.SQLException;
import java.text.SimpleDateFormat;

import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import main.java.fobu.admin.excel.service.ProductExcelService;
import main.java.fobu.admin.excel.service.ProductExcelVO;
import main.java.fobu.admin.orderManage.service.OrderExcelVO;
import main.java.fobu.admin.product.service.NewShopProductService;
import main.java.fobu.admin.product.service.NewShopProductVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.admin.product.service.ProductVO;
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
public class ProductExcelController {
	
	//private String listScale ="20";
		
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	@Resource(name = "productExcelServiceImpl")
	private ProductExcelService productExcelService;
	
	@Resource(name = "newShopProductServiceImpl")
	private NewShopProductService newShopProductService;
	
	/**
	 * The Constructor
	 */
	public ProductExcelController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	/**
	 * 제품 통합검색 - 재고내역 엑셀 목록
	 * @param request
	 * @param response
	 * @param seq
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/excel/product_excellist.html")
	public String viewExcel(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		//System.out.println("viewExcel paramMap=====>"+paramMap);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		String searchTextTmp = paramMap.get("searchText").toString();
		//System.out.println("searchText=====>"+searchTextTmp);
		//System.out.println("searchText=====>"+StringUtil.encode(searchTextTmp, "UTF-8"));
		paramMap.put("searchText", StringUtil.encode(searchTextTmp, "UTF-8"));
		//System.out.println("viewExcel paramMap2=====>"+paramMap);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		
		List<ProductVO> listProduct = productService.listProduct(paramMap);
		model.addAttribute("titleImgPath", Constant.imageMediumPath);
		model.addAttribute("listProduct", listProduct);
		model.addAttribute("hostURL",Constant.hostURL );		
		
		return "/fobu/admin/excel/product_excellist";
	}
	
	/**
	 * 대형몰 신제품 목록 조회(엑셀)
	 * @param request
	 * @param response
	 * @param seq
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/excel/new_shop_product_list.html")
	public String viewExcel2(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);		
		String deliver_type = "";
		if(paramMap.get("deliver").equals("free")){
			deliver_type ="무료";
		}else{
			deliver_type ="착불 선결제";
		}
		
		
	    List<NewShopProductVO> listProduct = newShopProductService.listExcelNewProduct(paramMap);
	    model.addAttribute("listProduct", listProduct);
	    model.addAttribute("imageTitlePath", Constant.imageTitlePath);
	    model.addAttribute("deliver_type", deliver_type);
	    model.addAttribute("hostURL",Constant.hostURL );
	    model.addAttribute("fileName","신규제품등록"+getStringDate());
	    model.addAttribute("marketType",paramMap.get("marketType").toString());
	    model.addAttribute("companyCategory",paramMap.get("companyCategory").toString());
	    
	    
		return "/fobu/admin/excel/new_shop_product_list";
	}
	
	/**
	 * 대형몰 신제품 목록 조회(엑셀)
	 * @param request
	 * @param response
	 * @param seq
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/excel/choco_mall_product_list.html")
	public String viewExcel3(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);		
		String deliver_type = "";
		if(paramMap.get("deliver").equals("free")){
			deliver_type ="무료";
		}else{
			deliver_type ="착불 선결제";
		}
		
		
	    List<NewShopProductVO> listProduct = newShopProductService.listExcelNewChocoMall(paramMap);
	    model.addAttribute("listProduct", listProduct);
	    model.addAttribute("imageTitlePath", Constant.imageTitlePath);
	    model.addAttribute("deliver_type", deliver_type);
	    model.addAttribute("hostURL",Constant.hostURL );
	    model.addAttribute("fileName","신규제품등록"+getStringDate());
	    model.addAttribute("marketType",paramMap.get("marketType").toString());
	    model.addAttribute("companyCategory",paramMap.get("companyCategory").toString());
	    
	    
		return "/fobu/admin/excel/choco_mall_product_list";
	}
	
	/**
	 * 발주검색 - 주문,제품 발주 엑셀 목록
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/excel/enterPriseOrder_excellist.html")
	public String viewExcel(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		List<ProductExcelVO> totalOrderList = productExcelService.listProductExcel(paramMap);
		model.addAttribute("titleImgPath", Constant.imageMediumPath);
		model.addAttribute("enterpriseOrderExcelList", totalOrderList);
		model.addAttribute("hostURL",Constant.hostURL );
		List<ProductExcelVO> listCompany = productExcelService.listProductCompanyExcel(paramMap);
		//List<ProductExcelVO> listCompanySum = productExcelService.listProductCompanySumExcel(paramMap);
		model.addAttribute("listCompany", listCompany);
		model.addAttribute("textYn", paramMap.get("textYn"));

		return "/fobu/admin/excel/enterPriseOrder_excelList";
	}
	
	
	/***
	 * 현재 시간 문자열 반환 함수
	 * @return
	 */
	private String getStringDate(){
		String date ="";
		GregorianCalendar calendar = new GregorianCalendar();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		
		date = dateFormat.format(calendar.getTime());
		return date;
		
	}
	
}
