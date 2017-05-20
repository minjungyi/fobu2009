package main.java.fobu.admin.product.service.impl;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import main.java.fobu.admin.product.service.EnterpriseOrderVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.ProductBrandVO;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductListVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.admin.product.service.ProductSizeOptVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.UserVO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;


/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class ProductServiceImpl implements ProductService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "productDAO")
	private ProductDAO productDAO;
	
	@Resource(name = "shopManagerDAO")
	private ShopManagerDAO shopManagerDAO;
	
	@Resource(name = "productStockDAO")
	private ProductStockDAO productStockDAO;
	
	@Resource(name = "enterpriseOrderDAO")
	private EnterpriseOrderDAO enterpriseOrderDAO;
	
	@Resource(name = "productBrandDAO")
	private ProductBrandDAO productBrandDAO;
	
	@Resource(name = "productCategoryDAO")
	private ProductCategoryDAO productCategoryDAO;
	
	/**
	 * The Constructor
	 */
	public ProductServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@Override
	@Transactional(rollbackFor=Exception.class,propagation=Propagation.REQUIRED)
	public int saveProduct(ProductVO product, List<CommonFileVO> fileBeanList) throws SQLException {		
		
		try{
			UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
			
			if(fileBeanList != null){
				product.setTitleImageFile(fileBeanList.get(0).getFileName());
				product.setDetailImageFile(fileBeanList.get(1).getFileName());			    
			}			
			
			product.setCreator(userInfo.getUserId());
			productDAO.saveProduct(product);
			
			if(product.getSizeOptStock() != null){
				for(int j=0;j<product.getSizeOptStock().length ;j++){
					ProductSizeOptVO productSizeOpt = new ProductSizeOptVO();
					
					productSizeOpt.setSizeOpt(product.getSizeOptName()[j]);
					productSizeOpt.setSizeOptStock(product.getSizeOptStock()[j]);
					productSizeOpt.setuSeq(product.getSeq());
					productDAO.saveProductSizeOpt(productSizeOpt);
				}
			}
			
			
			for(int i = 0 ;i < 5;i++){
				OpenMarketMarginVO openMarketMargin = new OpenMarketMarginVO();
				String marketType = "";
				
				if(i==0)
					marketType="aut";
				else if(i==1)
					marketType="itp";
				else if(i==2)
					marketType="cyw";
				else if(i==3)
					marketType="gmk";
				else
					marketType="shn";
				
				openMarketMargin.setUid(product.getSeq());
				openMarketMargin.setMarketType(marketType);
				openMarketMargin.setShopCode("0");
				openMarketMargin.setMallPrice("0");
				openMarketMargin.setMallMarginRate("0");
				openMarketMargin.setCreater(userInfo.getUserId());
				openMarketMargin.setTableName("fb_openmarket_margin_choco");
				shopManagerDAO.saveOpenMarketMargin(openMarketMargin);				
				
				openMarketMargin.setTableName("fb_openmarket_margin_fobu");
				shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
				
				openMarketMargin.setTableName("fb_openmarket_margin_good");
				shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
				
				openMarketMargin.setTableName("fb_openmarket_margin_min");
				shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
				
				openMarketMargin.setTableName("fb_openmarket_margin_tmin");
				shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
				// 한번만 처리하기 위해...
				if(i==0){
					openMarketMargin.setMarketType("sun");
					openMarketMargin.setTableName("fb_openmarket_margin_sun");
					shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
				}
				
			}
			
		}catch(Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return -1;
		}
		return Integer.parseInt(product.getSeq());
	}
	
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public int updateProduct(ProductVO product, List<CommonFileVO> fileBeanList) throws SQLException {		
		
		try{
			UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
			
			if(fileBeanList != null){
				product.setTitleImageFile(fileBeanList.get(0).getFileName());
				product.setDetailImageFile(fileBeanList.get(1).getFileName());			    
			}
			product.setModifier(userInfo.getLoginId());
			productDAO.updateProduct(product);
			
			Map<String,String> paramMap = new HashMap<String, String>();
			paramMap.put("uSeq", product.getSeq());
			
			if(product.getSizeOptStock() != null){
				productStockDAO.deleteProductStock(paramMap);
				
				for(int j=0;j<product.getSizeOptStock().length ;j++){
					ProductSizeOptVO productSizeOpt = new ProductSizeOptVO();
					
					productSizeOpt.setSizeOpt(product.getSizeOptName()[j]);
					productSizeOpt.setSizeOptStock(product.getSizeOptStock()[j]);
					productSizeOpt.setuSeq(product.getSeq());
					productDAO.saveProductSizeOpt(productSizeOpt);
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return Integer.parseInt(product.getSeq());
	}
	
	@Override
	public int updateProductList(ProductListVO productList) throws SQLException {	
		try{
			UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
			
			for(int i = 0 ; i < productList.getSeq().length ; i++){
				if(productList.getCheckbox()[i].toString().equals("true")){
					ProductVO product = new ProductVO();					
					
					//product.setRealStock(productList.getRealStock()[i].toString());
					product.setOriginalPrice(productList.getOriginalPrice()[i].toString());
					product.setFamilyPrice(productList.getFamilyPrice()[i].toString());
					product.setSellPrice(productList.getSellPrice()[i].toString());
					product.setRetailPrice(productList.getRetailPrice()[i].toString());
					product.setCompanyCategory(productList.getCompanyCategory()[i].toString());
					product.setStatus(productList.getStatus()[i].toString());
					product.setSeq(productList.getSeq()[i].toString());
					product.setCategory1(productList.getCategory1()[i].toString());
					product.setCategory2(productList.getCategory2()[i].toString());
					product.setCategory3(productList.getCategory3()[i].toString());
					
					Map<String,String> paramMap = new HashMap<String, String>();
					paramMap.put("category", productList.getCategory2()[i].toString());
					paramMap.put("code", productList.getCategory3()[i].toString());
					List<ProductCategoryVO> listCategory = productCategoryDAO.listCategory(paramMap);
					String infoCate = "-1";
					if(listCategory.size() == 1){
						infoCate = listCategory.get(0).getAttrExt1();
					}
					product.setInfoCategory(infoCate);
					product.setCorpProductCode(productList.getCorpProductCode()[i].toString());
					product.setModifier(userInfo.getLoginId());
					
					productDAO.updateProductList(product);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@Override
	public int updateProductList2(ProductListVO productList) throws SQLException {	
		try{
			UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
			
			for(int i = 0 ; i < productList.getSeq().length ; i++){
				if(productList.getCheckbox()[i].toString().equals("true")){
					ProductVO product = new ProductVO();					
					
					/*product.setSeq(productList.getSeq()[i].toString());
					product.setdSize(productList.getdSize()[i].toString());
					product.setSizeOpt(productList.getSizeOpt()[i].toString());
					product.setdMaterial(productList.getdMaterial()[i].toString());
					product.setdManufacturer(productList.getdManufacturer()[i].toString());
					product.setdManufacturerCountry(productList.getdManufacturerCountry()[i].toString());
					product.setdUseAge(productList.getdUseAge()[i].toString());
					product.setdMadeDate(productList.getdMadeDate()[i].toString());
					product.setdKCcert(productList.getdKCcert()[i].toString());
					product.setdGuarantee(productList.getdGuarantee()[i].toString());
					product.setdNotice(productList.getdNotice()[i].toString());
					product.setdDescription(productList.getdDescription()[i].toString());
					product.setdASManager(productList.getdASManager()[i].toString());
					product.setDetailDisplay(productList.getDetailDisplay()[i]);					
					product.setModifier(userInfo.getLoginId());*/
					
					productDAO.updateProductList2(product);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@Override
	public int insertEnterpriseOrderList(ProductListVO productList) throws SQLException {	
		try{
			UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");			
			String nowDate = dateFormat.format(cal.getTime());
			
			for(int i = 0 ; i < productList.getSeq().length ; i++){
				if(productList.getCheckbox()[i].toString().equals("true")){
					EnterpriseOrderVO enterprise = new EnterpriseOrderVO();	
					
					enterprise.setProductSeq(productList.getSeq()[i].toString());
					enterprise.setEnterpriseOrderQy(productList.getEnterpriseOrderQy()[i].toString());
					enterprise.setEnterpriseOrderTarget("0002");
					enterprise.setEnterpriseOrderStatus("0001");
					enterprise.setCreator(userInfo.getUserId());
					enterprise.setOrderDate(nowDate);
					
					int itemCnt = enterpriseOrderDAO.listDupOrder(productList.getSeq()[i].toString());
					if(itemCnt > 0){
						enterpriseOrderDAO.addEnterpriseOrderQy(enterprise);
					}
					else{
						enterpriseOrderDAO.insertEnterpriseOrder(enterprise);
					}
					
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@Override
	public List<ProductCompanyVO> listCompany(Map paramMap) throws SQLException {
		List<ProductCompanyVO> listCategory = productDAO.listCompany(paramMap);
		return listCategory;
	}
		
	@Override
	public int listProductCount(Map paramMap) throws SQLException {
		int listProductCount = productDAO.listProductCount(paramMap);
		return listProductCount;
	}
	
	@Override
	public List<ProductVO> listProduct(Map paramMap) throws SQLException {		
		List<ProductVO> listProduct = productDAO.listProduct(paramMap);
		return listProduct;
	}
	
	
	@Override
	public List<ProductVO> listProductDetail(String seq) throws SQLException {
		List<ProductVO> listProductDetail = productDAO.listProductDetail(seq);
		return listProductDetail;
	}
	
	@Override
	public int getProductLastSeq() throws SQLException {
		int seq = productDAO.getProductLastSeq();
		return seq;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(rollbackFor=Exception.class,propagation=Propagation.REQUIRED)
	public int saveNewProductExcel(Map paramMap, CommonFileVO fileBean, String path) throws SQLException {
		System.out.println("fileBean.getFileName()====!!!!========>"+fileBean.getFileName());
    	Workbook workbook = null;
    	
		try {
			workbook = Workbook.getWorkbook(new File(path+"/"+fileBean.getFileName()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	Sheet sheet = workbook.getSheet(0);
    	int col = sheet.getColumns();
    	//System.out.println("col============>"+col);
    	int row = sheet.getRows();
    	//System.out.println("row============>"+row);
    	
    	UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
    	
    	try{
			for(int i = 1; i < row; i++){
				
				Cell cell[] = sheet.getRow(i);
				
				ProductVO productVO = new ProductVO();
				 productVO.setProduct(cell[0].getContents());
				 productVO.setColorOpt(cell[1].getContents());
				 productVO.setRetailPrice(cell[2].getContents());
				 productVO.setSellPrice(cell[3].getContents());
				 productVO.setMallPrice(cell[3].getContents());
				 productVO.setFamilyPrice(cell[4].getContents());
				 productVO.setOriginalPrice(cell[5].getContents());
				 
				 paramMap.put("brandNm", cell[6].getContents());
				 List<ProductBrandVO> productBrandList = null;
				 String brandCode = "-1";
				 productBrandList = productBrandDAO.selectBrandDetail(paramMap);
				 if(productBrandList.size() > 0){
					 brandCode = productBrandList.get(0).getCode();
				 }
				 
				 productVO.setBrandCategory(brandCode);
				 
				 productVO.setOriginCountry(cell[7].getContents());
				 productVO.setCorpProductCode(cell[8].getContents());
				 //String
				 Boolean fixedPrice = false;
				 if(cell[9].getContents().equals("고정가")){
					 fixedPrice = true;
				 }
				 productVO.setFixedPrice(fixedPrice);
				 productVO.setCompanyCategory(cell[10].getContents());
				 
				 int seq = getProductLastSeq();
				 productVO.setSeq(Integer.toString(seq));
				 productVO.setStatus("001");
				 productVO.setRemark("");
				 productVO.setDealerPrice("");
				 productVO.setDeliverPrice("2500");
				 productVO.setAddDeliverPrice("0");
				 productVO.setSizeOpt("");
				 productVO.setProductOpt("");
				 productVO.setStock("999");
				 productVO.setRealStock("0");
				 //productVO.setSiteCode("");
				 productVO.setEventOpt("");
				 productVO.setPackageCode("");
				 productVO.setMinusPrice("");
				 productVO.setCategory1("-1");
				 productVO.setCategory2("-1");
				 productVO.setCategory3("-1");
				 productVO.setFamilyNoDisplay(false);
				 productVO.setDealerNoDisplay(false);
				 productVO.setTitleImageFile("");
				 productVO.setDetailImageFile("");
				 productVO.setIsFreeDeliver(false);
				 productVO.setBarCode("");
				 productVO.setInfo1("");
				 productVO.setInfo2("");
				 productVO.setInfo3("");
				 productVO.setInfo4("");
				 productVO.setInfo5("");
				 productVO.setInfo6("");
				 productVO.setInfo7("");
				 productVO.setInfo8("");
				 productVO.setInfo9("");
				 productVO.setInfo10("");
				 productVO.setInfo11("");
				 productVO.setInfo12("");
				 productVO.setInfo13("");
				 productVO.setInfoCategory("-1");
				 productVO.setDetailDisplay(false);
				
				 //saveProduct(productVO,null);		
				 productVO.setCreator(userInfo.getUserId());
				 productDAO.saveProduct(productVO);
					
				for(int j = 0 ;j < 5;j++){
					OpenMarketMarginVO openMarketMargin = new OpenMarketMarginVO();
					String marketType = "";
					
					if(j==0)
						marketType="aut";
					else if(j==1)
						marketType="itp";
					else if(j==2)
						marketType="cyw";
					else if(j==3)
						marketType="gmk";
					else
						marketType="shn";
					
					openMarketMargin.setUid(productVO.getSeq());
					openMarketMargin.setMarketType(marketType);
					openMarketMargin.setShopCode("0");
					openMarketMargin.setMallPrice("0");
					openMarketMargin.setMallMarginRate("0");
					openMarketMargin.setCreater(userInfo.getUserId());
					openMarketMargin.setTableName("fb_openmarket_margin_choco");
					shopManagerDAO.saveOpenMarketMargin(openMarketMargin);				
					
					openMarketMargin.setTableName("fb_openmarket_margin_fobu");
					shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
					
					openMarketMargin.setTableName("fb_openmarket_margin_good");
					shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
					
					openMarketMargin.setTableName("fb_openmarket_margin_min");
					shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
					
					openMarketMargin.setTableName("fb_openmarket_margin_tmin");
					shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
					// 한번만 처리하기 위해...
					if(j==0){
						openMarketMargin.setMarketType("sun");
						openMarketMargin.setTableName("fb_openmarket_margin_sun");
						shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
					}
					
				}
			
			}
    	}catch(Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
}
