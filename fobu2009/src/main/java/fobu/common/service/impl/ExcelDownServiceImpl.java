package main.java.fobu.common.service.impl;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.write.WriteException;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.orderManage.service.impl.TotalOrderDAO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.admin.product.service.impl.ProductDAO;
import main.java.fobu.common.service.ExcelDownService;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.ExcelDownUtil;

@Service
public class ExcelDownServiceImpl implements ExcelDownService {
	
	// Logger
	@SuppressWarnings("unused")
	private Log logger;
		
	@Resource(name = "excelDownUtil")
	private ExcelDownUtil excelDownUtil;
	
	@Resource(name = "totalOrderDAO")
	private TotalOrderDAO totalOrderDao;
	
	@Resource(name = "productDAO")
	private ProductDAO productDAO;
	
	/**
	 * The Constructor
	 */
	public ExcelDownServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	/*
	@SuppressWarnings("unchecked")
	@Override
	public void deliveryCompleteExcel(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException {
		List<TotalOrderVO> listTotalOrder = totalOrderDao.listTotalOrder(paramMap);
		String columnName[] = {"거래처","수집","수집일","최종변경일","상태","주문자","수령자","업체명","제품명","수량","재고","원가","판매가","마진","%","배송"};
		String columnSize[] = {"20","20","20","20","20","20","20","20","20","20","20","20","20","20","20","20"};
		int sizeCnt = listTotalOrder.size();
		String columnData[][] = new String[sizeCnt][columnName.length];

		for(int i = 0 ; i < sizeCnt ; i++){
			columnData[i][0] = listTotalOrder.get(i).getCompanyName();
			columnData[i][1] = listTotalOrder.get(i).getSiteCode();
			columnData[i][2] = listTotalOrder.get(i).getCollectDt();
			columnData[i][3] = listTotalOrder.get(i).getModifyDt();
			columnData[i][4] = listTotalOrder.get(i).getOrderStat();
			columnData[i][5] = listTotalOrder.get(i).getOrderer();
			columnData[i][6] = listTotalOrder.get(i).getReceiver();
			columnData[i][7] = listTotalOrder.get(i).getShopId();
			columnData[i][8] = listTotalOrder.get(i).getProduct();
			columnData[i][9] = listTotalOrder.get(i).getOrderQy();
			columnData[i][10] = listTotalOrder.get(i).getRealStock();
			columnData[i][11] = listTotalOrder.get(i).getFamilyPrice();
			columnData[i][12] = listTotalOrder.get(i).getOrderPrice();
			columnData[i][13] = "";
			columnData[i][14] = "";
			columnData[i][15] = listTotalOrder.get(i).getDeliverType();			
		}
		excelDownUtil.doExcelDown(columnData, columnName, path, columnSize);
	}*/
	
	@SuppressWarnings("unchecked")
	@Override
	public void deliveryCompleteExcel(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException {

		List<TotalOrderVO> listTotalOrder = totalOrderDao.listTotalOrder(paramMap);
		String columnName[] = {"업체명", "보내는분전화번호", "보내는분주소(전체, 분할)", "받는분성명", "받는분전화번호", "	받는분기타연락처", "받는분주소(전체, 분할)", "박스크기", "박스수량", "기본운임" , "결제조건", "품목명", "품목명2", "배송메세지", "업체명"};
		String columnSize[] = {"15", "15", "30", "10", "15", "15", "30", "10", "10", "10", "10", "45", "10", "20", "15"};
		int sizeCnt = listTotalOrder.size();
		String columnData[][] = new String[sizeCnt][columnName.length];
		String boxCode = "1";
		String payCode = "1";
		String deliveryMemoTmp = "";
		for(int i = 0 ; i < listTotalOrder.size() ; i++){
			
			if(listTotalOrder.get(i).getDeliverType().equals("착불")){
				payCode = "2";
				boxCode = "2";
			}else{
				payCode = "3";
				boxCode = "1";
			}
			columnData[i][0] = listTotalOrder.get(i).getShopName();			
			columnData[i][1] = "070-7559-4645";	
			columnData[i][2] = "경기도 용인시 기흥구 언남동 408번지 삼성리지프라자 203호";	
			columnData[i][3] = listTotalOrder.get(i).getReceiver();	
			columnData[i][4] = listTotalOrder.get(i).getReceiverTel();	
			columnData[i][5] = listTotalOrder.get(i).getReceiverHp();		
			columnData[i][6] = listTotalOrder.get(i).getReceiverAddress();	
			columnData[i][7] = boxCode;	
			columnData[i][8] = "1";	
			columnData[i][9] = "";	
			columnData[i][10] = payCode;	
			columnData[i][11] = "("+listTotalOrder.get(i).getOrderQy()+") "+"["+listTotalOrder.get(i).getBrandNm()+"] "+listTotalOrder.get(i).getProduct();	
			columnData[i][12] = "";	
			
			deliveryMemoTmp = listTotalOrder.get(i).getDeliverMemo();
			if(deliveryMemoTmp != null){
				deliveryMemoTmp = deliveryMemoTmp.replaceAll("\\[사은품\\]", "");
			}
			
			columnData[i][13] = deliveryMemoTmp;
			columnData[i][14] = listTotalOrder.get(i).getShopName();
		}
		excelDownUtil.doExcelDown(columnData, columnName, path, columnSize);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void exportDeliveryExcel(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException {
		List<TotalOrderVO> listTotalOrder = totalOrderDao.listTotalOrderDetail(paramMap);
		String columnName[] = {"업체명", "보내는분전화번호", "보내는분주소(전체, 분할)", "받는분성명", "받는분전화번호", "	받는분기타연락처", "받는분주소(전체, 분할)", "박스크기", "박스수량", "기본운임" , "결제조건", "품목명", "품목명2", "배송메세지", "업체명"};
		String columnSize[] = {"15", "15", "30", "10", "15", "15", "30", "10", "10", "10", "10", "45", "10", "20", "15"};
		int sizeCnt = listTotalOrder.size();
		String columnData[][] = new String[sizeCnt][columnName.length];
		String boxCode = "1";
		String payCode = "1";
		String deliveryMemoTmp = "";
		for(int i = 0 ; i < listTotalOrder.size() ; i++){
			System.out.println("listTotalOrder.get(i).getDeliverType()=======>"+listTotalOrder.get(i).getDeliverType());
			if(listTotalOrder.get(i).getDeliverType().equals("착불")){
				payCode = "2";
				boxCode = "2";
			}else{
				payCode = "3";
				boxCode = "1";
			}
			columnData[i][0] = listTotalOrder.get(i).getShopName();			
			columnData[i][1] = "070-7559-4645";	
			columnData[i][2] = "경기도 용인시 기흥구 언남동 408번지 삼성리지프라자 203호";	
			columnData[i][3] = listTotalOrder.get(i).getReceiver();	
			columnData[i][4] = listTotalOrder.get(i).getReceiverTel();	
			columnData[i][5] = listTotalOrder.get(i).getReceiverHp();		
			columnData[i][6] = listTotalOrder.get(i).getReceiverAddress();	
			columnData[i][7] = boxCode;	
			columnData[i][8] = "1";	
			columnData[i][9] = "";	
			columnData[i][10] = payCode;	
			columnData[i][11] = "("+listTotalOrder.get(i).getOrderQy()+") "+"["+listTotalOrder.get(i).getBrandNm()+"] "+listTotalOrder.get(i).getProduct();	
			columnData[i][12] = "";	
			deliveryMemoTmp = listTotalOrder.get(i).getDeliverMemo();
			if(deliveryMemoTmp != null){
				deliveryMemoTmp = deliveryMemoTmp.replaceAll("\\[사은품\\]", "");
			}
			
			columnData[i][13] = deliveryMemoTmp;
			columnData[i][14] = listTotalOrder.get(i).getShopName();
		}
		excelDownUtil.doExcelDown(columnData, columnName, path, columnSize);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void enterpriseOrderExcel(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException {
		List<TotalOrderVO> listTotalOrder = totalOrderDao.listTotalOrder(paramMap);
		String columnName[] = {"이미지", "상품명", "수량", "원가", "수령자명", "전화번호", "결제", "배송메세지", "상품코드"};
		String columnSize[] = {"20", "20", "20", "20", "20", "20", "20", "20", "20"};
		int sizeCnt = listTotalOrder.size();
		String columnData[][] = new String[sizeCnt][columnName.length];

		for(int i = 0 ; i < listTotalOrder.size() ; i++){
			columnData[i][0] = "";
			columnData[i][1] = "["+listTotalOrder.get(i).getBrandNm()+"] "+listTotalOrder.get(i).getProduct();
			columnData[i][2] = listTotalOrder.get(i).getOrderQy();
			columnData[i][3] =  listTotalOrder.get(i).getOriginalPrice();
			columnData[i][4] = listTotalOrder.get(i).getReceiver();
			columnData[i][5] = listTotalOrder.get(i).getReceiverHp();
			columnData[i][6] = listTotalOrder.get(i).getDeliverType();
			columnData[i][7] = listTotalOrder.get(i).getDeliverMemo();
			columnData[i][8] = listTotalOrder.get(i).getProductCode();		
		}
		excelDownUtil.doExcelDown(columnData, columnName, path, columnSize);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void enterpriseOrderExcelEtc(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException {
		List<TotalOrderVO> listTotalOrder = totalOrderDao.listTotalOrder(paramMap);
		String columnName[] = {"상품명" ,"매입원가","수량" ,"주문자명" ,"수령자명" ,"전화번호" ,"핸드폰번호" ,"우편번호" ,"주소" ,"배송메세지"};
		String columnSize[] = {"50" ,"10","5" ,"10" ,"10" ,"15" ,"15" ,"10" ,"100" ,"50"};
		int sizeCnt = listTotalOrder.size();
		String columnData[][] = new String[sizeCnt][columnName.length];

		for(int i = 0 ; i < listTotalOrder.size() ; i++){
			//columnData[i][0] = listTotalOrder.get(i).getOrderCode();
			columnData[i][0] = "["+listTotalOrder.get(i).getBrandNm()+"] "+listTotalOrder.get(i).getProduct();
			columnData[i][1] = listTotalOrder.get(i).getOriginalPrice();
			columnData[i][2] = listTotalOrder.get(i).getOrderQy();			
			
			
			String qy = listTotalOrder.get(i).getOrderQy().toString();			
			String price =  listTotalOrder.get(i).getFamilyPrice();
			int totalPrice = Integer.parseInt(qy) * Integer.parseInt(price);	
			
			//columnData[i][4] = Integer.toString(totalPrice);			
			//columnData[i][5] = listTotalOrder.get(i).getDeliverType();
			columnData[i][3] = listTotalOrder.get(i).getOrderer();
			columnData[i][4] = listTotalOrder.get(i).getReceiver();
			columnData[i][5] = listTotalOrder.get(i).getReceiverTel();
			columnData[i][6] = listTotalOrder.get(i).getReceiverHp();
			columnData[i][7] = listTotalOrder.get(i).getReceiverZipcode();
			columnData[i][8] = listTotalOrder.get(i).getReceiverAddress();
			columnData[i][9] = listTotalOrder.get(i).getDeliverMemo();
			//columnData[i][13] = listTotalOrder.get(i).getManagerMemo();
			//columnData[i][14] = "";
			//columnData[i][15] = "";
			
		}
		excelDownUtil.doExcelDown(columnData, columnName, path, columnSize);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void enterpriseDepositExcel(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException {
		List<TotalOrderVO> listTotalOrder = totalOrderDao.listTotalOrder(paramMap);
		String columnName[] = {"샵링커Code" ,"샵링커상품Code" ,"택배코드" ,"송장번호"};
		String columnSize[] = {"20", "20", "20", "20"};
		int sizeCnt = listTotalOrder.size();
		String columnData[][] = new String[sizeCnt][columnName.length];
		 
		for(int i = 0 ; i < sizeCnt ; i++){
			columnData[i][0] = listTotalOrder.get(i).getShoplinkerCode();
			columnData[i][1] = listTotalOrder.get(i).getProdCode();
			columnData[i][2] = listTotalOrder.get(i).getDeliveryCompany();			
			columnData[i][3] = listTotalOrder.get(i).getDeliveryNumber().replaceAll("-", "");		
		}
		excelDownUtil.doExcelDownNoHead(columnData, columnName, path, columnSize);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void productListExce(Map paramMap, String path) throws SQLException, FileNotFoundException, WriteException, IOException {
		List<ProductVO> listProduct = productDAO.listProductExcel(paramMap);
		String columnName[] = {"제품명" , "재고" ,"원가" ,"판매가" ,"소가" ,"제품번호"};
		String columnSize[] = {"20", "20", "20", "20", "20", "20"};
		int sizeCnt = listProduct.size();
		String columnData[][] = new String[sizeCnt][columnName.length];
		
		for(int i = 0 ; i < sizeCnt ; i++){
			columnData[i][0] = listProduct.get(i).getProduct();
			columnData[i][1] = listProduct.get(i).getStock();
			columnData[i][2] = listProduct.get(i).getOriginalPrice();
			columnData[i][3] = listProduct.get(i).getRetailPrice();
			columnData[i][4] = listProduct.get(i).getSellPrice();
			columnData[i][5] = listProduct.get(i).getCorpProductCode();
		}
		excelDownUtil.doExcelDown(columnData, columnName, path, columnSize);
	}
}