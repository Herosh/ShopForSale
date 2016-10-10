<%@page import="Model.AdminInfo"%>
<%@page import="Model.UserInfo"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript" src="./Public/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="./Public/js/admin.js"></script>

<link href="./Public/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="./Public/css/examAdmin.css" rel="stylesheet" type="text/css">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%AdminInfo admin = (AdminInfo) request.getAttribute("admin"); %>

<!--背景图片开始-->
	<div>
		<image src="./Public/images/header6.jpg" width="100%"
			height="140px">
	</div>
	<!--背景图片结束-->

	<!--顶栏开始-->
	<div class="Head bg-primary">
		管理员编号:<span><%= admin.AdminNum %></span>&nbsp;&nbsp;姓名:<span><%= admin.AdminName %></span><span class="exit"><span><a
				href="javascript:void(0)" style="color: white" onclick="relogin()">重新登录</a></span></span>
	</div>
	<!--顶栏结束-->
	<!-------------------------------------------- 主体内容开始 ------------------------------------------->
	<div class="main">
		<!--左右栏框分布源码开始-->
		<!----------------------------------左栏框开始---------------------------->
		<span class="main-left" id="div_left"> 
		<!---------------------------------左栏内容开始--------------------------->
			<div class="left-style text">
				<a href="javascript:void(0)" onclick="hiddenOp('1')">基本信息</a>
			</div>
			<div class="left-style text">
				<a href="javascript:void(0)" onclick="hiddenOp('2')">员工信息管理</a>
			</div>
			<ul style="display: none;" id="stu_ul">
				<li><a href="javascript:void(0)"
					onclick="hiddenOp2('querydiv')">查询</a></li>
				<li><a href="javascript:void(0)"
					onclick="hiddenOp2('insertdiv')">添加新员工</a></li>
				<!-- <li><a href="javascript:void(0)" onclick="test_hiddenOp('Math_test')"></a></li> -->
			</ul>
			<div class="left-style text">
				<a id="testManagebtn" href="javascript:void(0)" onclick="hiddenOp('3')">商品库存管理</a>
			</div>
			<div class="left-style text">
				<a href="#" id="b01" onclick="hiddenOp('4')">修改密码</a>
		    </div> 
			<!----------------------------------------左栏内容结束---------------->
	  </span>
	  <!--------------------------------------------左栏框结束-------------------------------------->
	  
	  
	  <!---------------------------------------------右栏框开始-------------------------------------->
		<span class="main-right" id="main_content_right" id="div_right">
			<!---------------------------右栏内容边框开始----------------------------> 
			
			<!------------------------------用户信息开始----------------------------->
			<div class="right-style" id="1">
				<h2 style="text-align: center;">用户信息</h2>
				<hr style="border: solid 1px #666666">
				<div class="right-info-style">
					<span>编号：<input type="text" class="mylabel" id="txtNum" readonly="readonly"
						value="<%= admin.AdminNum %>"></span>
				</div>
				<div class="right-info-style">
					<span>姓名：<input type="text" class="mylabel" id="txtName" readonly="readonly"
						value="<%= admin.AdminName %>" ></span>
				</div>
				<div class="right-info-style">
					<span>邮箱：<input type="text" class="mylabel" id="txtEmail"
						readonly="readonly" value="<%= admin.Email %>" ></span>
				</div>
				<!-- <div class="right-info-style"><span>联系电话：<input type="text" id="txtTel" readonly="readonly" value="13876543210" style="border:none;"></span></div> -->
				<!-- <div class="right-info-style"><span>常用邮箱：<input type="text" id="txtEmail" readonly="readonly" value="1091313628@qq.com" style="border:none;"></span></div> -->
				<div class="right-info-style">
					<span>电话：<input type="text" id="txtPhone" class="mylabel"
						readonly="readonly" value="<%= admin.Phone %>" ></span>
				</div>
				<div class="right-info-style">
					<span>注册时间：<input type="text" id="txtSubTime" class="mylabel"
						readonly="readonly" value="<%=admin.SubTime %>"
						></span>
				</div>
				<div id="div_update" style="text-align: center; margin-top: 6%;">
					<input id="updatebtn" type="button" style="width: 40%;" value="修改"
						onclick="updateAdmin()">
				</div>
				<div id="div_save" style="text-align: center; margin-top: 6%;display:none;">
					<input id="updatebtn" type="button" style="width: 20%;" value="保存"
						onclick="saveAdmin()"><input id="cancelbtn" type="button"
						style="width: 20%;" value="取消" onclick="updateAdminCancel()()">
				</div>
			</div> 
			<!------------------------------用户信息结束------------------------------> 
			
			<!----------------------------------修改密码开始-------------------------------->
			<div class="right-style" id="4" style="display: none;">
				<h2 style="text-align: center;">修改密码</h2>
				<hr style="border: solid 1px #666666">

				<div style="height: 60%; padding-top: 5%;">
					<div class="right-pwd-style">
						旧密码：<input class="right-pwd-txtStyle pwd" type="text" id="oldPwd">
					</div>
					<div class="right-pwd-style">
						新密码：<input class="right-pwd-txtStyle pwd" type="password" id="newPwd1">
					</div>
					<div class="right-pwd-style">
						确认密码：<input class="right-pwd-txtStyle pwd" type="password" id="newPwd2">
					</div>
					<div class="right-pwd-style">
						<input type="button" style="width: 20%;" value="修改" onclick="updateAdminPwd()">&nbsp;&nbsp;&nbsp;&nbsp;<input
							type="reset" style="width: 20%;" value="重置" onclick="cancel()"/>
					</div>
				</div>

			</div> 
			<!----------------------------------修改密码结束-------------------------------->
			
			<!----------------------------------员工信息管理开始（查询添加）----------------------------->
			<div class="right-style" id="2" style="display: none;">
				<!------------------ 查询开始 -------------------->
				<div id="querydiv">
					<h2 style="text-align: center;">员工信息管理</h2>
					<hr style="border: solid 1px #666666">
					<div>
						编号：<input type="text" id="txtUserNum"/>&nbsp;&nbsp;或&nbsp;名字:<input type="text" id="txtUserName"/>或&nbsp;性别:<input type="text" style="width:40px" id="txtGender"/>
						<input type="button" style="float: right;" value="导出到Excel表" onclick="window.location.href='./AdminController?a=PrintUserInfo'"/>
						<input type="button" style="float: right;" value="查询所有员工" onclick="queryAllUserInfo()"/>
						<input type="button" style="float: right;" value="条件查询" onclick="queryUserInfobyitem()"/>	
									
					</div>
					
					<div class="myrow" style="margin-top:25px;"id="showInfodiv">
						<div class="row myrow">
							<div class="col-sm-1 col-md-1 mysubrow">编号</div>
							<div class="col-sm-3 col-md-1 mysubrow">名字</div>
							<div class="col-sm-2 col-md-1 mysubrow">性别</div>
							<div class="col-sm-2 col-md-2 mysubrow">邮箱</div>
							<div class="col-sm-2 col-md-2 mysubrow">电话</div>
							<div class="col-sm-2 col-md-3 mysubrow">操作</div>
						</div>
						<div class="row myrow">
						</div>
					</div>
				</div>
				<!---------------- 查询员工结束 ----------------->
				<!---------------- 添加员工开始 ----------------->
				<div id="insertdiv" style="display: none;">
					<h2 style="text-align: center;">员工信息添加</h2>
					<hr style="border: solid 1px #666666">
					<div>
						编号:<input type="text" id="addUserNum">&nbsp;&nbsp;姓名:<input type="text" id="addUserName">&nbsp;&nbsp;性别:<input type="text" id="addGender">
							<input type="button" style="float: right;" value="添加新员工" onclick="addStuInfo()"/>
					</div>
				</div>
				<!--------------- 添加员工结束 ------------------->
			</div> 
			<!----------------------------------员工信息管理结束 （查询添加）----------------------------->
			
			<!----------------------------------商品信息管理开始（查询添加）--------------------------------->
			<div class="right-style" id="3" style="display: none;">
				<!------------------ 查询修改商品信息开始 -------------------->
				<div id="querydiv">
					<h2 style="text-align: center;">商品库存管理</h2>
					<hr style="border: solid 1px #666666">
					<div>
						编号：<input type="text" id="txtGoodsNum"/>&nbsp;&nbsp;或&nbsp;商品名:<input type="text" id="txtGoodsName"/>或&nbsp;商品类型:<input type="text" style="width:40px" id="txtCateName"/>
						<input type="button" style="float: right;" value="导出到Excel表" onclick="window.location.href='./AdminController?a=PrintAllGoodsInfo'"/>
						<input type="button" style="float: right;" value="查询所有商品" onclick="queryAllGoodsInfo()"/>
						<input type="button" style="float: right;" value="条件查询" onclick="queryGoodsInfobyitem()"/>	
									
					</div>
					
					<div class="myrow" style="margin-top:25px;" id="showInfodiv2">
						<div class="row myrow">
							<div class="col-sm-1 col-md-2 mysubrow">编号</div>
							<div class="col-sm-3 col-md-2 mysubrow">商品名</div>
							<div class="col-sm-2 col-md-2 mysubrow">商品类型</div>
							<div class="col-sm-2 col-md-2 mysubrow">销售价格</div>
							<div class="col-sm-2 col-md-1 mysubrow">库存量</div>
							<div class="col-sm-2 col-md-1 mysubrow">已售量</div>
							<div class="col-sm-2 col-md-2 mysubrow">操作</div>
						</div>
						<div class="row myrow">
						</div>
					</div>
				</div>
				<!---------------- 查询商品修改信息结束 ------------------------------->
				<!---------------- 新商品添加开始 ------------------------------->
				<div id="insertdiv" style="display: none;">
					<h2 style="text-align: center;">新商品信息添加</h2>
					<hr style="border: solid 1px #666666">
					<div>
						编号:<input type="text" id="addUserNum">&nbsp;&nbsp;姓名:<input type="text" id="addUserName">&nbsp;&nbsp;性别:<input type="text" id="addGender">
							<input type="button" style="float: right;" value="添加新员工" onclick="addStuInfo()"/>
					</div>
				</div>
				<!--------------- 修改结束 -------------------------------->
			</div> 
			<!----------------------------------商品信息管理开始（查询添加）--------------------------------->
</body>
</html>