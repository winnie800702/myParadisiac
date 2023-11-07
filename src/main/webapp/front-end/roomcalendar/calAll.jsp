<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<style>
        .container {
            text-align: center;
        }

        th {
            text-align: center;
        }

        th.scope {
            background-color: red;
            color: white;
        }
        .selected {
            background-color: #007bff;
            color: white;
        }
        .calstatus {
            padding-right: 20px;
        }
    </style>
</head>
<body>
    <div class="container text-center my-4">
        <button id="prevMonth" class="btn btn-primary">上個月</button>
        <span id="currentMonthYear" class="h4 mx-4">August 2023</span>
        <button id="nextMonth" class="btn btn-primary">下個月</button>
    </div>
    <div class="container">
        <table class="table table-bordered">
            <thead class="thead-dark">
                <tr>
                    <th class="scope">星期日</th>
                    <th>星期一</th>
                    <th>星期二</th>
                    <th>星期三</th>
                    <th>星期四</th>
                    <th>星期五</th>
                    <th class="scope">星期六</th>
                </tr>
            </thead>
            <tbody id="calendarBody">
                <!-- Calendar body content here -->
            </tbody>
        </table> 
    </div>
    <!-- 動態產生房型資訊 -->
     <div class="container" id="roomInformation">
        <h2>房型信息</h2>
    </div>
    <!-- 按下立即預定顯示燈箱內容為訂房確認內容 -->
    <div id="roomInformation" class="container"></div>
    <div id="lightbox" class="modal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">訂房確認表</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="lightboxContent">
                    <!-- 這裡放入動態生成的訂房確認表內容 -->
                </div>
            </div>
        </div>
    </div>
    <div class="container">
    <input type="text" id="selectedDate" readonly>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/front-end/js/fetchRoom.js"></script>
</body>
</html>