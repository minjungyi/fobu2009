package main.java.fobu.admin.orderManage.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.java.fobu.admin.orderManage.service.TotalOrderVO;
import main.java.fobu.admin.product.service.OpenMarketMarginVO;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.impl.AbstractDao;

import org.springframework.stereotype.Repository;

/**
 * Asign Data Access Object
 *
 * @author min
 * @since 2010. 09. 10.
 */
@Repository
public class TotalOrderDAO extends AbstractDao {
	
	/**
	 *
	 * @param realmCode
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public String searchTotalOrderViewList() throws SQLException {
		Map<String, String> param = new HashMap<String, String>();
		return (String) getSqlMapClientTemplate().queryForObject("TotalOrderDAO.searchTotalOrderViewList", param);
	}
	
	/**
	 * 주문통합정보검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<TotalOrderVO> listTotalOrder(Map paramMap) throws SQLException {		
		return (List<TotalOrderVO>) list("TotalOrderDAO.listTotalOrder", paramMap);
	}
	
	/**
	 * 주문통합정보검색 총건수
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listTotalOrderCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("TotalOrderDAO.listTotalOrderCount", paramMap));
	}
	
	/**
	 * 주문통합정보상세검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<TotalOrderVO> listTotalOrderDetail(Map paramMap) throws SQLException {		
		return (List<TotalOrderVO>) list("TotalOrderDAO.listTotalOrderDetail", paramMap);
	}
	
	/**
	 * 묶음상품정보
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<TotalOrderVO> listPackageInfo(Map paramMap) throws SQLException {		
		return (List<TotalOrderVO>) list("TotalOrderDAO.listPackageInfo", paramMap);
	}
	
	/**
	 * 묶음상품정보 저장
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void savePackageInfo(TotalOrderVO totalOrder) throws SQLException {		
		update("TotalOrderDAO.savePackageInfo", totalOrder);
	}
	
	/**
	 * 개인송장출력
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<TotalOrderVO> listDeliveryNumber(Map paramMap) throws SQLException {		
		return (List<TotalOrderVO>) list("TotalOrderDAO.listDeliveryNumber", paramMap);
	}
	
	/**
	 * 주문통합의 관리자 메모 저장
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void saveMemo(Map paramMap) throws SQLException {		
		update("TotalOrderDAO.saveMemo", paramMap);
	}
	
	/**
	 * 주문통합의 재고옵션 저장
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void saveStockOpt(Map paramMap) throws SQLException {		
		update("TotalOrderDAO.saveStockOpt", paramMap);
	}
	
	/**
	 * 주문정보 상세 저장
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public void saveOrderDetail(Map paramMap) throws SQLException {		
		update("TotalOrderDAO.saveOrderDetail", paramMap);
	}
	
	/**
	 * 주문상태값 수정
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void saveStat(String orderSeq, String orderStat, String deliveryCompleteYn, String userId) throws SQLException {		
		Map<String, String> param = new HashMap<String, String>();
		param.put("seq", orderSeq);
		param.put("orderStat", orderStat);
		param.put("deliveryCompleteYn", deliveryCompleteYn);
		param.put("modifiers", userId);
		update("TotalOrderDAO.saveStat", param);
	}

	/**
	 * 정산상태값 수정
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void saveAccountStat(String orderSeq, String userId) throws SQLException {		
		Map<String, String> param = new HashMap<String, String>();
		param.put("seq", orderSeq);
		param.put("modifiers", userId);
		update("TotalOrderDAO.saveAccountStat", param);
	}
	
	
	/**
	 * 주문상태값 수정(송장번호 저장)
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void saveDeliveryNumber(String orderSeq, String deliveryNumber, String deliveryCompany) throws SQLException {		
		Map<String, String> param = new HashMap<String, String>();
		param.put("seq", orderSeq);
		param.put("deliveryNumber", deliveryNumber);
		param.put("deliveryCompany", deliveryCompany);
		update("TotalOrderDAO.saveDeliveryNumber", param);
	}
	
	/**
	 * 신규주문정보 저장시 제품테이블에서 해당데이타 가져오기
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<TotalOrderVO> listProductInfo(String productCode) throws SQLException {	
		Map<String, String> param = new HashMap<String, String>();
		param.put("seq", productCode);
		return (List<TotalOrderVO>) list("TotalOrderDAO.listProductInfo", param);
	}
	
	/**
	 * 신규주문정보 저장(엑셀파일업로드)
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void saveNewOrder(TotalOrderVO totalOrderVO) throws SQLException {		
		insert("TotalOrderDAO.saveNewOrder", totalOrderVO);
	}

	/**
	 * 오픈마켓정산(엑셀파일업로드)
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void saveOpenMarketAccount(TotalOrderVO totalOrderVO) throws SQLException {		
		update("TotalOrderDAO.saveOpenMarketAccount", totalOrderVO);
	}
	
	/**
	 * 제품 저장(엑셀파일업로드)
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void saveProductStatus(OpenMarketMarginVO openMarketMarginVO) throws SQLException {		
		update("TotalOrderDAO.saveProductStatus", openMarketMarginVO);
	}
	
	/**
	 * 주문상품변경검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<ProductVO> listChangeProduct(Map paramMap) throws SQLException {	
		
		//System.out.println("paramMap=====>"+paramMap);
		return (List<ProductVO>) list("TotalOrderDAO.listChangeProduct", paramMap);
	}
	
	/**
	 * 주문상품변경검색 총건수
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public int listChangeProductCount(Map paramMap) throws SQLException {		
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("TotalOrderDAO.listChangeProductCount", paramMap));
	}
	
	/**
	 * 주문상품변경 저장
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	public void saveChangeProduct(TotalOrderVO totalOrder) throws SQLException {		
		update("TotalOrderDAO.saveChangeProduct", totalOrder);
	}
	
	/**
	 * 주문재고 조회
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<TotalOrderVO> listRealOrderStock(String seq) throws SQLException {		
		Map<String, String> param = new HashMap<String, String>();
		param.put("seq", seq);
		return (List<TotalOrderVO>) list("TotalOrderDAO.listRealOrderStock", param);
	}
	
	/**
	 * 재고검색
	 * @param 
	 * @return TotalOrderVO List
	 * @throws SQLException 
	 */
	@SuppressWarnings("unchecked")
	public List<TotalOrderVO> searchRealStock(Map paramMap) throws SQLException {		
		return (List<TotalOrderVO>) list("TotalOrderDAO.searchRealStock", paramMap);
	}
	
	/**
	 * 주문재고 수정
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void saveChangeRealOrderStock2(String productCode, String stockTarget, String userId) throws SQLException {	
		//saveChangeRealOrderStock(String productCode, String realStock, String stockTarget, String userNm)
		Map<String, String> param = new HashMap<String, String>();
		param.put("stockTarget", stockTarget);
/*		param.put("productCode", productCode);
		param.put("stock", realStock);*/
		param.put("modifiers", userId);
		param.put("seq", productCode);
		update("TotalOrderDAO.saveChangeRealOrderStock2", param);
	}
	
	/**
	 * 주문재고 수정
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void saveChangeRealOrderStock(String productCode, String realStock, String stockTarget, String userId, String stockOpt) throws SQLException {	
		//saveChangeRealOrderStock(String productCode, String realStock, String stockTarget, String userNm)
		Map<String, String> param = new HashMap<String, String>();
		param.put("stockTarget", stockTarget);
		param.put("productCode", productCode);
		param.put("stock", realStock);
		param.put("stockOpt", stockOpt);
		param.put("modifiers", userId);
		update("TotalOrderDAO.saveChangeRealOrderStock", param);
	}
	
	/**
	 * 업체발주재고 저장
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void saveRealStock(String productCode, String realStock, String remark, String status, String target, String userId) throws SQLException {		
		Map<String, String> param = new HashMap<String, String>();
		param.put("productCode", productCode);
		param.put("realStock", realStock);
		param.put("remark", remark);		
		param.put("status", status);
		param.put("target", target);
		param.put("modifiers", userId);
		update("TotalOrderDAO.saveRealStock", param);
	}
	
	/**
	 * 업체발주재고 수정
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public void updateRealStock(String productCode, String option) throws SQLException {		
		Map<String, String> param = new HashMap<String, String>();
		param.put("productCode", productCode);
		param.put("option", option);
		update("TotalOrderDAO.updateRealStock", param);
	}
	
	
	
	/**
	 * 업체발주중복조회
	 * @param 
	 * @return void
	 * @throws SQLException 
	 */
	public int listDupOrder(String productCode) throws SQLException {		
		Map<String, String> param = new HashMap<String, String>();
		param.put("productCode", productCode);
		return Integer.parseInt((String) getSqlMapClientTemplate().queryForObject("TotalOrderDAO.listDupOrder", param));
	}
}
