package main.java.fobu.common.web;

import java.sql.SQLException;
import java.util.Map;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.common.service.FileService;
import main.java.fobu.common.util.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class FileUploadController {
	
	@Autowired
	private FileService fileService;
	
	/**
	 * The Constructor
	 */
	public FileUploadController() {
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
	@RequestMapping(value = "/fileUploadTest.html")
	public String viewFileUpload(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
		
		    System.out.println("파일업로드");
	        request.setAttribute("SHEET_MSG", "파일업로드");
	        
		return "/fobu/fileUploadTest";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/multiUpload.html")
	public String multiUpload(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
		
		    System.out.println("멀티업로드");
	        request.setAttribute("SHEET_MSG", "멀티업로드");
	        
		return "/fobu/multiUpload";
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
	@RequestMapping(value = "/multiUpload.action")
	public String multiUpload(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
        int res = 0;
        try {
        	ServletContext context = request.getSession().getServletContext();
        	System.out.println("context.getRealPath--->"+context.getRealPath("/view/fobu/excel"));
        	String path = context.getRealPath("/view/fobu/excel");
        	//path = C:\\Users\\min\\workspace\\fobu2009\\WebContent\\view\\fobu\\excel
			fileService.multiUpload(request, 1, path);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
	    return "/fobu/multiUpload";
	}
		
	
}
