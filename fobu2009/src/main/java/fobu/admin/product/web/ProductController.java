package main.java.fobu.admin.product.web;

import main.java.fobu.common.Constant;
import main.java.fobu.common.service.CommonFileVO;
import main.java.fobu.common.util.AjaxPageSplit;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;








import main.java.fobu.admin.product.service.InfoCategoryService;
import main.java.fobu.admin.product.service.InfoCategoryVO;
import main.java.fobu.admin.product.service.ProductBrandService;
import main.java.fobu.admin.product.service.ProductBrandVO;
import main.java.fobu.admin.product.service.ProductCategoryService;
import main.java.fobu.admin.product.service.ProductCategoryVO;
import main.java.fobu.admin.product.service.ProductListVO;
import main.java.fobu.admin.product.service.ProductService;
import main.java.fobu.admin.product.service.ProductCompanyVO;
import main.java.fobu.admin.product.service.ProductSizeOptVO;
//import main.java.fobu.admin.product.service.ProductStockService;
import main.java.fobu.admin.product.service.ProductVO;
import main.java.fobu.common.service.FileService;
import main.java.fobu.common.util.StringUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sun.jimi.core.Jimi;
import com.sun.jimi.core.JimiUtils;

/**
 *  Controller
 *
 * @author min 
 * @since 2010. 09. 08.
 */
@Controller
public class ProductController {
	
	//private String listScale ="20";
		
	@Resource(name = "productServiceImpl")
	private ProductService productService;
	
	@Resource(name = "productBrandServiceImpl")
	private ProductBrandService productBrandService;
	
	@Resource(name = "infoCategoryServiceImpl")
	private InfoCategoryService infoCategoryService;	
	
	@Resource(name = "productCategoryServiceImpl")
	private ProductCategoryService productCategoryService;	
	
	@Autowired
	private FileService fileService;
	
	/**
	 * The Constructor
	 */
	public ProductController() {
		//logger = LogFactory.getLog(this.getClass());
	}	
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_write.html")
	public String view1(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);	   
	    paramMap.put("category", "0001");
		paramMap.put("useYN", "Y");
		
		List<ProductBrandVO> listBrand = productBrandService.listBrand(paramMap);
		List<InfoCategoryVO>listInfoCategory = infoCategoryService.listInfoCategory(paramMap);
		
		model.addAttribute("listBrand", listBrand);
		model.addAttribute("listInfoCategory", listInfoCategory);
		return "/fobu/admin/product/product_write";
	}
	/**
	 * 제품수정 팝업 페이지
	 * @param request
	 * @param response
	 * @param seq
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/product/product_updatePop.html")
	public String view3(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    paramMap.put("category", "0001");
		paramMap.put("useYN", "Y");
		paramMap.put("uSeq", seq);
		
		List<ProductVO> listProductDetail = new ArrayList<ProductVO>();
		
		
		listProductDetail = productService.listProductDetail(seq);
		List<ProductBrandVO> listBrand = productBrandService.listBrand(paramMap);
		List<InfoCategoryVO>listInfoCategory = infoCategoryService.listInfoCategory(paramMap);
		//List<ProductSizeOptVO> listStock = productStockService.listStock(paramMap);
		
		model.addAttribute("listProductDetail", listProductDetail);
		model.addAttribute("listBrand", listBrand);
		model.addAttribute("listInfoCategory", listInfoCategory);
		model.addAttribute("titleImgPath", Constant.imageLargePath);		
	    model.addAttribute("detailImgPath", Constant.imageDetailPath);
		//model.addAttribute("listStock", listStock);
		
		return "/fobu/admin/product/product_updatePop";
	}
	
	/**
	 * 제품 수정페이지
	 * @param request
	 * @param response
	 * @param seq
	 * @param model
	 * @return
	 * @throws SQLException
	 */
	@RequestMapping(value = "/admin/product/product_update.html")
	public String view2(HttpServletRequest request, HttpServletResponse response, String seq
			, ModelMap model) throws SQLException {		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    paramMap.put("category", "0001");
		paramMap.put("useYN", "Y");
		paramMap.put("uSeq", seq);
		
		List<ProductVO> listProductDetail = new ArrayList<ProductVO>();
		
		
		listProductDetail = productService.listProductDetail(seq);
		List<ProductBrandVO> listBrand = productBrandService.listBrand(paramMap);
		List<InfoCategoryVO>listInfoCategory = infoCategoryService.listInfoCategory(paramMap);
		//List<ProductSizeOptVO> listStock = productStockService.listStock(paramMap);
		
		model.addAttribute("listProductDetail", listProductDetail);
		model.addAttribute("listBrand", listBrand);
		model.addAttribute("listInfoCategory", listInfoCategory);
		model.addAttribute("titleImgPath", Constant.imageLargePath);
	    model.addAttribute("detailImgPath", Constant.imageDetailPath);
		//model.addAttribute("listStock", listStock);
		
		return "/fobu/admin/product/product_update";
	}
	
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_write.action")
	public ModelAndView write(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("Product")ProductVO product) throws SQLException {
				
		int seq = productService.getProductLastSeq();
		product.setSeq(Integer.toString(seq));
		
		List<CommonFileVO> fileBeanList = null;
		try {
        	//ServletContext context = request.getSession().getServletContext();
        	fileBeanList = fileService.multiUpload2(request, 1, product);
        	
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		int rtnVal = productService.saveProduct(product, fileBeanList);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result2");
		
		return mav;
	}
	
	//제품수정
	/**
	 * 
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_update.action")
	public ModelAndView update(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("Product")ProductVO product) throws SQLException {
				
		String mode = product.getSeq().equals("-1")?"create":"modify";
		int rtnVal = -1;
		
		if(mode.equals("create")){
			int seq = productService.getProductLastSeq();
			product.setSeq(Integer.toString(seq));
		}
		
		List<CommonFileVO> fileBeanList = null;
		try {
        	//ServletContext context = request.getSession().getServletContext();
        	fileBeanList = fileService.multiUpload2(request, 1, product);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		
		if(mode.equals("create")){
			rtnVal = productService.saveProduct(product, fileBeanList);
		}
		else{
			rtnVal = productService.updateProduct(product, fileBeanList);
		}
			
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		
		mav.setViewName("/fobu/admin/product/product_result2");
		
		return mav;
	}
	

	/**
	 * 주문통합정보검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/product/product_company.action")
	public ModelAndView listCompany(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav, ModelMap model) throws Exception {	
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
	    List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	   
		// JSON 객체
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("listCompany"   , JSONArray.fromObject(listCompany));
		
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	/**
	 * 제품통합검색 목록
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_list.html")
	public String list(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
		paramMap.put("category", "0001");
		paramMap.put("useYN", "Y");
		
	    List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	    List<ProductBrandVO> listBrand = productBrandService.listBrand(paramMap);
	    
	    model.addAttribute("listCompany", listCompany);
	    model.addAttribute("listBrand", listBrand);
	    model.addAttribute("selectBrand", paramMap.get("selectBrand"));
	    model.addAttribute("category1", paramMap.get("cate1"));
	    model.addAttribute("category2", paramMap.get("cate2"));
	    model.addAttribute("category3", paramMap.get("cate3"));
	    model.addAttribute("titleImgPath", Constant.imageSmallPath);
	    model.addAttribute("titleImgPath2", Constant.imageTitlePath);
	    model.addAttribute("detailImgPath", Constant.imageDetailPath);
	    
		return "/fobu/admin/product/product_list";
	}
	
	/**
	 * 제품통합검색 목록
	 * 
	 * @param HttpServletResponse response
	 * @param ModelMap model
	 * @return 
	 * @throws SQLException 
	 */
	
	@RequestMapping(value = "/admin/product/product_detailList.html")
	public String detailList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
		paramMap.put("category", "0001");
		paramMap.put("useYN", "Y");
		
	    List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
	    List<ProductBrandVO> listBrand = productBrandService.listBrand(paramMap);
	    
	    model.addAttribute("listCompany", listCompany);
	    model.addAttribute("listBrand", listBrand);
	    model.addAttribute("titleImgPath", Constant.imageSmallPath);
	    model.addAttribute("titleImgPath2", Constant.imageTitlePath);
	    model.addAttribute("detailImgPath", Constant.imageDetailPath);
	    
		return "/fobu/admin/product/product_detailList";
	}
	
	/**
	 *  제품통합검색
	 * 
	 * @param HttpServletResponse response
	 * @param ModelAndView mav
	 * @param 
	 * @return 
	 * @throws Exception 
	 */		
	@RequestMapping(value = "/admin/product/product_list.action")
	public ModelAndView init(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav, ModelMap model) throws Exception {		
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		
		int pageNum = Integer.parseInt(paramMap.get("pageNum").toString());
		int listScale = Integer.parseInt(paramMap.get("listScale").toString());
		int paging = (pageNum-1)*listScale;		
		
		List<ProductCompanyVO> listCompany = productService.listCompany(paramMap);
		
		paramMap.put("paging", paging);
		paramMap.put("listScale", listScale);
		//paramMap.put("listScale", listScale);
		//System.out.println("**************************"+paramMap);
		int listProductCount = productService.listProductCount(paramMap);
	    List<ProductVO> listProduct = productService.listProduct(paramMap);
		
		AjaxPageSplit pageSplitMgr = new AjaxPageSplit();
		String pageSplit = pageSplitMgr.getSplitPageLink(listProductCount, pageNum, listScale, 15, "");
		
		Map<String, Object> hmap = new HashMap<String, Object>();
		hmap.put("pageSplit" , pageSplit);
		hmap.put("listProductCount" , listProductCount);
		hmap.put("listCompany"   , JSONArray.fromObject(listCompany));
		hmap.put("listProduct"   , JSONArray.fromObject(listProduct));
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
	    return null;
	}
	
	@RequestMapping(value = "/admin/product/product_save.action")
	public ModelAndView productSave(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductList")ProductListVO productList) throws SQLException {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = productService.updateProductList(productList);
		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result");
		
		return mav;
	}
	
	@RequestMapping(value = "/admin/product/product_save2.action")
	public ModelAndView productSave2(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductList")ProductListVO productList) throws SQLException {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = productService.updateProductList2(productList);
		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result");
		
		return mav;
	}
	
	@RequestMapping(value = "/admin/product/enterpriseOrder_save.action")
	public ModelAndView orderProductTod_save(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model,@ModelAttribute("ProductList")ProductListVO productList) throws SQLException {
		
		Map<String,Object> paramMap = StringUtil.getParameterMap2(request);
		int rtnVal = productService.insertEnterpriseOrderList(productList);
		
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result");
		
		return mav;
	}
	
	@RequestMapping(value = "/admin/product/category_view.action")
	public ModelAndView category_view(HttpServletRequest request, HttpServletResponse response, 
			ModelAndView mav, ModelMap model) throws Exception {	
		
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		List<ProductCategoryVO> categoryView = new ArrayList<ProductCategoryVO>();
		categoryView = productCategoryService.listCategory(paramMap);
				
		Map<String, Object> hmap = new HashMap<String, Object>();		
		hmap.put("categoryView"   , JSONArray.fromObject(categoryView));
				
		JSONObject jsonObject = JSONObject.fromObject(hmap);		
		sendResponse(response, jsonObject);
		
		return null;
	}
	
	/***
	 * 신제품 등록(가방쟁이)
	 * @param request
	 * @param response
	 * @param mav
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/productUpload2.action")
	public ModelAndView productUpload2(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		Map<String,String> paramMap = StringUtil.getParameterMap(request);
		CommonFileVO fileBean = null;
        //int res = 0;
        ServletContext context = request.getSession().getServletContext();
    	System.out.println("context.getRealPath--->"+context.getRealPath("/view/file/admin/product/excel"));
    	String path = context.getRealPath("/view/file/admin/product/excel");
        try {
        	//path = C:\\Users\\min\\workspace\\fobu2009\\WebContent\\view\\fobu\\excel
			fileBean = fileService.getUploadFileList(request, 2, path);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
        
        
		Integer rtnVal = productService.saveNewProductExcel(paramMap, fileBean, path);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnVal);
		mav.setViewName("/fobu/admin/product/product_result");
	    return mav;
	}
	
	@RequestMapping(value = "/admin/product/product_list2.html")
	public String list2(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException {
		
		return "/fobu/admin/product/product_list2";
	}
	
	@RequestMapping(value = "/admin/product/product_list2.action")
	public ModelAndView doGetData(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws SQLException, IOException {
		
	    Map<String,String> paramMap = StringUtil.getParameterMap(request);
	    		
	    String urlPath = paramMap.get("urlPath").toString();
        String pageContents = "";
        String rtnContens= "";
        StringBuilder contents = new StringBuilder();
 
        try{
 
            URL url = new URL(urlPath);
            URLConnection con = (URLConnection)url.openConnection();
            InputStreamReader reader = new InputStreamReader (con.getInputStream(), "euc-kr");
 
            BufferedReader buff = new BufferedReader(reader);
            
    		
            while((pageContents = buff.readLine())!=null){
                //System.out.println(pageContents);             
                contents.append(pageContents);
                contents.append("\r\n");
                
            }
 
            buff.close();
            rtnContens = contents.toString();
            System.out.println(contents.toString());
             
        }catch(Exception e){
            e.printStackTrace();
        }
        ModelAndView mav = new ModelAndView();
		mav.addObject("rtnVal", rtnContens);
		mav.setViewName("/fobu/admin/product/product_list3");
       
        return mav;
	    
	}
	
	/**
	 * Ajax json 응답
	 * @param response
	 * @param jsonObject
	 * @throws Exception
	 */
	private void sendResponse(HttpServletResponse response, JSONObject jsonObject) throws Exception {
		Thread.sleep(200);
		response.setContentType("text/xml;charset=UTF-8");
		response.getWriter().print(jsonObject);
		response.getWriter().flush();
		response.getWriter().close();
    }
}
