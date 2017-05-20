package main.java.fobu.admin.orderManage.service;

/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class OrderExcelVO {
	
	private String orderCode;			//주문번호(자체)
	private String deliverType;			//배송비타입
	private String orderQy;				//수량	
	private String receiver;			//수취인
	private String receiverHp;			//수취인핸드폰번호
	private String deliverMemo;			//배송메세지
	private String shopId;				//쇼핑몰아이디
	private String managerMemo;			//관리자메모
	private String product;				//상품
	private String originalPrice;		//원가	
	private String titleImageFile;		//타이틀이미지파일	
	private String originalSumPrice;    //원가총계(오리지날원가 * 수량)
	private String orderOption;		    //옵션
	private String brandNm;		    	//브랜드
	private String companyCategory;		//업체
	private String companyName;			//업체명
	private String orderPriceSum;		//주문가격합계
	private String orderQySum;			//주문수량합계
	private String orderCount;			//주만건수
	private String orderStat;			//주문상태값
	private String orderStatName;		//주문상태값
	
	public String getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
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
	public String getDeliverMemo() {
		return deliverMemo;
	}
	public void setDeliverMemo(String deliverMemo) {
		this.deliverMemo = deliverMemo;
	}
	public String getShopId() {
		return shopId;
	}
	public void setShopId(String shopId) {
		this.shopId = shopId;
	}
	public String getManagerMemo() {
		return managerMemo;
	}
	public void setManagerMemo(String managerMemo) {
		this.managerMemo = managerMemo;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = originalPrice;
	}
	public String getTitleImageFile() {
		return titleImageFile;
	}
	public void setTitleImageFile(String titleImageFile) {
		this.titleImageFile = titleImageFile;
	}
	public String getOriginalSumPrice() {
		return originalSumPrice;
	}
	public void setOriginalSumPrice(String originalSumPrice) {
		this.originalSumPrice = originalSumPrice;
	}
	public String getOrderOption() {
		return orderOption;
	}
	public void setOrderOption(String orderOption) {
		this.orderOption = orderOption;
	}
	public String getBrandNm() {
		return brandNm;
	}
	public void setBrandNm(String brandNm) {
		this.brandNm = brandNm;
	}
	public String getCompanyCategory() {
		return companyCategory;
	}
	public void setCompanyCategory(String companyCategory) {
		this.companyCategory = companyCategory;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getOrderPriceSum() {
		return orderPriceSum;
	}
	public void setOrderPriceSum(String orderPriceSum) {
		this.orderPriceSum = orderPriceSum;
	}
	public String getOrderQySum() {
		return orderQySum;
	}
	public void setOrderQySum(String orderQySum) {
		this.orderQySum = orderQySum;
	}
	public String getOrderCount() {
		return orderCount;
	}
	public void setOrderCount(String orderCount) {
		this.orderCount = orderCount;
	}
	public String getOrderStat() {
		return orderStat;
	}
	public void setOrderStat(String orderStat) {
		this.orderStat = orderStat;
	}
	public String getOrderStatName() {
		return orderStatName;
	}
	public void setOrderStatName(String orderStatName) {
		this.orderStatName = orderStatName;
	}
}
