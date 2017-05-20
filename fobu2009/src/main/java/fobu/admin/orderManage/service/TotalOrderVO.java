package main.java.fobu.admin.orderManage.service;

import main.java.fobu.common.util.StringUtil;


/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class TotalOrderVO {

	private String seq;								//시퀀스
	private String siteCode;						//사이트코드
	private String siteImg;							//사이트코드 이미지명
	private String orderCode;						//주문번호(자체)
	private String productCode;					//고객사상품번호
	private String deliverType;						//배송비타입
	private String orderQy;						//수량
	private String orderPrice;						//주문금액
	private String orderer;							//주문자
	private String ordererHp;						//주문자핸드폰번호
	private String ordererTel;						//주문자전화번호
	private String ordererEmail;					//주문자이메일
	private String ordererZipcode;				//주문자우편번호
	private String ordererAddress;				//주문자주소
	
	private String receiver;							//수취인
	private String receiverHp;						//수취인핸드폰번호
	private String receiverTel;						//수취인전화번호
	private String receiverEmail;					//수취인이메일
	private String receiverZipcode;				//수취인우편번호
	private String receiverAddress;				//수취인주소
	private String deliverMemo;					//배송메세지
	private String etc;								//비고
	private String shoplinkerCode;				//샵링커 주문번호	
	private String prodCode;						//상품번호
	private String shoplinkerOrderCode;		//샵링커 쇼핑몰연동주문번호
	private String orderDt;							//주문일
	private String collectDt;						//수집일
	private String shopId;							//쇼핑몰아이디
	private String shopIdTmp;						//쇼핑몰아이디
	private String shopName;						//쇼핑몰명칭
	private String shopImg;						//쇼핑몰아이디 이미지명
	private String orderOption;					//주문옵션
	
	private String createDt;						//등록일
	private String creater;			    			//등록자
	private String modifyDt;						//수정일
	private String modifiers;						//수정자
	
	private String orderStat;						//주문상태
	private String cancelStat;						//취소상태
	private String returnStat;						//반품상태
	private String changeStat;						//교환상태
	private String managerMemo;				//관리자메모
	private String managerMemoYn;				//관리자메모유무
	private String cnt;								//묶음수량
	private String basePrice;						//판매가
	private String product;							//상품
	private String originalPrice;					//원가
	
	private String deliveryNumber;      			//송장번호
	private String deliveryCompany;     			//택배회사
	
	private String titleImageFile;					//타이틀이미지파일
	private String realStock;						//재고
	private String familyPrice;						//패밀리원가
	
	private String companyCategory;				//거래처
	private String orderStatCode;					//주문상태코드
	private String deliveryCompleteStat;			//배송완료상태(주문상세조회 팝업에서 씀)
	private String marketFee;						//마켓수수료
	private String fee;								//수수료
	private String marginPrice;					//마진
	private String marketPrice;					//마켓수수료
	private String addPrice;						//추가금
	private String deliveryCompleteYn;			//배송완료여부
	
	private String deliverPrice;						//배송비
	private String addDeliverPrice;				//추가배송비
	private String companyName;				//거래처명
	private String accidentYn;						//배송사고여부
	private String accidentCompleteYn;			//사고완료여부
	private String originalSumPrice;    			//원가총계(오리지날원가 * 수량)
	private String brandNm;    					//브랜드명
	private String couponPrice;    				//쿠폰가격
	private String deliveryDt;    					//배송날짜
	
	private String companyLinkUrl; 				//업체URL
	private String corpProductCode;				//협력사제품코드
	private String url;								//마켓별 URL
	private String totalCnt;							//totalCnt
	private String totalSum;						//totalSum
	private String productOrderQySum;   		//제품별 주문 수량 합계
	private String openMarketAccountYn;   	//제품별 주문 수량 합계
	private String stockOpt;   						//재고옵션
	private String payType;   						//결제수단방법
	
	private String inBank;   						//입금은행	 
	private String saleChannel;   					//매출경로	 
	private String orderChannel;   				//주문경로	 
	private String useSavePrice;   				//사용적립금
	
	
	
	public String getDeliveryCompany() {
		return deliveryCompany;
	}
	public void setDeliveryCompany(String deliveryCompany) {
		this.deliveryCompany = deliveryCompany;
	}
	public String getDeliveryNumber() {
		return deliveryNumber;
	}
	public void setDeliveryNumber(String deliveryNumber) {
		this.deliveryNumber = deliveryNumber;
	}
	public String getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = originalPrice;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getSiteCode() {
		return siteCode;
	}
	public void setSiteCode(String siteCode) {
		this.siteCode = siteCode;
	}
	public String getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}
	public String getProductCode() {
		return productCode;
	}
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}
	public String getDeliverType() {
		return deliverType;
	}
	public void setDeliverType(String deliverType) {
		this.deliverType = deliverType;
	}
	public String getOrderQy() {
		return orderQy;
	}
	public void setOrderQy(String orderQy) {
		this.orderQy = StringUtil.replaceInt(orderQy, ",", "");
	}
	public String getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(String orderPrice) {
		this.orderPrice = StringUtil.replaceInt(orderPrice, ",", "");
	}
	public String getOrderer() {
		return orderer;
	}
	public void setOrderer(String orderer) {
		this.orderer = orderer;
	}
	public String getOrdererHp() {
		return ordererHp;
	}
	public void setOrdererHp(String ordererHp) {
		this.ordererHp = ordererHp;
	}
	public String getOrdererTel() {
		return ordererTel;
	}
	public void setOrdererTel(String ordererTel) {
		this.ordererTel = ordererTel;
	}
	public String getOrdererEmail() {
		return ordererEmail;
	}
	public void setOrdererEmail(String ordererEmail) {
		this.ordererEmail = ordererEmail;
	}
	public void setOrdererZipcode(String ordererZipcode) {
		this.ordererZipcode = ordererZipcode;
	}
	public String getOrdererZipcode() {
		return ordererZipcode;
	}
	public void setOrdererAddress(String ordererAddress) {
		this.ordererAddress = ordererAddress;
	}
	public String getOrdererAddress() {
		return ordererAddress;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getReceiverHp() {
		return receiverHp;
	}
	public void setReceiverHp(String receiverHp) {
		this.receiverHp = receiverHp;
	}
	public String getReceiverTel() {
		return receiverTel;
	}
	public void setReceiverTel(String receiverTel) {
		this.receiverTel = receiverTel;
	}
	public void setReceiverEmail(String receiverEmail) {
		this.receiverEmail = receiverEmail;
	}
	public String getReceiverEmail() {
		return receiverEmail;
	}
	public String getReceiverZipcode() {
		return receiverZipcode;
	}
	public void setReceiverZipcode(String receiverZipcode) {
		this.receiverZipcode = receiverZipcode;
	}
	public String getReceiverAddress() {
		return receiverAddress;
	}
	public void setReceiverAddress(String receiverAddress) {
		this.receiverAddress = receiverAddress;
	}
	public String getDeliverMemo() {
		return deliverMemo;
	}
	public void setDeliverMemo(String deliverMemo) {
		this.deliverMemo = deliverMemo;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getShoplinkerCode() {
		return shoplinkerCode;
	}
	public void setShoplinkerCode(String shoplinkerCode) {
		this.shoplinkerCode = shoplinkerCode;
	}
	public String getProdCode() {
		return prodCode;
	}
	public void setProdCode(String prodCode) {
		this.prodCode = prodCode;
	}
	public String getShoplinkerOrderCode() {
		return shoplinkerOrderCode;
	}
	public void setShoplinkerOrderCode(String shoplinkerOrderCode) {
		this.shoplinkerOrderCode = shoplinkerOrderCode;
	}
	public String getOrderDt() {
		return orderDt;
	}
	public void setOrderDt(String orderDt) {
		this.orderDt = orderDt;
	}
	public String getCollectDt() {
		return collectDt;
	}
	public void setCollectDt(String collectDt) {
		this.collectDt = collectDt;
	}
	public String getShopId() {
		return shopId;
	}
	public void setShopId(String shopId) {
		this.shopId = shopId;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getShopName() {
		return shopName;
	}
	public String getOrderOption() {
		return orderOption;
	}
	public void setOrderOption(String orderOption) {
		this.orderOption = orderOption;
	}
	public String getCreateDt() {
		return createDt;
	}
	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public String getModifyDt() {
		return modifyDt;
	}
	public void setModifyDt(String modifyDt) {
		this.modifyDt = modifyDt;
	}
	public String getModifiers() {
		return modifiers;
	}
	public void setModifiers(String modifiers) {
		this.modifiers = modifiers;
	}
	public String getOrderStat() {
		return orderStat;
	}
	public void setOrderStat(String orderStat) {
		this.orderStat = orderStat;
	}
	public String getCancelStat() {
		return cancelStat;
	}
	public void setCancelStat(String cancelStat) {
		this.cancelStat = cancelStat;
	}
	public String getReturnStat() {
		return returnStat;
	}
	public void setReturnStat(String returnStat) {
		this.returnStat = returnStat;
	}
	public String getChangeStat() {
		return changeStat;
	}
	public void setChangeStat(String changeStat) {
		this.changeStat = changeStat;
	}
	public void setManagerMemo(String managerMemo) {
		this.managerMemo = managerMemo;
	}
	public String getManagerMemo() {
		return managerMemo;
	}
	public String getManagerMemoYn() {
		return managerMemoYn;
	}
	public void setManagerMemoYn(String managerMemoYn) {
		this.managerMemoYn = managerMemoYn;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getCnt() {
		return cnt;
	}
	public void setBasePrice(String basePrice) {
		this.basePrice = StringUtil.replaceInt(basePrice, ",", "");
	}
	public String getBasePrice() {
		return basePrice;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getProduct() {
		return product;
	}
	public String getSiteImg() {
		return siteImg;
	}
	public void setSiteImg(String siteImg) {
		this.siteImg = siteImg;
	}
	public String getShopImg() {
		return shopImg;
	}
	public void setShopImg(String shopImg) {
		this.shopImg = shopImg;
	}
	public void setTitleImageFile(String titleImageFile) {
		this.titleImageFile = titleImageFile;
	}
	public String getTitleImageFile() {
		return titleImageFile;
	}
	public void setRealStock(String realStock) {
		this.realStock = StringUtil.replaceInt(realStock, ",", "");
	}
	public String getRealStock() {
		return realStock;
	}
	public void setFamilyPrice(String familyPrice) {
		this.familyPrice = StringUtil.replaceInt(familyPrice, ",", "");
	}
	public String getFamilyPrice() {
		return familyPrice;
	}
	public void setCompanyCategory(String companyCategory) {
		this.companyCategory = companyCategory;
	}
	public String getCompanyCategory() {
		return companyCategory;
	}
	public void setOrderStatCode(String orderStatCode) {
		this.orderStatCode = orderStatCode;
	}
	public String getOrderStatCode() {
		return orderStatCode;
	}
	public void setDeliveryCompleteStat(String deliveryCompleteStat) {
		this.deliveryCompleteStat = deliveryCompleteStat;
	}
	public String getDeliveryCompleteStat() {
		return deliveryCompleteStat;
	}
	public void setMarketFee(String marketFee) {
		this.marketFee = marketFee;
	}
	public String getMarketFee() {
		return marketFee;
	}
	public void setMarginPrice(String marginPrice) {
		this.marginPrice = StringUtil.replaceInt(marginPrice, ",", "");
	}
	public String getMarginPrice() {
		return marginPrice;
	}
	public void setMarketPrice(String marketPrice) {
		this.marketPrice = marketPrice;
	}
	public String getMarketPrice() {
		return marketPrice;
	}
	public void setFee(String fee) {
		this.fee = fee;
	}
	public String getFee() {
		return fee;
	}
	public void setAddPrice(String addPrice) {
		this.addPrice = StringUtil.replaceInt(addPrice, ",", "");
	}
	public String getAddPrice() {
		return addPrice;
	}
	public void setDeliveryCompleteYn(String deliveryCompleteYn) {
		this.deliveryCompleteYn = deliveryCompleteYn;
	}
	public String getDeliveryCompleteYn() {
		return deliveryCompleteYn;
	}
	public void setDeliverPrice(String deliverPrice) {
		this.deliverPrice = deliverPrice;
	}
	public String getDeliverPrice() {
		return deliverPrice;
	}
	public void setAddDeliverPrice(String addDeliverPrice) {
		this.addDeliverPrice = addDeliverPrice;
	}
	public String getAddDeliverPrice() {
		return addDeliverPrice;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setAccidentYn(String accidentYn) {
		this.accidentYn = accidentYn;
	}
	public String getAccidentYn() {
		return accidentYn;
	}
	public void setAccidentCompleteYn(String accidentCompleteYn) {
		this.accidentCompleteYn = accidentCompleteYn;
	}
	public String getAccidentCompleteYn() {
		return accidentCompleteYn;
	}
	public void setOriginalSumPrice(String originalSumPrice) {
		this.originalSumPrice = originalSumPrice;
	}
	public String getOriginalSumPrice() {
		return originalSumPrice;
	}
	public void setBrandNm(String brandNm) {
		this.brandNm = brandNm;
	}
	public String getBrandNm() {
		return brandNm;
	}
	public String getCouponPrice() {
		return couponPrice;
	}
	public void setCouponPrice(String couponPrice) {
		this.couponPrice = couponPrice;
	}
	public String getDeliveryDt() {
		return deliveryDt;
	}
	public void setDeliveryDt(String deliveryDt) {
		this.deliveryDt = deliveryDt;
	}
	public String getCompanyLinkUrl() {
		return companyLinkUrl;
	}
	public void setCompanyLinkUrl(String companyLinkUrl) {
		this.companyLinkUrl = companyLinkUrl;
	}
	public String getCorpProductCode() {
		return corpProductCode;
	}
	public void setCorpProductCode(String corpProductCode) {
		this.corpProductCode = corpProductCode;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(String totalCnt) {
		this.totalCnt = totalCnt;
	}
	public String getTotalSum() {
		return totalSum;
	}
	public void setTotalSum(String totalSum) {
		this.totalSum = totalSum;
	}
	public String getProductOrderQySum() {
		return productOrderQySum;
	}
	public void setProductOrderQySum(String productOrderQySum) {
		this.productOrderQySum = productOrderQySum;
	}
	public String getOpenMarketAccountYn() {
		return openMarketAccountYn;
	}
	public void setOpenMarketAccountYn(String openMarketAccountYn) {
		this.openMarketAccountYn = openMarketAccountYn;
	}
	public String getStockOpt() {
		return stockOpt;
	}
	public void setStockOpt(String stockOpt) {
		this.stockOpt = stockOpt;
	}
	public String getShopIdTmp() {
		return shopIdTmp;
	}
	public void setShopIdTmp(String shopIdTmp) {
		this.shopIdTmp = shopIdTmp;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public String getInBank() {
		return inBank;
	}
	public void setInBank(String inBank) {
		this.inBank = inBank;
	}
	public String getSaleChannel() {
		return saleChannel;
	}
	public void setSaleChannel(String saleChannel) {
		this.saleChannel = saleChannel;
	}
	public String getOrderChannel() {
		return orderChannel;
	}
	public void setOrderChannel(String orderChannel) {
		this.orderChannel = orderChannel;
	}
	public String getUseSavePrice() {
		return useSavePrice;
	}
	public void setUseSavePrice(String useSavePrice) {
		this.useSavePrice = useSavePrice;
	}	
}
