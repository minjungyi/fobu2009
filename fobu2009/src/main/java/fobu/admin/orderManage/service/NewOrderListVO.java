package main.java.fobu.admin.orderManage.service;


/**
 * 
 * 
 * @author min
 * @since 2012. 03. 10.
 */
public class NewOrderListVO {

	private String[] productSeq;
	private String[] orderPrice;
	private String[] qy;
	private String orderer;
	private String receiver;
	private String receiverEmail;
	private String receiverTel;
	private String receiverHp;
	private String receiverZipcode;
	private String receiverAddress;
	private String deliverType;
	private String deliverPrice;
	private String addPrice;
	private String memo;
	
	public String[] getProductSeq() {
		return productSeq;
	}
	public void setProductSeq(String[] productSeq) {
		this.productSeq = productSeq;
	}
	public String[] getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(String[] orderPrice) {
		this.orderPrice = orderPrice;
	}
	public String[] getQy() {
		return qy;
	}
	public void setQy(String[] qy) {
		this.qy = qy;
	}
	public String getOrderer() {
		return orderer;
	}
	public void setOrderer(String orderer) {
		this.orderer = orderer;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getReceiverEmail() {
		return receiverEmail;
	}
	public void setReceiverEmail(String receiverEmail) {
		this.receiverEmail = receiverEmail;
	}
	public String getReceiverTel() {
		return receiverTel;
	}
	public void setReceiverTel(String receiverTel) {
		this.receiverTel = receiverTel;
	}
	public String getReceiverHp() {
		return receiverHp;
	}
	public void setReceiverHp(String receiverHp) {
		this.receiverHp = receiverHp;
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
	public String getDeliverType() {
		return deliverType;
	}
	public void setDeliverType(String deliverType) {
		this.deliverType = deliverType;
	}
	public String getDeliverPrice() {
		return deliverPrice;
	}
	public void setDeliverPrice(String deliverPrice) {
		this.deliverPrice = deliverPrice;
	}
	public String getAddPrice() {
		return addPrice;
	}
	public void setAddPrice(String addPrice) {
		this.addPrice = addPrice;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
}
