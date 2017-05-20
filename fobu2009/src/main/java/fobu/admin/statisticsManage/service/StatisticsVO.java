package main.java.fobu.admin.statisticsManage.service;


/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class StatisticsVO {

	private String seqCnt;					//건수
	private String collectDt;				//주문날짜
	private String familyPrice;				//매입금액
	private String orderPrice;				//주문금액
	private String deliverPrice;			//배송금액
	private String addDeliverPrice;			//추가배송금액
	private String marketPrice;				//마켓수수료
	private String marginPrice;				//마진금액
	private String product;					//상품명
	private String productCnt; 				//주문건수
	private String orderQy;					//주문수량
	private String companyName;				//거래처명
	private String deliveryCompleteCnt;		//배송완료 배송건수
	private String returnCnt;				//반품완료 배송건수
	private String exchangeCnt;				//교환완료 배송건수	
	private String originalPrice;				//원가
		
	public String getSeqCnt() {
		return seqCnt;
	}
	public void setSeqCnt(String seqCnt) {
		this.seqCnt = seqCnt;
	}
	public String getCollectDt() {
		return collectDt;
	}
	public void setCollectDt(String collectDt) {
		this.collectDt = collectDt;
	}
	public String getFamilyPrice() {
		return familyPrice;
	}
	public void setFamilyPrice(String familyPrice) {
		this.familyPrice = familyPrice;
	}
	public String getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(String orderPrice) {
		this.orderPrice = orderPrice;
	}
	public String getDeliverPrice() {
		return deliverPrice;
	}
	public void setDeliverPrice(String deliverPrice) {
		this.deliverPrice = deliverPrice;
	}
	public String getAddDeliverPrice() {
		return addDeliverPrice;
	}
	public void setAddDeliverPrice(String addDeliverPrice) {
		this.addDeliverPrice = addDeliverPrice;
	}
	public String getMarketPrice() {
		return marketPrice;
	}
	public void setMarketPrice(String marketPrice) {
		this.marketPrice = marketPrice;
	}
	public String getMarginPrice() {
		return marginPrice;
	}
	public void setMarginPrice(String marginPrice) {
		this.marginPrice = marginPrice;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getProduct() {
		return product;
	}
	public void setProductCnt(String productCnt) {
		this.productCnt = productCnt;
	}
	public String getProductCnt() {
		return productCnt;
	}
	public void setOrderQy(String orderQy) {
		this.orderQy = orderQy;
	}
	public String getOrderQy() {
		return orderQy;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCompanyName() {
		return companyName;
	}
	public String getDeliveryCompleteCnt() {
		return deliveryCompleteCnt;
	}
	public void setDeliveryCompleteCnt(String deliveryCompleteCnt) {
		this.deliveryCompleteCnt = deliveryCompleteCnt;
	}
	public String getReturnCnt() {
		return returnCnt;
	}
	public void setReturnCnt(String returnCnt) {
		this.returnCnt = returnCnt;
	}
	public String getExchangeCnt() {
		return exchangeCnt;
	}
	public void setExchangeCnt(String exchangeCnt) {
		this.exchangeCnt = exchangeCnt;
	}
	public String getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = originalPrice;
	}
}
