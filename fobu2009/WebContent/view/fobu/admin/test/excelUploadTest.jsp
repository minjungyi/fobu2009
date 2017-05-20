<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*, java.io.*, jxl.*" %>
<%
	String path = "C:\\Users\\min\\workspace\\fobu2009\\WebContent\\view\\fobu";
	//String path = "/view/fobu";
	///css/themes/base/ui.all.css"
	String fileName = "Book1.xls";
	
	Workbook workbook = Workbook.getWorkbook(new File(path+"\\"+fileName));
	Sheet sheet = workbook.getSheet(0);
	int col = sheet.getColumns();
	System.out.println("col============>"+col);
	int row = sheet.getRows();
	System.out.println("row============>"+row);
	
	
%>
<html>
<head>
	<title></title>
</head>
<body>
	<form name="bci" method="post">
		<table cellspacing="0" cellpadding="6" border="1">
		<%
			int tmpCellLen = 0;
			for(int i = 0; i < row; i++){
				Cell cell[] = sheet.getRow(i);
				tmpCellLen = cell.length;
				out.println("<tr>");
				for(int j = 0 ; j < col ; j++){
					if(j < tmpCellLen){
						out.println("<td>"+cell[j].getContents()+"</td>");
						System.out.println("내용========>"+cell[j].getContents());
					}else{
						out.println("<td>&nbsp;</td>");
						System.out.println("내용없음");
					}
				}
				out.println("</tr>");
			}
		%>
		</table>
	</form>
</body>
</html>