<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	if(${rtnVal} == "99"){
		alert("파일이 등록되었습니다.");
		parent.afterInit(${rtnVal});
	}
	else if(${rtnVal}>0){
		//parent.showMsgNClose("제품이 등록되었습니다.");
		alert("제품이 등록되었습니다.");
		parent.afterInit(${rtnVal});
	}else{
		alert("제품 등록중 오류가 발생했습니다.");
	}
</script>