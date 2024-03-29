<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
 <title>活動管理系統首頁</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .album card mb-3 {
            position: relative;
        }

        .photo-content d-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .photo-content img {
		    max-width: 40%;  
		    height: 200px; 
            background-color: #eee;
            border: 1px solid #ccc;
            margin: 5px;
        }

        .album-info {
	        margin-bottom: 50px;
	        font-size: 15px;
        }
        
        .table_content {
        border: 1px solid #eee;
    	}
<!--table-->
    	.album {
    display: flex;
    flex-direction: column;
    border: 1px solid #ddd;
    margin-bottom: 15px;
}

.album .row {
    display: flex;
    flex-wrap: wrap;
}

.album .col-md-7 {
    flex: 0 0 70%;
    max-width: 70%;
    position: relative;
}

.album .col-md-5 {
    flex: 0 0 30%;
    max-width: 30%;
}

.album img {
    width: 100%;
    height: 300px;
    object-fit: cover;
}

.album-info {
    padding: 10px;
    box-sizing: border-box;
}

.album-info table {
    width: 100%;
    border-collapse: collapse;
}

.album-info table td {
    padding: 8px;
    border: 1px solid #ddd;
}

.album-info table td:first-child {
    width: 40%;
}

.album-info table td:nth-child(2) {
    width: 60%;
}



    </style>
</head>

<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
<div style="margin-left: 200px;">
    <div class="container">
        
        <div style="border: 1px solid black; padding: 10px;">
        <h1 class="text-center">活動管理</h1>
            <h2 class="d-flex justify-content-between">
               查詢活動與檔期               
            </h2>
            <c:if test="${not empty errorMsgs}">
			    <div style="color: red; font-size: 15px;">
			        請修正以下錯誤:
			        <ul>
			            <c:forEach var="message" items="${errorMsgs}">
			                <li>${message}</li>
			            </c:forEach>
			        </ul>
			    </div>
			</c:if>
            <FORM METHOD="post" ACTION="${pageContext.request.contextPath}/act.do">
				<b>輸入活動編號</b> <input type="text" name="actNo">
				<input type="hidden" name="action" value="getOneActAllSchd">
				<input type="submit" value="送出">
			</FORM>	
        </div>
    <h2 class="text-center" style="padding-top: 10px;">顯示所有活動</h2>
    <h4>點選活動編號顯示完整活動內容</h4>
	<c:if test="${actPageQty > 0}">
				<b><font color=red>第${currentPage}/${actPageQty}頁</font></b>
	</c:if>
	
        <div class="album card mb-3">
        <c:forEach var="act" items="${actList}">
            <div class="row g-0">
                <div class="col-md-7" style="margin-bottom: 5px;">
                    <a href='${pageContext.request.contextPath}/act.do?action=getOne_For_Display&actNo=${act.actNo}'>					
						<img
							src="<%=request.getContextPath()%>/dbg.do?act_no=${act.actNo}"
							style="width: 100%; height: 300px; object-fit: cover;" alt="相簿封面" class="img-fluid">
					</a>
                </div>
                <div class="col-md-5">
                    <div class="album-info">
                        <table class="table table-bordered">
                            <tr>
                                <td>活動編號:</td>
                                <td><a href='${pageContext.request.contextPath}/act.do?action=getOne_For_Display&actNo=${act.actNo}'>${act.actNo}</a>
                                </td>
                            </tr>
                            <tr>
                                <td>活動名稱:</td>
                                <td>${act.actName}</td>
                            </tr>
                            <tr>
                                <td>活動狀態:</td>
                                <td>${act.actStatus?'上架':'下架'}</td>
                            </tr>
                            <tr>
                                <td>參加費用:</td>
                                <td>${act.unitPrice}</td>
                            </tr>
                        </table>                       
                    </div>
                </div>
            </div>
        </c:forEach>
        </div>


	<c:if test="${currentPage > 1}">
			<a 
				href="${pageContext.request.contextPath}/act.do?action=getAll&page=1" >至第一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage - 1 != 0}">
			<a
				href="${pageContext.request.contextPath}/act.do?action=getAll&page=${currentPage - 1}">上一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage + 1 <= actPageQty}">
			<a
				href="${pageContext.request.contextPath}/act.do?action=getAll&page=${currentPage + 1}">下一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage != actPageQty}">
			<a
				href="${pageContext.request.contextPath}/act.do?action=getAll&page=${actPageQty}">至最後一頁</a>&nbsp;
	</c:if>

    
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">
    </script>
    </div>


</div>
</body>
</html>
