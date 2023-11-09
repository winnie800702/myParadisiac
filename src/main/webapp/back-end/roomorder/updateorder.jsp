<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html>
<html>
<head>
    <title>修改訂單</title>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
        body {
            padding: 20px;
        }
        .container {
            max-width: 800px;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>修改訂單</h1>
        <form method="post" action="${pageContext.request.contextPath}/order/order.do?action=updateorder">
            <div class="form-group">
                <label for="roomOrderNo">訂單編號：</label>
                <input type="text" class="form-control" id="roomOrderNo" name="roomOrderNo" value="${param.roomOrderNo}" readonly>
            </div>

			<div class="form-group">
			    <label for="roomOrderDate">訂單日期：</label>
			    <input type="text" class="form-control" id="roomOrderDate" name="roomOrderDate" value="${param.roomOrderDate}"readonly>
			    
			</div>


			<div class="form-group">
			    <label for="checkinDate">入住日期：</label>
<%-- 			    <input type="text" class="form-control" id="checkinDate" name="checkinDate" value="${param.checkinDate}"> --%>
			    <input type="date" id="checkinDate" name="checkinDate" value="${param.checkinDate}" min="2023-11-01" max="2025-12-31" />
			</div>
			
			
			<div class="form-group">
			    <label for="checkoutDate">退房日期：</label>
<%-- 			    <input type="text" class="form-control" id="checkoutDate" name="checkoutDate" value="${param.checkoutDate}"> --%>
			    <input type="date" id="checkoutDate" name="checkoutDate" value="${param.checkoutDate}" min="2023-11-01" max="2025-12-31" />
			</div>


            <div class="form-group">
                <label for="roomTypeNo">房型編號：</label>
                <input type="text" class="form-control" id="roomTypeNo" name="roomTypeNo" value="${param.roomTypeNo}">
            </div>

            <div class="form-group">
                <label for="memNo">員工編號：</label>
                <input type="text" class="form-control" id="memNo" name="memNo" value="${param.memNo}">
            </div>

            <div class="form-group">
                <label for="roomAmount">房間數量：</label>
                <input type="text" class="form-control" id="roomAmount" name="roomAmount" value="${param.roomAmount}">
            </div>

            <div class="form-group">
                <label for="price">價錢：</label>
                <input type="text" class="form-control" id="price" name="price" value="${param.price}">
            </div>

            <div class="form-group">
                <label for="paymentMethod">付款方式：</label>
                <input type="text" class="form-control" id="paymentMethod" name="paymentMethod" value="${param.paymentMethod}">
            </div>

            <div class="form-group">
                <label for="payStatus">付款狀態：</label>
                <input type="text" class="form-control" id="payStatus" name="payStatus" value="${param.payStatus}">
            </div>

            <div class="form-group">
                <label for="orderStatus">訂單狀態：</label>
                <input type="text" class="form-control" id="orderStatus" name="orderStatus" value="${param.orderStatus}">
            </div>

            <button class="btn btn-success" type="submit">確定修改</button>
        </form>
        <a class="btn btn-secondary" href="javascript:history.back()">取消修改</a>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/back-end/roomorder/orderfirst.jsp">返回</a>
    </div>





</body>
</html>
