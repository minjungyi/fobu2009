package main.java.fobu.common.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.PrintWriter;
import java.nio.ByteBuffer;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 
 * 다운로드 유틸 클래스.
 *  
 * 
 * 서블릿을 생성한 후, 해당 클래스를 사용하여 해당 서비스에 맞게 다운로드 기능을 구현한다. 
 * 파일에 대한 contentType(mime type) 을 설정하지 않고 다운로드를 시킬 경우 브라우져에서는 파일 저장에 대한 창을 띄워준다.
 * 단, <img src=""> 의 src 테그 내에서 다운로드를 요청할 경우 contentType 설정 유무와 상관없이 이미지는 브라우져에 직접 보여진다.  
 *
 * ex1) 
 * DownloadUtil down = new DownloadUtil("image/gif", "/data3/cafe/", "seunghwan.gif");
 * down.execute(request, response);
 * 
 * ex2)
 * DownloadUtil down = new DownloadUtil("/data3/cafe/", "seunghwan.gif");
 * down.execute(request, response);
 * 
 * ex3)
 * DownloadUtil down = new DownloadUtil();
 * down.setContentType("image/gif");
 * down.setFilepath("/data3/cafe/");
 * down.setFilename("seunghwan.gif");
 * down.execute(request, response);
 * 
 * @author ${Author}$
 * @version ${Date}$ ${Revision}$
 */
public class DownloadUtil {
    
    private String contentType = null;
    private String fileName = null;
    private String filePath = null;
    private String orgFileName = "";
    
    public DownloadUtil() {
    }
    
    /**
     * 
     * 생성자 
     * 
     * ex) DownloadUtil("image/gif", "/data3/cafe/", "seunghwan.gif")
     * @param contentType 다운로드 할 파일의 컨텐트 타입(mime-type)
     * @param filepath 파일명을 제외한 다운로드 할 파일의 경로
     * @param filename 다운로드 할 파일명
     */
    public DownloadUtil(String contentType, String filePath, String fileName) {
        this.contentType = contentType;
        this.filePath = filePath;        
        this.fileName = fileName;
    }
    
    /**
     *
     * 생성자
     *
     * ex) DownloadUtil("/data3/cafe/", "seunghwan.gif")
     * @param filepath 파일명을 제외한 다운로드 할 파일의 경로
     * @param filename 다운로드 할 파일명
     */
    public DownloadUtil(String filePath, String fileName) {
        this.filePath = filePath;        
        this.fileName = fileName;
    }
    
    /**
     *
     * 지정된 위치의 파일을 읽어 다운로드를 위한 스트림을 client 로 출력한다.
     *
     * @param req HttpServletRequest 인스턴스 
     * @param res HttpServletResponse 인스턴스
     * @throws Exception
     */
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {

		req.setCharacterEncoding("UTF-8");
		
		StringBuffer sb = new StringBuffer();
		sb.append(this.filePath);
		sb.append(this.fileName);
		
		String filePath = sb.toString();
		String contentDisp = null;
	
		String userAgent = req.getHeader("User-Agent");
		if (userAgent == null) {
			return;
		}
		
		if (userAgent.indexOf("MSIE") > 0) {
			if (userAgent.indexOf("MSIE 5.0") > 0) {
				contentDisp = "attachment;filename=";
				if (contentType == null) {
					contentType = "application/x-msdownload";
				}					
			} else {
				contentDisp = "attachment;filename=";
				if (contentType == null)
					contentType = "application/unknown";
			}
		} else {
			contentDisp = "attachment;filename=";
			if (contentType == null) {
				contentType = "application/unknown";
			}
		}
		
		sb.setLength(0);
		sb.append(contentDisp);
		sb.append(orgFileName);
		
		res.setContentType(contentType + "; charset=UTF-8");
		//res.setHeader("Content-Disposition", contentDisp + new String(logicalFileName.getBytes("UTF-8"), "8859_1"));
		res.setHeader("Content-Disposition", sb.toString());
		res.setHeader("Pragma", "no-cache;");
    	res.setHeader("Expires", "-1");
    	res.flushBuffer();

		//res.setHeader("Content-Transfer-Encoding", "binary");
		
		PrintWriter out1 = null;
		ServletOutputStream out2 = null;
	
		try {
	
			File f = new File(filePath);
			if(!f.exists()) {
				return;
			}
			
			if (contentType.equals("text/plain") || contentType.equals("text/html")) {
				System.out.println("execute=========000===========>");
				out1 = res.getWriter();
				FileReader fin = new FileReader(f);
				
				int fsize = (int) f.length();
				char[] data = new char[512];
	
				StringBuffer buf = new StringBuffer(fsize + 1);
				int bytes_read = 0;
				
				BufferedReader in = new BufferedReader(fin);
	
				int total_bytes_read = 0;
				while ((bytes_read = in.read(data, 0, 512)) != -1) {
					total_bytes_read += bytes_read;
					buf.append(data, 0, bytes_read);
				}
	
				fin.close();
				in.close();
				
				out1.write(buf.toString());
				out1.close();
				
			} else {
				System.out.println("execute=========111===========>");
				
				out2 = res.getOutputStream();
	
				FileInputStream fin = null;
				byte[] data = null;
	
				fin = new FileInputStream(f);
				//FileChannel channel = fin.getChannel();
				//MappedByteBuffer fileMap = channel.map(FileChannel.MapMode.READ_ONLY, 0, f.length());
				//ByteBuffer fileMap = channel.map(FileChannel.MapMode.READ_ONLY, 0, f.length());
				data = new byte[(int) f.length()];
				//fileMap.get(data);
				for(int count = 0 ; (count = fin.read(data))!= -1 ;){
					out2.write(data, 0, count);
					out2.flush();
				}
				fin.close();	
				out2.close();
				
			}
		} finally {
			if (out1 != null) {
				out1.close();
				out1 = null;
			}	
			if (out2 != null) {
				out2.close();
				out2 = null;
			}	
		}
	}
	
    /**
     * 
     * @return Returns the contentType.
     */
    public String getContentType() {
        return contentType;
    }
    
    /**
     *
     * 다운로드할 파일의 컨텐트 타입(mime type)을 설정한다.
     *
     * @param contentType The contentType to set.
     */
    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
    
    /**
     * @return Returns the filename.
     */
    public String getFileName() {
        return fileName;
    }
    
    /**
     *
     * 다운로드할 파일명을 설정한다.
     *
     * @param filename The filename to set.
     */
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
    /**
     * @return Returns the filePath.
     */
    public String getFilePath() {
        return filePath;
    }
    
    /** 
     * 
     * 파일명을 제외한 다운로드할 파일의 경로를 설정한다.
     * 
     * @param filepath The filePath to set.
     */
    public void setFilePath(String filePath) {
        if(!filePath.endsWith("/") || !filePath.endsWith("\\")) {
            this.filePath = filePath + "/"; 
        } else {
            this.filePath = filePath;
        }
    }  
    
    /**
     * 
     * 파일의 원본 이름을 설정한다.
     * 
     * @param orgFileName
     */
    public void setOrgFileName(String orgFileName) {
        this.orgFileName = orgFileName;
    }
}