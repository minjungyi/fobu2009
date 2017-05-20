package main.java.fobu.admin.operationBbs.web;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.operationBbs.service.OperationBbsService;
import main.java.fobu.admin.operationBbs.service.OperationBbsVO;
import main.java.fobu.common.util.AjaxPageSplit;
import main.java.fobu.common.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Controller
 *
 * @author min 
 * @since 2013. 03. 08.
 */
@Controller
public class OperationBbsController {
			
	// Logger
	private Log logger;
	
	@Resource(name = "operationBbsServiceImpl")
	private OperationBbsService operationBbsService;
	
	/**
	 * The Constructor
	 */
	public OperationBbsController() {
		logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/operationBbs/operationBbsList.html")
	public String view(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		request.setAttribute("typeCode",paramMap.get("typeCode"));
		return "/fobu/admin/operationBbs/operationBbsList";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/operationBbs/operationBbsNew.html")
	public String viewNew(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		request.setAttribute("typeCode",paramMap.get("typeCode"));
		return "/fobu/admin/operationBbs/operationBbsNew";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/operationBbs/operationBbsDetail.html")
	public String viewDetail(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		request.setAttribute("typeCode",paramMap.get("typeCode"));
		request.setAttribute("idx",paramMap.get("idx"));
		return "/fobu/admin/operationBbs/operationBbsDetail";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/operationBbs/operationBbsUpdate.html")
	public String viewUpdate(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		request.setAttribute("typeCode",paramMap.get("typeCode"));
		request.setAttribute("idx",paramMap.get("idx"));
		return "/fobu/admin/operationBbs/operationBbsUpdate";
	}
	
	
	/**
	 * 작업요청게시판 검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/operationBbs/init.action")
	public void init(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		//UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);

		int operationBbsCount = operationBbsService.listOperationBbsCount(paramMap);
	    List<OperationBbsVO> operationBbsList = operationBbsService.listOperationBbs(paramMap);

		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(operationBbsCount, pageNum, listScale, 15, "");
		
		hmap.put("operationBbsList"   , JSONArray.fromObject(operationBbsList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("operationBbsCount" , operationBbsCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	}
	
	/**
	 * 작업요청게시판 검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/operationBbs/initDetail.action")
	public void initDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		//UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		
	    List<OperationBbsVO> operationBbsList = operationBbsService.listDetailOperationBbs(paramMap);

		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("operationBbsList"   , JSONArray.fromObject(operationBbsList));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	}
	
	/**
	 * 작업요청게시판 insert
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/operationBbs/insertOperationBbs.action")
	public void insertOperationBbs(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		operationBbsService.insertOperationBbs(paramMap);
	}
	
	/**
	 * 작업요청게시판 update
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/operationBbs/updateOperationBbs.action")
	public void updateOperationBbs(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    //totalOrderService.saveEnterOrder(paramMap);
		operationBbsService.updateOperationBbs(paramMap);
	}
	
	/**
	 * 작업요청게시판 delete
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/operationBbs/deleteOperationBbs.action")
	public void deleteOperationBbs(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    //totalOrderService.saveEnterOrder(paramMap);
		operationBbsService.deleteOperationBbs(paramMap);
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
