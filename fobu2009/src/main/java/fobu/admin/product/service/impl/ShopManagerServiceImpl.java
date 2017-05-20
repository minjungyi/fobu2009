package main.java.fobu.admin.product.service.impl;

import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import main.java.fobu.admin.product.service.DummySoldoutVO;
import main.java.fobu.admin.product.service.OpenMarketMarginListVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ShopManagerService;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.service.UserVO;
import main.java.fobu.common.util.StringUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;



/**
 * TotalOrder Service Implementation
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Service
public class ShopManagerServiceImpl implements ShopManagerService {
	
	// Logger
	private Log logger;
	
	@Resource(name = "shopManagerDAO")
	private ShopManagerDAO shopManagerDAO;
	
	/**
	 * The Constructor
	 */
	public ShopManagerServiceImpl() {
		logger = LogFactory.getLog(this.getClass());
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<OpenMarketMarginVO> listOpenMarketMargin(Map paramMap) throws SQLException {
				
		List<OpenMarketMarginVO> listOpenMarketMargin = shopManagerDAO.listOpenMarketMargin(paramMap);
		return listOpenMarketMargin;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public int listOpenMarketMarginCount(Map paramMap) throws SQLException {
		
		if(paramMap.get("face").equals("new")){
			paramMap.put("new", "Y");
		}
		else if(paramMap.get("face").equals("status")){
			paramMap.put("status", "Y");
		}
		int listProductCount = shopManagerDAO.listOpenMarketMarginCount(paramMap);
		return listProductCount;
	}
	
	@Override
	public int updateOpenMarketMarginList(OpenMarketMarginListVO openMarketMarginList) throws SQLException {		
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		try{
			for(int i = 0 ;i < openMarketMarginList.getCheckbox().length ; i++){
				if(openMarketMarginList.getCheckbox()[i].toString().equals("true")){
					OpenMarketMarginVO openMarketMargin = new OpenMarketMarginVO();
					
					//openMarketMargin.setOpenSeq(openMarketMarginList.getOpenSeq()[i].toString());
					openMarketMargin.setUid(openMarketMarginList.getUid()[i].toString());
					openMarketMargin.setMallPrice(openMarketMarginList.getMallPrice()[i].toString());
					openMarketMargin.setMallMarginRate(openMarketMarginList.getMallMarginRate()[i].toString());
					openMarketMargin.setMallMarginPrice(openMarketMarginList.getMallMarginPrice()[i].toString());
					openMarketMargin.setMarketType(openMarketMarginList.getMarketType()[0].toString());
					openMarketMargin.setOpenSeq(openMarketMarginList.getOpenSeq()[i].toString());					
					openMarketMargin.setShopCode("0");
					openMarketMargin.setCreater(userInfo.getUserId());
					openMarketMargin.setModifier(userInfo.getUserId());
					
					openMarketMargin.setCouponSalePrice(openMarketMarginList.getCouponSalePrice()[i].toString());
					openMarketMargin.setCouponSaleRate(openMarketMarginList.getCouponSaleRate()[i].toString());
					
					if(userInfo.getLoginId().equals("sun")){
						openMarketMargin.setTableName("fb_openmarket_margin_sun");
						Object obj = shopManagerDAO.checkOpenMarketSeq(openMarketMargin);
						if(obj != null) {
							openMarketMargin.setOpenSeq(obj.toString());
							shopManagerDAO.updateOpenMarketMargin(openMarketMargin);						
						}else{
							shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
						}	
					}else{
						openMarketMargin.setTableName("fb_openmarket_margin_choco");
						Object obj = shopManagerDAO.checkOpenMarketSeq(openMarketMargin);
						if(obj != null) {
							openMarketMargin.setOpenSeq(obj.toString());
							shopManagerDAO.updateOpenMarketMargin(openMarketMargin);						
						}else{
							shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
						}			
						
						openMarketMargin.setTableName("fb_openmarket_margin_fobu");
						obj = shopManagerDAO.checkOpenMarketSeq(openMarketMargin);
						if(obj != null) {
							openMarketMargin.setOpenSeq(obj.toString());
							shopManagerDAO.updateOpenMarketMargin(openMarketMargin);						
						}else{
							shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
						}
						
						openMarketMargin.setTableName("fb_openmarket_margin_good");
						obj = shopManagerDAO.checkOpenMarketSeq(openMarketMargin);
						if(obj != null) {
							openMarketMargin.setOpenSeq(obj.toString());
							shopManagerDAO.updateOpenMarketMargin(openMarketMargin);						
						}else{
							shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
						}
						
						openMarketMargin.setTableName("fb_openmarket_margin_min");
						obj = shopManagerDAO.checkOpenMarketSeq(openMarketMargin);
						if(obj != null) {
							openMarketMargin.setOpenSeq(obj.toString());
							shopManagerDAO.updateOpenMarketMargin(openMarketMargin);						
						}else{
							shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
						}
						
						openMarketMargin.setTableName("fb_openmarket_margin_tmin");
						obj = shopManagerDAO.checkOpenMarketSeq(openMarketMargin);
						if(obj != null) {
							openMarketMargin.setOpenSeq(obj.toString());
							shopManagerDAO.updateOpenMarketMargin(openMarketMargin);						
						}else{
							shopManagerDAO.saveOpenMarketMargin(openMarketMargin);
						}
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	/**
	 * 오픈마켓 추천리스트 목록(Iframe)
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<OpenMarketMarginVO> listRecommendOpenMarket(Map paramMap) throws SQLException {
				
		List<ProductCategoryVO> listOpenMarketMarginCategory = shopManagerDAO.listRecommendOpenMarketCategory(paramMap);
		
		paramMap.put("cate2one", "-1");
		paramMap.put("cate2two", "-1");
		paramMap.put("cate2three", "-1");
		paramMap.put("cate2four", "-1");
		
		for(int i = 0 ; i<listOpenMarketMarginCategory.size();i++){
			if(i==0){
				paramMap.put("cate2one", listOpenMarketMarginCategory.get(0).getCode());
			}else if(i==1){
				paramMap.put("cate2two", listOpenMarketMarginCategory.get(1).getCode());
			}else if(i==2){
				paramMap.put("cate2three", listOpenMarketMarginCategory.get(2).getCode());
			}else if(i==3){
				paramMap.put("cate2four", listOpenMarketMarginCategory.get(3).getCode());
			}
		}
		
		List<OpenMarketMarginVO> listOpenMarketMargin = shopManagerDAO.listRecommendOpenMarket(paramMap);		
		
		
		return listOpenMarketMargin;
	}
	
	/**
	 * 오픈마켓 추천리스트 목록(Iframe)
	 * @param paramMap
	 * @return
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<OpenMarketMarginVO> listRecommendOpenMarket2(Map paramMap) throws SQLException {
				
		shopManagerDAO.updateOpenMarketHitCount(paramMap);
		List<ProductCategoryVO> listOpenMarketMarginCategory = shopManagerDAO.listRecommendOpenMarketCategory(paramMap);
		
		paramMap.put("cate2one", "-1");
		paramMap.put("cate2two", "-1");
		paramMap.put("cate2three", "-1");
		paramMap.put("cate2four", "-1");
		
		for(int i = 0 ; i<listOpenMarketMarginCategory.size();i++){
			if(i==0){
				paramMap.put("cate2one", listOpenMarketMarginCategory.get(0).getCode());
			}else if(i==1){
				paramMap.put("cate2two", listOpenMarketMarginCategory.get(1).getCode());
			}else if(i==2){
				paramMap.put("cate2three", listOpenMarketMarginCategory.get(2).getCode());
			}else if(i==3){
				paramMap.put("cate2four", listOpenMarketMarginCategory.get(3).getCode());
			}
		}
		
		List<OpenMarketMarginVO> listOpenMarketMargin = shopManagerDAO.listRecommendOpenMarket2(paramMap);		
		
		
		return listOpenMarketMargin;
	}
	
	/**
	 * 품절연동을 위한 오픈마켓별 상품번호 가져오기
	 */
	@Override
	public List<OpenMarketMarginVO> listSoldOutUrl(Map paramMap) throws SQLException {
				
		List<OpenMarketMarginVO> listOpenMarketMargin = shopManagerDAO.listSoldOutUrl(paramMap);
		return listOpenMarketMargin;
	}
	
	/**
	 * 오픈 마켓별 품절연동 동기화 
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int updateSoldOutUrl(Map paramMap) throws SQLException {		
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		try{			
			paramMap.put("userId", userInfo.getLoginId());
			shopManagerDAO.updateSoldOutUrl(paramMap);
		
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	/**
	 * 오픈마켓/관리자 삭제목록 저장.
	 * @param paramMap
	 * @param fileBean
	 * @param path
	 * @throws SQLException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void saveDummySoldout(Map paramMap, CommonFileVO fileBean, String path) throws SQLException {
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
    	
    	shopManagerDAO.deleteDummySoldout();
    	
		for(int i = 1; i < row; i++){
			//System.out.println("파일 시크 읽기 시작");
			Cell cell[] = sheet.getRow(i);
			//System.out.println("종료");
			DummySoldoutVO dummyVO = new DummySoldoutVO();
			
			//openMarketMarginVO.setTableName("fb_openmarket_margin_"+userInfo.getUserId());
			//dummyVO.setSeq(cell[0].getContents().replace("'", ""));
			dummyVO.setMarketSeq(cell[0].getContents().replace("'", ""));
			dummyVO.setMarketType(paramMap.get("marketType").toString());
			
			shopManagerDAO.saveDummySoldout(dummyVO);
			
		}
	}
	
	@Override
	public List<DummySoldoutVO> listDummySoldout2(Map paramMap) throws SQLException {
				
		List<DummySoldoutVO> listDummySoldout = shopManagerDAO.listDummySoldout2(paramMap);
		return listDummySoldout;
	}
	
	@Override
	public List<DummySoldoutVO> listDummySoldout1(Map paramMap) throws SQLException {
				
		List<DummySoldoutVO> listDummySoldout = shopManagerDAO.listDummySoldout1(paramMap);
		return listDummySoldout;
	}
	
	@Override
	public List<DummySoldoutVO> listDummySoldout3(Map paramMap)throws SQLException {
		
		List<DummySoldoutVO> listDummySoldout = shopManagerDAO.listDummySoldout3(paramMap);
    	return listDummySoldout;
    }
	
	@SuppressWarnings("unchecked")
	@Override
	public int updateDummySoldout(Map paramMap) throws SQLException {		
		UserVO userInfo = (UserVO) RequestContextHolder.getRequestAttributes().getAttribute("userInfo", RequestAttributes.SCOPE_SESSION);
		try{			
			paramMap.put("userId", userInfo.getLoginId());
			shopManagerDAO.updateDummySoldout(paramMap);
		
		}catch(Exception e){
			e.printStackTrace();
			return -1;
		}
		return 1;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public int updateDummySoldout2(Map paramMap) throws SQLException {
	    UserVO userInfo = (UserVO)RequestContextHolder.getRequestAttributes().getAttribute("userInfo", 1);
	    try {
	      paramMap.put("userId", userInfo.getLoginId());
	      shopManagerDAO.updateDummySoldout2(paramMap);
	    }
	    catch (Exception e) {
	      e.printStackTrace();
	      return -1;
	    }
	    return 1;
	  }
	
	
}
