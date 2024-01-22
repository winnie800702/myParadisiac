<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.photoAlbum.model.*"%>
<!DOCTYPE html>


<html>
<head>
<%@ include file="/front-end/index/MembersMeta.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>會員紀念相簿</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
	.popup-container {
    display: none;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    width: 1200px;
    height: 800px;
    z-index: 999;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid black;
	}

    .popup-container img {
    max-width: calc(100% - 34px); 
    max-height: calc(100% - 34px); 
    width: calc(100% - 34px);
    height: auto;
    object-fit: contain;
    display: block;
    margin: auto; /* 上下左右都是17px的margin */
    margin-top: 17px;
    }

    .close-btn {
     position: absolute;
     top: 10px;
     right: 10px;
     cursor: pointer;
     background-color: white;
    }
	.btn-separator {
		margin-left: auto;
	}
	
	.flex-container {
		display: flex;
		align-items: center;
	}
	
	
	table {
		font-size: 15px;
	}
	



</style>
</head>

<body>
<%@ include file="/front-end/index/MembersBody.jsp"%>

	<div class="container">

		<h1 class="text-center">會員紀念相簿</h1>
		<div>
			<h2 class="d-flex justify-content-between">
				 我的相簿				
			</h2>
			
		</div>

		<div class="album card mb-3">
			<div class="row g-0">
				<div class="col-md-7">
					<img id="albPhoto"
						src="<%=request.getContextPath()%>/dbg.do?alb_no=${phaVO.albNo}"
						style="width: 100%; height: 300px; object-fit: cover;" alt="相簿封面" class="img-fluid">
				</div>
				<div class="col-md-5">
					<div class="album-info">
						<table class="table table-bordered">
							<tr>
								<td>相簿編號:</td>
								<td>${phaVO.albNo}</td>
							</tr>
							<tr>
								<td>相簿名稱:</td>
								<td>${phaVO.albName}</td>
							</tr>
							<tr>
								<td>會員編號:</td>
								<td>${phaVO.memNo}</td>
							</tr>
							<tr>
								<td>相簿日期:</td>
								<td>${phaVO.albDate}</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
 
		<div class="flex-container">
		    <h2>我的相片</h2>		    
		</div>
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
		<c:if test="${phoPageQty > 0}">
			<b><span style="color: red; font-size: 15px;">第${currentPage}/${phoPageQty}頁</span></b>
		</c:if>
				
		<div class="album card mb-3">

			<div class="row g-0">
				<div class="col-md-12">
					<form id="photoForm" method="post"
						action="<%=request.getContextPath()%>/pho.do">
						<div class="col-md-12" >
							<c:forEach var="pha" items="${list}">									
								<div class="col-md-4"  style="padding: 5px; display: flex; flex-direction: column; align-items: center;">									
									<img
										src="<%=request.getContextPath()%>/dbg.do?photo_no=${pha.photoNo}"
										style="width: 100%; height: 400px; object-fit: cover;" alt="相片1" class="img-fluid">
									<table>
										<%--<tr>
											 <td>相片名稱:</td>
											<td>${pha.photoName}</td>
										</tr>
										<tr>
											<td>相片編號:</td>
											<td>${pha.photoNo}</td>
										</tr>--%>
										<tr>
											<td>相片日期:</td>
											<td>${pha.photoDate}</td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</div>

					</form>
					
				</div>
			</div>
		</div>

		<c:if test="${currentPage > 1}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display_Front&albNo=${phaVO.albNo}&page=1" style="font-size: 15px;">至第一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage - 1 != 0}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display_Front&albNo=${phaVO.albNo}&page=${currentPage - 1}" style="font-size: 15px;">上一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage + 1 <= phoPageQty}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display_Front&albNo=${phaVO.albNo}&page=${currentPage + 1}" style="font-size: 15px;">下一頁</a>&nbsp;
		</c:if>
		<c:if test="${currentPage != phoPageQty}">
			<a
				href="${pageContext.request.contextPath}/pha.do?action=getOne_For_Display_Front&albNo=${phaVO.albNo}&page=${phoPageQty}" style="font-size: 15px;">至最後一頁</a>&nbsp;
		</c:if>
		<div id="popup" class="popup-container" style="display: none;">
		  <span class="close-btn" onclick="closePopup()">X</span>
		  <img id="popupImage" src="" alt="Popup Image">
		</div>




	</div><%--container --%>

	
	<script>
	document.addEventListener('DOMContentLoaded', function() {
	    const popupContainer = document.getElementById('popup');
	    const popupImage = document.getElementById('popupImage');

	    document.querySelectorAll('.img-fluid').forEach(img => {
	        img.addEventListener('click', function() {
	            const src = this.src;
	            popupImage.src = src;
	            openPopup();
	        });
	    });

	    function openPopup() {
	        popupContainer.style.display = 'block';
	    }

	    function closePopup() {
	        const popupContainer = document.getElementById('popup');
	        popupContainer.style.display = 'none';
	    }
	    document.getElementById('popup').addEventListener("click",closePopup);
	});

	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js">     
    </script>

</body>
</html>
