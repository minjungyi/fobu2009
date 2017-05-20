package main.java.fobu.admin.product.service;

import main.java.fobu.common.util.StringUtil;


/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class OpenMarketMarginVO {

	private String seq;
	private String product;
	private String originalPrice;
	private String familyPrice;
	private String companyCategory;
	private String sellPrice;	
	private boolean isFreeDeliver;
	private boolean fixedPrice;
	private String addDeliverPrice;
	private String category1;
	private String categoryNm1;
	private String category2;
	private String categoryNm2;
	private String category3;
	private String categoryNm3;
	private String corpProductCode;	
	private String companyLinkUrl;
	private String openSeq;
	private String uid;
	private String mallPrice;
	private String mallMarginRate;
	private String mallMarginPrice;
	private String marketType;
	private String shopCode;
	private String linkCode;
	private String url;
	private String relateShopCode;
	private String createDate;
	private String creater;
	private String modifyDate;
	private String modifier;
	private String fee;
	private String titleImageFile;
	private String detailImageFile;	
	private String tableName;
	private String startPrice;
	private String brandNm;
	private String hitCount;
	private String openStatus;
	
	private String couponSalePrice;
	private String couponSaleRate;
	
	public String getOpenStatus() {
		return openStatus;
	}
	public void setOpenStatus(String openStatus) {
		this.openStatus = openStatus;
	}
	public String getHitCount() {
		return hitCount;
	}
	public void setHitCount(String hitCount) {
		this.hitCount = hitCount;
	}
	public String getCorpProductCode() {
		return corpProductCode;
	}
	public void setCorpProductCode(String corpProductCode) {
		this.corpProductCode = corpProductCode;
	}
	public String getCompanyLinkUrl() {
		return companyLinkUrl;
	}
	public void setCompanyLinkUrl(String companyLinkUrl) {
		this.companyLinkUrl = companyLinkUrl;
	}
	public String getAddDeliverPrice() {
		return addDeliverPrice;
	}
	public void setAddDeliverPrice(String addDeliverPrice) {
		this.addDeliverPrice = addDeliverPrice;
	}
	public boolean getFixedPrice() {
		return fixedPrice;
	}
	public void setFixedPrice(boolean fixedPrice) {
		this.fixedPrice = fixedPrice;
	}
	public String getSellPrice() {
		return sellPrice;
	}
	public void setSellPrice(String sellPrice) {
		this.sellPrice = sellPrice;
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
	public String getStartPrice() {
		return startPrice;
	}
	public void setStartPrice(String startPrice) {
		this.startPrice = startPrice;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getRelateShopCode() {
		return relateShopCode;
	}
	public void setRelateShopCode(String relateShopCode) {
		this.relateShopCode = relateShopCode;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getCompanyCategory() {
		return companyCategory;
	}
	public void setCompanyCategory(String companyCategory) {
		this.companyCategory = companyCategory;
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
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
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
	public String getFamilyPrice() {
		return familyPrice;
	}
	public void setFamilyPrice(String familyPrice) {
		this.familyPrice = familyPrice;
	}
	public String getCategory1() {
		return category1;
	}
	public void setCategory1(String category1) {
		this.category1 = category1;
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
		this.category2 = category2;
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
		this.category3 = category3;
	}
	public String getCategoryNm3() {
		return categoryNm3;
	}
	public void setCategoryNm3(String categoryNm3) {
		this.categoryNm3 = categoryNm3;
	}
	public String getOpenSeq() {
		return openSeq;
	}
	public void setOpenSeq(String openSeq) {
		this.openSeq = openSeq;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getMallPrice() {
		return mallPrice;
	}
	public void setMallPrice(String mallPrice) {
		this.mallPrice = StringUtil.replaceInt(mallPrice, ",", "");
	}
	public String getMallMarginRate() {
		return mallMarginRate;
	}
	public void setMallMarginRate(String mallMarginRate) {
		this.mallMarginRate = StringUtil.replaceInt(mallMarginRate, ",", "");
	}
	public String getMallMarginPrice() {
		return mallMarginPrice;
	}
	public void setMallMarginPrice(String mallMarginPrice) {
		this.mallMarginPrice = StringUtil.replaceInt(mallMarginPrice, ",", "");
	}
	public String getMarketType() {
		return marketType;
	}
	public void setMarketType(String marketType) {
		this.marketType = marketType;
	}
	public String getShopCode() {
		return shopCode;
	}
	public void setShopCode(String shopCode) {
		this.shopCode = shopCode;
	}
	public String getLinkCode() {
		return linkCode;
	}
	public void setLinkCode(String linkCode) {
		this.linkCode = linkCode;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreater() {
		return creater;
	}
	public void setCreater(String creater) {
		this.creater = creater;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	
	public String getFee() {
		return fee;
	}
	public void setFee(String fee) {
		this.fee = fee;
	}
	public String getCouponSalePrice() {
		return couponSalePrice;
	}
	public void setCouponSalePrice(String couponSalePrice) {
		this.couponSalePrice = couponSalePrice;
	}
	public String getCouponSaleRate() {
		return couponSaleRate;
	}
	public void setCouponSaleRate(String couponSaleRate) {
		this.couponSaleRate = couponSaleRate;
	}
	
	
}
