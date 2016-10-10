<%@page import="Model.ProviderInfo"%>
<%@page import="Model.UserInfo"%>
<%@page import="Model.GoodsInfo"%>
<%@page import="Model.CategoryInfo"%>
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
<link href="./Public/css/examAdmin.css" rel="stylesheet" type="text/css">
<link href="./Public/css/stuinfo.css" rel="stylesheet" type="text/css">
<link href="./Public/css/checkbox.css" rel="stylesheet" type="text/css">
<link href="./Public/css/index.css" rel="stylesheet" type="text/css" />

<style type="text/css">
	body{
		background-color: #F9F6F7;
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
			<nav class="navbar navbar-default  mynav" style="font-size:20px;">
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
						<li class="active" id="munavL4"><a href="javascript:void(0);">商品采购<span
								class="sr-only">(current)</span></a></li>
						<li id="mynavL3"><a
							href="./HomeController?a=EnterGoodsExport">商品销售</a></li>
						<li id="munavL5"><a href="./HomeController?a=EnterGoodsBack"
							target="_blank">订单和退货</a></li>
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
		<%
			ArrayList<GoodsInfo> goodsInfoArr = (ArrayList<GoodsInfo>) request.getAttribute("goodsInfoArr");
		ArrayList<CategoryInfo> cateInfoArr = (ArrayList<CategoryInfo>) request.getAttribute("cateInfoArr");
		ArrayList<ProviderInfo> proInfoArr = (ArrayList<ProviderInfo>) request.getAttribute("proInfoArr");
		%>
		<h1 style="text-align: center;">当前库存</h1>
		<hr>
		<div class="row myheaderrow">
			<div class="col-sm-2 col-md-1 myfirstcol myheaderlabel">序号</div>
			<div class="col-sm-2 col-md-2 mycol myheaderlabel">商品名称</div>
			<div class="col-sm-2 col-md-1 mycol myheaderlabel">商品类型</div>
			<div class="col-sm-2 col-md-2 mycol myheaderlabel">商品价格(单位：元)</div>
			<div class="col-sm-2 col-md-2 mycol myheaderlabel">商品库存量</div>
			<div class="col-sm-2 col-md-1 mycol myheaderlabel">是否上架</div>
			<div class="col-sm-2 col-md-3 mylastcol myheaderlabel">操作</div>
		</div>
		<%
			for (int i = 0; i < goodsInfoArr.size(); i++) {
				GoodsInfo g = goodsInfoArr.get(i);
				//标识字符串
				String div_sale = "div_sale" + i;
				String div_saleEnter = "div_saleEnter" + i;

				String id_number = "number" + i;
				String id_price = "price" + i;
		%>
		<%
			if (i % 2 == 0) {
		%>
		<div class="row myotherrow2">
			<div class="col-sm-2 col-md-1 mycol"><%=i+1%></div>
			<div class="col-sm-2 col-md-2 mycol"><%=g.GoodsName%></div>
			<div class="col-sm-2 col-md-1 mycol"><%=g.CateName%></div>
			<div class="col-sm-2 col-md-2 mycol"><%=g.Price%></div>
			<%
				if (g.TotalNumber < 100) {
			%>
			<div class="col-sm-2 col-md-2 mycol">
				<span style="color: red;"><%=g.TotalNumber%></span>
			</div>
			<%
				} else {
			%>
			<div class="col-sm-2 col-md-2 mycol">
				<span><%=g.TotalNumber%></span>
			</div>
			<%
				}
			%>
			<!-- <div class="col-sm-2 col-md-1 mycol ">否</div> -->
			<%
				if (g.IsSale == 0) {
			%>
			<div class="col-sm-2 col-md-1 mycol ">否</div>
			<%
				} else {
			%>
			<div class="col-sm-2 col-md-1 mycol ">是</div>
			<%
				}
			%>
			<div id="<%=div_sale%>" class="col-sm-2 col-md-3 mycol">
				<a style="color:#990066;" href="javascript:void(0);" onclick="ToImport('<%=g.GoodsNum %>','<%=g.GoodsName %>', '<%=g.CateName %>#<%=g.CateId %>','<%=g.Price%>', '<%=g.TotalNumber%>','<%=g.IsSale%>')"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> 采购</a> |
				<%
					if (g.IsSale == 0) {
				%>
				<a href="javascript:void(0);" style="color:#669900" onclick="UpToSale('<%=g.GoodsNum%>')"><span
					class="glyphicon glyphicon-upload" aria-hidden="true"></span> 上架</a>
				<%
					} else {
				%>
				<a href="javascript:void(0);" style="color:#FF9999"
					onclick="DownToSale('<%=g.GoodsNum%>')"><span
					class="glyphicon glyphicon-download" aria-hidden="true"></span> 下架</a>
				<%
					}
				%>

			</div>

			<div id="<%=div_saleEnter%>" style="display: none"
				class="col-sm-2 col-md-5 mycol">
				数量：<input id="<%=id_number%>" type="text"
					style="width: 40px; height: 25px">&nbsp;&nbsp; 入货价：<input
					id="<%=id_price%>" type="text" style="width: 60px; height: 25px">&nbsp;&nbsp;
				<a
					onclick="goodsImport('<%=i%>','<%=g.GoodsNum%>','<%=g.GoodsName%>')">确认入货</a>&nbsp;&nbsp;<a
					onclick="saleCancel(<%=i%>)">取消</a>
			</div>

		</div>

		<%
			} else {
		%>
		<div class="row myotherrow1">
			<div class="col-sm-2 col-md-1 mycol"><%=i+1%></div>
			<div class="col-sm-2 col-md-2 mycol"><%=g.GoodsName%></div>
			<div class="col-sm-2 col-md-1 mycol"><%=g.CateName%></div>
			<div class="col-sm-2 col-md-2 mycol"><%=g.Price%></div>
			<%
				if (g.TotalNumber < 100) {
			%>
			<div class="col-sm-2 col-md-2 mycol">
				<span style="color: red;"><%=g.TotalNumber%></span>
			</div>
			<%
				} else {
			%>
			<div class="col-sm-2 col-md-2 mycol">
				<span><%=g.TotalNumber%></span>
			</div>
			<%
				}
			%>
			<!-- <div class="col-sm-2 col-md-1 mycol ">否</div> -->
			<%
				if (g.IsSale == 0) {
			%>
			<div class="col-sm-2 col-md-1 mycol ">否</div>
			<%
				} else {
			%>
			<div class="col-sm-2 col-md-1 mycol ">是</div>
			<%
				}
			%>

			<div id="<%=div_sale%>" class="col-sm-2 col-md-3 mycol">
				<a style="color:#990066;" href="javascript:void(0);" onclick="ToImport('<%=g.GoodsNum %>','<%=g.GoodsName %>', '<%=g.CateName %>#<%=g.CateId %>','<%=g.Price%>', '<%=g.TotalNumber%>','<%=g.IsSale%>')"><span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span> 采购</a> |
				<%
					if (g.IsSale == 0) {
				%>
				<a href="javascript:void(0);" style="color:#669900" onclick="UpToSale('<%=g.GoodsNum%>')"><span
					class="glyphicon glyphicon-upload" aria-hidden="true"></span> 上架</a>
				<%
					} else {
				%>
				<a href="javascript:void(0);" style="color:#FF9999"
					onclick="DownToSale('<%=g.GoodsNum%>')"><span
					class="glyphicon glyphicon-download" aria-hidden="true"></span> 下架</a>
				<%
					}
				%>

			</div>

			<div id="<%=div_saleEnter%>" style="display: none"
				class="col-sm-2 col-md-5 mycol">
				数量：<input id="<%=id_number%>" type="text"
					style="width: 40px; height: 25px">&nbsp;&nbsp; 入货价：<input
					id="<%=id_price%>" type="text" style="width: 60px; height: 25px">&nbsp;&nbsp;
				<a
					onclick="goodsImport('<%=i%>','<%=g.GoodsNum%>','<%=g.GoodsName%>')">确认入货</a>&nbsp;&nbsp;<a
					onclick="saleCancel(<%=i%>)">取消</a>
			</div>

		</div>
		<%
			}
		%>
		<%
			}
		%>
		<div style="width: 100%; margin-top: 20px;">

			<div class="col-md-12" style="text-align: right; border-style: none;">
				<span style="border: 1px solid blue; border-radius: 6px; padding: 5px; background-color: #FFFFCC;margin-right:10px;">
					<a href="javascript:void(0);" onclick="myAddGoods()"><span class="glyphicon glyphicon-plus"
						aria-hidden="true"></span> 新增商品</a>
				</span>
				
				<span
					style="border: 1px solid blue; border-radius: 6px; padding: 5px; background-color: #FFFFCC;">
					<a href="javascript:void(0);" onclick="myAddCotegory()"><span class="glyphicon glyphicon-plus"
						aria-hidden="true"></span> 新增商品分类</a>
				</span>
			</div>
		</div>




	</div>
	<!-- main -->
	<div>
		<!-- 【采购页面】 -->
		<button id="btnAddGoods" style="display:none" type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#exampleModal" data-whatever="@mdo">Open modal
			for @mdo</button>

		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="ModalLabel">新增商品</h4>
					</div>
					<div class="modal-body">
						<form>
							<div class="form-group">
								<label for="txtNewGoodsName" class="control-label">商品名称</label>
								<input type="text" class="form-control" id="txtNewGoodsName" placeholder="请输入...">
							</div>
							<div class="form-group">
								<label for="selNewCategory" class="control-label">分类：</label>
								<select style="border-radius:6px;" id="selNewCategory">
									<option id="0" value="0">请选择</option>
									<%for(int k =0;k < cateInfoArr.size();k++) { CategoryInfo c = cateInfoArr.get(k); %><option  value="<%=c.CateName%>#<%=c.id %>"><%=c.CateName %></option><%} %>
								</select>
							</div>
							<div class="form-group">
								<label for="txtNewSalePrice" class="control-label">出售价格：</label>
								<input type="text" style="font-size:14px; border-radius:6px;padding:6px 12px;height: 34px;" id="txtNewSalePrice" placeholder="请输入..." >
								&nbsp;&nbsp;
								<label for="isUpToSale">是否立即上架： </label>
								<input type="checkbox" id="isUpToSale" class="chk_1" /> 
								<label for="isUpToSale">&nbsp;&nbsp;&nbsp;&nbsp;</label>
							</div>
							<hr>
							
							<div class="form-group"><!-- 【选择供货商开始】 -->
								<label for="selProviderName" class="control-label">供货商（选填）：</label> 
								<select style="border-radius:6px;" id="selProviderName" onchange="ShowImportInfo()">
									<option value="0">请选择</option>
									<%for(int k =0;k < proInfoArr.size();k++) { ProviderInfo p = proInfoArr.get(k); %><option  value="<%=p.ProvideName%>#<%=p.id %>"><%=p.ProvideName %></option><%} %>
								</select>
							</div><!-- 【选择供货商开始】 -->
							<div class="form-group" id="div_importInfo" style="display:none;"><!-- 【选择供货商开始】 -->
								&nbsp;&nbsp;
								<label for="txtNewTotalNumber" class="control-label" >初始入货量：</label> 
								<input type="text" style="border-radius:6px;width:80px;padding:6px 12px;height: 34px;" id="txtNewTotalNumber" value="0" >
								&nbsp;&nbsp;
								<label for="txtNewPrice" class="control-label">进货价格：</label> 
								<input type="text" style="border-radius:6px;width:80px;padding:6px 12px;height: 34px;" id="txtNewPrice" >
							</div><!-- 【选择供货商结束】 -->
							
							<div class="form-group">
								<label for="txtNewRemark" class="control-label">备注信息（选填）:</label>
								<textarea class="form-control" id="txtNewRemark" placeholder="请输入250字以内的信息..." ></textarea>
								
							</div>
							
						</form>
					</div>
					<div class="modal-footer">
						<span id="msgNewGoodsInfo"></span>
						<span onclick="CancelNewGoodsInfo()"><button type="button" class="btn btn-default" data-dismiss="modal" >取消</button></span>
						<span id="span_btnSave"><button type="button" class="btn btn-primary" onclick="SaveNewGoodsInfo()">保存</button></span> 
						
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="myGoodsNum" value="">
	<!-- 【采购页面】 -->

	<!-- 【新增商品页面】 -->
	
	<button id="btnAddGoodsCategory" style="display:none" type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#exampleModa2" data-whatever="@mdo">Open modal
			for @mdo</button>

		<div class="modal fade" id="exampleModa2" tabindex="1" role="dialog"
			aria-labelledby="exampleModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="exampleModalLabel">新增商品分类</h4>
					</div>
					<div class="modal-body">
						<form>
							<div class="form-group">
								<label for="recipient-name" class="control-label">分类名字</label>
								<input type="text" class="form-control" id="txtCateName">
							</div>
							<div style="margin-bottom:10px;color:gray;margin-left:10px;">已存在的分类：<%for(int k =0;k < cateInfoArr.size();k++) { CategoryInfo c = cateInfoArr.get(k); %>【<%=c.CateName %>】<%} %></div>
							<div class="form-group">
								<label for="message-text" class="control-label">备注信息（选填）</label>
								<textarea class="form-control" id="txtCateRemark" placeholder="请输入..." ></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<span  id="msgSaveCategory"></span>&nbsp;&nbsp;
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary" onclick="SaveNewCategory()">保存</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 【新增商品页面】 -->



	<!-- ---------------------------------------------------------------------------->
	<div>
		<!-- 【尾部部分结束】 -->
		<!-- Button trigger modal -->
		<button style="display: none;" type="button"
			class="btn btn-primary btn-lg" data-toggle="modal"
			data-target="#myModal" id="btnHelpLink">Launch demo modal</button>

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
				2016- © <a href="#">ZRY、CBF、YJB </a>
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
	<script type="text/javascript" src="./Public/js/goods.js"></script>
	<script type="text/javascript" src="./Public/js/checkbox.js"></script>
	<script type="text/javascript">
		function myHelpLink() {
			//$(".btn-primary").click();
			$("#btnHelpLink").click();
		}
		
		//商品新增
		function myAddGoods(){
			
			ShowByType("Add");
		}
		
		//商品类型新增
		function myAddCotegory(){
			$("#btnAddGoodsCategory").click();
		}
	</script>

</body>
</html>




