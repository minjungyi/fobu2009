<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	if('${rtnVal}'>0){
		//parent.showMsgNClose("제품이 등록되었습니다.");
		alert("${msg}"+" 등록되었습니다.");
		opener.search(${pageNumPop}, ${trIndex});
		self.close();
	}
</script>