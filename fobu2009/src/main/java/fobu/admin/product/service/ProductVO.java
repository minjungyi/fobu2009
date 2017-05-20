package main.java.fobu.admin.product.service;

import main.java.fobu.common.util.StringUtil;


/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class ProductVO {

	private String seq;
	private String status;
	private String product;
	private String remark;
	private String originalPrice;
	private String dealerPrice;
	private String retailPrice;
	private String sellPrice;
	private String deliverPrice;
	private String addDeliverPrice;
	private boolean fixedPrice;
	private boolean isFreeDeliver;		
	private String sizeOpt;
	private String productOpt;
	private String colorOpt;
	private String stockOpt;
	private String stock;
	private String realStock;
	private String corpProductCode;
	private String siteCode;
	private String originCountry;
	private String eventOpt;
	private String packageCode;
	private String minusPrice;
	private String familyPrice;
	private String mallPrice;
	private String category1;
	private String categoryNm1;
	private String category2;
	private String categoryNm2;
	private String category3;
	private String categoryNm3;
	private String companyCategory;
	private String brandCategory;
	private String brandNm;
	
	
	private boolean familyNoDisplay;
	private boolean dealerNoDisplay;
	private boolean mallNoDisplay;
	private String creator;
	private String createDate;
	private String modifier;
	private String modifyDate;
	private String detailImageFile;
	private String titleImageFile;
	private String companyLinkUrl;
	private String company;
	private String barCode;	
	private String[] sizeOptStock;
	private String[] sizeOptName;
	
	private String enterpriseOrderSeq;	
	private String productSeq;
	private String enterpriseOrderQy;
	private String orderDate;
	private String enterpriseOrderStatus;
	private String enterpriseOrderTarget;
	private String productStock;
	private String orderStock;
	private String productOrderQySum;
	
	private String infoCategory;	
	private String info1;	
	private String info2;
	private String info3;
	private String info4;
	private String info5;
	private String info6;
	private String info7;
	private String info8;
	private String info9;
	private String info10;
	private String info11;
	private String info12;
	private String info13;
	
	private boolean detailDisplay;
	
	public String getInfo1() {
		return info1;
	}
	public void setInfo1(String info1) {
		this.info1 = info1;
	}
	public String getInfo2() {
		return info2;
	}
	public void setInfo2(String info2) {
		this.info2 = info2;
	}
	public String getInfo3() {
		return info3;
	}
	public void setInfo3(String info3) {
		this.info3 = info3;
	}
	public String getInfo4() {
		return info4;
	}
	public void setInfo4(String info4) {
		this.info4 = info4;
	}
	public String getInfo5() {
		return info5;
	}
	public void setInfo5(String info5) {
		this.info5 = info5;
	}
	public String getInfo6() {
		return info6;
	}
	public void setInfo6(String info6) {
		this.info6 = info6;
	}
	public String getInfo7() {
		return info7;
	}
	public void setInfo7(String info7) {
		this.info7 = info7;
	}
	public String getInfo8() {
		return info8;
	}
	public void setInfo8(String info8) {
		this.info8 = info8;
	}
	public String getInfo9() {
		return info9;
	}
	public void setInfo9(String info9) {
		this.info9 = info9;
	}
	public String getInfo10() {
		return info10;
	}
	public void setInfo10(String info10) {
		this.info10 = info10;
	}
	public String getInfo11() {
		return info11;
	}
	public void setInfo11(String info11) {
		this.info11 = info11;
	}
	public String getInfo12() {
		return info12;
	}
	public void setInfo12(String info12) {
		this.info12 = info12;
	}
	public String getInfo13() {
		return info13;
	}
	public void setInfo13(String info13) {
		this.info13 = info13;
	}
	public String getInfoCategory() {
		return infoCategory;
	}
	public void setInfoCategory(String infoCategory) {
		this.infoCategory = infoCategory;
	}
	public boolean isDetailDisplay() {
		return detailDisplay;
	}
	public void setDetailDisplay(boolean detailDisplay) {
		this.detailDisplay = detailDisplay;
	}
	public String getProductStock() {
		return productStock;
	}
	public void setProductStock(String productStock) {
		this.productStock = productStock;
	}
	public String getOrderStock() {
		return orderStock;
	}
	public void setOrderStock(String orderStock) {
		this.orderStock = orderStock;
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
	
	
	public String getBarCode() {
		return barCode;
	}
	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}
	public boolean getIsFreeDeliver() {
		return isFreeDeliver;
	}
	public void setIsFreeDeliver(boolean isFreeDeliver) {
		this.isFreeDeliver = isFreeDeliver;
	}
	public String getBrandNm() {
		return brandNm;
	}
	public void setBrandNm(String brandNm) {
		this.brandNm = brandNm;
	}
	public String[] getSizeOptStock() {
		return sizeOptStock;
	}
	public void setSizeOptStock(String[] sizeOptStock) {
		this.sizeOptStock = sizeOptStock;
	}
	public String[] getSizeOptName() {
		return sizeOptName;
	}
	public void setSizeOptName(String[] sizeOptName) {
		this.sizeOptName = sizeOptName;
	}	
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = StringUtil.replaceInt(originalPrice, ",", "");
	}
	public String getDealerPrice() {
		return dealerPrice;
	}
	public void setDealerPrice(String dealerPrice) {
		this.dealerPrice = StringUtil.replaceInt(dealerPrice, ",", "");
	}
	public String getRetailPrice() {
		return retailPrice;
	}
	public void setRetailPrice(String retailPrice) {
		this.retailPrice = StringUtil.replaceInt(retailPrice, ",", "");
	}
	public String getSellPrice() {
		return sellPrice;
	}
	public void setSellPrice(String sellPrice) {
		this.sellPrice = StringUtil.replaceInt(sellPrice, ",", "");
	}
	public String getDeliverPrice() {
		return deliverPrice;
	}
	public void setDeliverPrice(String deliverPrice) {
		this.deliverPrice = StringUtil.replaceInt(deliverPrice, ",", "");
	}
	public String getAddDeliverPrice() {
		return addDeliverPrice;
	}
	public void setAddDeliverPrice(String addDeliverPrice) {
		this.addDeliverPrice = StringUtil.replaceInt(addDeliverPrice, ",", "");
	}
	public boolean getFixedPrice() {
		return fixedPrice;
	}
	public void setFixedPrice(boolean fixedPrice) {
		this.fixedPrice = fixedPrice;
	}
	public String getSizeOpt() {
		return sizeOpt;
	}
	public void setSizeOpt(String sizeOpt) {
		this.sizeOpt = sizeOpt;
	}
	public String getProductOpt() {
		return productOpt;
	}
	public void setProductOpt(String productOpt) {
		this.productOpt = productOpt;
	}
	public String getColorOpt() {
		return colorOpt;
	}
	public void setColorOpt(String colorOpt) {
		this.colorOpt = colorOpt;
	}
	public String getStock() {
		return stock;
	}
	public void setStock(String stock) {
		this.stock = StringUtil.replaceInt(stock, ",", "");
	}
	public String getRealStock() {
		return realStock;
	}
	public void setRealStock(String realStock) {
		this.realStock = StringUtil.replaceInt(realStock, ",", "");
	}
	public String getCorpProductCode() {
		return corpProductCode;
	}
	public void setCorpProductCode(String corpProductCode) {
		this.corpProductCode = corpProductCode;
	}
	public String getSiteCode() {
		return siteCode;
	}
	public void setSiteCode(String siteCode) {
		this.siteCode = siteCode;
	}
	public String getOriginCountry() {
		return originCountry;
	}
	public void setOriginCountry(String originCountry) {
		this.originCountry = originCountry;
	}
	public String getEventOpt() {
		return eventOpt;
	}
	public void setEventOpt(String eventOpt) {
		this.eventOpt = eventOpt;
	}
	public String getPackageCode() {
		return packageCode;
	}
	public void setPackageCode(String packageCode) {
		this.packageCode = packageCode;
	}
	public String getMinusPrice() {
		return minusPrice;
	}
	public void setMinusPrice(String minusPrice) {
		this.minusPrice = StringUtil.replaceInt(minusPrice, ",", "");
	}
	public String getFamilyPrice() {
		return familyPrice;
	}
	public void setFamilyPrice(String familyPrice) {
		this.familyPrice = StringUtil.replaceInt(familyPrice, ",", "");
	}
	public String getMallPrice() {
		return mallPrice;
	}
	public void setMallPrice(String mallPrice) {
		this.mallPrice = StringUtil.replaceInt(mallPrice, ",", "");
	}
	public String getCategory1() {
		return category1;
	}
	public void setCategory1(String category1) {
		this.category1 = StringUtil.replaceInt(category1, ",", "");
	}
	public String getCategoryNm1() {
		return categoryNm1;
	}
	public void setCategoryNm1(String categoryNm1) {
		this.categoryNm1 = categoryNm1;
	}
	public String getCategory2() {
		return category2;
	}
	public void setCategory2(String category2) {
		this.category2 = StringUtil.replaceInt(category2, ",", "");
	}
	public String getCategoryNm2() {
		return categoryNm2;
	}
	public void setCategoryNm2(String categoryNm2) {
		this.categoryNm2 = categoryNm2;
	}
	public String getCategory3() {
		return category3;
	}
	public void setCategory3(String category3) {
		this.category3 = StringUtil.replaceInt(category3, ",", "");
	}
	public String getCategoryNm3() {
		return categoryNm3;
	}
	public void setCategoryNm3(String categoryNm3) {
		this.categoryNm3 = categoryNm3;
	}
	public String getCompanyCategory() {
		return companyCategory;
	}
	public void setCompanyCategory(String companyCategory) {
		this.companyCategory = companyCategory;
	}
	public String getBrandCategory() {
		return brandCategory;
	}
	public void setBrandCategory(String brandCategory) {
		this.brandCategory = brandCategory;
	}
	public boolean getFamilyNoDisplay() {
		return familyNoDisplay;
	}
	public void setFamilyNoDisplay(boolean familyNoDisplay) {
		this.familyNoDisplay = familyNoDisplay;
	}
	public boolean getDealerNoDisplay() {
		return dealerNoDisplay;
	}
	public void setDealerNoDisplay(boolean dealerNoDisplay) {
		this.dealerNoDisplay = dealerNoDisplay;
	}
	public boolean getMallNoDisplay() {
		return mallNoDisplay;
	}
	public void setMallNoDisplay(boolean mallNoDisplay) {
		this.mallNoDisplay = mallNoDisplay;
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
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	
	public String getDetailImageFile() {
		return detailImageFile;
	}
	public void setDetailImageFile(String detailImageFile) {
		this.detailImageFile = detailImageFile;
	}
	public String getTitleImageFile() {
		return titleImageFile;
	}
	public void setTitleImageFile(String titleImageFile) {
		this.titleImageFile = titleImageFile;
	}
	public String getCompanyLinkUrl() {
		return companyLinkUrl;
	}
	public void setCompanyLinkUrl(String companyLinkUrl) {
		this.companyLinkUrl = companyLinkUrl;
	}
	public String getProductOrderQySum() {
		return productOrderQySum;
	}
	public void setProductOrderQySum(String productOrderQySum) {
		this.productOrderQySum = productOrderQySum;
	}
	public String getStockOpt() {
		return stockOpt;
	}
	public void setStockOpt(String stockOpt) {
		this.stockOpt = stockOpt;
	}
	
	
}
