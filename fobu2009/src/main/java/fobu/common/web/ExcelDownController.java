package main.java.fobu.common.web;

import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.common.service.ExcelDownService;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.beans.factory.annotation.Autowired;
import main.java.fobu.common.Constant;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class ExcelDownController {
	
	@Autowired
	private ExcelDownService excelDownService;
	
	/**
	 * The Constructor
	 */
	public ExcelDownController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 파일다운(배송완료)
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/util/deliveryCompleteExcel.action")
	public ModelAndView deliveryCompleteExcel(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		ServletContext context = request.getSession().getServletContext();
    	//System.out.println("context.getRealPath--->"+context.getRealPath(Constant.excelPath));
    	String path = context.getRealPath(Constant.excelPath+"/deliveryCompleteExcel.xls");
    	//String path = "C:/Documents and Settings/min/My Documents/네이트온 받은 파일";
		paramMap.put("paging", 0);
		paramMap.put("listScale", 1000000000);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		//paramMap.put("listScale", listScale);
		excelDownService.deliveryCompleteExcel(paramMap, path);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		
	    return null;
	}
	
	/**
	 * 파일다운(배송완료)
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/util/exportDeliveryExcel.action")
	public ModelAndView exportDeliveryExcel(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		ServletContext context = request.getSession().getServletContext();
    	//System.out.println("context.getRealPath--->"+context.getRealPath(Constant.excelPath));
    	//System.out.println("paramMap--->"+paramMap);
    	String path = context.getRealPath(Constant.excelPath+"/exportDeliveryExcel.xls");
		paramMap.put("paging", 0);
		paramMap.put("listScale", 1000000000);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		excelDownService.exportDeliveryExcel(paramMap, path);		
	    return null;
	}
	
	/**
	 * 파일다운(업체발주 이미지 있는 엑셀다운)
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/util/enterpriseOrderExcel.action")
	public ModelAndView enterpriseOrderExcel(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		ServletContext context = request.getSession().getServletContext();
    	//System.out.println("context.getRealPath--->"+context.getRealPath(Constant.excelPath));
    	String path = context.getRealPath(Constant.excelPath+"/enterpriseOrderExcel.xls");
    	//String path = "C:/Documents and Settings/min/My Documents/네이트온 받은 파일";
		paramMap.put("paging", 0);
		paramMap.put("listScale", 1000000000);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		//paramMap.put("listScale", listScale);
		excelDownService.enterpriseOrderExcel(paramMap, path);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		
	    return null;
	}
	
	/**
	 * 파일다운(업체발주)
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/util/enterpriseOrderExcelEtc.action")
	public ModelAndView enterpriseOrderExcelEtc(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		ServletContext context = request.getSession().getServletContext();
    	//System.out.println("context.getRealPath--->"+context.getRealPath(Constant.excelPath));
    	String path = context.getRealPath(Constant.excelPath+"/enterpriseOrderExcel.xls");
    	//String path = "C:/Documents and Settings/min/My Documents/네이트온 받은 파일";
		paramMap.put("paging", 0);
		paramMap.put("listScale", 1000000000);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		//paramMap.put("listScale", listScale);
		excelDownService.enterpriseOrderExcelEtc(paramMap, path);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		
	    return null;
	}
	
	/**
	 * 파일다운(업체입금)
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/util/enterpriseDepositExcel.action")
	public ModelAndView enterpriseDepositExcel(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		ServletContext context = request.getSession().getServletContext();
    	//System.out.println("context.getRealPath--->"+context.getRealPath(Constant.excelPath));
    	String path = context.getRealPath(Constant.excelPath+"/enterpriseDepositExcel.xls");
    	//String path = "C:/Documents and Settings/min/My Documents/네이트온 받은 파일";
		paramMap.put("paging", 0);
		paramMap.put("listScale", 1000000000);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		//paramMap.put("listScale", listScale);
		excelDownService.enterpriseDepositExcel(paramMap, path);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		
	    return null;
	}
	
	/**
	 * 파일다운(제품관리)
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/util/productListExcelEtc.action")
	public ModelAndView productListExce(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	

		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		ServletContext context = request.getSession().getServletContext();
    	//System.out.println("context.getRealPath--->"+context.getRealPath(Constant.excelPath));
    	String path = context.getRealPath(Constant.excelPath+"/enterpriseOrderExcel.xls");
    	//String path = "C:/Documents and Settings/min/My Documents/네이트온 받은 파일";
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		//paramMap.put("listScale", listScale);
		excelDownService.productListExce(paramMap, path);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		
	    return null;
	}
		
	
}
