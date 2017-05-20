package main.java.fobu.admin.orderManage.service;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class PackageInfoListVO {

	private String[] seq;
	private String[] checkbox;
	private String[] orderStat;
	private String[] deliveryNumber;
	private String[] deliveryCompany;
	
	public void setSeq(String[] seq) {
		this.seq = seq;
	}
	public String[] getSeq() {
		return seq;
	}
	public void setCheckbox(String[] checkbox) {
		this.checkbox = checkbox;
	}
	public String[] getCheckbox() {
		return checkbox;
	}
	public void setOrderStat(String[] orderStat) {
		this.orderStat = orderStat;
	}
	public String[] getOrderStat() {
		return orderStat;
	}
	public void setDeliveryNumber(String[] deliveryNumber) {
		this.deliveryNumber = deliveryNumber;
	}
	public String[] getDeliveryNumber() {
		return deliveryNumber;
	}
	public String[] getDeliveryCompany() {
		return deliveryCompany;
	}
	public void setDeliveryCompany(String[] deliveryCompany) {
		this.deliveryCompany = deliveryCompany;
	}
}
