package main.java.fobu.admin.statisticsManage.web;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.admin.statisticsManage.service.StatisticsService;
import main.java.fobu.admin.statisticsManage.service.StatisticsVO;
import main.java.fobu.common.service.FileService;
import main.java.fobu.common.util.AjaxPageSplit;
import main.java.fobu.common.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class StatisticsController {
	
	//private String listScale ="20";
		
	@Resource(name = "statisticsServiceImpl")
	private StatisticsService statisticsService;
	
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	/**
	 * The Constructor
	 */
	public StatisticsController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 월별통계화면호출
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/statisticsManage/statisticsList.html")
	public String view(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	    model.addAttribute("listCompany", listCompany);
		return "/fobu/admin/statisticsManage/statisticsList";
	}	
	
	/**
	 * 월별통계목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/statisticsManage/init.action")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int statisticsCount = statisticsService.listStatisticsCount(paramMap);
	    List<StatisticsVO> statisticsList = statisticsService.listStatistics(paramMap);
		mav.setViewName("/fobu/admin/statisticsManage/statisticsList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(statisticsCount, pageNum, listScale, 15, "");
				 
		hmap.put("statisticsList"   , JSONArray.fromObject(statisticsList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("statisticsCount" , statisticsCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	    return null;
	}
	
	/**
	 * 일별통계화면호출
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/statisticsManage/statisticsDailyList.html")
	public String viewDaily(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	    model.addAttribute("listCompany", listCompany);
		return "/fobu/admin/statisticsManage/statisticsDailyList";
	}	
	
	/**
	 * 일별통계목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/statisticsManage/initDaily.action")
	public ModelAndView initDaily(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int statisticsCount = statisticsService.listStatisticsDailyCount(paramMap);
	    List<StatisticsVO> statisticsList = statisticsService.listStatisticsDaily(paramMap);
		mav.setViewName("/fobu/admin/statisticsManage/statisticsDailyList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(statisticsCount, pageNum, listScale, 15, "");
				 
		hmap.put("statisticsDailyList"   , JSONArray.fromObject(statisticsList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("statisticsDailyCount" , statisticsCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	    return null;
	}
	
	/**
	 * 상품별통계화면호출
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/statisticsManage/statisticsProductList.html")
	public String viewProduct(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	    model.addAttribute("listCompany", listCompany);
		return "/fobu/admin/statisticsManage/statisticsProductList";
	}	
	
	/**
	 * 상품별통계목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/statisticsManage/initProduct.action")
	public ModelAndView initProduct(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int statisticsProductCount = statisticsService.listStatisticsProductCount(paramMap);
	    List<StatisticsVO> statisticsList = statisticsService.listStatisticsProduct(paramMap);
		mav.setViewName("/fobu/admin/statisticsManage/statisticsProductList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(statisticsProductCount, pageNum, listScale, 15, "");
				 
		hmap.put("statisticsList"   , JSONArray.fromObject(statisticsList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("statisticsProductCount" , statisticsProductCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	    return null;
	}
	
	/**
	 * 배송별통계화면호출
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/admin/statisticsManage/statisticsDeliveryList.html")
	public String viewDelivery(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		return "/fobu/admin/statisticsManage/statisticsDeliveryList";
	}	
	
	/**
	 * 배송별통계목록검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/statisticsManage/initDelivery.action")
	public ModelAndView initDelivery(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		
		int statisticsCount = statisticsService.listStatisticsDeliveryCount(paramMap);
	    List<StatisticsVO> statisticsList = statisticsService.listStatisticsDelivery(paramMap);
		mav.setViewName("/fobu/admin/statisticsManage/statisticsDeliveryList");
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(statisticsCount, pageNum, listScale, 15, "");
				 
		hmap.put("statisticsDeliveryList"   , JSONArray.fromObject(statisticsList));
		hmap.put("pageSplit" , pageSplit);
		hmap.put("statisticsDeliveryCount" , statisticsCount);
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
	    return null;
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
