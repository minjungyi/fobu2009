package main.java.fobu.admin.product.service;

import java.util.ArrayList;
import java.util.List;

/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class ProductListVO {

	private String[] checkbox;
	public String[] getCheckbox() {
		return checkbox;
	}
	public void setCheckbox(String[] checkbox) {
		this.checkbox = checkbox;
	}
	private String[] seq;
	private String[] status;
	private String[] product;
	private String[] remark;
	private String[] originalPrice;
	private String[] dealerPrice;
	private String[] retailPrice;
	private String[] sellPrice;
	private String[] deliverPrice;
	private String[] addDeliverPrice;
	private boolean[] fixedPrice;
	private String[] sizeOpt;
	private String[] productOpt;
	private String[] colorOpt;
	private String[] stock;
	private String[] realStock;
	private String[] enterpriseOrderQy;		
	private String[] corpProductCode;
	private String[] siteCode;
	private String[] originCountry;
	private String[] eventOpt;
	private String[] packageCode;
	private String[] minusPrice;
	private String[] familyPrice;
	private String[] mallPrice;
	private String[] category1;
	private String[] categoryNm1;
	private String[] category2;
	private String[] categoryNm2;
	private String[] category3;
	private String[] categoryNm3;
	private String[] companyCategory;
	private boolean[] familyNoDisplay;
	private boolean[] dealerNoDisplay;
	private boolean[] mallNoDisplay;
	private String[] creator;
	private String[] createDate;
	private String[] modifier;
	private String[] modifyDate;		
	private String[] enterpriseOrderSeq;
	private String[] dSize;	
	private String[] dMaterial;
	private String[] dManufacturer;
	private String[] dManufacturerCountry;
	private String[] dUseAge;
	private String[] dMadeDate;
	private String[] dKCcert;
	private String[] dGuarantee;	
	private String[] dNotice;
	private String[] dDescription;
	private String[] dASManager;
	private boolean[] detailDisplay;
	
	public boolean[] getDetailDisplay() {
		return detailDisplay;
	}
	public void setDetailDisplay(boolean[] detailDisplay) {
		this.detailDisplay = detailDisplay;
	}
	public String[] getdSize() {
		return dSize;
	}
	public void setdSize(String[] dSize) {
		this.dSize = dSize;
	}
	public String[] getdMaterial() {
		return dMaterial;
	}
	public void setdMaterial(String[] dMaterial) {
		this.dMaterial = dMaterial;
	}
	public String[] getdManufacturer() {
		return dManufacturer;
	}
	public void setdManufacturer(String[] dManufacturer) {
		this.dManufacturer = dManufacturer;
	}
	public String[] getdManufacturerCountry() {
		return dManufacturerCountry;
	}
	public void setdManufacturerCountry(String[] dManufacturerCountry) {
		this.dManufacturerCountry = dManufacturerCountry;
	}
	public String[] getdUseAge() {
		return dUseAge;
	}
	public void setdUseAge(String[] dUseAge) {
		this.dUseAge = dUseAge;
	}
	public String[] getdMadeDate() {
		return dMadeDate;
	}
	public void setdMadeDate(String[] dMadeDate) {
		this.dMadeDate = dMadeDate;
	}
	public String[] getdKCcert() {
		return dKCcert;
	}
	public void setdKCcert(String[] dKCcert) {
		this.dKCcert = dKCcert;
	}
	public String[] getdGuarantee() {
		return dGuarantee;
	}
	public void setdGuarantee(String[] dGuarantee) {
		this.dGuarantee = dGuarantee;
	}
	public String[] getdNotice() {
		return dNotice;
	}
	public void setdNotice(String[] dNotice) {
		this.dNotice = dNotice;
	}
	public String[] getdDescription() {
		return dDescription;
	}
	public void setdDescription(String[] dDescription) {
		this.dDescription = dDescription;
	}
	public String[] getdASManager() {
		return dASManager;
	}
	public void setdASManager(String[] dASManager) {
		this.dASManager = dASManager;
	}
	public String[] getEnterpriseOrderSeq() {
		return enterpriseOrderSeq;
	}
	public void setEnterpriseOrderSeq(String[] enterpriseOrderSeq) {
		this.enterpriseOrderSeq = enterpriseOrderSeq;
	}
	public String[] getSeq() {
		return seq;
	}
	public void setSeq(String[] seq) {
		this.seq = seq;
	}
	public String[] getStatus() {
		return status;
	}
	public void setStatus(String[] status) {
		this.status = status;
	}
	public String[] getProduct() {
		return product;
	}
	public void setProduct(String[] product) {
		this.product = product;
	}
	public String[] getRemark() {
		return remark;
	}
	public void setRemark(String[] remark) {
		this.remark = remark;
	}
	public String[] getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(String[] originalPrice) {
		this.originalPrice = originalPrice;
	}
	public String[] getDealerPrice() {
		return dealerPrice;
	}
	public void setDealerPrice(String[] dealerPrice) {
		this.dealerPrice = dealerPrice;
	}
	public String[] getRetailPrice() {
		return retailPrice;
	}
	public void setRetailPrice(String[] retailPrice) {
		this.retailPrice = retailPrice;
	}
	public String[] getSellPrice() {
		return sellPrice;
	}
	public void setSellPrice(String[] sellPrice) {
		this.sellPrice = sellPrice;
	}
	public String[] getDeliverPrice() {
		return deliverPrice;
	}
	public void setDeliverPrice(String[] deliverPrice) {
		this.deliverPrice = deliverPrice;
	}
	public String[] getAddDeliverPrice() {
		return addDeliverPrice;
	}
	public void setAddDeliverPrice(String[] addDeliverPrice) {
		this.addDeliverPrice = addDeliverPrice;
	}
	public boolean[] getFixedPrice() {
		return fixedPrice;
	}
	public void setFixedPrice(boolean[] fixedPrice) {
		this.fixedPrice = fixedPrice;
	}
	public String[] getSizeOpt() {
		return sizeOpt;
	}
	public void setSizeOpt(String[] sizeOpt) {
		this.sizeOpt = sizeOpt;
	}
	public String[] getProductOpt() {
		return productOpt;
	}
	public void setProductOpt(String[] productOpt) {
		this.productOpt = productOpt;
	}
	public String[] getColorOpt() {
		return colorOpt;
	}
	public void setColorOpt(String[] colorOpt) {
		this.colorOpt = colorOpt;
	}
	public String[] getStock() {
		return stock;
	}
	public void setStock(String[] stock) {
		this.stock = stock;
	}
	public String[] getRealStock() {
		return realStock;
	}
	public void setRealStock(String[] realStock) {
		this.realStock = realStock;
	}
	public String[] getCorpProductCode() {
		return corpProductCode;
	}
	public void setCorpProductCode(String[] corpProductCode) {
		this.corpProductCode = corpProductCode;
	}
	public String[] getSiteCode() {
		return siteCode;
	}
	public void setSiteCode(String[] siteCode) {
		this.siteCode = siteCode;
	}
	public String[] getOriginCountry() {
		return originCountry;
	}
	public void setOriginCountry(String[] originCountry) {
		this.originCountry = originCountry;
	}
	public String[] getEventOpt() {
		return eventOpt;
	}
	public void setEventOpt(String[] eventOpt) {
		this.eventOpt = eventOpt;
	}
	public String[] getPackageCode() {
		return packageCode;
	}
	public void setPackageCode(String[] packageCode) {
		this.packageCode = packageCode;
	}
	public String[] getMinusPrice() {
		return minusPrice;
	}
	public void setMinusPrice(String[] minusPrice) {
		this.minusPrice = minusPrice;
	}
	public String[] getFamilyPrice() {
		return familyPrice;
	}
	public void setFamilyPrice(String[] familyPrice) {
		this.familyPrice = familyPrice;
	}
	public String[] getMallPrice() {
		return mallPrice;
	}
	public void setMallPrice(String[] mallPrice) {
		this.mallPrice = mallPrice;
	}
	public String[] getCategory1() {
		return category1;
	}
	public void setCategory1(String[] category1) {
		this.category1 = category1;
	}
	public String[] getCategoryNm1() {
		return categoryNm1;
	}
	public void setCategoryNm1(String[] categoryNm1) {
		this.categoryNm1 = categoryNm1;
	}
	public String[] getCategory2() {
		return category2;
	}
	public void setCategory2(String[] category2) {
		this.category2 = category2;
	}
	public String[] getCategoryNm2() {
		return categoryNm2;
	}
	public void setCategoryNm2(String[] categoryNm2) {
		this.categoryNm2 = categoryNm2;
	}
	public String[] getCategory3() {
		return category3;
	}
	public void setCategory3(String[] category3) {
		this.category3 = category3;
	}
	public String[] getCategoryNm3() {
		return categoryNm3;
	}
	public void setCategoryNm3(String[] categoryNm3) {
		this.categoryNm3 = categoryNm3;
	}
	public String[] getCompanyCategory() {
		return companyCategory;
	}
	public void setCompanyCategory(String[] companyCategory) {
		this.companyCategory = companyCategory;
	}
	public boolean[] getFamilyNoDisplay() {
		return familyNoDisplay;
	}
	public void setFamilyNoDisplay(boolean[] familyNoDisplay) {
		this.familyNoDisplay = familyNoDisplay;
	}
	public boolean[] getDealerNoDisplay() {
		return dealerNoDisplay;
	}
	public void setDealerNoDisplay(boolean[] dealerNoDisplay) {
		this.dealerNoDisplay = dealerNoDisplay;
	}
	public boolean[] getMallNoDisplay() {
		return mallNoDisplay;
	}
	public void setMallNoDisplay(boolean[] mallNoDisplay) {
		this.mallNoDisplay = mallNoDisplay;
	}
	public String[] getCreator() {
		return creator;
	}
	public void setCreator(String[] creator) {
		this.creator = creator;
	}
	public String[] getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String[] createDate) {
		this.createDate = createDate;
	}
	public String[] getModifier() {
		return modifier;
	}
	public void setModifier(String[] modifier) {
		this.modifier = modifier;
	}
	public String[] getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String[] modifyDate) {
		this.modifyDate = modifyDate;
	}
		
	public String[] getEnterpriseOrderQy() {
		return enterpriseOrderQy;
	}
	public void setEnterpriseOrderQy(String[] enterpriseOrderQy) {
		this.enterpriseOrderQy = enterpriseOrderQy;
	}
}
