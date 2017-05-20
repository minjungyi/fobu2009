package main.java.fobu.common.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.CommonFileVO;


public interface FileService {
	
	//파일 저장
	public CommonFileVO getUploadFileList(HttpServletRequest request, int attachSize, String path) throws Exception;

	//파일 저장
	public List<CommonFileVO> multiUpload(HttpServletRequest request, int attachSize, String path) throws Exception;
	
	//제품 등록 파일 저장
	public List<CommonFileVO> multiUpload2(HttpServletRequest request, int attachSize,ProductVO product) throws Exception;
}
