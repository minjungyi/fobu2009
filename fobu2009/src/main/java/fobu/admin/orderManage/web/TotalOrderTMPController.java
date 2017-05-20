package main.java.fobu.admin.orderManage.web;

import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.util.AjaxPageSplit;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;

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
import main.java.fobu.admin.orderManage.service.TotalOrderService;
import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.common.util.StringUtil;

import org.springframework.beans.factory.annotation.Autowired;
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
public class TotalOrderTMPController {
	
	//private String listScale ="20";
		
	@Resource(name = "totalOrderServiceImpl")
	private TotalOrderService totalOrderService;
	
	@Autowired
	private FileService fileService;
	
	/**
	 * The Constructor
	 */
	public TotalOrderTMPController() {
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
	@RequestMapping(value = "/admin/orderManageT/totalList.html")
	public String view(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		    String returnUrl = "/fobu/admin/orderManage/totalList";
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
		    }else{		    
		    	request.setAttribute("MSG", "주문통합검색");
		    	returnUrl = "/fobu/admin/orderManage/totalList";
		    }
		    request.setAttribute("type", typeTmp);
		return returnUrl;
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/orderManage/orderDetailPT.html")
	public String viewDetail(HttpServletRequest request, String seq, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		paramMap.put("seq", seq);
		List<TotalOrderVO> totalOrderDetailList = totalOrderService.listTotalOrderDetail(paramMap);
		model.addAttribute("totalOrderDetailList", totalOrderDetailList);
		return "/fobu/admin/orderManage/orderDetailP";
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
	@RequestMapping(value = "/admin/orderManage/initT.action")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		System.out.println("**************1************");
		//int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int pageNum = 1;
		System.out.println("**************2************");
//		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int listScale = 20;
		System.out.println("**************3************");
		int paging = (pageNum-1)*listScale;
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		//paramMap.put("listScale", listScale);
		System.out.println("**************************"+paramMap);
		int totalOrderCount = totalOrderService.listTotalOrderCount(paramMap);
	    List<TotalOrderVO> totalOrderList = totalOrderService.listTotalOrder(paramMap);
	    System.out.println("************totalOrderCount**************"+totalOrderCount);
		mav.setViewName("/fobu/admin/orderManage/totalList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(totalOrderCount, pageNum, listScale, 15, "");
		
		
		// HttpSession session = request.getSession(); 
		// System.out.println("session======================>"+session.getAttribute("id"));
		 
		
		hmap.put("page" , "1");
		hmap.put("total" , totalOrderCount);
		hmap.put("record" , "10");
		hmap.put("rows"   , JSONArray.fromObject(totalOrderList));
		request.setAttribute("totalOrderList", totalOrderList);
		JSONObject jsonObject = JSONObject.fromObject(hmap);	
		 System.out.println("************jsonObject**************"+jsonObject);
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
	@RequestMapping(value = "/admin/orderManage/initDetailT.action")
	public ModelAndView initDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		
	    List<TotalOrderVO> totalOrderDetailList = totalOrderService.listTotalOrderDetail(paramMap);
		mav.setViewName("/fobu/admin/orderManage/totalList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
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
	@RequestMapping(value = "/admin/orderManage/saveMemoT.action")
	public ModelAndView saveMemo(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    totalOrderService.saveMemo(paramMap);
		mav.setViewName("/fobu/admin/orderManage/totalList");
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
	 * 주문상태값 수정
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/orderManage/saveStatT.action")
	public ModelAndView saveStat(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    totalOrderService.saveStat(paramMap);
		mav.setViewName("/fobu/admin/orderManage/totalList");
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
	@RequestMapping(value = "/admin/orderManage/saveDeliveryNumberT.action")
	public ModelAndView saveDeliveryNumber(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, 
			@ModelAttribute("TotalOrder")TotalOrderVO TotalOrder, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		
	    totalOrderService.saveDeliveryNumber(paramMap);
		mav.setViewName("/fobu/admin/orderManage/totalList");
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
	 * 파일업로드
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/uploadT.action")
	public String uploadOrder(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
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
		totalOrderService.saveNewOrder(paramMap, fileBean, path);
		System.out.println("==============> uploadOrder END");
	    return "/fobu/admin/orderManage/newOrder";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/topT.html")
	public String view5(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
	        request.setAttribute("SHEET_MSG", "ㅋㅋㅋㅋ");
		return "/fobu/ainclude/top";
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
