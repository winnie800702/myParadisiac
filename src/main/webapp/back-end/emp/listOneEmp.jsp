<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.paradisiac.employee.model.*"%>
<%@ page import="com.paradisiac.department.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  EmpVO empVO = (EmpVO) request.getAttribute("empVO"); //EmpServlet.java(Concroller), 存入req的empVO物件

%>

<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<title>員工資料</title>

<style>
<%--
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }--%>
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
<div style="margin-left: 200px;">
<table id="table-1">
	<tr><td>
		 <h3>員工資料</h3>
		 <h4><a href="back-end/emp/select_page.jsp">回員工首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>員工編號</th>
		<th>部門編號</th>
		<th>員工狀態</th>
		<th>員工姓名</th>
		<th>員工信箱</th>
		<th>員工帳號</th>
		<th>員工密碼</th>
		<th>員工性別</th>
		<th>員工電話</th>

	<tr>
		<%
		String ge = "";	
		switch(empVO.getEmpGender()){
		case 1: 
			ge = "男";
			break;
		case 2:
			ge = "女";
			break;
		case 3:
			ge = "其他";
			break;
		}
		
		String st = "";
		switch(empVO.getEmpStatus()){
		case 0:
			st = "凍結";
			break;
		case 1:
			st = "未凍結";
			break;		
		}	
		%>
		<td><%=empVO.getEmpno()%></td>
		<td><%=empVO.getDept().getDeptNo()%><%=empVO.getDept().getDeptName()%></td>
		<td><%=st%></td>
		<td><%=empVO.getEmpName()%></td>
		<td><%=empVO.getEmpMail()%></td>
		<td><%=empVO.getEmpAccount()%></td>
		<td><%=empVO.getEmpPass()%></td>
		<td><%=ge%></td>
		<td><%=empVO.getEmpPhone()%></td>

	</tr>
</table>
</div>
</body>
</html>