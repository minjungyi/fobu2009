package main.java.fobu.admin.bbs.web;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.bbs.service.BbsService;
import main.java.fobu.admin.bbs.service.BbsVO;
import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.common.Constant;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.AjaxPageSplit;
import main.java.fobu.common.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Controller
 *
 * @author min 
 * @since 2013. 03. 08.
 */
@Controller
public class BbsController {
			
	// Logger
	private Log logger;
	
	@Resource(name = "bbsServiceImpl")
	private BbsService bbsService;
	
	/**
	 * The Constructor
	 */
	public BbsController() {
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
	@RequestMapping(value = "/admin/bbs/bbsList.html")
	public String view(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		request.setAttribute("typeCode",paramMap.get("typeCode"));
		return "/fobu/admin/bbs/bbsList";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/bbs/bbsNew.html")
	public String viewNew(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		request.setAttribute("typeCode",paramMap.get("typeCode"));
		return "/fobu/admin/bbs/bbsNew";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/bbs/bbsReply.html")
	public String viewReply(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		request.setAttribute("typeCode",paramMap.get("typeCode"));
		request.setAttribute("idx",paramMap.get("idx"));
		request.setAttribute("ref",paramMap.get("ref"));
		request.setAttribute("lvl",paramMap.get("lvl"));
		
		return "/fobu/admin/bbs/bbsReply";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/bbs/bbsDetail.html")
	public String viewDetail(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		request.setAttribute("typeCode",paramMap.get("typeCode"));
		request.setAttribute("idx",paramMap.get("idx"));
		return "/fobu/admin/bbs/bbsDetail";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/bbs/bbsUpdate.html")
	public String viewUpdate(HttpServletRequest request, String type, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		request.setAttribute("typeCode",paramMap.get("typeCode"));
		request.setAttribute("idx",paramMap.get("idx"));
		return "/fobu/admin/bbs/bbsUpdate";
	}
	
	
	/**
	 * BBS 검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/bbs/init.action")
	public void init(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		//UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);

		int bbsCount = bbsService.listBbsCount(paramMap);
	    List<BbsVO> bbsList = bbsService.listBbs(paramMap);

		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(bbsCount, pageNum, listScale, 15, "");
		
		hmap.put("bbsList"   , JSONArray.fromObject(bbsList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("bbsCount" , bbsCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	}
	
	/**
	 * BBS 검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/bbs/initDetail.action")
	public void initDetail(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		//UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		
	    List<BbsVO> bbsList = bbsService.listDetailBbs(paramMap);

		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("bbsList"   , JSONArray.fromObject(bbsList));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	}
	
	/**
	 * BBS insert
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/bbs/insertBbs.action")
	public void insertBbs(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		bbsService.insertBbs(paramMap);
	}
	
	/**
	 * BBS insert
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/bbs/insertReplyBbs.action")
	public void insertReplyBbs(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		bbsService.insertReplyBbs(paramMap);
	}
	
	/**
	 * BBS update
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/bbs/updateBbs.action")
	public void updateBbs(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    //totalOrderService.saveEnterOrder(paramMap);
		bbsService.updateBbs(paramMap);
	}
	
	/**
	 * BBS delete
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/bbs/deleteBbs.action")
	public void deleteBbs(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    //totalOrderService.saveEnterOrder(paramMap);
		bbsService.deleteBbs(paramMap);
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
