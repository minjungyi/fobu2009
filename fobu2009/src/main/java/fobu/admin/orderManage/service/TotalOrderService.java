package main.java.fobu.admin.orderManage.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import jxl.write.WriteException;

import main.java.fobu.admin.product.service.ProductListVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.CommonFileVO;


/**
 * TotalOrder Service Interface
 *
 * @author min
 * @since 2010. 09. 10.
 */
public interface TotalOrderService {
	
	/**
	 * 
	 * @param 
	 * @return String
	 * @throws SQLException 
	 */
	String getTotalOrderViewList() throws SQLException;		
	
	
	/**
	 * 주문통합정보검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<TotalOrderVO> listTotalOrder(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	/**
	 * 주문통합정보검색 총건수
	 * @param 
	 * @return int
	 * @throws SQLException 
	 */
	int listTotalOrderCount(Map paramMap) throws SQLException;
	
	/**
	 * 주문통합정보상세검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	List<TotalOrderVO> listTotalOrderDetail(Map paramMap) throws SQLException;
	
	/**
	 * 묶음상품정보
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	List<TotalOrderVO> listPackageInfo(Map paramMap) throws SQLException;
	
	/**
	 * 묶음상품정보 저장
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	int savePackageInfo(PackageInfoListVO PackageInfoList) throws SQLException;
	
	/**
	 * 주문통합의 관리자 메모 저장
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveMemo(Map paramMap) throws SQLException;
	
	/**
	 * 주문통합의 재고옵션 저장
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveStockOpt(Map paramMap) throws SQLException;
	
	
	/**
	 * 주문정보 상세 저장
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveOrderDetail(Map paramMap) throws SQLException;
	
	/**
	 * 주문상태값 수정
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveStat(Map paramMap) throws SQLException;

	/**
	 * 정산상태값 수정
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveAccountStat(Map paramMap) throws SQLException;
	
	/**
	 * 주문상태값 수정(송장번호 저장)
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveDeliveryNumber(Map paramMap) throws SQLException;
	
	/**
	 * 신규주문정보 저장(엑셀파일업로드)
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveNewOrder(Map paramMap, CommonFileVO fileBean, String path) throws SQLException;

	/**
	 * 오픈마켓정산 저장(엑셀파일업로드)
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveOpenMarketAccount(Map paramMap, CommonFileVO fileBean, String path) throws SQLException;
	
	/**
	 * 제품 저장(엑셀파일업로드)
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveProductStatus(Map paramMap, CommonFileVO fileBean, String path) throws SQLException;
	
	/**
	 * 주문상품변경검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws FileNotFoundException 
	 */
	List<ProductVO> listChangeProduct(Map paramMap) throws SQLException, FileNotFoundException, WriteException, IOException;
	
	/**
	 * 주문상품변경검색 총건수
	 * @param 
	 * @return int
	 * @throws SQLException 
	 */
	int listChangeProductCount(Map paramMap) throws SQLException;
	
	/**
	 * 주문상품변경 저장
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	int saveChangeProduct(ChangeProductListVO changeProductList, String seq) throws SQLException;
	
	/**
	 * 재고 검색
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	List<TotalOrderVO> searchRealStock(Map paramMap) throws SQLException;
	
	/**
	 * 재고 저장
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveRealStock(Map paramMap) throws SQLException;
	
	/**
	 * 발주저장
	 * @param 
	 * @return 
	 * @throws SQLException 
	 */
	void saveEnterOrder(Map paramMap) throws SQLException;
}
