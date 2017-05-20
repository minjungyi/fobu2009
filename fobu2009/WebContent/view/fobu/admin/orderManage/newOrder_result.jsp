<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>

	if('${succ}'== "N"){
		alert('업로드 에러 입니다. 확인하시고 다시 시도해주세요.');
		parent.search(1);
		self.close();
	}else{
		parent.search(1);
		self.close();
	}
</script>