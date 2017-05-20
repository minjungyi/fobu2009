package main.java.fobu.common.service.impl;

import java.awt.Image;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;






import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;
import com.sun.jimi.core.util.JimiUtil;

import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.Constant;
import main.java.fobu.common.service.FileService;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.util.FileUploadUtil;

@Service
public class FileServiceImpl implements FileService {
	
	//private String UPDATE_ORG_URL ="/upload/files/";
	//private String UPDATE_TEMP_URL="/upload/temp/";
	private int MEGA=1000000;
	private int MEGA1=6000000;
	
	/**
	 * 
	 * 파일 저장
	 * 
	 */
	public CommonFileVO getUploadFileList(HttpServletRequest request, int attachSize, String path) throws Exception{

		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		System.out.println("sdsds"+mpRequest.getFileNames());
		Iterator<String> fileNameIterator = mpRequest.getFileNames();
		MultipartFile multiFile = mpRequest.getFile(fileNameIterator.next());
		System.out.println("multiFile.getName------------------->"+multiFile.getName());
		System.out.println("multiFile.getName------------------->"+multiFile.getOriginalFilename());
		CommonFileVO fileBean = null;
    	if(multiFile.getSize() > 0) {
    		if((attachSize*MEGA) > multiFile.getSize() ){
    			fileBean = FileUploadUtil.doFileUpload2Bean(multiFile, path);
			}
    		else{
    			fileBean = new CommonFileVO();
    			fileBean.setFileSize("-1");
    		}
        }    	
    	return fileBean;
    }
	
	/**
	 * 
	 * 파일 다중 저장
	 * 
	 */
	public List<CommonFileVO> multiUpload(HttpServletRequest request, int attachSize, String path) throws Exception{

		List<CommonFileVO> fileBeanList = new ArrayList<CommonFileVO>();
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		System.out.println("sdsds"+mpRequest.getFileNames());
		Iterator fileNameIterator = mpRequest.getFileNames();
		
		while(fileNameIterator.hasNext()){
			String key = (String)fileNameIterator.next();
			MultipartFile multiFile = mpRequest.getFile(key);
			System.out.println("multiFile.getName------------------->"+multiFile.getName());
			System.out.println("multiFile.getOriginalFilename------------------->"+multiFile.getOriginalFilename());
			System.out.println("multiFile.getSize------------------->"+multiFile.getSize());
			//CommonFileVO fileBean = null;
	    	if(multiFile.getSize() > 0) {
	    		if((attachSize*MEGA1) > multiFile.getSize() ){
	    			CommonFileVO fileBean = FileUploadUtil.multiUpload(multiFile, path);
	    			
	    			if(fileBean !=null){
	    				fileBeanList.add(fileBean);
	    			}
	    				
				}
	        } 
		}
    	return fileBeanList;
    }
	
	/**
	 * 
	 * 파일 다중 저장2 - 제품등록 페이지 타이틀/상세보기 이미지 업로드
	 * 
	 */
	public List<CommonFileVO> multiUpload2(HttpServletRequest request, int attachSize,ProductVO product) throws Exception{

		String path = "";
		List<CommonFileVO> fileBeanList = new ArrayList<CommonFileVO>();
		ServletContext context = request.getSession().getServletContext();
		MultipartHttpServletRequest mpRequest = (MultipartHttpServletRequest) request;
		
		Iterator fileNameIterator = mpRequest.getFileNames();
		
		while(fileNameIterator.hasNext()){
			CommonFileVO fileBean = new CommonFileVO();
			String key = (String)fileNameIterator.next();
			MultipartFile multiFile = mpRequest.getFile(key);	

	    	if(multiFile.getSize() > 0 && ((attachSize*MEGA1) > multiFile.getSize())) {
	    		//if((attachSize*MEGA1) > multiFile.getSize() ){
    			if(key.equals("titleImageFile1")){
    				path = context.getRealPath(Constant.imageTitlePath);    				
    			}
    			else{
    				//path = context.getRealPath(Constant.imageDetailPath + product.getCompanyCategory());
    				path = context.getRealPath(Constant.imageDetailPath);    				
    			}
    			
    			fileBean = FileUploadUtil.multiProductUpload(multiFile, path, product.getSeq());
    			
    			if(key.equals("titleImageFile1")){
    				
    				ftpUpload(path+File.separator+fileBean.getFileName(),"/web/product/big",fileBean.getFileName());
	            	ftpUpload(path+File.separator+fileBean.getFileName(),"/web/product/medium",fileBean.getFileName());
	            	
    				//50x50 이지미 변환
	    			Image thumbnail = JimiUtils.getThumbnail(path+File.separator+fileBean.getFileName(), 
	    													 50, 50, Jimi.IN_MEMORY, true);
	    			FileUploadUtil.verifyDirectory(context.getRealPath(Constant.imageSmallPath));
	    			String pathFile = context.getRealPath(Constant.imageSmallPath)+File.separator+fileBean.getFileName();
	            	Jimi.putImage(thumbnail, pathFile);
	            	
	            	ftpUpload(pathFile,"/web/product/tiny",fileBean.getFileName());
	            	
	            	//100x100 이지미 변환
	            	Image thumbnail2 = JimiUtils.getThumbnail(path+File.separator+fileBean.getFileName(), 
							 								  100, 100, Jimi.IN_MEMORY, true);
					FileUploadUtil.verifyDirectory(context.getRealPath(Constant.imageMediumPath));
					String pathFile2 = context.getRealPath(Constant.imageMediumPath)+File.separator+fileBean.getFileName();
					Jimi.putImage(thumbnail2, pathFile2);
					//150x150 이지미 변환
					Image thumbnail3 = JimiUtils.getThumbnail(path+File.separator+fileBean.getFileName(), 
							 								  150, 150, Jimi.IN_MEMORY, true);
					FileUploadUtil.verifyDirectory(context.getRealPath(Constant.imageLargePath));
					String pathFile3 = context.getRealPath(Constant.imageLargePath)+File.separator+fileBean.getFileName();
					Jimi.putImage(thumbnail3, pathFile3);
					
					ftpUpload(pathFile3,"/web/product/small",fileBean.getFileName());
    			}
    			
	        }else{
	        	fileBean.setFileName(product.getSeq() + Constant.imageExtenstion);
	        }
	    	
	    	if(fileBean !=null){
				fileBeanList.add(fileBean);
			}
		}
    	return fileBeanList;
    }
	
	public int ftpUpload(String localFilePath, String remoteFilePath, String fileName) throws Exception {
		
		FTPClient ftp = null; // FTP Client 객체
	    FileInputStream fis = null; // File Input Stream
	    File uploadfile = new File(localFilePath); // File 객체
	    
	    String url  = "chocofl.cafe24.com"; 
	    String id  = "chocofl";
	    String pwd  = "vhqn2323"; 
	    String port = "21";
	    
	    int result = -1;
	    try{          
	        ftp = new FTPClient(); // FTP Client 객체 생성
	        ftp.setControlEncoding("UTF-8"); // 문자 코드를 UTF-8로 인코딩
	        ftp.connect(url, Integer.parseInt(port)); // 서버접속 " "안에 서버 주소 입력 또는 "서버주소", 포트번호
	        ftp.login(id, pwd); // FTP 로그인 ID, PASSWORLD 입력
	        ftp.enterLocalPassiveMode(); // Passive Mode 접속일때 
	        ftp.changeWorkingDirectory(remoteFilePath); // 작업 디렉토리 변경
	        ftp.setFileType(FTP.BINARY_FILE_TYPE); // 업로드 파일 타입 셋팅
	        
	        try{
	            fis = new FileInputStream(uploadfile); // 업로드할 File 생성
	            boolean isSuccess = ftp.storeFile(fileName, fis); // File 업로드
	            
	            if (isSuccess){
	       result = 1; // 성공     
	      }
	      else{
	       throw new Exception("파일 업로드를 할 수 없습니다.");
	      }
	        } catch(Exception ex){
	            System.out.println("IO Exception : " + ex.getMessage());
	        }finally{
	            if (fis != null){
	                try{
	                    fis.close(); // Stream 닫기
	                    return result;
	                    
	                }
	                catch(Exception ex){
	                    System.out.println("IO Exception : " + ex.getMessage());
	                }
	            }
	        }
	        ftp.logout(); // FTP Log Out
	    }catch(Exception e){
	        System.out.println("IO:"+e.getMessage());
	    }finally{
	        if (ftp != null && ftp.isConnected()){
	            try{
	                ftp.disconnect(); // 접속 끊기
	                return result;
	            }
	            catch (Exception e){
	                System.out.println("IO Exception : " + e.getMessage());
	            }
	        }
	    }
	    return result;  
	}
	
}