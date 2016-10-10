<%@page import="Model.UserInfo"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品采购</title>

<link href="./Public/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="./Public/css/index.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.mylabel {
	font-size: 25px;
	/* color: #66CCCC; */
	color: #990066;
}

.myUpdatePwdInput {
	/* background: transparent; */
	border-style: solid;
	border-width: 1px;
	border-color: gray;
	border-radius: 6px;
	padding-left: 5px;
	border-top-width: 3px;
	border-right-width: 3px;
	border-top-color: gray;
	border-right-color: gray;
}


.myError{
	color:red;
}
</style>
</head>

<body>
	<!-- 取得后台传过来的员工信息对象 -->


	<div>
		<!-- 【头部部分结束】 -->
		<div
			style="background-image: url(./Public/images/headerpic.jpg); width: 100%; height: 200px; background-repeat: repeat; background-size: 100% 200px;">
			<!-- <h1 style="text-align: center;">欢迎使用本系统</h1> -->
		</div>
		<!-- ãå¯¼èªå¼å§ã -->
		<div>
			<nav class="navbar navbar-default   mynav">
			<div class="container-fluid">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
						aria-expanded="false">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>


					<!-- <img class="navbar-brand" src="./Public/images/LOGO2.png" /> -->
				</div>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav" id="mynavUl">
						<li  id="mynavL1"><a href="./HomeController">个人信息
						</a></li>
						<li class="active" id="mynavL2"><a href="javascript:void(0);"
							>修改密码<span
								class="sr-only">(current)</span></a></li>
						<li id="munavL4"><a
							href="./HomeController?a=EnterGoodsImport" >商品采购</a>
						</li>
						<li id="mynavL3"><a
							href="./HomeController?a=EnterGoodsExport" >商品销售</a></li>
						<li id="munavL5"><a href="./HomeController?a=GoodsBack"
							target="_blank">订单和退货</a></li>
					</ul>

					<ul class="nav navbar-nav navbar-right">

						</li>

						<%
							if (session.getAttribute("username") == null) {
						%>
						<li><a href="./HomeController">登录</a> <%
 	} else {
 %>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false"><%=session.getAttribute("username")%> <span
								class="caret"></span></a>
							<ul class="dropdown-menu"
								style="background-color: #CCFFFF; font-size: 20px; font-weight: 600;">
								<li><a href="./HomeController?a=Exit">切换账户</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="./HomeController?a=Exit">退出</a></li>
							</ul></li>


						<%
							}
						%>
						<li><a href=" javascript:void(0);"> <!-- <span
								class="glyphicon glyphicon-log-out myError" aria-hidden="true"> 
								</span>&nbsp; -->注册
						</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid --> </nav>
		</div>

	</div>
	<!-- 【头部部分结束】 -->

	<div class="main">


		<!-- 【个人信息开始】 -->

		
		<!-- 【个人信息开始】 -->

		<!-- 【修改密码开始】 -->
		
		<div id="div_updatePwd"
			style=" background-image: url(./Public/images/userinfoBG.jpg); background-size: auto;">
			<div
				style="margin-left: 10%; width: 80%; border-style: solid; border-color: #99CCFF; border-width: 1px; border-radius: 6px; padding: 10px; padding-left: 5%; padding-right: 5%; margin-bottom: 20px; padding-top: 30px; background-color: transparent;height: 500px;">
				<div style="text-align: center;">
					<div>
						<h1>修改密码</h1>
					</div>
					<div style="margin-top: 20px;">
						<span class="mylabel">输入旧密码：</span> <input
							class="myUpdatePwdInput" type="password" class="myUpdateInput"
							type="text" id="oldPwd">
					</div>
					<div style="margin-top: 20px;">
						<span class="mylabel">输入新密码：</span> <input
							class="myUpdatePwdInput" type="password" class="myUpdateInput"
							type="text" id="newPwd1">
					</div>
					<div style="margin-top: 20px;">
						<span class="mylabel"> 确认新密码：</span> <input
							class="myUpdatePwdInput" type="password" class="myUpdateInput"
							type="text" id="newPwd2">
					</div>
					<div style="margin-top: 40px; font-size: 20px;">
						<input type="button" value="修改" onclick="updateStaffPwd()"
							style="width: 20%; border-radius: 6px; background-color: #CCFFCC;">
					</div>

				</div>



			</div>
			<br /> <br />
		</div>
		<!-- 【修改密码结束】 -->

	</div>


	


	<!-- ---------------------------------------------------------------------------->
	<div>
		<!-- 【尾部部分结束】 -->
		<!-- Button trigger modal -->
		<button style="display: none;" type="button"
			class="btn btn-primary btn-lg" data-toggle="modal"
			data-target="#myModal">Launch demo modal</button>

		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">欢迎使用本系统</h4>
					</div>
					<div class="modal-body">该系统为超市进销存系统</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<!-- <button type="button" class="btn btn-primary">Save changes</button> -->
					</div>
				</div>
			</div>
		</div>


		<div class="footer">
			<div>
				<span style="color: #990066"> <span
					class="glyphicon glyphicon-link" aria-hidden="true"></span> 友情链接：
				</span><a href="http://v3.bootcss.com/" target="_blank">Bootstrap</a> | <a
					href="http://glyphicons.com/" target="_blank">Glyphicons</a> | <span
					id="addLink"></span> <a href="javascript:void(0);"
					onclick="myHelpLink()">帮助</a>
			</div>
			<div>
				2016- © <a href="#">ZRY、CBF、YJB</a>
			</div>

		</div>
	</div>
	<!-- 【尾部部分结束】 -->



	<script type="text/javascript" src="./Public/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="./Public/js/jquery-2.1.4.min.js"></script>
	<script type="text/javascript" src="./Public/js/bootstrap.min.js"></script>
	<script type="text/javascript"
		src="./Public/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="./Public/js/staff.js"></script>
	<script type="text/javascript">
		function myHelpLink() {
			$(".btn-primary").click();
		}
	</script>
<a href="./students.xls">下载</a>
</body>
</html>




