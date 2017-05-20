package main.java.fobu.admin.orderManage.service;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class ChangeProductListVO {

	private String[] seq;
	private String[] checkbox;
	private String[] productSeq;
	private String[] qy;
	private String[] companyCategory;
	private String[] familyPrice;
	
	public String[] getSeq() {
		return seq;
	}
	public void setSeq(String[] seq) {
		this.seq = seq;
	}
	public String[] getCheckbox() {
		return checkbox;
	}
	public void setCheckbox(String[] checkbox) {
		this.checkbox = checkbox;
	}
	public String[] getProductSeq() {
		return productSeq;
	}
	public void setProductSeq(String[] productSeq) {
		this.productSeq = productSeq;
	}
	public String[] getQy() {
		return qy;
	}
	public void setQy(String[] qy) {
		this.qy = qy;
	}
	public void setCompanyCategory(String[] companyCategory) {
		this.companyCategory = companyCategory;
	}
	public String[] getCompanyCategory() {
		return companyCategory;
	}
	public String[] getFamilyPrice() {
		return familyPrice;
	}
	public void setFamilyPrice(String[] familyPrice) {
		this.familyPrice = familyPrice;
	}	
	
}
