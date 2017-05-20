package main.java.fobu.common.util;

import java.io.File;
import java.io.IOException;
import java.util.StringTokenizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import main.java.fobu.common.Constant;
import main.java.fobu.common.util.StringUtil;

public class DownloadServlet extends HttpServlet {
	
	private static final long serialVersionUID = -2363556206112221802L;
	
	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		  
		try {
			 
		    String contentType = req.getParameter("contentType");		// 컨텐트 타입
		    String fileName = req.getParameter("fileName");				// 변경이름 파일명
		    String key = req.getParameter("key");	    				// 파일이 위치한 해쉬 경로를 찾기 위한 값
		    String path	= req.getParameter("path");	  					// 파일위치
		    String orgFileName = req.getParameter("orgFileName");   	// 원본 파일명
		    System.out.println("contentType:"+contentType);
		    System.out.println("fileName:"+fileName);
		    System.out.println("key:"+key);
		    System.out.println("path:"+path);
		    System.out.println("orgFileName"+orgFileName);
		    ServletContext context = req.getSession().getServletContext();
		    
	    	String basePath = context.getRealPath(Constant.excelPath);
		    //String basePath ="C:/Users/min/Documents";
		    
		    if(!StringUtil.isNull(key)) {
		    	
		    	StringTokenizer st = new StringTokenizer(key, "_");
				String firstDir = null;
				String secondDir = null;
				
				int count = st.countTokens();
				
				while(count == 2 && st.hasMoreTokens()) {
					firstDir = st.nextToken();
					secondDir = st.nextToken();
				}
				
				StringBuffer sb = new StringBuffer();
				
				if(StringUtil.isNull(firstDir) || StringUtil.isNull(secondDir)) {
					sb.append(basePath);
					sb.append(File.separator);
					sb.append(key);
					sb.append(File.separator);
				}else{
					sb.append(basePath);
					sb.append(File.separator);
					sb.append(firstDir);
					sb.append(File.separator);
					sb.append(secondDir);
					sb.append(File.separator);
				}
				path = sb.toString();
				
		    }else{
		    	path = basePath;
		    }
		    		    
		    // 다운로드를 위한 인스턴스 생성 
		    DownloadUtil down = new DownloadUtil();
		    // 다운로드할 파일의 contentType 을 설정한다.
		    down.setContentType(contentType);
		    // 다운로드할 파일의 파일명을 제외한 경로명을 설정한다.
		    down.setFilePath(path);
		    // 다운로드할  파일명을 설정한다.
		    down.setFileName(fileName);	
		    
		    // 업로드 파일명을 변경하기전의 실제 파일명 명시
		    orgFileName = StringUtil.nullToString(orgFileName, fileName);
		    down.setOrgFileName(StringUtil.kor2Eng(orgFileName));
		    
		    // 다운로드할 파일의 스트림을 client 로 보낸다.
		    down.execute(req, res);
		    
		}catch(Exception e) {
			System.out.println("download error:"+e);
		}
	}
}