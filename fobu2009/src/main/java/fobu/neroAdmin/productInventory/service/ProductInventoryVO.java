package main.java.fobu.neroAdmin.productInventory.service;


/**
 * 
 * 
 * @author min™
 * @since 2012. 04. 10.
 */
public class ProductInventoryVO {

	private String companySeq;			//거래처Seq
	private String companyName;			//거래처명
	private String companyNumber;		//거래처사업자번호
	private String companyContactPersn;	//거래처담당자
	private String companyTelNo;		//거래처전화번호
	private String companyFaxNo;		//거래처팩스번호
	private String companyAddr;			//거래서주소
	private String inventorySeq;		//재고Seq
	private String productSeq;			//제품Seq
	private int inventoryCnt;			//재고수량
	private String productName;			//제품명
	private String productBarcode;		//제품바코드
	private String productManufacture;	//제품제조사	
	private String createDt;			//등록일
	private String creator;			    //등록자
	private String modifyDt;			//수정일
	private String modifiers;			//수정자
	private int productPrice;			//재고수량
	private String inventoryDate;		//재고일자
	private String saleType;			//판매타입
	
	public String getCompanySeq() {
		return companySeq;
	}
	public void setCompanySeq(String companySeq) {
		this.companySeq = companySeq;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCompanyNumber() {
		return companyNumber;
	}
	public void setCompanyNumber(String companyNumber) {
		this.companyNumber = companyNumber;
	}
	public String getCompanyContactPersn() {
		return companyContactPersn;
	}
	public void setCompanyContactPersn(String companyContactPersn) {
		this.companyContactPersn = companyContactPersn;
	}
	public String getCompanyTelNo() {
		return companyTelNo;
	}
	public void setCompanyTelNo(String companyTelNo) {
		this.companyTelNo = companyTelNo;
	}
	public String getCompanyFaxNo() {
		return companyFaxNo;
	}
	public void setCompanyFaxNo(String companyFaxNo) {
		this.companyFaxNo = companyFaxNo;
	}
	public String getCompanyAddr() {
		return companyAddr;
	}
	public void setCompanyAddr(String companyAddr) {
		this.companyAddr = companyAddr;
	}
	public String getInventorySeq() {
		return inventorySeq;
	}
	public void setInventorySeq(String inventorySeq) {
		this.inventorySeq = inventorySeq;
	}
	public String getProductSeq() {
		return productSeq;
	}
	public void setProductSeq(String productSeq) {
		this.productSeq = productSeq;
	}
	public int getInventoryCnt() {
		return inventoryCnt;
	}
	public void setInventoryCnt(int inventoryCnt) {
		this.inventoryCnt = inventoryCnt;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductBarcode() {
		return productBarcode;
	}
	public void setProductBarcode(String productBarcode) {
		this.productBarcode = productBarcode;
	}
	public String getProductManufacture() {
		return productManufacture;
	}
	public void setProductManufacture(String productManufacture) {
		this.productManufacture = productManufacture;
	}
	public String getCreateDt() {
		return createDt;
	}
	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getModifyDt() {
		return modifyDt;
	}
	public void setModifyDt(String modifyDt) {
		this.modifyDt = modifyDt;
	}
	public String getModifiers() {
		return modifiers;
	}
	public void setModifiers(String modifiers) {
		this.modifiers = modifiers;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setInventoryDate(String inventoryDate) {
		this.inventoryDate = inventoryDate;
	}
	public String getInventoryDate() {
		return inventoryDate;
	}
	public String getSaleType() {
		return saleType;
	}
	public void setSaleType(String saleType) {
		this.saleType = saleType;
	}
}
