<%@page import="Model.UserInfo"%>
<%@page import="Model.GoodsInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.CategoryInfo"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品销售</title>

<link href="./Public/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />

<link href="./Public/css/examAdmin.css" rel="stylesheet" type="text/css">
<link href="./Public/css/stuinfo.css" rel="stylesheet" type="text/css">
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

.myError {
	color: red;
}

body {
	background-color: #F9F6F7;
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
						<li id="mynavL1"><a href="./HomeController">个人信息<span
								class="sr-only">(current)</span>
						</a></li>
						<li id="mynavL2"><a href="./HomeController?a=UpdatePwd"
							>修改密码</a></li>
						<li id="munavL4"><a
							href="./HomeController?a=EnterGoodsImport">商品采购</a></li>
						<li id="mynavL3" class="active"><a
							href="javascript:void(0)">商品销售</a></li>
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
		<div>
			<!-- 【列表信息】 -->
			<%
				ArrayList<GoodsInfo> goodsInfoArr = (ArrayList<GoodsInfo>) request.getAttribute("goodsInfoArr");
			ArrayList<CategoryInfo> cateInfoArr = (ArrayList<CategoryInfo>) request.getAttribute("cateInfoArr");
			%>
			<h1 style="text-align: center;">商品销售</h1>
			<hr>
			<div class="row myheaderrow">
				<div class="col-sm-2 col-md-1 myfirstcol myheaderlabel">序号</div>
				<div class="col-sm-2 col-md-2 mycol myheaderlabel">商品名称</div>
				<div class="col-sm-2 col-md-1 mycol myheaderlabel">商品类型</div>
				<div class="col-sm-2 col-md-1 mycol myheaderlabel">商品价格</div>
				<div class="col-sm-2 col-md-2 mycol myheaderlabel">商品库存量</div>
				<div class="col-sm-2 col-md-2 mycol myheaderlabel">商品已售量</div>
				<div class="col-sm-2 col-md-3 mylastcol myheaderlabel">操作</div>
			</div>
			<%
				for (int i = 0; i < goodsInfoArr.size(); i++) {
					GoodsInfo g = goodsInfoArr.get(i);

					String div_sale = "div_sale" + i;
					String div_saleEnter = "div_saleEnter" + i;
					String id_number = "number" + i;
					g.GoodsName = g.GoodsName + "";
			%>
			<%
				if (i % 2 == 0) {
			%>
			<div class="row myotherrow2">
				<div class="col-sm-2 col-md-1 mycol"><%=i + 1%></div>
				<div class="col-sm-2 col-md-2 mycol"><%=g.GoodsName%></div>
				<div class="col-sm-2 col-md-1 mycol"><%=g.CateName%></div>
				<div class="col-sm-1 col-md-1 mycol"><%=g.Price%></div>
				<div class="col-sm-1 col-md-2 mycol"><%=g.TotalNumber%></div>
				<div class="col-sm-2 col-md-2 mycol"><%=g.SaleNumber%></div>

				<div  class="col-sm-2 col-md-3 mycol">
					<a style="color: #990066" href="javascript:void(0)"
						onclick="ToSale('<%=g.GoodsNum%>', '<%=g.GoodsName%>', '<%=g.CateId %>', '<%=g.CateName%>', '<%=g.Price%>', '<%=g.TotalNumber%>')"><span
						class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
						购买</a>
				</div>

				

			</div>

			<%
				} else {
			%>
			<div class="row myotherrow1">
				<div class="col-sm-2 col-md-1 mycol"><%=i + 1%></div>
				<div class="col-sm-2 col-md-2 mycol"><%=g.GoodsName%></div>
				<div class="col-sm-2 col-md-1 mycol"><%=g.CateName%></div>
				<div class="col-sm-2 col-md-1 mycol"><%=g.Price%></div>
				<div class="col-sm-2 col-md-2 mycol"><%=g.TotalNumber%></div>
				<div class="col-sm-2 col-md-2 mycol"><%=g.SaleNumber%></div>


				<div class="col-sm-3 col-md- mycol">
					<a style="color: #990066" href="javascript:void(0)"
						onclick="ToSale('<%=g.GoodsNum%>', '<%=g.GoodsName%>', '<%=g.CateId %>', '<%=g.CateName%>', '<%=g.Price%>', '<%=g.TotalNumber%>')"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
						购买</a>
				</div>
			</div>
			<%
				}
				}
			%>
		</div>
		<!-- 【列表信息】 -->

		<!-- 【个人信息结束】 -->



	</div>


	<div>
		<!-- 【购买弹出框开始】 -->
		<button id="btnToSale" style="display:none" type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#exampleModal" data-whatever="@mdo">Open modal
			for @mdo</button>
		

		<div class="modal fade" id="exampleModal" tabindex="1" role="dialog"
			aria-labelledby="exampleModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel">商品销售</h4>
					</div>
					<div class="modal-body">
							<div class="form-group">
								<label for="txtGoodsName" class="control-label">商品名称：</label>
								<input style="font-size:15px;" type="text" class="form-control" id="txtGoodsName">
							</div>
							<div class="form-group">
								<label for="selCategory" class="control-label">分类：</label>
								<select style="border-radius:6px;" id="selCategory">
									<option id="0" value="0">请选择</option>
									<%for(int k =0;k < cateInfoArr.size();k++) { CategoryInfo c = cateInfoArr.get(k); %><option  value="<%=c.CateName%>#<%=c.id %>"><%=c.CateName %></option><%} %>
								</select>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<label for="txtTotalNumber" class="control-label">剩余商品数：</label>
								<input  type="text" style="font-size:14px; border-radius:6px;padding:6px 12px;height: 34px;width:100px;" id="txtTotalNumber" placeholder="请输入..." >
							</div>
							<div class="form-group">
								<label for="txtSalePrice" class="control-label">出售价格：</label>
								<input  type="text" style="font-size:14px; border-radius:6px;padding:6px 12px;height: 34px;width:100px;" id="txtSalePrice" placeholder="请输入..." >
								&nbsp;&nbsp;&nbsp;&nbsp;
								<label for="txtSaleNumber" class="control-label">购买数量：</label>
								<input id="txtSaleNumber" type="text" style="font-size:14px; border-radius:6px;padding:6px 12px;height: 34px;width:100px;" id="txtNewSalePrice" placeholder="请输入..." >
							</div>
							<div class="form-group" id="div_totalMoney" style="display: none">
								<label style="color:#990066" for="totalMoney" class="control-label">当前消费总额为：</label>
								<span style="color:#999933" id="totalMoney"></span>
							</div>
							
					</div>
					<div class="modal-footer">
						<span id="msgToSale"></span>
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary" onclick="SureToBuy()">确定购买</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 【购买弹出框开始】 -->
	<input type="hidden" id="txtGoodsNum" value="">

	<!-- ---------------------------------------------------------------------------->
	<div>
		<!-- 【尾部部分结束】 -->
		<!-- Button trigger modal -->
		<button id="btnHelpLink" style="display: none;" type="button"
			class="btn btn-primary btn-lg" data-toggle="modal"
			data-target="#myModal1">Launch demo modal</button>

		<!-- Modal -->
		<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
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
	<script type="text/javascript" src="./Public/js/goods.js"></script>
	<script type="text/javascript">
		function myHelpLink() {
			$("#btnHelpLink").click();
		}
		
		
	</script>

</body>
</html>




