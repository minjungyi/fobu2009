package main.java.fobu.admin.product.service.impl;
 
import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import main.java.fobu.admin.product.service.NewShopProductListVO;
import main.java.fobu.admin.product.service.NewShopProductVO;
import main.java.fobu.admin.product.service.NewShopProductService;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.Constant;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;



/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class NewShopProductServiceImpl implements NewShopProductService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "newShopProductDAO")
	private NewShopProductDAO newShopProductDAO;
	
	/**
	 * The Constructor
	 */
	public NewShopProductServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	/**
	 * 대형몰 신제품 관리 정보 조회하기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<NewShopProductVO> listNewShopProduct(Map paramMap) throws SQLException {
		
		List<NewShopProductVO> listNewShopProduct = newShopProductDAO.listNewShopProduct(paramMap);
		return listNewShopProduct;
	}
	
	/**
	 * 대형몰 신제품 관리 정보 갯수 조회하기
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int listNewShopProductCount(Map paramMap) throws SQLException {
		
		int listNewShopProductCNT = newShopProductDAO.listNewShopProductCount(paramMap);
		return listNewShopProductCNT;
	}
	
	/**
	 * 대형몰 신제품 관리 브랜드 매핑
	 */
	@SuppressWarnings("unchecked")
	@Override
	@Transactional(propagation=Propagation.REQUIRED)
	public int updateNewShopBrandList(NewShopProductListVO newShopProductList,Map paramMap) throws SQLException {		
		
		try{
			for(int i = 0 ;i < newShopProductList.getCheckbox().length ; i++){
				if(newShopProductList.getCheckbox()[i].toString().equals("true")){
					ProductVO product = new ProductVO();
					product.setSeq(newShopProductList.getUid()[i].toString());
					product.setProduct(newShopProductList.getProduct()[i].toString());					
					if(!paramMap.get("brandCategory2").toString().equals("0")){
						product.setBrandCategory(paramMap.get("brandCategory2").toString());
					}else{
						product.setBrandCategory(newShopProductList.getBrandCategory()[i].toString());
					}
					
					newShopProductDAO.updateNewShopBrandList(product);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<NewShopProductVO> listExcelNewProduct(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		paramMap.put("userId", userInfo.getUserId());
		List<NewShopProductVO> listNewShopProduct = newShopProductDAO.listExcelNewProduct(paramMap);	
		
		for(int i=0;i<listNewShopProduct.size();i++){
			//String detailHtml = Constant.excelDetailHtml05;
			String detailHtml = Constant.excelDetailHtml;
			
			if(listNewShopProduct.get(i).getMarketType().equals("aut") || 
					listNewShopProduct.get(i).getMarketType().equals("gmk"))
			{
				detailHtml = Constant.excelDetailHtml2;
			}
			// {0}:detailImageFile, {1}:id, {2}:category1, {3}:category2,{4}:marketType			
			detailHtml = StringUtil.replace(detailHtml, "{0}", listNewShopProduct.get(i).getDetailImageFile());
			detailHtml = StringUtil.replace(detailHtml, "{1}", userInfo.getUserId()); 
			detailHtml = StringUtil.replace(detailHtml, "{2}", listNewShopProduct.get(i).getCategory1()); 
			detailHtml = StringUtil.replace(detailHtml, "{3}", listNewShopProduct.get(i).getCategory2()); 
			detailHtml = StringUtil.replace(detailHtml, "{4}", listNewShopProduct.get(i).getMarketType());
			detailHtml = StringUtil.replace(detailHtml, "{5}", listNewShopProduct.get(i).getSeq()); 
			detailHtml = StringUtil.replace(detailHtml, "{99}", listNewShopProduct.get(i).getCompanyCategory());
			
			listNewShopProduct.get(i).setSizeOpt(StringUtil.replace(listNewShopProduct.get(i).getSizeOpt(),"|",","));
			listNewShopProduct.get(i).setColorOpt(StringUtil.replace(listNewShopProduct.get(i).getColorOpt(),"|",","));
			listNewShopProduct.get(i).setDetailHtml(detailHtml);
			//listNewShopProduct.get(i).setProduct("["+listNewShopProduct.get(i).getBrandNm()+"]"+listNewShopProduct.get(i).getProduct());
		}
		return listNewShopProduct;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<NewShopProductVO> listExcelNewChocoMall(Map paramMap) throws SQLException {
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		paramMap.put("table", "fb_openmarket_margin_"+userInfo.getUserId());
		paramMap.put("userId", userInfo.getUserId());
		List<NewShopProductVO> listNewShopProduct = newShopProductDAO.listExcelNewProduct(paramMap);	
		
		for(int i=0;i<listNewShopProduct.size();i++){
			//String detailHtml = Constant.excelDetailHtml05;
			String detailHtml = Constant.excelDetailHtml;
			String chocoDetailHtml = Constant.chocoDetailHtml;
			
			if(listNewShopProduct.get(i).getMarketType().equals("aut") || 
					listNewShopProduct.get(i).getMarketType().equals("gmk") ||
					listNewShopProduct.get(i).getMarketType().equals("sun"))
			{
				detailHtml = Constant.excelDetailHtml2;
			}
			// {0}:detailImageFile, {1}:id, {2}:category1, {3}:category2,{4}:marketType			
			detailHtml = StringUtil.replace(detailHtml, "{0}", listNewShopProduct.get(i).getDetailImageFile());
			detailHtml = StringUtil.replace(detailHtml, "{1}", userInfo.getUserId()); 
			detailHtml = StringUtil.replace(detailHtml, "{2}", listNewShopProduct.get(i).getCategory1()); 
			detailHtml = StringUtil.replace(detailHtml, "{3}", listNewShopProduct.get(i).getCategory2()); 
			detailHtml = StringUtil.replace(detailHtml, "{4}", listNewShopProduct.get(i).getMarketType());
			detailHtml = StringUtil.replace(detailHtml, "{5}", listNewShopProduct.get(i).getSeq()); 
			detailHtml = StringUtil.replace(detailHtml, "{99}", listNewShopProduct.get(i).getCompanyCategory());
						
			listNewShopProduct.get(i).setSizeOpt(StringUtil.replace(listNewShopProduct.get(i).getSizeOpt(),"|",","));
			listNewShopProduct.get(i).setColorOpt(StringUtil.replace(listNewShopProduct.get(i).getColorOpt(),"|",","));
			listNewShopProduct.get(i).setDetailHtml(detailHtml);
			
			chocoDetailHtml = StringUtil.replace(chocoDetailHtml, "{0}", listNewShopProduct.get(i).getSeq());
			listNewShopProduct.get(i).setChocoDetailHtml(chocoDetailHtml);
			//listNewShopProduct.get(i).setProduct("["+listNewShopProduct.get(i).getBrandNm()+"]"+listNewShopProduct.get(i).getProduct());
		}
		return listNewShopProduct;
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public void updateRelateOpenMarket(Map paramMap, CommonFileVO fileBean, String path) throws SQLException {
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
    	
		for(int i = 8; i < row; i++){
			//System.out.println("파일 시크 읽기 시작");
			Cell cell[] = sheet.getRow(i);
			//System.out.println("종료");
			OpenMarketMarginVO openMarketMarginVO = new OpenMarketMarginVO();
			
			//openMarketMarginVO.setTableName("fb_openmarket_margin_"+userInfo.getUserId());
			//openMarketMarginVO.setTableName(getOpenMarketMarginTable(cell[48].getContents()));
			openMarketMarginVO.setTableName(getOpenMarketMarginTable(cell[51].getContents()));
			openMarketMarginVO.setShopCode(cell[0].getContents().replace("'", ""));
			openMarketMarginVO.setLinkCode(cell[1].getContents());	
			openMarketMarginVO.setUid(cell[2].getContents().replace("'", ""));					
			//String marketType = cell[46].getContents();
			//openMarketMarginVO.setUrl(cell[47].getContents());
			String marketType = cell[49].getContents();
			openMarketMarginVO.setUrl(cell[50].getContents());
			String marketTypeTmp = "";
			if(marketType.indexOf("지마켓") > -1){
				marketTypeTmp = "gmk";
			}else if(marketType.indexOf("옥션") > -1 ){
				marketTypeTmp = "aut";
			}else if(marketType.indexOf("11번가") > -1 ){
				marketTypeTmp = "cyw";
			}else if(marketType.indexOf("샵N") > -1 || marketType.indexOf("스토어팜") > -1  ){
				marketTypeTmp = "shn";
			}else if(marketType.indexOf("인터파크") > -1 ){
				marketTypeTmp = "itp";
			}else if(marketType.indexOf("초코팝") > -1 ){
				marketTypeTmp = "sun";
			}
			
			openMarketMarginVO.setMarketType(marketTypeTmp);
			openMarketMarginVO.setModifier(userInfo.getUserId());
			newShopProductDAO.updateRelateOpenMarket(openMarketMarginVO);
		}
	}
	
	private String getOpenMarketMarginTable(String relationId){
		String returnTable = "";
		
		if((relationId.indexOf("newsun76") > -1) || (relationId.indexOf("fobu2009") > -1)){
			returnTable = "fb_openmarket_margin_fobu";
		}else if((relationId.indexOf("chocofl") > -1) || (relationId.indexOf("fobu2010") > -1) || (relationId.indexOf("choco") > -1)){
			returnTable = "fb_openmarket_margin_choco";
		}else if((relationId.indexOf("mintwin") > -1) || (relationId.indexOf("mintwin79") > -1)){
			returnTable = "fb_openmarket_margin_min";
		}else if((relationId.indexOf("rewcta") > -1) || (relationId.indexOf("goodfather23") > -1)|| (relationId.indexOf("father23") > -1)){
			returnTable = "fb_openmarket_margin_good";
		}else if((relationId.indexOf("onemins") > -1) || (relationId.indexOf("onemins79") > -1)|| (relationId.indexOf("twinmall") > -1)){
			returnTable = "fb_openmarket_margin_tmin";
		}else{
			returnTable = "fb_openmarket_margin_sun";
		}
		
		return returnTable;
	}
	
}
