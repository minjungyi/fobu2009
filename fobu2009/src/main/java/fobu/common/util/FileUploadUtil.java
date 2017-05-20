package main.java.fobu.common.util;

import java.awt.Image;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;

import main.java.fobu.common.Constant;
import main.java.fobu.common.service.CommonFileVO;

public class FileUploadUtil {
		
	/**
	 * 
	 * File Upload Util
	 * 
	 * @param formFile
	 * @param path
	 * @return
	 * @throws Exception
	 */
	public static String doFileUpload(MultipartFile formFile, String basePath) throws Exception{
        
		InputStream stream = null;
		OutputStream bos = null;
		
		String orgFileName = formFile.getOriginalFilename();
		String fileExtension = getFileExtension(orgFileName);
		
		
		// UUID(Universally Unique IDentifier) - 범용 유닉 식별자
		UUID uuid = UUID.randomUUID();
        String newFile = uuid.toString();
		
		
		// 디렉토리 생성
		verifyDirectory(basePath);
		
		StringBuffer sb = new StringBuffer();
		sb.append(basePath);
		sb.append(File.separator);
		sb.append(newFile);
		sb.append(fileExtension);
		
		String fullFilePath = sb.toString();
		
		sb.setLength(0);
		sb.append(newFile);
		sb.append(fileExtension);
		String newFileName = sb.toString();
		
        try {
            
        	stream = formFile.getInputStream();
            bos = new FileOutputStream(fullFilePath);
            
            int bytesRead = 0;
            byte[] buffer = new byte[8192];
            while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
            bos.close();
            stream.close();
            
        } catch (FileNotFoundException e) {
            //e.printStackTrace();
        	throw new Exception();
        } catch (IOException e) {
            //e.printStackTrace();
        	throw new Exception();
        } finally{
			if(bos != null) bos.close();
			if(stream != null) stream.close();
		}
        
        return newFileName;
    }
	
	/**
	 * 
	 * File Upload Util
	 * 
	 * @param formFile
	 * @param path
	 * @return
	 * @throws Exception
	 */
	
	/**
	 * 
	 * path에 대한 실제 디렉토리가 존재하면 true, 아니면 생성을 시도한 후 결과에 대한 true/false 반환
	 * 
	 * @param path
	 * @return boolean
	 */
	public static boolean verifyDirectory(String path) {

		File dircectory = new File(path);
		boolean result = false;
		
		if(dircectory.exists()) {
		    result = true;
		} else {
		    synchronized(dircectory) {
		    	result = dircectory.mkdirs();
		    }
		}
		
		return result;
	}
	
	/**
	 * 
	 * 확장자 구하기 
	 *  => 기본 : .jpg
	 *  => i가 1일떄 : jpg
	 * 
	 * @param str
	 * @return
	 */
	public static String getFileExtension(String str) {
		return getFileExtension(str, 0);
	}
	public static String getFileExtension(String str, int i) {
		
		String extension = ".xls";
		if(str.lastIndexOf(".") > 0) {
			extension = str.substring(str.lastIndexOf(".")+i);
		}else{
			extension = str;
		}
		return extension.toLowerCase();
		//return extension;
	}
	
	public static CommonFileVO doFileUpload2Bean(MultipartFile formFile, String basePath) throws Exception{
        
		InputStream stream = null;
		OutputStream bos = null;
		CommonFileVO fileBean = null;
		
		String orgFileName = formFile.getOriginalFilename();
		//String fileExtension = getFileExtension(orgFileName);
		
		// UUID(Universally Unique IDentifier) - 범용 유닉 식별자
		UUID uuid = UUID.randomUUID();
        String newFile = uuid.toString();
		
		// 디렉토리 생성
		verifyDirectory(basePath);
		
		StringBuffer sb = new StringBuffer();
		sb.append(basePath);
		sb.append(File.separator);
		//sb.append("["+orgFileName+"]");
		sb.append(orgFileName);
		//sb.append(newFile);
		//sb.append(fileExtension);
		
		String fullFilePath = sb.toString();
		
        try {
            
        	stream = formFile.getInputStream();
            bos = new FileOutputStream(fullFilePath);
            
            int bytesRead = 0;
            byte[] buffer = new byte[8192];
            while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
            bos.close();
            stream.close();
    		
            // 파일 정보 bean에 담기
            fileBean = new CommonFileVO();
    		fileBean.setFileName(orgFileName);
    		fileBean.setOrgFileName(formFile.getOriginalFilename());
    		fileBean.setFileSize(formFile.getSize()+"");
    		fileBean.setContentType(formFile.getContentType());
    		
        } catch (FileNotFoundException e) {
            //e.printStackTrace();
        	throw new Exception();
        } catch (IOException e) {
            //e.printStackTrace();
        	throw new Exception();
        } finally{
			if(bos != null) bos.close();
			if(stream != null) stream.close();
		}
        
        return fileBean;
	}
	
	public static CommonFileVO multiUpload(MultipartFile formFile, String basePath) throws Exception{
        
		InputStream stream = null;
		OutputStream bos = null;
		CommonFileVO fileBean = null;
		
		String orgFileName = formFile.getOriginalFilename();
		//String fileExtension = getFileExtension(orgFileName);
		
		// UUID(Universally Unique IDentifier) - 범용 유닉 식별자
		UUID uuid = UUID.randomUUID();
        String newFile = uuid.toString();
		
		// 디렉토리 생성
		verifyDirectory(basePath);
		
		StringBuffer sb = new StringBuffer();
		sb.append(basePath);
		sb.append(File.separator);
		//sb.append("["+orgFileName+"]");
		sb.append(orgFileName);
		//sb.append(newFile);
		//sb.append(fileExtension);
		
		String fullFilePath = sb.toString();
		
        try {
            
        	stream = formFile.getInputStream();
            bos = new FileOutputStream(fullFilePath);
            
            int bytesRead = 0;
            byte[] buffer = new byte[8192];
            while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
            bos.close();
            stream.close();
    		
            // 파일 정보 bean에 담기
            fileBean = new CommonFileVO();
    		fileBean.setFileName(formFile.getName());
    		fileBean.setOrgFileName(formFile.getOriginalFilename());
    		fileBean.setFileSize(formFile.getSize()+"");
    		fileBean.setContentType(formFile.getContentType());
    		
        } catch (FileNotFoundException e) {
            //e.printStackTrace();
        	throw new Exception();
        } catch (IOException e) {
            //e.printStackTrace();
        	throw new Exception();
        } finally{
			if(bos != null) bos.close();
			if(stream != null) stream.close();
		}
        
        return fileBean;
	}
	
	public static CommonFileVO multiProductUpload(MultipartFile formFile, String basePath,String seqFileName) throws Exception{
        
		InputStream stream = null;
		OutputStream bos = null;
		CommonFileVO fileBean = null;
		
		String orgFileName = seqFileName +getFileExtension(formFile.getOriginalFilename());
		//String fileExtension = getFileExtension(orgFileName);
		
		// UUID(Universally Unique IDentifier) - 범용 유닉 식별자
		//UUID uuid = UUID.randomUUID();
        //String newFile = uuid.toString();
		
		// 디렉토리 생성
		verifyDirectory(basePath);
		
		StringBuffer sb = new StringBuffer();
		sb.append(basePath);
		sb.append(File.separator);
		//sb.append("["+orgFileName+"]");
		sb.append(orgFileName);
		//sb.append(newFile);
		//sb.append(fileExtension);
		
		String fullFilePath = sb.toString();
		
        try {
            
        	stream = formFile.getInputStream();
            bos = new FileOutputStream(fullFilePath);
            
            int bytesRead = 0;
            byte[] buffer = new byte[8192];
            while ((bytesRead = stream.read(buffer, 0, 8192)) != -1) {
                bos.write(buffer, 0, bytesRead);
            }
            bos.close();
            stream.close();
    		
            // 파일 정보 bean에 담기
            fileBean = new CommonFileVO();
    		fileBean.setFileName(orgFileName);
    		fileBean.setOrgFileName(formFile.getOriginalFilename());
    		fileBean.setFileSize(formFile.getSize()+"");
    		fileBean.setContentType(formFile.getContentType());        	
    		
        } catch (FileNotFoundException e) {
            //e.printStackTrace();
        	throw new Exception();
        } catch (IOException e) {
            //e.printStackTrace();
        	throw new Exception();
        } finally{
			if(bos != null) bos.close();
			if(stream != null) stream.close();
		}
        
        return fileBean;
	}
}