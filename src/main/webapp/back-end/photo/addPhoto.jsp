<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/back-end/index/ManagerMeta.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/back-end/index/ManagerBody.jsp"%>
	<h1>新增相片</h1>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>	
	
		<form action="${pageContext.request.contextPath}/pho.do" method="post" enctype="multipart/form-data">
				<label for="albNo">相簿編號：${phaVO.albNo}</label><input type="hidden" name="albNo" value="${phaVO.albNo}"><br>
				<label for="memNo" >會員編號：${phaVO.memNo}</label><input type="hidden" name="memNo" value="${phaVO.memNo}"><br>
				<br> <label for="photoDate">相片日期：</label> <input type="date" name="photoDate" required><br>
				<br> <input type="hidden"  name="photoName1"><br>
				<br> <label for="photo">相片1：</label> <input class="photo" type="file" name="photo1" accept="image/*" onchange="showPreview"><br>
				<br> <input type="hidden"  name="photoName2"><br>
				<br> <label for="photo">相片2：</label> <input class="photo" type="file"  name="photo2" accept="image/*" onchange="showPreview"><br>
				<br> <input type="hidden"  name="photoName3"><br>
				<br> <label for="photo">相片3：</label> <input class="photo" type="file"  name="photo3" accept="image/*" onchange="showPreview"><br>
				<br>
				<div class="form-group">
                        <label>相片封面預覽區</label>
                        <img name="photoPreview" src="#" alt="封面預覽" style="width: 200px; height: 200px; object-fit: cover;">
                        <img name="photoPreview" src="#" alt="封面預覽" style="width: 200px; height: 200px; object-fit: cover;">
                        <img name="photoPreview" src="#" alt="封面預覽" style="width: 200px; height: 200px; object-fit: cover;">
                </div>
				<input type="hidden" name="action" value="insert">
				<br> <input type="submit" value="送出">

		</form>
		
		<script>
		// 取得"選取檔案"的檔名(輸入元素)
		function fileName(inputName, fileInput) {
	        var nameInput = document.querySelector('input[name="' + inputName + '"]');      
	        if (fileInput.files.length > 0) { //有選到檔案, 檔案名稱長度>0
	            nameInput.value = fileInput.name; //nameInput.value = fileInput.files[0].name;
	        } else {
	            nameInput.value = "";
	        }
    	}
		
		var photo1 = document.querySelector('input[name="photo1"]');//檔案名稱
		// 當選擇檔案時觸發事件
		photo1.addEventListener('change', function() {
		    fileName('photoName1', photo1);//設定相片的name = 檔案名稱
		});
		
		var photo2 = document.querySelector('input[name="photo2"]');//檔案名稱
		photo2.addEventListener('change', function() {
		    fileName('photoName2', photo2);//設定相片的name = 檔案名稱
		});
		
		var photo3 = document.querySelector('input[name="photo3"]');//檔案名稱
		photo3.addEventListener('change', function() {
		    fileName('photoName3', photo3);//設定相片的name = 檔案名稱
		});
		
		// 預覽相片
	 	const photoElements = document.getElementsByClassName('photo');
		for (let i = 0; i < photoElements.length; i++) {
		    photoElements[i].addEventListener('change', function(e) {
		    	const preview = document.getElementsByName('photoPreview')[i];
		    
		        const file = e.target.files[0];
		        const reader = new FileReader();
		
		        reader.onload = function(e) {
		            preview.src = e.target.result;
        	};
        	reader.readAsDataURL(file);
		    
		});
		}


		</script>

</body>
</html>