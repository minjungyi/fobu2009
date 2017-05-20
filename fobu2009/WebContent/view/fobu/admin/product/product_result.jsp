<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	if(${rtnVal}>0){
		//parent.showMsgNClose("제품이 등록되었습니다.");
		alert("제품이 등록되었습니다.");
		parent.afterInit(${rtnVal});
	}else{
		alert("오류가 발생하였습니다.");
		parent.afterInit(${rtnVal});
	}
</script>