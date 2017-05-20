package main.java.fobu.admin.product.service;


/**
 * 
 * 
 * @author min
 * @since 2012. 10. 01.
 */
public class EnterpriseOrderVO {
	
	private String enterpriseOrderSeq;	
	private String productSeq;
	private String enterpriseOrderQy;
	private String orderDate;
	private String enterpriseOrderStatus;
	private String enterpriseOrderTarget;
	private String creator;
	private String createDate;
	private String remark;
	
	
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getEnterpriseOrderSeq() {
		return enterpriseOrderSeq;
	}
	public void setEnterpriseOrderSeq(String enterpriseOrderSeq) {
		this.enterpriseOrderSeq = enterpriseOrderSeq;
	}
	public String getProductSeq() {
		return productSeq;
	}
	public void setProductSeq(String productSeq) {
		this.productSeq = productSeq;
	}
	public String getEnterpriseOrderQy() {
		return enterpriseOrderQy;
	}
	public void setEnterpriseOrderQy(String enterpriseOrderQy) {
		this.enterpriseOrderQy = enterpriseOrderQy;
	}
	public String getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}
	public String getEnterpriseOrderStatus() {
		return enterpriseOrderStatus;
	}
	public void setEnterpriseOrderStatus(String enterpriseOrderStatus) {
		this.enterpriseOrderStatus = enterpriseOrderStatus;
	}
	public String getEnterpriseOrderTarget() {
		return enterpriseOrderTarget;
	}
	public void setEnterpriseOrderTarget(String enterpriseOrderTarget) {
		this.enterpriseOrderTarget = enterpriseOrderTarget;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
}
	