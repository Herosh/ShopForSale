<%@page import="Model.UserInfo"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>员工主页</title>

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
	<%
		UserInfo user = (UserInfo) request.getAttribute("user");
	%>

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
						<li class="active" id="mynavL1"><a href="javascript:void(0);">个人信息<span
								class="sr-only">(current)</span>
						</a></li>
						<li id="mynavL2"><a href="./HomeController?a=UpdatePwd"
							>修改密码</a></li>
						<li id="munavL4"><a
							href="./HomeController?a=EnterGoodsImport" >商品采购</a>
						</li>
						<li id="mynavL3"><a
							href="./HomeController?a=EnterGoodsExport" >商品销售</a></li>
						<li id="munavL5"><a href="./HomeController?a=EnterGoodsBack"
							>订单和退货</a></li>
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

		<div id="div_userInfo"
			style="background-image: url(./Public/images/userinfoBG.jpg); background-size: auto;">
			<div
				style="margin-left: 10%; margin-right: 10%; width: 80%; border-style: solid; border-color: #99CCFF; border-width: 1px; border-radius: 6px; padding: 10px; padding-left: 5%; padding-right: 5%; margin-bottom: 20px; padding-top: 30px;">

				<div class="myinfo-second">
					<span> <span class="mylabel">编号：</span>
					</span>&nbsp; <span class="myinfo-tip"><input type="text"
						id="txtNum" readonly="readonly" value="<%=user.UserNum%>"
						style="border: none;"></span>
				</div>

				<hr class="myhr">
				<div class="myinfo-second">
					<span><span class="mylabel">姓名：</span></span>&nbsp;<span
						class="myinfo-tip"><input readonly="readonly" class="txtCanEdit myHideUpdateInput" value="<%=user.UserName%>" id="txtName" /> </span>&nbsp; <span class="CanEditTrip"><span
						class="glyphicon glyphicon-edit" aria-hidden="true"></span><span
						id="TrueName_Input_Msg"></span> </span>
				</div>
				<hr class="myhr">
				<div class="myinfo-second">
					<span><span class="mylabel">性别：</span></span>&nbsp;<span
						class="myinfo-tip"><span id="Gender_Man"> 男</span><input
						type="radio" name="Gender" checked="checked" class="radio_gender"
						value="man"> <span>女</span><input type="radio"
						name="Gender" class="radio_gender" value="woman"> <span>保密</span><input
						type="radio" name="Gender" class="radio_gender" value="no"></span>&nbsp;
					<span class="CanEditTrip"><span
						class="glyphicon glyphicon-edit" aria-hidden="true"></span><span
						id="Gender_Input_Msg"></span></span>
				</div>
				<hr class="myhr">

				<div class="myinfo-second">
					<span><span class="mylabel">邮箱：</span></span>&nbsp;<span
						class="myinfo-tip"><input readonly="readonly" class="txtCanEdit myHideUpdateInput" value="<%=user.Email%>" id="txtEmail" /> </span>&nbsp; <span class="CanEditTrip"><span
						class="glyphicon glyphicon-edit" aria-hidden="true"></span><span
						id="DeviceId_Input_Msg"></span></span>
				</div>
				<hr class="myhr">
				<div class="myinfo-second">
					<span><span class="mylabel">手机号码：</span></span>&nbsp;<span
						class="myinfo-tip"><input readonly="readonly" class="txtCanEdit myHideUpdateInput" value="<%=user.Phone%>" id="txtPhone" /></span>&nbsp; <span class="CanEditTrip"><span
						class="glyphicon glyphicon-edit" aria-hidden="true"></span><span
						id="Phone_Input_Msg"></span></span>
				</div>

				<hr class="myhr">
				<div class="myinfo-second">
					<span><span class="mylabel">注册时间：</span></span>&nbsp;<span
						class="myinfo-tip"><input type="text" id="txtSubTime"
						readonly="readonly" value="<%=user.SubTime%>"
						style="border: none; background: transparent;"></span>
				</div>


				<div style="text-align: center; margin-top: 40px; font-size: 20px;">
					<div id="div_update">
						<input type="button" value="修改" onclick="update()" class="myBtn"
							style="width: 30%; border-radius: 6px; background-color: #CCFFCC;" />
					</div>

					<div id="div_save" style="display: none;">
						<input type="button" value="保存" onclick="save()"
							style="width: 30%; border-radius: 6px; background-color: #CCFFCC;" />
						<input type="button" value="取消" onclick="updateCancel()"
							style="width: 30%; border-radius: 6px; background-color: #CCFFCC;" />
					</div>
				</div>


			</div>
			<br /> <br />
		</div>
		<!-- 【个人信息开始】 -->

		<!-- 【修改密码开始】 -->
		<div id="div_updatePwd"
			style="display: none; background-image: url(./Public/images/userinfoBG.jpg); background-size: auto;">
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

	<%-- 员工基本信息：<br/>
编号：<input type="text" id="txtNum" readonly="readonly" value="<%=user.UserNum %>" style="border: none;"><br/>
姓名：<input type="text" id="txtName" readonly="readonly" value="<%=user.UserName %>" style="border: none;"><br/>
邮箱：<input type="text" id="txtEmail" readonly="readonly" value="<%=user.Email %>" style="border: none;"><br/>
电话：<input type="text" id="txtPhone" readonly="readonly" value="<%=user.Phone %>" style="border: none;"><br/>
性别：<input type="text" id="txtGender" readonly="readonly" value="<%=user.Gender %>" style="border: none;"><br/>
注册时间：<input type="text" id="txtSubTime" readonly="readonly" value="<%=user.SubTime %>" style="border: none;"><br/>
<div id="div_update">
	<input type="button"  value="修改" onclick="update()" class="myBtn">
</div>
<div id="div_save" style="display: none">
	<input type="button"  value="保存" onclick="save()">
	<input type="button"  value="取消" onclick="updateCancel()">
</div>
<hr> --%>
	<!-- ---------------------------------------------------------------------- -->

	<!-- ---------------------------------------------------------------------- -->

	<!-- ----------------------------------------------------------------------------->
	<!-- 退货处理：
	<br />
	<div>
		销售单号：<input id="exportId" type="text" /><input type="button"
			value="查询单号" onclick="QueryExportInfoByExportId()">
	</div>
	<div id="div_showExportInfo" style="display: none;">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<h3>查询结果:</h3>
		销售单号：<input type="text" id="id" readonly="readonly"
			style="border: none;"><br /> 商品编号：<input type="text"
			id="goodsNum" readonly="readonly" style="border: none;">&nbsp;&nbsp;商品名称：<input
			type="text" id="goodsName" readonly="readonly" style="border: none;"><br />
		销售数量：<input type="text" id="number" readonly="readonly"
			style="border: none;">&nbsp;&nbsp;销售价格：<input type="text"
			id="price" readonly="readonly" style="border: none;"><br />
		销售员编号：<input type="text" id="userNum" readonly="readonly"
			style="border: none;">销售员名字：<input type="text" id="userName"
			readonly="readonly" style="border: none;"><br /> <input
			id="1" type="button" value="退货" onclick="saleBack1()">
		<div id="2" style="display: none;">
			<h3>填写退货信息:</h3>
			顾客电话:&nbsp;<input type="text" id="customerPhone">&nbsp;&nbsp;&nbsp;&nbsp;
			顾客名字:&nbsp;<input type="text" id="customerName"><br /> <br />
			退货描述:&nbsp;<input type="text" style="width: 600px" id="description"><br />
			<br /> <input type="button" value="确认退货" onclick="saleBack2()">
		</div>
	</div>


	<hr /> -->
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

</body>
</html>




