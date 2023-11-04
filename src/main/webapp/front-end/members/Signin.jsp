<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.paradisiac.members.model.*"%>

<%
MembersVO membersVO = (MembersVO) request.getAttribute("memberVO");
pageContext.setAttribute("membersVO", membersVO);
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>會員資料新增 - Signin.jsp</title>
</head>
<body>
	<h3>會員註冊 - Sign.jsp</h3>
	<a href="login.jsp">回登入</a>
	<h3>資料新增:</h3>

	<c:if test="${not empty errorMsgs}">
		<div class="error-message">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>

	<form method="post"
		action="<%=request.getContextPath()%>/front-end/members/members.do"
		name="form1" id="form1" enctype="multipart/form-data">

		<div>
			<label for="memname">會員姓名:<font color="red"><b>*</b></font></label> <input
				type="text" id="memname" name="memname" value="${membersVO.memname}" size="45"
				required />
		</div>

		<div>
			<label for="memmail">電子信箱:<font color="red"><b>*</b></font></label> <input
				type="email" id="email" name="memmail" value="${membersVO.memmail}"
				required />
			<button type="button" id="getAuthCodeButton">取得驗證碼</button>
		</div>
		<div>
			<label for="memcaptcha">註冊驗證碼：<font color="red"><b>*</b></font></label>
			<input type="text" id="memcaptcha" name="memcaptcha" 
				value="${membersVO.memcaptcha}" required />
			<button type="button" id="checkCaptchaButton">驗證</button>
		</div>
		<div id="captchaError" style="color: red;"></div>

		<div>
			<label for="memaccount">帳號:<font color="red"><b>*</b></font></label>
			<input type="text" id="memaccount" name="memaccount" 
				value="${membersVO.memaccount}" size="45" placeholder="請輸入帳號"
				required />
		</div>
		<div id="accountError" style="color: red;"></div>

		<div>
			<label for="mempass">密碼:<font color="red"><b>*</b></font></label> <input
				type="password" id="mempass" name="mempass" value="${membersVO.mempass}"
				size="45" required />
		</div>

		<div>
			<label>性別:<font color="red"><b>*</b></font></label> <input
				type="radio" name="memgender" value="1" id="male" checked> <label
				for="male">男</label> <input type="radio" name="memgender" value="2"
				id="female"> <label for="female">女</label> <input
				type="radio" name="memgender" value="3" id="other"> <label
				for="other">其他</label>
		</div>

		<div>
			<label for="memid">身分證字號:<font color="red"><b>*</b></font></label> <input
				type="text" id="memid" name="memid" value="${membersVO.memid}" size="45"
				required />
		</div>

		<div>
			<label for="membir">生日:</label> <input name="membir" id="membir"
				type="date">
		</div>

		<div>
			<label for="memphone">電話:<font color="red"><b>*</b></font></label> <input
				type="text" id="memphone"  name="memphone" value="${membersVO.memphone}" size="45"
				required />
		</div>

		<div>
			<label for="memaddress">地址:</label> <input type="text" id="memaddress"
				name="memaddress" value="${membersVO.memaddress}" size="45" />
		</div>

		<div>
			<label for="mempicture">上傳會員頭像:</label> <input name="mempicture"
				id="mempicture" type="file" accept="image/*" />
		</div>
		<br> <input type="button" value="註冊" name="submitButton" id="submitButton"> <br>
		        <input type="hidden" name="action" value="insert">
		<br>
		<button type="reset" id="reset">重設</button>
	</form>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
        var p_file_el = document.getElementById("mempicture");
        var isGetAuthCodeButtonDisabled = false;
        var countdown = 30; //倒數計時秒數
    	var isMemaccountValid = false;//預設驗證帳號
		var isMemcaptchaValid = false;//預設驗證驗證碼

        function startCountdown() {
            isGetAuthCodeButtonDisabled = true;
            $("#getAuthCodeButton").prop("disabled", true);
            var interval = setInterval(function() {
                if (countdown > 0) {
                    $("#getAuthCodeButton").text("等待 " + countdown + " 秒");
                    countdown--;
                } else {
                    clearInterval(interval);
                    isGetAuthCodeButtonDisabled = false;
                    $("#getAuthCodeButton").text("取得驗證碼");
                    $("#getAuthCodeButton").prop("disabled", false);
                }
            }, 1000);
        }

        $("#getAuthCodeButton").on('click', async function() {
            if (isGetAuthCodeButtonDisabled) {
                alert("請等待30秒後再嘗試。");
                return;
            }
            // 啟動計時
            startCountdown();
            var formdata = new FormData();
            formdata.append("memmail", $("#email").val());
            var url = "<%=request.getContextPath()%>/front-end/members/members.do?action=getAuthCode";
            try {
                var response = await fetch(url, {
                    method: "POST",
                    body: formdata
                });
                if (!response.ok) {
                    throw new Error("錯誤");
                }
                const data = await response.text();
                console.log(data);
            } catch (error) {
                console.error(error);
            }
        });
         
        // 帳號重複檢查
        $("#memaccount").on('blur', function() {
        	var memaccount = $("#memaccount").val().trim(); // 去除前後空白
            if (memaccount === "") {
                // 如果輸入為空或輸入空白則不做檢查
                return;
            }
            $.ajax({
                type: "post",
                url: "<%=request.getContextPath()%>/front-end/members/members.do?action=checkAccount",
                data: { memaccount: memaccount },
                async: true,
                success: function(data) {
                    if (data.message == 'true') {
                        $('#accountError').text("可用帳號");
                        isMemaccountValid=true;//帳號可用
                        console.log(isMemaccountValid);
                    } else {
                        $('#accountError').text("帳號已存在，請重新輸入");
//                         $('#memaccount').val('');
                    }
                }
            		});
       		 });

        //驗證碼驗證
        $('#checkCaptchaButton').on('click', function() {
            var memcaptcha = $('#memcaptcha').val().trim();
            if (memcaptcha === "") {
            	 isMemcaptchaValid=false;
            }
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/front-end/members/members.do?action=checkCaptcha",
                data: {
                    memcaptcha: memcaptcha,
                    memmail: $("#email").val()
                },
                success: function(data) {
                    // 直接检查整数值，无需解析JSON
                    const responseMessage = parseInt(data);
                    console.log("後臺驗證號碼"+responseMessage);
                    if (responseMessage === 1) {
                        $('#captchaError').text("驗證已逾時，請重新驗證");
                        isMemcaptchaValid=false;
//                         $('#memcaptcha').val('');
                    } else if (responseMessage === 3) {
                        $('#captchaError').text("驗證碼錯誤，請重新輸入");
                        isMemcaptchaValid=false;
//                         $('#memcaptcha').val('');
                    } else if (responseMessage === 2) {
                        $('#captchaError').text("驗證成功");
                        isMemcaptchaValid=true;
                    	console.log(isMemcaptchaValid);
                    }
                }
            });
        });

//         $('#submitButton').click(function() {
//         	console.log("11111");
//         	var memname = $("#memname").val();
//         	var memcaptcha = $("#memcaptcha").val();
// //         	//檢查狀態
//   			console.log(isMemaccountValid);
//   			console.log(isMemcaptchaValid);
//   		     // 提交表单
//   	        function submitForm() {
//   	          if (isMemaccountValid && isMemcaptchaValid) {
//   	            // 驗證通過
//   	            $.ajax({
//   	              type: "POST",
<%--   	              url: "<%=request.getContextPath()%>/front-end/members/members.do?action=insert", --%>
//   	              data: $("#form1").serialize(),
//   	              success: function(response) {
//   	                alert("註冊成功");
//   	              console.log($("#form1").serialize());
//   	              }
//   	            });
//   	          } else {
//   	            alert("註冊失敗，請確認帳號、驗證碼是否驗證成功");
//   	          }
//   	      }
//         });

$('#submitButton').click(function() {
   
    var memname = $("#memname").val();
    var memcaptcha = $("#memcaptcha").val();
    // 檢查狀態
    console.log("帳號驗證最終:"+isMemaccountValid);
    console.log("驗證碼驗證最終"+isMemcaptchaValid);

    // 如果验证通过，将修改隐藏输入框的值
    if (isMemaccountValid &&isMemcaptchaValid) {
        console.log("11111");
        // 验证通过
        $("#form1 input[name='action']").val("insert");
        // 然后提交整个表单
        $("#form1").submit();
        alert("註冊成功");
    } else {
        alert("註冊失敗，請確認帳號、驗證碼是否驗證成功");
    }

});

    </script>
</body>
</html>
