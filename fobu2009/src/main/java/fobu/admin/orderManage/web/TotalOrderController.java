package main.java.fobu.admin.orderManage.web;

import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.AjaxPageSplit;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import main.java.fobu.common.service.FileService;
import main.java.fobu.admin.orderManage.service.ChangeProductListVO;
import main.java.fobu.admin.orderManage.service.PackageInfoListVO;
import main.java.fobu.admin.orderManage.service.TotalOrderService;
import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
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
import main.java.fobu.common.Constant;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class TotalOrderController {
	
	//private String listScale ="20";
		
	@Resource(name = "totalOrderServiceImpl")
	private TotalOrderService totalOrderService;
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	@Autowired
	private FileService fileService;
	
	/**
	 * The Constructor
	 */
	public TotalOrderController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/orderManage/totalList.html")
	public String view(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		    String returnUrl = "/fobu/admin/orderManage/totalList";
		    Map<String,String> paramMap = StringUtil.getParameterMap(request);
		    String typeTmp = "";
		    if(type != null){
		    	typeTmp = type;
		    }
		    if(typeTmp.equals("0")){
		    	request.setAttribute("MSG", "신규주문");
		    	returnUrl = "/fobu/admin/orderManage/newOrder";
		    }else if(typeTmp.equals("1")){
		    	request.setAttribute("MSG", "업체발주");
		    	returnUrl = "/fobu/admin/orderManage/enterpriseOrder";
		    }else if(typeTmp.equals("2")){
		    	request.setAttribute("MSG", "업체입금");
		    	returnUrl = "/fobu/admin/orderManage/enterpriseDeposit";
		    }else if(typeTmp.equals("3")){
		    	request.setAttribute("MSG", "배송완료");
		    	returnUrl = "/fobu/admin/orderManage/deliveryComplete";
		    }else if(typeTmp.equals("4")){
		    	request.setAttribute("MSG", "발송보류");
		    	returnUrl = "/fobu/admin/orderManage/deliveryDefer";
		    }else if(typeTmp.equals("5")){
		    	request.setAttribute("MSG", "취소요청");
		    	returnUrl = "/fobu/admin/orderManage/cancelRequest";
		    }else if(typeTmp.equals("6")){
		    	request.setAttribute("MSG", "취소완료");
		    	returnUrl = "/fobu/admin/orderManage/cancelComplete";
		    }else if(typeTmp.equals("7")){
		    	request.setAttribute("MSG", "반품요청");
		    	returnUrl = "/fobu/admin/orderManage/returnRequest";
		    }else if(typeTmp.equals("8")){
		    	request.setAttribute("MSG", "반품완료");
		    	returnUrl = "/fobu/admin/orderManage/returnComplete";
		    }else if(typeTmp.equals("9")){
		    	request.setAttribute("MSG", "교환요청");
		    	returnUrl = "/fobu/admin/orderManage/exchangeRequest";
		    }else if(typeTmp.equals("10")){
		    	request.setAttribute("MSG", "교환완료");
		    	returnUrl = "/fobu/admin/orderManage/exchangeComplete";
		    }else if(typeTmp.equals("11")){		    
		    	//System.out.println("------->"+paramMap);
		    	System.out.println("------->"+paramMap.get("totalNameText"));
		    	request.setAttribute("MSG", "주문통합검색");
		    	request.setAttribute("nameSel", paramMap.get("totalNameSel"));
				request.setAttribute("nameText",paramMap.get("totalNameText"));

			
		    	returnUrl = "/fobu/admin/orderManage/totalList";
		    }else{		    
		    	request.setAttribute("MSG", "주문통합검색");
		    	returnUrl = "/fobu/admin/orderManage/totalList";
		    }
		    List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
		    model.addAttribute("titleImgPath2", Constant.imageTitlePath);
		    model.addAttribute("listCompany", listCompany);
		    request.setAttribute("type", typeTmp);
		return returnUrl;
	}

	/**
	 * 주문정보 상세조회
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/orderManage/orderDetailPop.html")
	public String viewDetailPop(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
		List<TotalOrderVO> totalOrderDetailList = totalOrderService.listTotalOrderDetail(paramMap);
		model.addAttribute("listCompany", listCompany);
		model.addAttribute("trIndex", paramMap.get("trIndex"));
		model.addAttribute("pageNumPop", paramMap.get("pageNumPop"));
		model.addAttribute("titleImgPath", Constant.imageMediumPath);
		model.addAttribute("totalOrderDetailList", totalOrderDetailList);
		return "/fobu/admin/orderManage/orderDetailPop";
	}
	
	/**
	 * 오픈마켓정산 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/orderManage/openMatketAccount.html")
	public String viewOpenMatketAccount(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
		//List<TotalOrderVO> totalOrderDetailList = totalOrderService.listTotalOrderDetail(paramMap);
		model.addAttribute("listCompany", listCompany);
		//model.addAttribute("trIndex", paramMap.get("trIndex"));
		//model.addAttribute("pageNumPop", paramMap.get("pageNumPop"));
		//model.addAttribute("titleImgPath", Constant.imageMediumPath);
		//model.addAttribute("totalOrderDetailList", totalOrderDetailList);
		return "/fobu/admin/orderManage/openMatketAccount";
	}
	
	/**
	 * 주문정보 상품변경
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/orderManage/orderProductC.html")
	public String viewProductChangePop(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		model.addAttribute("trIndex", paramMap.get("trIndex"));
		model.addAttribute("pageNumPop", paramMap.get("pageNumPop"));
		model.addAttribute("seq", paramMap.get("seq"));
		model.addAttribute("titleImgPath", Constant.imageSmallPath);
		return "/fobu/admin/orderManage/orderProductC";
	}
	
	
	/**
	 * 주문통합정보검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/init.action")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		//response.sendError(404);
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		//paramMap.put("listScale", listScale);
		//System.out.println("**************************"+paramMap);
		int totalOrderCount = totalOrderService.listTotalOrderCount(paramMap);
	    List<TotalOrderVO> totalOrderList = totalOrderService.listTotalOrder(paramMap);
	    //System.out.println("************totalOrderCount**************"+totalOrderCount);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(totalOrderCount, pageNum, listScale, 15, "");
				
		// HttpSession session = request.getSession(); 
		 System.out.println("session======================>");
		hmap.put("autUrl", Constant.autLinkUrl);
		hmap.put("gmkUrl", Constant.gmkLinkUrl);
		hmap.put("itpUrl", Constant.itpLinkUrl);
		hmap.put("cywUrl", Constant.cywLinkUrl);
		hmap.put("shnUrl", Constant.shnLinkUrl);
		
		hmap.put("totalOrderList"   , JSONArray.fromObject(totalOrderList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("totalOrderCount" , totalOrderCount);
		 System.out.println("session======================>22");
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		//sendResponse(response, jsonObject);
	    //mav.addObject("totalOrderList", totalOrderList);
	    return null;
	}
	
	/**
	 * 주문통합정보상세검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/initDetail.action")
	public ModelAndView initDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		
	    List<TotalOrderVO> totalOrderDetailList = totalOrderService.listTotalOrderDetail(paramMap);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("titleImgPath", Constant.imageMediumPath);
		hmap.put("totalOrderDetailList"   , JSONArray.fromObject(totalOrderDetailList));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		//sendResponse(response, jsonObject);
	    //mav.addObject("totalOrderList", totalOrderList);
	    return null;
	}
	
	/**
	 * 주문통합의 관리자 메모 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveMemo.action")
	public void saveMemo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    totalOrderService.saveMemo(paramMap);
	}

	/**
	 * 주문통합의 재고옵션 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveStockOpt.action")
	public void saveStockOpt(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    totalOrderService.saveStockOpt(paramMap);
	}
	
	/**
	 * 주문정보 상세 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/orderDeSave.action")
	public void saveOrderDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		System.out.println("saveOrderDetail paramMap : "+paramMap);
	    totalOrderService.saveOrderDetail(paramMap);
	}
	
	/**
	 * 주문상태값 수정
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveStat.action")
	public ModelAndView saveStat(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    totalOrderService.saveStat(paramMap);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		// JSON 객체
		/*
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("totalOrderDetailList"   , JSONArray.fromObject(totalOrderDetailList));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		//sendResponse(response, jsonObject);
	    //mav.addObject("totalOrderList", totalOrderList);*/
	    return null;
	}
	
	
	/**
	 * 주문상태값 수정(송장번호 저장)
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveDeliveryNumber.action")
	public ModelAndView saveDeliveryNumber(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, 
			@ModelAttribute("TotalOrder")TotalOrderVO TotalOrder, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		
	    totalOrderService.saveDeliveryNumber(paramMap);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		// JSON 객체
		/*
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("totalOrderDetailList"   , JSONArray.fromObject(totalOrderDetailList));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		//sendResponse(response, jsonObject);
	    //mav.addObject("totalOrderList", totalOrderList);*/
	    return null;
	}
	
	/**
	 * 신규주문 파일업로드
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/newOrderUpload.action")
	public ModelAndView newOrderUpload(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		CommonFileVO fileBean = null;
		String succText = "Y";
        //int res = 0;
        ServletContext context = request.getSession().getServletContext();
    	System.out.println("context.getRealPath--->"+context.getRealPath(Constant.excelPath));
    	String path = context.getRealPath(Constant.excelPath);
        try {
        	//path = C:\\Users\\min\\workspace\\fobu2009\\WebContent\\view\\fobu\\excel
			fileBean = fileService.getUploadFileList(request, 1, path);
		} catch (Exception e) {
			System.out.println("[ERROR] fileUploadError--->"+e);
			succText = "N";
		}	
		
		try {
			totalOrderService.saveNewOrder(paramMap, fileBean, path);
		} catch (Exception e) {
			System.out.println("[ERROR] newOrderSveError--->"+e);
			succText = "N";
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("succ", succText);
		mav.setViewName("/fobu/admin/orderManage/newOrder");
		return mav;
	}
	
	/**
	 * 오픈마켓정산 파일업로드
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/openMarketAccountUpload.action")
	public ModelAndView openMarketAccountUpload(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		CommonFileVO fileBean = null;
		String succText = "Y";
        //int res = 0;
        ServletContext context = request.getSession().getServletContext();
    	System.out.println("context.getRealPath--->"+context.getRealPath(Constant.excelPath));
    	String path = context.getRealPath(Constant.excelPath);
        try {
        	//path = "C:/Users/mintwin/Desktop/min";
			fileBean = fileService.getUploadFileList(request, 1, path);
		} catch (Exception e) {
			System.out.println("[ERROR] fileUploadError--->"+e);
			succText = "N";
		}	
		
		try {
			totalOrderService.saveOpenMarketAccount(paramMap, fileBean, path);
		} catch (Exception e) {
			System.out.println("[ERROR] newOrderSveError--->"+e);
			succText = "N";
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("succ", succText);
		mav.setViewName("/fobu/admin/orderManage/openMatketAccount");
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
	/*
	@RequestMapping(value = "/productUpload.action")
	public String productUpload(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		CommonFileVO fileBean = null;
        //int res = 0;
        ServletContext context = request.getSession().getServletContext();
    	System.out.println("context.getRealPath--->"+context.getRealPath("/view/fobu/excel"));
    	String path = context.getRealPath("/view/fobu/excel");
        try {
        	//path = C:\\Users\\min\\workspace\\fobu2009\\WebContent\\view\\fobu\\excel
			fileBean = fileService.getUploadFileList(request, 1, path);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		totalOrderService.saveProductStatus(paramMap, fileBean, path);
	    return "";
	}*/
	
	/**
	 * 묶음상품정보
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/orderManage/packageInfoP.html")
	public String viewPackageInfo(HttpServletRequest request, String seq, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		paramMap.put("seq", seq);
		List<TotalOrderVO> packageInfolList = totalOrderService.listPackageInfo(paramMap);
		int totalSum = 0;
		for(int i = 0 ; i < packageInfolList.size() ; i++){
			totalSum = totalSum + Integer.parseInt(packageInfolList.get(i).getOrderQy());
		}
		
		model.addAttribute("rtnVal", "00");
		model.addAttribute("totalCnt", packageInfolList.size());
		model.addAttribute("totalSum", totalSum);
		model.addAttribute("pageNumPop", paramMap.get("pageNumPop"));
		model.addAttribute("trIndex", paramMap.get("trIndex"));
		model.addAttribute("packageInfolList", packageInfolList);
		model.addAttribute("titleImgPath", Constant.imageSmallPath);
		return "/fobu/admin/orderManage/packageInfoPop";
	}
	
	/**
	 * 묶음상품정보 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/savePackageInfo.action")
	public ModelAndView savePackageInfo(HttpServletRequest request, HttpServletResponse response,  
			@ModelAttribute("PackageInfoList")PackageInfoListVO PackageInfoList, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);		
		int rtnVal = totalOrderService.savePackageInfo(PackageInfoList);		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.addObject("msg", "묶음상품정보가");
		mav.addObject("pageNumPop", paramMap.get("pageNumPop"));
		mav.addObject("trIndex", paramMap.get("trIndex"));
		mav.setViewName("/fobu/admin/orderManage/packageInfoPop");		
	    return mav;
	}
	
	/**
	 * 주문상품변경 검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/listChangeProduct.action")
	public ModelAndView initChangeProduct(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = 8;
		int paging = (pageNum-1)*listScale;
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		int changeProductCount = totalOrderService.listChangeProductCount(paramMap);
	    List<ProductVO> changeProductList = totalOrderService.listChangeProduct(paramMap);
		
	    
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(changeProductCount, pageNum, listScale, 15, "");			 
		hmap.put("changeProductList"   , JSONArray.fromObject(changeProductList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("titleImgPath", Constant.imageSmallPath);
		hmap.put("changeProductCount" , changeProductCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	    return null;
	}
	
	/**
	 * 주문상품변경 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveChangeProduct.action")
	public ModelAndView saveChangeProduct(HttpServletRequest request, HttpServletResponse response,  
			@ModelAttribute("changeProductList")ChangeProductListVO changeProductList, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);	
		//System.out.println("=================================saveChangeProduct=====================================");
		int rtnVal = totalOrderService.saveChangeProduct(changeProductList, paramMap.get("seq"));		

		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.addObject("msg", "상품정보가");
		mav.addObject("pageNumPop", paramMap.get("pageNumPop"));
		mav.addObject("trIndex", paramMap.get("trIndex"));
		mav.setViewName("/fobu/admin/orderManage/order_result");		
	    return mav;
	}
	
	/**
	 * 재고수정화면
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/orderManage/realStockPop.html")
	public String viewRealStockPop(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		String productStr = "";
		String stockOptStr = "";
		try {
			productStr = new String(paramMap.get("product").getBytes("8859_1"), "UTF-8");
			stockOptStr = new String(paramMap.get("stockOpt").getBytes("8859_1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("paramMap.get(product)==>"+paramMap.get("product"));
		//System.out.println("productStr==>"+productStr);
		model.addAttribute("trIndex", paramMap.get("trIndex"));
		model.addAttribute("pageNumPop", paramMap.get("pageNumPop"));
		model.addAttribute("productCode", paramMap.get("productCode"));
		model.addAttribute("product", productStr);
		model.addAttribute("realStock", paramMap.get("realStock"));
		model.addAttribute("stockOpt", stockOptStr);
		
		return "/fobu/admin/orderManage/realStockPop";
	}
	
	
	/**
	 * 재고 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/realStockSearch.action")
	public void searchRealStock(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		
	    List<TotalOrderVO> searchRealStockList = totalOrderService.searchRealStock(paramMap);
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		hmap.put("searchRealStockList"   , JSONArray.fromObject(searchRealStockList));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return;
	}
	
	/**
	 * 재고 저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveRealStock.action")
	public void saveRealStock(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		System.out.println("saveRealStock paramMap : "+paramMap);
	    totalOrderService.saveRealStock(paramMap);	
/*
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageNumPop", paramMap.get("pageNumPop"));
		mav.addObject("trIndex", paramMap.get("trIndex"));
		mav.setViewName("/fobu/admin/orderManage/realStockPop");		
	    return mav;*/
	}
	
	/**
	 * 발주저장
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveEnterOrder.action")
	public ModelAndView saveEnterOrder(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    totalOrderService.saveEnterOrder(paramMap);
		//mav.setViewName("/fobu/admin/orderManage/totalList");
		// JSON 객체
		/*
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("totalOrderDetailList"   , JSONArray.fromObject(totalOrderDetailList));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		//sendResponse(response, jsonObject);
	    //mav.addObject("totalOrderList", totalOrderList);*/
	    return null;
	}
	
	/**
	 * 정산상태값 수정
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveAccountStat.action")
	public ModelAndView saveAccountStat(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    totalOrderService.saveAccountStat(paramMap);
		
	    return null;
	}
	

	/**
	 * Ajax json 응답
	 * @param response
	 * @param jsonObject
	 * @throws Exception
	 */
	private void sendResponse(HttpServletResponse response, JSONObject jsonObject) throws Exception {
		//Thread.sleep(200);
		response.setContentType("text/xml;charset=UTF-8");
		response.getWriter().print(jsonObject);
		response.getWriter().flush();
		response.getWriter().close();
    }
}
