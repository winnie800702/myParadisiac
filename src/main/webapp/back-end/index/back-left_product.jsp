<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>後端管理頁面</title>

  <!-- Bootstrap Core CSS -->
  <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.6/lumen/bootstrap.min.css" rel="stylesheet"> 




    <style>
        @import url(https://fonts.googleapis.com/css?family=Lato:400,700);
        body {
        overflow-x: hidden;
        font-family: 'Lato', sans-serif;
        background: #f2f2f2;
        }

        h1,
        h2,
        h3,
        h4 {
        font-family: 'Lato', sans-serif;
        font-weight: 700;
        }


        /* Toggle Styles */

        #menu-toggle {
        position: absolute;
        top: 10px;
        right: 10px;
        }

        ul.navigation {
	list-style-type: none;
	margin: 0;
	padding: 0;
	overflow: hidden;
	background: #4aafd2;
	/*COLOR*/
	width: 100%;
	height: 61px;
}

        .navigation li {
        float: right;
        }

        .navigation li a {
        display: block;
        color: white;
        text-align: center;
        padding: 20px 16px;
        text-decoration: none;
        transition: 0.1s all;
        }

        .navigation li a:hover {
        background-color: #4aafd2;
        /*COLOR*/
        }

        .container-fluid {
        max-width: 1100px;
        margin-top: 10px;
        }

        .sidebar-nav > .sidebar-title {
        color: #dddddd;
        text-transform: uppercase;
        margin-bottom: -10px;
        font-size: 14px;
        }

        .sidebar-nav > .sidebar-brand a,
        .sidebar-nav > .sidebar-brand a:active,
        .sidebar-nav > .sidebar-brand a:hover,
        .sidebar-nav > .sidebar-brand a:visited {
        background: #783993;
        /*COLOR*/
        color: #ffffff!important;
        font-size: 24px;
        font-family: 'Lato', sans-serif;
        font-weight: 700;
        border: 0px solid #000!important;
        }

        .sidebar-nav li a {
        border-left: 0px solid #000;
        transition: 0.1s all;
        }

        .sidebar-nav li a:hover {
        border-left: 4px solid #783993;
        /*COLOR*/
        }

        #wrapper {
        padding-left: 0;
        -webkit-transition: all 0.5s ease;
        -moz-transition: all 0.5s ease;
        -o-transition: all 0.5s ease;
        transition: all 0.5s ease;
        }

        #wrapper.toggled {
        padding-left: 250px;
        }

        #sidebar-wrapper {
        z-index: 1000;
        position: fixed;
        left: 250px;
        width: 0;
        height: 100%;
        margin-left: -250px;
        overflow-y: auto;
        background: #4d4d4d;
        -webkit-transition: all 0.5s ease;
        -moz-transition: all 0.5s ease;
        -o-transition: all 0.5s ease;
        transition: all 0.5s ease;
        }

        #wrapper.toggled #sidebar-wrapper {
        width: 250px;
        }

        #page-content-wrapper {
        width: 100%;
        position: absolute;
        padding: 15px;
        }

        #wrapper.toggled #page-content-wrapper {
        position: absolute;
        margin-right: -250px;
        }


        /* Sidebar Styles */

        .sidebar-nav {
        position: absolute;
        top: 0;
        width: 250px;
        margin: 0;
        padding: 0;
        list-style: none;
        }

        .sidebar-nav li {
        text-indent: 20px;
        line-height: 40px;
        }

        .sidebar-nav li a {
        display: block;
        text-decoration: none;
        color: #999999;
        }

        .sidebar-nav li a:hover {
        text-decoration: none;
        color: #fff;
        background: rgba(255, 255, 255, 0.2);
        }

        .sidebar-nav li a:active,
        .sidebar-nav li a:focus {
        text-decoration: none;
        }

        .sidebar-nav > .sidebar-brand {
        height: 65px;
        font-size: 18px;
        line-height: 60px;
        }

        .sidebar-nav > .sidebar-brand a:hover {
        border: 1px solid #000 !important;
        }


        #sidebar-wrapper {
            width: 250px;
        }
        #wrapper.toggled #sidebar-wrapper {
            width: 0;
        }
        #page-content-wrapper {
            padding: 20px;
            position: relative;
        }
        #wrapper.toggled #page-content-wrapper {
            position: relative;
            margin-right: 0;
        }

       
         .sidebar-title {
            cursor: pointer;
            }
            .sub-menu {
            display: none;
            }
        }
        .sub-menu {
          max-height: 0;
          overflow: hidden;
          transition: max-height 0.3s ease-in-out;  
        }
        #brandName {
  float: left;
  color: #fff;
  font-size: 25px; /* 設定字體大小 */
  margin-top: 15px;
  margin-left: 5px;
  
}



    </style>
</head>

<body>

  <div class="">


    <!-- Top Navigation -->
    <ul class="navigation">
     <li id="brandName">Paradisiac</li>
      <li><a href="${pageContext.request.contextPath}/loginempN.do?action=logoutEmp">員工登出</a></li>
      <li><a href="#" id="productManagement">商品管理</a></li>
      <li><a href="#" id="productDetail">商品訂單管理</a></li>
      <li><a href="#" id="promotion">促銷專案管理</a></li>
    </ul>
    
  </div><!--結尾-->

  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.2/jquery.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

  <!-- Menu Toggle Script -->
  <script>
        let pathName = window.document.location.pathname;
	    let projectName = pathName.substring(0, pathName.substring(1).indexOf("/") + 1);
	    
         var topLink = document.getElementById('promotion');
         var productLink = document.getElementById('productManagement');
         var listLink = document.getElementById('promotionLeft');
         var detailLink = document.getElementById('productDetail');
         topLink.setAttribute('href', projectName+"/back-end/promotion/listall.jsp");
         productLink.setAttribute('href', projectName + "/productsView.html");
         detailLink.setAttribute('href', projectName + "/allOrders.html");
//          listLink.setAttribute('href', projectName+"/back-end/promotion/listall.jsp");
  </script>

</body>

</html>