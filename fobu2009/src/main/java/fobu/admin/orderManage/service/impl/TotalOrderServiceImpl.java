package main.java.fobu.admin.orderManage.service.impl;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import main.java.fobu.admin.orderManage.service.ChangeProductListVO;
import main.java.fobu.admin.orderManage.service.PackageInfoListVO;
import main.java.fobu.admin.orderManage.service.TotalOrderService;
import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.ProductVO;

import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.StringUtil;

import org.apache.catalina.Session;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import com.ibatis.sqlmap.engine.scope.SessionScope;

/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2012. 03. 10.
 */
@Service
public class TotalOrderServiceImpl implements TotalOrderService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "totalOrderDAO")
	private TotalOrderDAO totalOrderDao;
	
	/**
	 * The Constructor
	 */
	public TotalOrderServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public String getTotalOrderViewList() throws SQLException {
		return totalOrderDao.searchTotalOrderViewList();
	}
	
	@Override
	public List<TotalOrderVO> listTotalOrder(Map paramMap) throws SQLException {
		List<TotalOrderVO> listTotalOrder = totalOrderDao.listTotalOrder(paramMap);
		return listTotalOrder;
	}
	
	@Override
	public int listTotalOrderCount(Map paramMap) throws SQLException {
		int totalOrderCount = totalOrderDao.listTotalOrderCount(paramMap);
		return totalOrderCount;
	}
	
	@Override
	public List<TotalOrderVO> listTotalOrderDetail(Map paramMap) throws SQLException {		
		List<TotalOrderVO> listTotalOrderDetail = totalOrderDao.listTotalOrderDetail(paramMap);
		
		return listTotalOrderDetail;
	}
	
	@Override
	public List<TotalOrderVO> listPackageInfo(Map paramMap) throws SQLException {	
		List<TotalOrderVO> listTotalOrderDetail = totalOrderDao.listPackageInfo(paramMap);
		
		return listTotalOrderDetail;
	}
	
	@Override
	public int savePackageInfo(PackageInfoListVO PackageInfoList) throws SQLException {	
		//logger.info("=================================== SAVE_PACKAGE_INFO START ==========================================");
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		String userIdTmp = "";
		if(userInfo != null) {
			userIdTmp = userInfo.getUserId();
		} else {
			userIdTmp = "SYSTEM";
		}
		try{
			for(int i = 0 ; i < PackageInfoList.getSeq().length ; i++){
				if(PackageInfoList.getCheckbox()[i].toString().equals("true")){
					TotalOrderVO totalOrder = new TotalOrderVO();					
					
					totalOrder.setDeliveryNumber(PackageInfoList.getDeliveryNumber()[i].toString());
					totalOrder.setDeliveryCompany(PackageInfoList.getDeliveryCompany()[i].toString());
					totalOrder.setOrderStat(PackageInfoList.getOrderStat()[i].toString());
					totalOrder.setSeq(PackageInfoList.getSeq()[i].toString());
					totalOrder.setModifiers(userIdTmp);
					
					totalOrderDao.savePackageInfo(totalOrder);
					
					if(PackageInfoList.getOrderStat()[i].toString().equals("3")){
						//logger.info("================================= < saveChangeRealOrderStock2 START > ============================================");
						totalOrderDao.saveChangeRealOrderStock2(PackageInfoList.getSeq()[i].toString(), "2",userIdTmp);
						//logger.info("================================= < saveChangeRealOrderStock2 END > ============================================");
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		//logger.info("=================================== SAVE_PACKAGE_INFO END ==========================================");
		return 1;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveMemo(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifiers", userInfo.getUserId());
		} else {
			paramMap.put("modifiers", "SYSTEM");
		}
		totalOrderDao.saveMemo(paramMap);
	}	
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveStockOpt(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifiers", userInfo.getUserId());
		} else {
			paramMap.put("modifiers", "SYSTEM");
		}
		totalOrderDao.saveStockOpt(paramMap);
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveOrderDetail(Map paramMap) throws SQLException {	
		//logger.info("=================================== SAVE_ORDER_DETAIL START ==========================================");
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		if(userInfo != null) {
			paramMap.put("modifiers", userInfo.getUserId());
		} else {
			paramMap.put("modifiers", "SYSTEM");
		}
		paramMap.put("addPrice", Integer.parseInt(StringUtil.replaceInt(paramMap.get("addPriceStr").toString(), ",", "")));
		paramMap.put("familyPrice", Integer.parseInt(StringUtil.replaceInt(paramMap.get("familyPriceStr").toString(), ",", "")));
		paramMap.put("deliverPrice", Integer.parseInt(StringUtil.replaceInt(paramMap.get("deliverPrice").toString(), ",", "")));
		paramMap.put("addDeliverPrice", Integer.parseInt(StringUtil.replaceInt(paramMap.get("addDeliverPrice").toString(), ",", "")));
		paramMap.put("orderQy", Integer.parseInt(StringUtil.replaceInt(paramMap.get("orderQyStr").toString(), ",", "")));
		paramMap.put("useSavePrice", Integer.parseInt(StringUtil.replaceInt(paramMap.get("useSavePrice").toString(), ",", "")));
		totalOrderDao.saveOrderDetail(paramMap);
		if(!paramMap.get("orderOriginStat").equals("3") && paramMap.get("orderStat").equals("3")){
			//logger.info("================================= < saveChangeRealOrderStock2 START > ============================================");
			totalOrderDao.saveChangeRealOrderStock2(paramMap.get("seq").toString(), "2",userInfo.getUserId());
			//logger.info("================================= < saveChangeRealOrderStock2 END > ============================================");
		}
		//logger.info("=================================== SAVE_ORDER_DETAIL END ==========================================");
	}
	
	@Override
	public void saveStat(Map paramMap) throws SQLException {	
		logger.info("=================================== SAVE_STAT START ==========================================");
		String orderStatStr = (String) paramMap.get("orderStatStr");
		String orderSeqStr = (String) paramMap.get("orderSeqStr");
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		String userIdTmp = "";
		if(userInfo != null) {
			userIdTmp = userInfo.getUserId();
		} else {
			userIdTmp = "SYSTEM";
		}
		//logger.info("orderStatStr--------------------------------->"+orderStatStr);
		//logger.info("orderSeqStr --------------------------------->"+orderSeqStr);
		
		String[] orderStatStrTmp = orderStatStr.split(",");
		String[] orderSeqStrTmp = orderSeqStr.split(",");
		 
		for(int j=0 ; j < orderStatStrTmp.length ; j++){
			String deliveryCompleteYn = ""; 
			if(orderStatStrTmp[j].equals("3")){
				deliveryCompleteYn = "Y";
				//List<TotalOrderVO> listRealOrderStock = totalOrderDao.listRealOrderStock(orderSeqStrTmp[j]);
				//logger.info("================================= [ 3 start ] ============================================");
				//logger.info("orderSeqStrTmp["+j+"]--------------------------------->"+orderSeqStrTmp[j]);
				//logger.info("================================= < saveStat start > ============================================");
				totalOrderDao.saveStat(orderSeqStrTmp[j], orderStatStrTmp[j], deliveryCompleteYn, userIdTmp);
				//logger.info("================================= < saveStat end > ============================================");
				//totalOrderDao.saveChangeRealOrderStock(listRealOrderStock.get(0).getProductCode(), listRealOrderStock.get(0).getOrderQy(), "2",userIdTmp);
				//logger.info("================================= < saveChangeRealOrderStock2 start > ============================================");
				totalOrderDao.saveChangeRealOrderStock2(orderSeqStrTmp[j], "2",userIdTmp);
				//logger.info("================================= < saveChangeRealOrderStock2 end > ============================================");
				//logger.info("================================= [ 3 end ] ============================================");
			}else{
				//logger.info("================================= [ 3 NOT start ] ============================================");
//				if(orderStatStrTmp[j].equals("1")){
//					List<TotalOrderVO> listRealOrderStock = totalOrderDao.listRealOrderStock(orderSeqStrTmp[j]);
//					totalOrderDao.saveRealStock(listRealOrderStock.get(0).getProductCode(), "0", "", "0001", "0001",userIdTmp);
//				}
				//logger.info("orderSeqStrTmp["+j+"]--------------------------------->"+orderSeqStrTmp[j]);
				//logger.info("================================= < saveStat start >============================================");
				totalOrderDao.saveStat(orderSeqStrTmp[j], orderStatStrTmp[j], deliveryCompleteYn, userIdTmp);
				//logger.info("================================= < saveStat end > ============================================");
				//logger.info("================================= [ 3 NOT end ] ============================================");
			}
		}
		
		String deliveryNumberSeqStr = (String) paramMap.get("deliveryNumberSeqStr");
		String deliveryNumberStr = (String) paramMap.get("deliveryNumberStr");
		String deliveryComStr = (String) paramMap.get("deliveryComStr");
		
		if(deliveryNumberSeqStr != null && !deliveryNumberSeqStr.equals("")){
			String[] deliveryNumberSeqStrTmp = deliveryNumberSeqStr.split(",");
			String[] deliveryNumberStrTmp = deliveryNumberStr.split(",");
			String[] deliveryComStrTmp = deliveryComStr.split(",");
			 
			 
			for(int i=0 ; i < deliveryNumberSeqStrTmp.length ; i++){
	
				totalOrderDao.saveDeliveryNumber(deliveryNumberSeqStrTmp[i], deliveryNumberStrTmp[i], deliveryComStrTmp[i]);
			}
		}
		//logger.info("=================================== SAVE_STAT END ==========================================");
	}
	

	@Override
	public void saveAccountStat(Map paramMap) throws SQLException {	
		logger.info("=================================== SAVE_STAT START ==========================================");
		String orderSeqStr = (String) paramMap.get("orderSeqStr");
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		String userIdTmp = "";
		if(userInfo != null) {
			userIdTmp = userInfo.getUserId();
		} else {
			userIdTmp = "SYSTEM";
		}
		
		String[] orderSeqStrTmp = orderSeqStr.split(",");
		 
		for(int j=0 ; j < orderSeqStrTmp.length ; j++){
				totalOrderDao.saveAccountStat(orderSeqStrTmp[j], userIdTmp);
		}
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveDeliveryNumber(Map paramMap) throws SQLException {	
		String orderSeqStr = (String) paramMap.get("deliveryNumberSeqStr");
		String deliveryNumberStr = (String) paramMap.get("deliveryNumberStr");
		String deliveryComStr = (String) paramMap.get("deliveryComStr");
		
		String[] orderSeqStrTmp = orderSeqStr.split(",");
		String[] deliveryNumberStrTmp = deliveryNumberStr.split(",");
		String[] deliveryComStrTmp = deliveryComStr.split(",");
		 
		 
		for(int j=0 ; j < orderSeqStrTmp.length ; j++){

			totalOrderDao.saveDeliveryNumber(orderSeqStrTmp[j], deliveryNumberStrTmp[j], deliveryComStrTmp[j]);
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveNewOrder(Map paramMap, CommonFileVO fileBean, String path) throws SQLException {
		//System.out.println("fileBean.getFileName()====!!!!========>"+fileBean.getFileName());
    	Workbook workbook = null;
    	
		try {
			workbook = Workbook.getWorkbook(new File(path+"/"+fileBean.getFileName()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	Sheet sheet = workbook.getSheet(0);
    	int col = sheet.getColumns();
    	//System.out.println("col============>"+col);
    	int row = sheet.getRows();
    	//System.out.println("row============>"+row);
    	
		for(int i = 1; i < row; i++){
			//System.out.println("파일 시크 읽기 시작");
			Cell cell[] = sheet.getRow(i);
			
			//out.println("<td>"+cell[j].getContents()+"</td>");
			//System.out.println("내용========>"+cell[j].getContents());
			TotalOrderVO totalOrderVO = new TotalOrderVO();
			List<TotalOrderVO> listProductInfoDetail = totalOrderDao.listProductInfo(cell[2].getContents());
			int originalPrice = 0;
			int companyCategory = 0;
			int familyPrice = 0;
			//int orderQy = 0;
			int orderPrice = 0;
			int marketPrice = 0;
			int aCnt = 0;
			int deliverPrice = 0;
			int addDeliverPrice = 0;
			String siteCodeTmp = "";
			String deliverType = cell[3].getContents();
			String deliverTypeTmp = "";
			String shopId = cell[22].getContents();
			String shopIdTmp = "";
			String payType = "";
			String popYn = "N";
			if(cell[1].getContents().equals("자체공급")||cell[1].getContents().equals("자체주문")){
				payType = cell[23].getContents();
				popYn = "Y";
			}
			String payTypeTmp = "";
			int shoppingDeliveryPrice = 2500;
			if(listProductInfoDetail.size() != 0){
				originalPrice = Integer.parseInt(listProductInfoDetail.get(0).getOriginalPrice());
				companyCategory = Integer.parseInt(listProductInfoDetail.get(0).getCompanyCategory());
				familyPrice = Integer.parseInt(listProductInfoDetail.get(0).getFamilyPrice());
				//deliverPrice = Integer.parseInt(listProductInfoDetail.get(0).getDeliverPrice());
				//addDeliverPrice = Integer.parseInt(listProductInfoDetail.get(0).getAddDeliverPrice());
				//orderQy = Integer.parseInt(cell[5].getContents());
				orderPrice = Integer.parseInt(cell[6].getContents());
				String fee = listProductInfoDetail.get(0).getFee();
				if(fee == null || fee.equals("")){
					fee = "12,12,10,12,6,4";
				}
				//fee = "12,10,10,12";
				String splitFee[] = fee.split(",");
				String siteCode = cell[1].getContents();
			
				if(siteCode.equals("지마켓")){
					aCnt = Integer.parseInt(splitFee[0]);
					siteCodeTmp = "gmk";
				}else if(siteCode.equals("(주)옥션")){
					aCnt = Integer.parseInt(splitFee[1]);
					siteCodeTmp = "aut";
				}else if(siteCode.equals("11번가")){
					aCnt = Integer.parseInt(splitFee[2]);
					siteCodeTmp = "cyw";
				}else if(siteCode.equals("(주)인터파크")){
					aCnt = Integer.parseInt(splitFee[3]);
					siteCodeTmp = "itp";
				}else if(siteCode.equals("샵N")||siteCode.equals("스토어팜")){
					aCnt = Integer.parseInt(splitFee[4]);
					siteCodeTmp = "shn";
				}else if(siteCode.equals("자체공급")){
					aCnt = Integer.parseInt(splitFee[5]);
					siteCodeTmp = "pop";
					shoppingDeliveryPrice = 3000;
				}else if(siteCode.equals("자체주문")){
					aCnt = Integer.parseInt(splitFee[5]);
					siteCodeTmp = "pop";
					shoppingDeliveryPrice = 3000;
				}else{
					siteCodeTmp = siteCode;
				}
				
				double feeRate = orderPrice*aCnt/100;
				marketPrice = (int)feeRate;
			}else{
				String siteCode = cell[1].getContents();
				
				if(siteCode.equals("지마켓")){
					siteCodeTmp = "gmk";
				}else if(siteCode.equals("(주)옥션")){
					siteCodeTmp = "aut";
				}else if(siteCode.equals("(주)인터파크")){
					siteCodeTmp = "itp";
				}else if(siteCode.equals("11번가")){
					siteCodeTmp = "cyw";
				}else if(siteCode.equals("샵N")||siteCode.equals("스토어팜")){
					siteCodeTmp = "shn";
				}else if(siteCode.equals("자체공급")){
					siteCodeTmp = "pop";
					shoppingDeliveryPrice = 3000;
				}else if(siteCode.equals("자체주문")){
					siteCodeTmp = "pop";
					shoppingDeliveryPrice = 3000;
				}else{
					siteCodeTmp = siteCode;
				}
			}
			
			if(deliverType.equals("착불(선결제가능)_선불")){
				deliverTypeTmp = "선불";
				deliverPrice = shoppingDeliveryPrice;
			}else if(deliverType.equals("무료_선불")){
				deliverTypeTmp = "선불";
				deliverPrice = shoppingDeliveryPrice;
			}else if(deliverType.equals("선불")){
				deliverTypeTmp = "선불";
				deliverPrice = shoppingDeliveryPrice;
			}else if(deliverType.equals("선결제")){
				deliverTypeTmp = "선불";
				deliverPrice = shoppingDeliveryPrice;
			}else if(deliverType.equals("결제완료")){
				deliverTypeTmp = "선불";
				deliverPrice = shoppingDeliveryPrice;
			}else if(deliverType.equals("무료")){
				deliverTypeTmp = "무료";
				addDeliverPrice = shoppingDeliveryPrice;
			}else if(deliverType.equals("착불")){
				deliverTypeTmp = "착불";
			}else if(deliverType.equals("착불(선결제불가)_착불")){
				deliverTypeTmp = "착불";
			}else if(deliverType.equals("0")){
				deliverTypeTmp = "무료";
				addDeliverPrice = shoppingDeliveryPrice;
			}else if(deliverType.equals("3000")){
				deliverTypeTmp = "선불";
				deliverPrice = shoppingDeliveryPrice;
			}else{
				deliverTypeTmp = deliverType;
			}

			if(shopId.trim() == null || shopId.trim().equals("")){
				shopIdTmp = "sunflower";
			}else{
				shopIdTmp = shopId;
			}
			
			//1 : 무통장입금  2 : 카드  3 : 적립금  4 : 현금
			if(payType.equals("무통장입금")){
				payTypeTmp = "1";
			}else if(payType.equals("적립금,무통장입금")){
				payTypeTmp = "31";
			}else if(payType.equals("카드")){
				payTypeTmp = "2";
			}else if(payType.equals("적립금,카드")){
				payTypeTmp = "32";
			}else if(payType.equals("적립금")){
				payTypeTmp = "3";
			}else if(payType.equals("현금")){
				payTypeTmp = "4";
			}else if(payType.equals("적립금,현금")){
				payTypeTmp = "34";
			}else{
				payTypeTmp = "";
			}
			
			
			totalOrderVO.setMarketFee(Integer.toString(aCnt));
			totalOrderVO.setMarketPrice(Integer.toString(marketPrice));
			totalOrderVO.setOriginalPrice(Integer.toString(originalPrice));
			totalOrderVO.setFamilyPrice(Integer.toString(familyPrice));
			totalOrderVO.setCompanyCategory(Integer.toString(companyCategory));
			
			totalOrderVO.setSiteCode(siteCodeTmp);
			//System.out.println("사이트코드===3=====>"+cell[1].getContents());
			totalOrderVO.setProductCode(cell[2].getContents());
			//System.out.println("고객사상품번호========>"+cell[2].getContents());
			totalOrderVO.setDeliverType(deliverTypeTmp);
			//System.out.println("배송비타입========>"+cell[3].getContents());
			totalOrderVO.setOrderOption(cell[4].getContents());
			totalOrderVO.setOrderQy(cell[5].getContents());
			//System.out.println("수량========>"+cell[5].getContents());
			totalOrderVO.setOrderPrice(cell[6].getContents());
			//System.out.println("주문금액========>"+cell[6].getContents());
			totalOrderVO.setOrderer(cell[7].getContents());
			///System.out.println("주문자========>"+cell[7].getContents());
			totalOrderVO.setOrdererTel(cell[8].getContents());
			//System.out.println("주문자전화번호========>"+cell[8].getContents());
			totalOrderVO.setOrdererHp(cell[9].getContents());
			//System.out.println("주문자핸드폰번호========>"+cell[9].getContents());
			totalOrderVO.setOrdererEmail(cell[10].getContents());
			//System.out.println("주문자이메일========>"+cell[10].getContents());
			totalOrderVO.setReceiver(cell[11].getContents());
			//System.out.println("수취인========>"+cell[11].getContents());
			totalOrderVO.setReceiverTel(cell[12].getContents());
			//System.out.println("수취인전화번호========>"+cell[12].getContents());
			totalOrderVO.setReceiverHp(cell[13].getContents());
			//System.out.println("수취인핸드폰번호========>"+cell[13].getContents());
			totalOrderVO.setReceiverZipcode(cell[14].getContents());
			//System.out.println("수취인우편번호========>"+cell[14].getContents());
			totalOrderVO.setReceiverAddress(cell[15].getContents());
			//System.out.println("수취인주소========>"+cell[15].getContents());
			totalOrderVO.setDeliverMemo(cell[16].getContents());
			//System.out.println("배송메세지========>"+cell[16].getContents());
			totalOrderVO.setEtc(cell[17].getContents());
			//System.out.println("비고========>"+cell[17].getContents());
			totalOrderVO.setShoplinkerCode(cell[18].getContents());
			//System.out.println("샵링커 주문번호========>"+cell[18].getContents());
			totalOrderVO.setProdCode(cell[19].getContents());
			//System.out.println("상품번호========>"+cell[19].getContents());
			totalOrderVO.setShoplinkerOrderCode(cell[20].getContents());
			//System.out.println("샵링커 쇼핑몰연동주문번호========>"+cell[20].getContents());
			totalOrderVO.setOrderDt(cell[21].getContents());
			//System.out.println("주문일========>"+cell[21].getContents());
			totalOrderVO.setShopId(shopIdTmp);
			totalOrderVO.setPayType(payTypeTmp);
			totalOrderVO.setDeliverPrice(Integer.toString(deliverPrice));
			totalOrderVO.setAddDeliverPrice(Integer.toString(addDeliverPrice));
			System.out.println("쇼핑몰아이디========>"+cell[22].getContents());
			//System.out.println("ERROR========>"+cell[24].getContents());
			String useSavePrice = "0";
			if(popYn.equals("Y")){
				totalOrderVO.setInBank(cell[24].getContents());
				totalOrderVO.setSaleChannel(cell[25].getContents());
				totalOrderVO.setOrderChannel(cell[26].getContents());
				if(!cell[27].getContents().equals("")){
					useSavePrice = cell[27].getContents();
				}
			}else{
				totalOrderVO.setInBank("");
				totalOrderVO.setSaleChannel("");
				totalOrderVO.setOrderChannel("");
			}
			
			
			totalOrderVO.setUseSavePrice(useSavePrice);
			
			
			UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
			if(userInfo != null) {
				totalOrderVO.setModifiers(userInfo.getUserId());
			} else {
				totalOrderVO.setModifiers("SYSTEM");
			}
						
			totalOrderDao.saveNewOrder(totalOrderVO);
		}
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveOpenMarketAccount(Map paramMap, CommonFileVO fileBean, String path) throws SQLException {
    	Workbook workbook = null;
		try {
			workbook = Workbook.getWorkbook(new File(path+"/"+fileBean.getFileName()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	Sheet sheet = workbook.getSheet(0);
    	int col = sheet.getColumns();
    	int row = sheet.getRows();
    	
		for(int i = 0; i < row; i++){
			//System.out.println("파일 시크 읽기 시작");
			Cell cell[] = sheet.getRow(i);
			TotalOrderVO totalOrderVO = new TotalOrderVO();
			System.out.println("shopLinkerOrderCode========>"+cell[0].getContents());
			totalOrderVO.setShoplinkerOrderCode(cell[0].getContents());
			//openMarketMarginVO.setMarketType(marketTypeTmp);
			totalOrderDao.saveOpenMarketAccount(totalOrderVO);
		}
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveProductStatus(Map paramMap, CommonFileVO fileBean, String path) throws SQLException {
		//System.out.println("fileBean.getFileName()====!!!!========>"+fileBean.getFileName());
    	Workbook workbook = null;
    	
		try {
			workbook = Workbook.getWorkbook(new File(path+"/"+fileBean.getFileName()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	Sheet sheet = workbook.getSheet(0);
    	int col = sheet.getColumns();
    	//System.out.println("col============>"+col);
    	int row = sheet.getRows();
    	//System.out.println("row============>"+row);
    	
		for(int i = 1; i < row; i++){
			//System.out.println("파일 시크 읽기 시작");
			Cell cell[] = sheet.getRow(i);
			//System.out.println("종료");
			OpenMarketMarginVO openMarketMarginVO = new OpenMarketMarginVO();
			openMarketMarginVO.setUid(cell[1].getContents());
			openMarketMarginVO.setShopCode(cell[2].getContents());
			openMarketMarginVO.setLinkCode(cell[3].getContents());			
			String marketType = cell[3].getContents();
			String marketTypeTmp = "";
			if(marketType.equals("지마켓")){
				marketTypeTmp = "gmk";
			}else if(marketType.equals("옥션")){
				marketTypeTmp = "aut";
			}else if(marketType.equals("11번가")){
				marketTypeTmp = "cyw";
			}else if(marketType.equals("샵N")||marketType.equals("스토어팜")){
				marketTypeTmp = "shn";
			}else{
				marketTypeTmp = "itp";
			}
			openMarketMarginVO.setMarketType(marketTypeTmp);
			totalOrderDao.saveProductStatus(openMarketMarginVO);
		}
	}
	
	@Override
	public List<ProductVO> listChangeProduct(Map paramMap) throws SQLException {
		List<ProductVO> listChangeProduct = totalOrderDao.listChangeProduct(paramMap);
		return listChangeProduct;
	}
	
	@Override
	public int listChangeProductCount(Map paramMap) throws SQLException {
		int changeProductCount = totalOrderDao.listChangeProductCount(paramMap);
		return changeProductCount;
	}
	
	@Override
	public int saveChangeProduct(ChangeProductListVO changeProductList, String seq) throws SQLException {	
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		String userIdTmp = "";
		if(userInfo != null) {
			userIdTmp = userInfo.getUserId();
		} else {
			userIdTmp = "SYSTEM";
		}
		//System.out.println("=================================saveChangeProductImpl=====================================");
		try{
			for(int i = 0 ; i < changeProductList.getProductSeq().length ; i++){
				if(changeProductList.getCheckbox()[i].toString().equals("true")){
					TotalOrderVO totalOrder = new TotalOrderVO();					
					//System.out.println("=============="+seq);
					//System.out.println("=============="+changeProductList.getProductSeq()[i].toString());
					//System.out.println("=============="+changeProductList.getQy()[i].toString());
										
					totalOrder.setSeq(seq);
					totalOrder.setFamilyPrice(changeProductList.getFamilyPrice()[i].toString());
					totalOrder.setProductCode(changeProductList.getProductSeq()[i].toString());
					totalOrder.setOrderQy(changeProductList.getQy()[i].toString());
					totalOrder.setCompanyCategory(changeProductList.getCompanyCategory()[i].toString());
					totalOrder.setModifiers(userIdTmp);
					
					totalOrderDao.saveChangeProduct(totalOrder);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@Override
	public List<TotalOrderVO> searchRealStock(Map paramMap) throws SQLException {		
		List<TotalOrderVO> searchRealStockList = totalOrderDao.searchRealStock(paramMap);
		
		return searchRealStockList;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveRealStock(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		String userIdTmp = "";
		if(userInfo != null) {
			userIdTmp = userInfo.getUserId();
		} else {
			userIdTmp = "SYSTEM";
		}
		String remark = (String) paramMap.get("rm");
		String realStock = (String) paramMap.get("realStock");
		String productCode = (String) paramMap.get("productCode");
		String stockOpt = (String) paramMap.get("stockOpt");
			 
		totalOrderDao.saveChangeRealOrderStock(productCode, realStock, "1",userIdTmp, stockOpt);
		totalOrderDao.saveRealStock(productCode, realStock, remark, "9999", "0003", userIdTmp);
	}
	
	@Override
	public void saveEnterOrder(Map paramMap) throws SQLException {	
		String orderSeqStr = (String) paramMap.get("orderSeqStr");
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		String userIdTmp = "";
		if(userInfo != null) {
			userIdTmp = userInfo.getUserId();
		} else {
			userIdTmp = "SYSTEM";
		}		
		String[] orderSeqStrTmp = orderSeqStr.split(",");	
		int dupCount = 0;
		for(int j=0 ; j < orderSeqStrTmp.length ; j++){
			List<TotalOrderVO> listRealOrderStock = totalOrderDao.listRealOrderStock(orderSeqStrTmp[j]);
			dupCount = totalOrderDao.listDupOrder(listRealOrderStock.get(0).getProductCode());
			if(dupCount > 0){
				totalOrderDao.updateRealStock(listRealOrderStock.get(0).getProductCode(), listRealOrderStock.get(0).getOrderOption());
			}else{
				totalOrderDao.saveRealStock(listRealOrderStock.get(0).getProductCode(), listRealOrderStock.get(0).getOrderQy(), listRealOrderStock.get(0).getOrderOption(), "0001", "0001",userIdTmp);
			}

		}
	}
}
