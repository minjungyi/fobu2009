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
import main.java.fobu.admin.orderManage.service.NewOrderListVO;
import main.java.fobu.admin.orderManage.service.NewOrderService;
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
 * @author min™
 * @since 2012. 03. 10.
 */
@Service
public class NewOrderServiceImpl implements NewOrderService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "newOrderDAO")
	private NewOrderDAO newOrderDao;
	
	@Resource(name = "totalOrderDAO")
	private TotalOrderDAO totalOrderDao;
	
	/**
	 * The Constructor
	 */
	public NewOrderServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	public int saveNewOrderProduct(NewOrderListVO NewOrderList) throws SQLException {	
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		
		try{
			for(int i = 0 ; i < NewOrderList.getProductSeq().length ; i++){					
				TotalOrderVO totalOrderVO = new TotalOrderVO();
				List<TotalOrderVO> listProductInfoDetail = totalOrderDao.listProductInfo(NewOrderList.getProductSeq()[i].toString());
				int originalPrice = 0;
				int companyCategory = 0;
				int familyPrice = 0;
				int orderQy = Integer.parseInt(StringUtil.replaceInt(NewOrderList.getQy()[i].toString(), ",", ""));
				int orderPrice = Integer.parseInt(StringUtil.replaceInt(NewOrderList.getOrderPrice()[i].toString(), ",", ""));
				int marketPrice = 0;
				int aCnt = 0;
				int deliverPrice = 0;
				int addDeliverPrice = 0;
				String deliverType = NewOrderList.getDeliverType().toString();
				String siteCodeTmp = "dir";
				
				if(listProductInfoDetail.size() != 0){
					originalPrice = Integer.parseInt(listProductInfoDetail.get(0).getOriginalPrice());
					companyCategory = Integer.parseInt(listProductInfoDetail.get(0).getCompanyCategory());
					familyPrice = Integer.parseInt(listProductInfoDetail.get(0).getFamilyPrice());
					//deliverPrice = Integer.parseInt(listProductInfoDetail.get(0).getDeliverPrice());
					//addDeliverPrice = Integer.parseInt(listProductInfoDetail.get(0).getAddDeliverPrice());
					//String fee = listProductInfoDetail.get(0).getFee();
					//fee = "12,10,10,12";
					//String splitFee[] = fee.split(",");					
					double feeRate = orderPrice*aCnt/100;
					marketPrice = (int)feeRate;
				}	
				
				if(deliverType.equals("선불")){
					deliverPrice = Integer.parseInt(StringUtil.replaceInt(NewOrderList.getDeliverPrice().toString(), ",", ""));
				}else if(deliverType.equals("무료")){
					addDeliverPrice = Integer.parseInt(StringUtil.replaceInt(NewOrderList.getDeliverPrice().toString(), ",", ""));
				}else{
					
				}
				
				totalOrderVO.setMarketFee(Integer.toString(aCnt));
				totalOrderVO.setMarketPrice(Integer.toString(marketPrice));
				totalOrderVO.setOriginalPrice(Integer.toString(originalPrice));
				totalOrderVO.setFamilyPrice(Integer.toString(familyPrice));
				totalOrderVO.setCompanyCategory(Integer.toString(companyCategory));
				
				totalOrderVO.setSiteCode(siteCodeTmp);
				totalOrderVO.setDeliverType(deliverType);
				totalOrderVO.setOrderQy(Integer.toString(orderQy));
				totalOrderVO.setOrderPrice(Integer.toString(orderQy*orderPrice));
				totalOrderVO.setOrderer(NewOrderList.getOrderer().toString());
				totalOrderVO.setOrdererTel(NewOrderList.getReceiverTel().toString());
				totalOrderVO.setOrdererHp(NewOrderList.getReceiverHp().toString());
				totalOrderVO.setOrdererEmail(NewOrderList.getReceiverEmail().toString());
				totalOrderVO.setReceiver(NewOrderList.getReceiver().toString());
				totalOrderVO.setReceiverTel(NewOrderList.getReceiverTel().toString());
				totalOrderVO.setReceiverHp(NewOrderList.getReceiverHp().toString());
				totalOrderVO.setReceiverZipcode(NewOrderList.getReceiverZipcode().toString());
				totalOrderVO.setReceiverAddress(NewOrderList.getReceiverAddress().toString());
				totalOrderVO.setManagerMemo(NewOrderList.getMemo().toString());
				totalOrderVO.setProdCode(NewOrderList.getProductSeq()[i].toString());
				totalOrderVO.setDeliverPrice(Integer.toString(deliverPrice));
				totalOrderVO.setAddDeliverPrice(Integer.toString(addDeliverPrice));
				
				totalOrderVO.setProductCode(NewOrderList.getProductSeq()[i].toString());
				totalOrderVO.setShoplinkerCode(NewOrderList.getProductSeq()[i].toString());
				totalOrderVO.setShoplinkerOrderCode(NewOrderList.getProductSeq()[i].toString());
				totalOrderVO.setShopId("fobu");
				
				
				
				if(userInfo != null) {
					totalOrderVO.setModifiers(userInfo.getUserId());
				} else {
					totalOrderVO.setModifiers("SYSTEM");
				}
							
				newOrderDao.saveNewOrderProduct(totalOrderVO);
			}
			
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
}
