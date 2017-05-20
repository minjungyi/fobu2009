package main.java.fobu.common.web;

import main.java.fobu.admin.orderManage.service.TotalOrderService;
import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.common.service.CommonFileVO;

import java.io.File;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Sheet;
import jxl.Workbook;

import main.java.fobu.common.service.FileService;
import main.java.fobu.common.service.TestService;
import main.java.fobu.common.util.AjaxPageSplit;
import main.java.fobu.common.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
public class TestController {
		
	@Resource(name = "testServiceImpl")
	private TestService testService;
	
	@Resource(name = "totalOrderServiceImpl")
	private TotalOrderService totalOrderService;
	
	@Autowired
	private FileService fileService;
	
	/**
	 * The Constructor
	 */
	public TestController() {
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
	@RequestMapping(value = "/myTest22.html")
	public String view(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
	        // Forward View
		    System.out.println("1");
		    String TestList = testService.getTestViewList();
		    System.out.println("34567899876543456789098765456789098765456789098765"+TestList);
	        request.setAttribute("SHEET_MSG", "��������");
	        System.out.println("Spring ȯ�� ��Ҵ�.");
    	//}
		///hr/ParersJdgmnM
		return "/fobu/myTest";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/myTest12.html")
	public String view11(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
	        // Forward View
		    System.out.println("1");
		    String TestList = testService.getTestViewList();
		    System.out.println("34567899876543456789098765456789098765456789098765"+TestList);
	        request.setAttribute("SHEET_MSG", "��������");
	        System.out.println("Spring ȯ�� ��Ҵ�.");
    	//}
		///hr/ParersJdgmnM
		return "/view/fobu/myTest";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/boardList.html")
	public String view2(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
	        // Forward View
		   // System.out.println("1");
		    //String TestList = testService.getTestViewList();
		    //System.out.println("34567899876543456789098765456789098765456789098765"+TestList);
	        request.setAttribute("SHEET_MSG", "��������");
	        //System.out.println("Spring ȯ�� ��Ҵ�.");
    	//}
		///hr/ParersJdgmnM
		return "/fobu/init";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/excelUploadTest.html")
	public String view3(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
	        // Forward View
		   // System.out.println("1");
		    //String TestList = testService.getTestViewList();
		    //System.out.println("34567899876543456789098765456789098765456789098765"+TestList);
	        request.setAttribute("SHEET_MSG", "��������");
	        //System.out.println("Spring ȯ�� ��Ҵ�.");
	        CommonFileVO fileBean = null;
	        int res = 0;
	        
	        try {
	        	ServletContext context = request.getSession().getServletContext();
	        	System.out.println("context.getRealPath--->"+context.getRealPath("/view/fobu/excel"));
	        	String path = context.getRealPath("/view/fobu/excel");
				fileBean = fileService.getUploadFileList(request, 1, path);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(fileBean != null && fileBean.getFileSize().equals("-1")){
				res = -100;
			}
			else{
				//res = applicationService.insertApplicationList(appList,fileBean);
				//commonService.sendServiceResultMail(res);					
			}
    	//}
		///hr/ParersJdgmnM
		return "/fobu/excelUploadTest";
	}	
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	@RequestMapping(value = "/fileUploadTest2.html")
	public String viewFileUpload(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws SQLException {
	        // Forward View
		   // System.out.println("1");
		    //String TestList = testService.getTestViewList();
		    System.out.println("34567899876543456789098765456789098765456789098765");
	        request.setAttribute("SHEET_MSG", "파일업로드테스트");
    	//}
		///hr/ParersJdgmnM
		return "/fobu/fileUploadTest";
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
	@RequestMapping(value = "/upload2.action")
	public String uploadTmp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav, ModelMap model) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		CommonFileVO fileBean = null;
        int res = 0;
        try {
        	ServletContext context = request.getSession().getServletContext();
        	System.out.println("context.getRealPath--->"+context.getRealPath("/view/fobu/excel"));
        	String path = context.getRealPath("/view/fobu/excel");
			fileBean = fileService.getUploadFileList(request, 1, path);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//System.out.println("fileBean                        "+fileBean.getFileName());
		/*
		if(fileBean != null && fileBean.getFileSize().equals("-1")){
			res = -100;
		}
		else{
			//res = applicationService.insertApplicationList(appList,fileBean);
			//commonService.sendServiceResultMail(res);					
		}*/
		System.out.println("fileBean.getFileName()============>"+fileBean.getFileName());
    	Workbook workbook = Workbook.getWorkbook(new File("C:\\Users\\min\\workspace\\fobu2009\\WebContent\\view\\fobu\\excel"+"\\"+fileBean.getFileName()));
    	
    	Sheet sheet = workbook.getSheet(0);
    	int col = sheet.getColumns();
    	System.out.println("col============>"+col);
    	int row = sheet.getRows();
    	System.out.println("row============>"+row);
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
	@RequestMapping(value = "/admin/orderManage/excelDown.html")
	public String viewExcelDown(HttpServletRequest request, HttpServletResponse response,ModelMap model) throws SQLException {

	        request.setAttribute("SHEET_MSG", "엑셀다운화면");
		return "/fobu/excelDown";
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
