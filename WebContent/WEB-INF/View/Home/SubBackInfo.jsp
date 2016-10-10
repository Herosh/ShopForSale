<%@page import="Model.UserInfo"%>
<%@page import="Model.ExportInfo"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登记退货信息</title>

<link href="./Public/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<link href="./Public/css/index.css" rel="stylesheet" type="text/css" />

<style type="text/css">

body{
	background-color: :#f9f7f6;
}
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

.myError {
	color: red;
}

.mylabel2{
	padding-top:10px;
	font-size: 22px;
}

.myrow3{
	margin-top:10px;
}

.myinput3{
	padding:5px;
	font-size: 20px;
	border-radius:6px;
}
</style>
</head>

<body>
	<!-- 取得后台传过来的员工信息对象 -->

	<%
		ExportInfo exportInfo = (ExportInfo) request.getAttribute("exportInfo");
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
						<li id="mynavL1"><a href="./HomeController">个人信息 </a></li>
						<li id="mynavL2"><a href="./HomeController?a=UpdatePwd">修改密码</a></li>
						<li id="munavL4"><a
							href="./HomeController?a=EnterGoodsImport">商品采购</a></li>
						<li id="mynavL3"><a
							href="./HomeController?a=EnterGoodsExport">商品销售</a></li>
						<li class="active" id="munavL5"><a href="javascript:void(0)"
							target="_blank">订单和退货<span class="sr-only">(current)</span></a></li>
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
		<div
			style="margin-left: 10%; margin-right: 10%; margin-top: 40px; padding: 10px; border: 1px #99ccff none; border-radius: 6px; text-align: center">
			<h2>退货信息登记</h2>

			<fieldset style="border: 1px #99ccff solid;border-radius:6px;background-color: FFFFFF;">
				<legend style="text-align: left">商品信息</legend>
				<input type="hidden" id="txtGoodsNum" value="<%=exportInfo.GoodsNum%>">
				<input type="hidden" id="txtGoodsName" value="<%=exportInfo.GoodsName%>"> 
				<div class="row">
					<div class="col-sm-2 col-md-6 mycol" style="text-align: right">
						<span class="mylabel">商品名称：</span>
					</div>
					<div class="col-sm-2 col-md-6 mycol" style="text-align: left">
						<span class="mylabel2"><%=exportInfo.GoodsName %></span>
					</div>

				</div>
				<div class="row myrow3">
					<div class="col-sm-2 col-md-6 mycol" style="text-align: right">
						<span class="mylabel">购买数量：</span>
					</div>
					<div class="col-sm-2 col-md-6 mycol" style="text-align: left">
						<span class="mylabel2"><%=exportInfo.Number %></span>
					</div>

				</div>
				<div class="row myrow3">
					<div class="col-sm-2 col-md-6 mycol" style="text-align: right">
						<span class="mylabel">单&nbsp;&nbsp;&nbsp;&nbsp;价：</span>
					</div>
					<div class="col-sm-2 col-md-6 mycol" style="text-align: left">
						<span class="mylabel2"><%=exportInfo.Price %></span>
					</div>

				</div>
				
				<div class="row myrow3">
					<div class="col-sm-2 col-md-6 mycol" style="text-align: right">
						<span class="mylabel">消费总额：</span>
					</div>
					<div class="col-sm-2 col-md-6 mycol" style="text-align: left">
						<span class="mylabel2"><%=exportInfo.Number*exportInfo.Price %></span>
					</div>

				</div>
				<div class="row myrow3">
					<div class="col-sm-2 col-md-6 mycol" style="text-align: right">
						<span class="mylabel">购买时间：</span>
					</div>
					<div class="col-sm-2 col-md-6 mycol" style="text-align: left">
						<span class="mylabel2"><%=exportInfo.SubTime %></span>
					</div>

				</div>
				<div class="row myrow3">
					<div class="col-sm-2 col-md-6 mycol" style="text-align: right">
						<span class="mylabel">当前状态：</span>
					</div>
					<div class="col-sm-2 col-md-6 mycol" style="text-align: left">
						<span class="mylabel2"><%=exportInfo.State %></span>
					</div>

				</div>
			</fieldset >
			
			<fieldset style="border: 1px #99ccff solid;border-radius:6px;">
				<legend style="text-align:left">填写客户信息</legend>
				
				<div class="row ">
					<div class="col-sm-2 col-md-6 mycol" style="text-align: right">
						<span class="mylabel">客户姓名：</span>
					</div>
					<div class="col-sm-2 col-md-6 mycol" style="text-align: left">
						<input type="text" class="myinput3" id="txtCustName" >
					</div>

				</div>
				<div class="row myrow3">
					<div class="col-sm-2 col-md-6 mycol" style="text-align: right">
						<span class="mylabel">联系电话：</span>
					</div>
					<div class="col-sm-2 col-md-6 mycol" style="text-align: left">
						<input type="text" class="myinput3" id="txtCustPhone">
					</div>

				</div>
				<div class="row myrow3">
					<div class="col-sm-2 col-md-6 mycol" style="text-align: right">
						<span class="mylabel">退货详情：</span>
					</div>
					<div class="col-sm-2 col-md-6 mycol" style="text-align: left">
						<textarea class="myinput3" rows="" cols="" id="txtDescription"></textarea>
					</div>

				</div>
				<div class="row myrow3">
					<div class="col-sm-2 col-md-12 mycol" style="text-align: center">
						<span id="msgSubBackInfo" style="font-size :20px;"></span>
						<input type="button" style="font-size:20px;width: 20%; border-radius: 6px; background-color: #CCFFCC;" value="提交" onclick="SubBackInfo('<%=exportInfo.Id%>')">
					</div>
					

				</div>
			</fieldset>
		</div>

		<!-- 【个人信息开始】 -->

		<!-- 【修改密码开始】 -->


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
		
		//提交
		function SubBackInfo(id){
			var custName = $("#txtCustName").val();
			var custPhone = $("#txtCustPhone").val();
			var description = $("#txtDescription").val();
			
			//alert(id+custName+custPhone+description);
			if(custName != ""){
				if(custPhone != "" && CheckPhone(custPhone)){
					if(description != ""){
						//showMsg("提交", "error", "success");
						$.post("./HomeController?a=InsertBackInfo", {"id":id,"goodsNum":$("#txtGoodsNum").val(), "goodsName":$("#txtGoodsName").val(), "custName":custName, "custPhone":custPhone, "description":description}, function(rst){
							if(rst == "success"){
								showMsg("提交成功！[2秒后跳转]", "error", "success");
								setTimeout(function(){
									window.location.href="./HomeController?a=EnterGoodsBack";
								}, 2000);
							}else{
								showMsg("操作有误，请重试！", "success", "error");
							}
						});
					}else{
						showMsg("退货详情不能为空！", "success", "error");
					}
				}else{
					showMsg("联系电话格式错误！", "success", "error");
				}
			}else{
				showMsg("客户姓名不能为空！", "success", "error");
			}
		}
		
		function showMsg(msg,removeClassName, addClassName){
			$("#msgSubBackInfo").removeClass(removeClassName);
			$("#msgSubBackInfo").addClass(addClassName);
			$("#msgSubBackInfo").html(msg);
		}
		
		$("#txtCustName").focus(function(){
			showMsg("", "error", "success");
		});
		
		$("#txtCustPhone").focus(function(){
			showMsg("", "error", "success");
		});
		
		$("#txtDescription").focus(function(){
			showMsg("", "error", "success");
		});
		
		//验证联系电话的方式
		function CheckPhone(phone) {
		    var phoneReg = /^(13+\d{9})|(147+\d{8})|(150+\d{8})|(151+\d{8})|(152+\d{8})|(153+\d{8})|(155+\d{8})|(156+\d{8})|(157+\d{8})|(158+\d{8})(159+\d{8})|(180+\d{8})|(182+\d{8})|(185+\d{8})|(186+\d{8})|(187+\d{8})|(188+\d{8})|(189+\d{8})$/;

		    if (!phoneReg.test(phone) || phone.length != 11) {
		        return false;
		    }
		    return true;
		}
	</script>

</body>
</html>




