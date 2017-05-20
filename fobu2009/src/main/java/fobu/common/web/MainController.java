package main.java.fobu.common.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.WriteException;
import main.java.fobu.common.service.MainService;
import main.java.fobu.common.service.MainVO;
import main.java.fobu.common.util.StringUtil;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class MainController {
		
	//@Resource(name = "loginServiceImpl")
	//private LoginService loginService;
	private Log logger = LogFactory.getLog(this.getClass());
	
	@Resource(name = "mainServiceImpl")
	private MainService mainService;
	
	/**
	 * The Constructor
	 */
	public MainController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
		
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	@RequestMapping(value = "/admin/main.html")
	public String view(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException, FileNotFoundException, WriteException, IOException {
	        request.setAttribute("SHEET_MSG", "MAIN START");
	        Map<String,String> paramMap = StringUtil.getParameterMap(request);
	        List<MainVO> listMainDaily = mainService.listMainDaily(paramMap);
	        List<MainVO> listMainMonth = mainService.listMainMonth(paramMap);
	        model.addAttribute("listMainDaily", listMainDaily);
	        model.addAttribute("listMainMonth", listMainMonth);
		return "/fobu/admin/main/main";
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
