package main.java.fobu.admin.accountManage.service;


/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class AccountVO {

	private String seq;					//시퀀스
	private String siteCode;			//사이트코드
	private String siteImg;				//사이트코드 이미지명
	private String orderCode;			//주문번호(자체)
	private String productCode;			//고객사상품번호
	private String deliverType;			//배송비타입
	private String orderQy;				//수량
	private String orderPrice;			//주문금액
	private String orderer;				//주문자
	private String ordererHp;			//주문자핸드폰번호
	private String ordererTel;			//주문자전화번호
	private String ordererEmail;		//주문자이메일
	private String receiver;			//수취인
	private String receiverHp;			//수취인핸드폰번호
	private String receiverTel;			//수취인전화번호
	private String receiverZipcode;		//수취인우편번호
	private String receiverAddress;		//수취인주소
	private String deliverMemo;			//배송메세지
	private String etc;					//비고
	private String shoplinkerCode;		//샵링커 주문번호	
	private String prodCode;			//상품번호
	private String shoplinkerOrderCode;	//샵링커 쇼핑몰연동주문번호
	private String orderDt;				//주문일
	private String collectDt;			//수집일
	private String shopId;				//쇼핑몰아이디
	private String shopImg;				//쇼핑몰아이디 이미지명
	private String orderOption;			//주문옵션
	
	private String createDt;			//등록일
	private String creator;			    //등록자
	private String modifyDt;			//수정일
	private String modifiers;			//수정자
	
	private String orderStat;			//주문상태
	private String orderStatCode;			//주문상태
	private String cancelStat;			//취소상태
	private String returnStat;			//반품상태
	private String changeStat;			//교환상태
	private String managerMemo;			//관리자메모
	private String cnt;					//묶음수량
	private String basePrice;			//판매가
	private String product;				//상품
	private String originalPrice;		//원가
	
	private String deliveryNumber;      //송장번호
	private String deliveryCompany;     //택배회사
	private String accountCode;         //정산여부
	private String accountNm;           //정산여부
	
	private String companyCategory;		//거래처
	private String marketFee;			//마켓수수료
	private String fee;					//수수료
	private String marginPrice;			//마진
	private String marketPrice;			//마켓수수료
	private String addPrice;			//추가금
	private String companyName;			//거래처명
	private String accountSeq;			//정산그룹SEQ
	private String accountName;			//정산그룹명칭
	private String familyPrice;			//원가
	private String familyPriceSum;			//원가합계
	private String deliverPrice;		//배송비
	private String addDeliverPrice;		//추가배송비
	private String brandNm;		//브랜드
	private String accountAccidentNm;		//정산 후 변경여부
	
	private String shopName;
	private String accountStartDate;
	private String accountEndDate;
	
	
	
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
		this.orderQy = orderQy;
	}
	public String getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(String orderPrice) {
		this.orderPrice = orderPrice;
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
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getCreator() {
		return creator;
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
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getCnt() {
		return cnt;
	}
	public void setBasePrice(String basePrice) {
		this.basePrice = basePrice;
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
	public void setAccountCode(String accountCode) {
		this.accountCode = accountCode;
	}
	public String getAccountCode() {
		return accountCode;
	}
	public void setAccountNm(String accountNm) {
		this.accountNm = accountNm;
	}
	public String getAccountNm() {
		return accountNm;
	}
	public void setCompanyCategory(String companyCategory) {
		this.companyCategory = companyCategory;
	}
	public String getCompanyCategory() {
		return companyCategory;
	}
	public void setMarketFee(String marketFee) {
		this.marketFee = marketFee;
	}
	public String getMarketFee() {
		return marketFee;
	}
	public void setFee(String fee) {
		this.fee = fee;
	}
	public String getFee() {
		return fee;
	}
	public void setMarginPrice(String marginPrice) {
		this.marginPrice = marginPrice;
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
	public void setAddPrice(String addPrice) {
		this.addPrice = addPrice;
	}
	public String getAddPrice() {
		return addPrice;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setAccountSeq(String accountSeq) {
		this.accountSeq = accountSeq;
	}
	public String getAccountSeq() {
		return accountSeq;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setFamilyPrice(String familyPrice) {
		this.familyPrice = familyPrice;
	}
	public String getFamilyPrice() {
		return familyPrice;
	}
	public void setFamilyPriceSum(String familyPriceSum) {
		this.familyPriceSum = familyPriceSum;
	}
	public String getFamilyPriceSum() {
		return familyPriceSum;
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
	public void setBrandNm(String brandNm) {
		this.brandNm = brandNm;
	}
	public String getBrandNm() {
		return brandNm;
	}
	public String getAccountAccidentNm() {
		return accountAccidentNm;
	}
	public void setAccountAccidentNm(String accountAccidentNm) {
		this.accountAccidentNm = accountAccidentNm;
	}
	public String getOrderStatCode() {
		return orderStatCode;
	}
	public void setOrderStatCode(String orderStatCode) {
		this.orderStatCode = orderStatCode;
	}
	public String getShopName() {
		return shopName;
	}
	public void setShopName(String shopName) {
		this.shopName = shopName;
	}
	public String getAccountStartDate() {
		return accountStartDate;
	}
	public void setAccountStartDate(String accountStartDate) {
		this.accountStartDate = accountStartDate;
	}
	public String getAccountEndDate() {
		return accountEndDate;
	}
	public void setAccountEndDate(String accountEndDate) {
		this.accountEndDate = accountEndDate;
	}	
}
