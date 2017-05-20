<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%

   	response.setHeader("Content-Disposition", "attachment; filename=ExcelFileName.xlsx");
   	response.setHeader("Content-Disposition", "JSP Generated Date");

%> 
<script type="text/javascript" src="/js/jquery-1.6.1.min.js"></script>
<script type="text/javascript" src="/js/ui.core.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/js/ui.datepicker.js"></script>
<script type="text/javascript" src="/js/ui.datepicker-ko.js"></script>
<script type="text/javascript" src="/js/common.js"></script>


<script language="javascript">
$(function() {	
	search(1);
});


function search(pageNum){
	var startDay = $('#datepicker').val();
	var endDay = $('#datepicker2').val();
	var listScale = $("#listScale").val();
	var searchCompany = $("#searchCompany").val();
	var searchStatus = $("#searchStatus").val();
	var searchField = $("#searchField").val();
	var searchText = $("#searchText").val();
	var searchBrand = $("#searchBrand").val();
	$("#hdnPageNum").val(pageNum);
	$.ajax({
        type:"POST",
        cache: false,
        data:{
			"startDay": "2011-09-01",
			"endDay": "",
			"searchCompany": "",
			"status": "",
			"searchField": "",
			"searchText": "",
			"searchBrand": "",		
			"pageNum": 1,
			"listScale": 20000000
			
        },
        dataType: "json",
        url:"/admin/product/product_list.action",
        beforeSend:function(xhr) {
		},
        success:function(data, status) {
			$("#page").empty();
			$("#page2").empty();
			$("#product_list tr").remove();
			$("#spanCount").empty();
			var c = "";
			var companyHtml = "";
			var list
			
			var cHeader = 
				   "<tr>"
				  +"	<td width='30' height='23' align='center' bgcolor='e7e7e7' class='tx12B'>선택</td>"
				  +"    <td width='75' align='center' bgcolor='e7e7e7' class='tx12B'>이미지</td>"
				  +"    <td width='45' align='center' bgcolor='e7e7e7' class='tx12B'>품번</td>"
				  +"    <td align='center' bgcolor='e7e7e7' class='tx12B'>제품명</td>"
				  +"    <td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>재고</td>"
				  +"    <td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>발주</td>"
				  +"    <td width='55' align='center' bgcolor='e7e7e7' class='tx12B'>2달/누적</td>"				  
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>원가</td>"
				  +"    <td width='40' align='center' bgcolor='e7e7e7' class='tx12B'>패밀리가</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>판매가</td>"
				  +"    <td width='60' align='center' bgcolor='e7e7e7' class='tx12B'>소비자가</td>"
				  +"    <td width='100' align='center' bgcolor='e7e7e7' class='tx12B'>업체명</td>"
				  +"    <td width='80' align='center' bgcolor='e7e7e7' class='tx12B'>상태</td>"
				  +"</tr>";
				  
			$("#product_list").append(cHeader);

			companyHtml += "<select name='companyCategory' id='companyCategory' style='width:90%;'>";
			$.each(data.listCompany, function() {
           		companyHtml += "<option value='"+this.seq+"'>"+this.company+"</option>";           	   
       	    });
			companyHtml +="	</select>";
       	    
            var index = -1;
            $.each(data.listProduct, function() {     
            	index = index+1;           	               

                var linkTag = "";
                if(this.companyLinkUrl != null && this.companyLinkUrl.length > 0){
                    linkTag = "<a href='"+this.companyLinkUrl+this.corpProductCode+"' target='_blink'> <img src='/images/button/btn_link.gif' width='37' height='21' /></a>";
                }

                var statusTag1="";
                var statusTag2="";
                var statusTag3="";
                // 상태값 설정
				if(this.status == "001"){
					statusTag1 = "selected";
				}
				else if(this.status == "002"){
					statusTag2 = "selected";
				}
				else{
					statusTag3 = "selected";
				}
                
            	c =  "<tr>"
            		+"  <td height='60' align='center' bgcolor='#FFFFFF'>"
            		+"  	<input type='checkbox' name='chk' id='chk' onclick='chkYN("+index+");'>"
            		+"		<input type='hidden' name='checkbox' id='checkbox' value='false'></td>"
            	    +"	<td align='center' bgcolor='#FFFFFF'>";
            	   
            	    if(this.titleImageFile.length > 0 ){
            	c  +="  	<img src='/view/fobu/excel/"+this.titleImageFile+"' width='50' height='50' onclick='imageView(\"/view/fobu/excel/"+this.titleImageFile+"\");' style='cursor:hand;'/>";
            	    }
            	    
            	c  +="      <img src='/images/button/bkn_zoom.gif' width='16' height='16' onclick='imageView(\"/view/fobu/excel/"+this.detailImageFile+"\");' style='cursor:hand;'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='hidden' id='seq' name='seq' value='"+this.seq+"'/>"+this.seq+"</td>"
            	    +"  <td bgcolor='#FFFFFF'>";

            	    //상세 이미지파일 존재유무 확인
            	    if(this.detailImageFile.length > 0){
            	    	doesImageExist("/view/fobu/excel/"+this.detailImageFile);
                	    if(!fileExist){
            	    		c  +="<img src='/images/button/bkn_img1.gif'/>&nbsp;";
            	    	}
            	    }
            	    else{
            			c  +="<img src='/images/button/bkn_img1.gif'/>&nbsp;";
            	    }
            	    //http://image.babyemart.co.kr/sdata/Simg/84624   	    
            	c  +=		"<a href='/admin/product/product_update.html?seq="+this.seq+"' target='_blank'>"
            		+       this.product+"</a>"+ linkTag
            	    +"      <img src='/images/button/cate_sel.gif' width='50' height='21' style='cursor:hand;' onclick='openWindow(\"product_categoryPop.html?seq="+this.seq+"&cate1="+this.category1+"&cate2="+this.category2+"&cate3="+this.category3+"\", \"categoryPop\", 800, 300, \"no\");'/><br/>"
            	    +"		<font color='blue'>" 
            	    +		this.categoryNm1+">"+this.categoryNm2+">"+this.categoryNm3
            	    +"		</font>"            	   
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"      <input name='realStock' type='text' id='realStock' class='number' size='4' value='"+this.realStock+"'/>"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"      <input name='textfield3' type='text' id='textfield2' class='number' size='4' />"
            	    +"  </td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>5/102</td>"            	   
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"  	<input type='text' name='originalPrice' id='originalPrice' class='price' size='7' value='"+this.originalPrice+"'/></td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +" 		<input type='text' name='familyPrice' id='familyPrice' class='price' size='7' value='"+this.familyPrice+"'/></td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"      <input type='text' name='sellPrice' id='sellPrice' class='price' size='7' value='"+this.sellPrice+"'/></td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<input type='text' name='retailPrice' id='retailPrice' class='price' size='7' value='"+this.retailPrice+"'/></td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    //+"		<input type='text' id='corpProductCode' size='10' value='"+this.corpProductCode+"'/>"
            	    +			this.company            	    
            	    +"	<br/>"
            	    + 			companyHtml 
            	    +"	</td>"
            	    +"  <td align='center' bgcolor='#FFFFFF'>"
            	    +"		<select name='status'>"
            	    +"    		<option value='001' "+statusTag1+">판매중</option>"
            	    +"    		<option value='002' "+statusTag2+">일시품절</option>"
            	    +"    		<option value='003' "+statusTag3+">삭제</option>"
            	    +"    	</select>"
            	    +"  </td>";

            	$("#product_list").append(c);
            	
            });
            
            //전체 21687 개 : 2 / 1085 페이지
            if(index == -1)  
				$("#product_list").append("<tr><td colspan='13' height='50' bgcolor='#FFFFFF' align='center'><B>해당 데이터가 없습니다.</B></td></tr>");
            
            
        },
        error:function(request, status) {
           alert(status);
        },
        complete:function(xhr, textStatus) {
        	
        }
	});
}
</script>
<table width="1200" id="product_list" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="d9d9d9">
  <tr>
  <td>dfasfddsfasd</td>
  </tr>
</table>




