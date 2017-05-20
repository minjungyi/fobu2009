package main.java.fobu.admin.product.service;


/**
 * 
 * 
 * @author min
 * @since 2010. 09. 10.
 */
public class ProductCompanyVO {

	private String seq;
	private String createDate;
	private String creator;
	private String company;
	private String stat;
	private String billYN;
	private String originalRate;
	private String dealerRate;
	private String familyRate;
	private String mallRate;
	private String companyLinkUrl;
	private String companyImageUrl;
	private String cnt;
	private String sellById;
	
	private boolean isFixedPrice;
	private boolean isFreeDeliver;
	
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getBillYN() {
		return billYN;
	}
	public void setBillYN(String billYN) {
		this.billYN = billYN;
	}
	
	public String getOriginalRate() {
		if(originalRate == null || originalRate.equals("")){
			return "0";
		}
		else{
			return originalRate;
		}
	}
	public void setOriginalRate(String originalRate) {
		this.originalRate = originalRate;
	}
	public String getDealerRate() {
		if(dealerRate == null || dealerRate.equals("")){
			return "0";
		}
		else{
			return dealerRate;
		}
	}
	public void setDealerRate(String dealerRate) {
		this.dealerRate = dealerRate;
	}
	public String getFamilyRate() {
		if(familyRate == null || familyRate.equals("")){
			return "0";
		}
		else{
			return familyRate;
		}
		
	}
	public void setFamilyRate(String familyRate) {
		this.familyRate = familyRate;
	}
	public String getMallRate() {
		if(mallRate == null || mallRate.equals("")){
			return "0";
		}
		else{
			return mallRate;
		}
	}
	public void setMallRate(String mallRate) {
		this.mallRate = mallRate;
	}
	
	public String getCompanyLinkUrl() {
		return companyLinkUrl;
	}
	public void setCompanyLinkUrl(String companyLinkUrl) {
		this.companyLinkUrl = companyLinkUrl;
	}

	public String getCompanyImageUrl() {
		return companyImageUrl;
	}
	public void setCompanyImageUrl(String companyImageUrl) {
		this.companyImageUrl = companyImageUrl;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getSellById() {
		return sellById;
	}
	public void setSellById(String sellById) {
		this.sellById = sellById;
	}
	public boolean getIsFixedPrice() {
		return isFixedPrice;
	}
	public void setIsFixedPrice(boolean isFixedPrice) {
		this.isFixedPrice = isFixedPrice;
	}
	public boolean isFreeDeliver() {
		return isFreeDeliver;
	}
	public void setFreeDeliver(boolean isFreeDeliver) {
		this.isFreeDeliver = isFreeDeliver;
	}
	
	
}
