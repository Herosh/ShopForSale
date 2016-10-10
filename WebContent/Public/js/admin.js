//--------------------------------修改管理员密码-------------------------------
function updateAdminPwd(){
	
	var oldPwd=$("#oldPwd").val();
	var newPwd1=$("#newPwd1").val();
	var newPwd2=$("#newPwd2").val();
	
	if(oldPwd!=""){
		if(newPwd1!=""){
			if(newPwd2!=""){
				if(newPwd1==newPwd2){
			
					$.post('./AdminController', {"oldPwd" : oldPwd , "newPwd" : newPwd1 , "a" : "updateAdminPwd"
					} , function(rst) {
						if (rst == "success") { // 返回"success"，密码修改成功
							alert("修改成功！");
						} else if (rst == "error") { // 返回"error",用户名和密码验证失败
							alert("旧密码错误！");
						} else {
							alert("deng");
						}
					});
				}else{
					alert("前后输入的新密码不一致！");
				}
			}else{
				alert("请确认新密码！");
			}
		}else{
			alert("请输入新密码！");
		}
	}else{
		alert("请输入旧密码！");
	}
}

//修改密码重置按钮事件
function cancel(){
	$("#oldPwd").val("");
	$("#newPwd1").val("");
	$("#newPwd2").val("");
}
//--------------------------------用户信息修改按钮事件-------------------------------
//修改按钮事件
function updateAdmin() {
	//
	$("#txtName").css("border", "solid");
	$("#txtName").removeAttr("readonly");
	
	$("#txtEmail").css("border", "solid");
	$("#txtEmail").removeAttr("readonly");
	
	$("#txtPhone").css("border", "solid");
	$("#txtPhone").removeAttr("readonly");
	
	//
	$("#div_update").css("display","none");
	//$("#div_update").addClass("myHide");
	
	$("#div_save").css("display","inline");
	//$("#div_save").addClass("myShow");
	
	//$(".canEdit").css("display","inline");
}

//取消按钮事件
function updateAdminCancel() { 
	//
	$("#txtName").attr("readonly", "readonly");
	$("#txtName").css("border", "none");
	
	$("#txtEmail").attr("readonly", "readonly");
	$("#txtEmail").css("border", "none");
	
	$("#txtPhone").attr("readonly", "readonly");
	$("#txtPhone").css("border", "none");
	
	//
	$("#div_update").css("display","inline");
	$("#div_save").css("display","none");
	
}

//保存按钮事件
function saveAdmin(){
	var UserNum = $("#txtNum").val();

	var UserName = $("#txtName").val();
	var Email = $("#txtEmail").val();
	var Phone = $("#txtPhone").val();
	
	if(UserName != ""){
		if(Phone != ""){
			if(Email!=""){
				//全部验证完成，可以执行提交
				$.post("./AdminController", {"UserName":UserName , "Email":Email , "Phone":Phone , "a":"UpdateAdminInfo"}, function(rst){
					if(rst == "success"){
						alert("保存成功！");
					}else{
						alert("修改失败，请重试！");
					}
				});
			}else{
				alert("邮箱不能为空！");
				$("#txtEmail").focus();
			}
		}else{
			alert("电话不能为空！");
			$("#txtPhone").focus();
		}
	}else{
		alert("姓名不能为空！");
		$("#txtName").focus();
	}
	
}
//--------------------------------员工信息管理事件------------------------------------
//左边栏显隐按钮
function hiddenOp(i){
	if(i==1){
		$("#1").css("display","inline");
		$("#2").css("display","none");
		$("#3").css("display","none");
		$("#4").css("display","none");
		$("#stu_ul").css("display","none");
	}else if(i==4){
		$("#4").css("display","inline");
		$("#2").css("display","none");
		$("#3").css("display","none");
		$("#1").css("display","none");
		$("#stu_ul").css("display","none");
	}else if(i==2){
		$("#2").css("display","inline");
		$("#stu_ul").css("display","inline");
		$("#4").css("display","none");
		$("#3").css("display","none");
		$("#1").css("display","none");
	}else{
		$("#3").css("display","inline");
		$("#2").css("display","none");
		$("#stu_ul").css("display","none");
		$("#4").css("display","none");
		$("#1").css("display","none");
	}
	
}
//员工信息查询或插入显隐
function hiddenOp2(i){
	if(i=="querydiv"){
		$("#querydiv").css("display","inline");
		$("#insertdiv").css("display","none");
	}else{
		$("#querydiv").css("display","none");
		$("#insertdiv").css("display","inline");
	}
	
}
//员工信息修改按钮显隐操作
function tb_showhidden3(userNumId,userNameId,emailId,phoneId,genderId,frontlinkId,backlinkId){
	$("#"+frontlinkId).css("display","none");
	$("#"+backlinkId).css("display","inline");
	
	$("#"+userNumId).css("border", "solid");
	$("#"+userNumId).removeAttr("readonly");
	
	$("#"+userNameId).css("border", "solid");
	$("#"+userNameId).removeAttr("readonly");
	
	$("#"+genderId).css("border", "solid");
	$("#"+genderId).removeAttr("readonly");
	
	$("#"+emailId).css("border", "solid");
	$("#"+emailId).removeAttr("readonly");
	
	$("#"+phoneId).css("border", "solid");
	$("#"+phoneId).removeAttr("readonly");
}
//员工信息取消按钮显隐操作
function tb_cancel3(userNumId, userNameId, genderId, emailId, phoneId, frontlinkId, backlinkId){
	$("#"+userNumId).attr("readonly", "readonly");
	$("#"+userNumId).css("border", "none");
	
	$("#"+userNameId).attr("readonly", "readonly");
	$("#"+userNameId).css("border", "none");
	
	$("#"+genderId).attr("readonly", "readonly");
	$("#"+genderId).css("border", "none");
	
	$("#"+emailId).attr("readonly", "readonly");
	$("#"+emailId).css("border", "none");
	
	$("#"+phoneId).attr("readonly", "readonly");
	$("#"+phoneId).css("border", "none");
	
	$("#"+backlinkId).css("display","none");
	$("#"+frontlinkId).css("display","inline");
}
//------------------------------
//添加新员工
function addStuInfo(){
	var userNum=$("#addUserNum").val();
	var userName=$("#addUserName").val();
	var gender=$("#addGender").val();
	
	$.post("./AdminController", {"userNum":userNum, "userName":userName, "gender":gender, "a":"AddUserInfo"}, function(rst){
		if(rst == "success"){
			alert("添加成功！");
		}else{
			alert("添加失败，请重试！");
		}
	});
}
//查询所有员工并于网页上排列
function queryAllUserInfo(){
	$.post("./AdminController", {"a":"QueryAllUserInfo"}, function(rst){
		//alert(rst);
		var obj = JSON.parse(rst);

		var showInfodiv = $("#showInfodiv");
		showInfodiv.html("");// 清空该版的内容
		
		var total = obj["Total"];
		//拼头部
		showInfodiv.append("<div class='row myrow'>"+
		"<div class='col-sm-1 col-md-1 mysubrow'>编号</div>"+
		"<div class='col-sm-2 col-md-1 mysubrow'>姓名</div>"+
		"<div class='col-sm-2 col-md-1 mysubrow'>性别</div>"+
		"<div class='col-sm-3 col-md-2 mysubrow'>电话</div>"+
		"<div class='col-sm-2 col-md-3 mysubrow'>邮箱</div>"+
		"<div class='col-sm-2 col-md-3 mysubrow'>操作</div>"+
		"</div>");
		//拼内容
		for(var i=0;i<total;i++){//遍历输入每一条数据
			//拼id键值，用于区分每一条数据,需要定位的地方都定义一个id来辨别
			var showInfodivId = "showInfodivId"+i;
			
			var userNumId = "userNum"+i;
			var userNameId = "userName"+i;
			var emailId = "email"+i;
			var phoneId = "phone"+i;
			var genderId  = "gender"+i;
			
			var frontlinkId = "frontlink"+i;//修改删除
			var backlinkId = "backlink"+i;//确认取消
			
			var olduserNum = obj["Row"][i].userNum;//用于删除用户时作为传到后台数据处理的依据，而且编号更改后要及时更新
			var newNum="newNum"+i;
			
			//拼标签
			var str1 = "<div id='"+frontlinkId+"'><a href='javascript:void(0)' onclick="+"tb_showhidden3('"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">修改</a>" +"/"+ "<a href='javascript:void(0)' onclick="+"deleteUserInfo('"+userNumId+"','"+showInfodivId+"')"+">删除</a></div>";
			var str2 = "<div id='"+backlinkId+"' style='display:none;'><a href='javascript:void(0)' onclick="+"updateStuInfo('"+olduserNum+"','"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"','"+showInfodivId+"','"+newNum+"')"+">确定</a>" +"/"+"<a href='javascript:void(0)' onclick="+"tb_cancel3('"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">取消</a></div>";

			var str_stuNum = "<input type='text' id='"+userNumId+"' readonly='readonly' value="+obj["Row"][i].userNum+" style='border:none;'>";
			var str_stuName = "<input type='text' id='"+userNameId+"' readonly='readonly' value="+obj["Row"][i].userName+" style='border:none;width:141px;'>";
			//var str_className = "<input type='text' id='"+classNameId+"' readonly='readonly' value="+obj["Row"][i].ClassName+" style='border:none;width:141px;'>";
			// StuInfo stuInfo = StuInfoArr.get(i);
			var str_email = "<input type='text' id='"+emailId+"' readonly='readonly' value="+obj["Row"][i].email+" style='border:none;'>";
			var str_phone = "<input type='text' id='"+phoneId+"' readonly='readonly' value="+obj["Row"][i].phone+" style='border:none;'>";
			var str_gender = "<input type='text' id='"+genderId+"' readonly='readonly' value="+obj["Row"][i].gender+" style='border:none;'>";
			
			//拼内容
			showInfodiv.append("<div class='row myrow' style='height:35px;' id='"+showInfodivId+"'>"+
			//"<div class='col-sm-1 col-md-1 mysubrow' style='height:29px;'>"+(i+1)+"</div>"+
			"<div class='col-sm-3 col-md-1 mysubrow'>"+str_stuNum+"</div>"+
			"<div class='col-sm-2 col-md-1 mysubrow'>"+str_stuName+"</div>"+
			"<div class='col-sm-2 col-md-1 mysubrow'>"+str_gender+"</div>"+
			"<div class='col-sm-2 col-md-2 mysubrow'>"+str_phone+"</div>"+
			"<div class='col-sm-3 col-md-3 mysubrow'>"+str_email+"</div>"+
			//"<div class='col-sm-2 col-md-2 mysubrow' style='height:29px;'><a href='javascript:void(0)' onclick="+"queryScore('"+stuNumId+"')"+">成绩查询</a></div>"+
			"<div id='newNum' class='col-sm-2 col-md-3 mysubrow' style='height:29px;'>"+str1+str2+"</div>"+
			"</div>");
		}
			
	});
}
//条件查询员工信息并展示
function queryUserInfobyitem(){
	var txtUserNum = $("#txtUserNum").val();
	var txtUserName = $("#txtUserName").val();
	var txtGender=$("#txtGender").val();
	
	if(txtUserNum == ""&&txtUserName == ""&&txtGender==""){
		alert("条件为空无法查询");
	}else{
		$.post("./AdminController", {"txtUserNum":txtUserNum, "txtUserName":txtUserName, "txtGender":txtGender, "a":"QueryUserInfoByItem"}, function(rst){
			if(rst!=null){
				//alert(rst);
				var obj = JSON.parse(rst);

				var showInfodiv = $("#showInfodiv");
				showInfodiv.html("");// 清空该版的内容
				
				var total = obj["Total"];
				//拼头部
				showInfodiv.append("<div class='row myrow'>"+
				"<div class='col-sm-1 col-md-1 mysubrow'>编号</div>"+
				"<div class='col-sm-2 col-md-1 mysubrow'>姓名</div>"+
				"<div class='col-sm-2 col-md-1 mysubrow'>性别</div>"+
				"<div class='col-sm-3 col-md-2 mysubrow'>电话</div>"+
				"<div class='col-sm-2 col-md-3 mysubrow'>邮箱</div>"+
				"<div class='col-sm-2 col-md-3 mysubrow'>操作</div>"+
				"</div>");
				//拼内容
				for(var i=0;i<total;i++){//遍历输入每一条数据
					//拼id键值，用于区分每一条数据,需要定位的地方都定义一个id来辨别
					var showInfodivId = "showInfodivId"+i;
					
					var userNumId = "userNum"+i;
					var userNameId = "userName"+i;
					var emailId = "email"+i;
					var phoneId = "phone"+i;
					var genderId  = "gender"+i;
					
					var frontlinkId = "frontlink"+i;//修改删除
					var backlinkId = "backlink"+i;//确认取消
					
					var olduserNum = obj["Row"][i].userNum;//用于删除用户时作为传到后台数据处理的依据，而且编号更改后要及时更新
					var newNum="newNum"+i;
					
					//拼标签
					var str1 = "<div id='"+frontlinkId+"'><a href='javascript:void(0)' onclick="+"tb_showhidden3('"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">修改</a>" +"/"+ "<a href='javascript:void(0)' onclick="+"deleteUserInfo('"+userNumId+"','"+showInfodivId+"')"+">删除</a></div>";
					var str2 = "<div id='"+backlinkId+"' style='display:none;'><a href='javascript:void(0)' onclick="+"updateStuInfo('"+olduserNum+"','"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"','"+showInfodivId+"','"+newNum+"')"+">确定</a>" +"/"+"<a href='javascript:void(0)' onclick="+"tb_cancel3('"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">取消</a></div>";

					var str_stuNum = "<input type='text' id='"+userNumId+"' readonly='readonly' value="+obj["Row"][i].userNum+" style='border:none;'>";
					var str_stuName = "<input type='text' id='"+userNameId+"' readonly='readonly' value="+obj["Row"][i].userName+" style='border:none;width:141px;'>";
					//var str_className = "<input type='text' id='"+classNameId+"' readonly='readonly' value="+obj["Row"][i].ClassName+" style='border:none;width:141px;'>";
					// StuInfo stuInfo = StuInfoArr.get(i);
					var str_email = "<input type='text' id='"+emailId+"' readonly='readonly' value="+obj["Row"][i].email+" style='border:none;'>";
					var str_phone = "<input type='text' id='"+phoneId+"' readonly='readonly' value="+obj["Row"][i].phone+" style='border:none;'>";
					var str_gender = "<input type='text' id='"+genderId+"' readonly='readonly' value="+obj["Row"][i].gender+" style='border:none;'>";
					
					//拼内容
					showInfodiv.append("<div class='row myrow' style='height:35px;' id='"+showInfodivId+"'>"+
					//"<div class='col-sm-1 col-md-1 mysubrow' style='height:29px;'>"+(i+1)+"</div>"+
					"<div class='col-sm-3 col-md-1 mysubrow'>"+str_stuNum+"</div>"+
					"<div class='col-sm-2 col-md-1 mysubrow'>"+str_stuName+"</div>"+
					"<div class='col-sm-2 col-md-1 mysubrow'>"+str_gender+"</div>"+
					"<div class='col-sm-2 col-md-2 mysubrow'>"+str_phone+"</div>"+
					"<div class='col-sm-3 col-md-3 mysubrow'>"+str_email+"</div>"+
					//"<div class='col-sm-2 col-md-2 mysubrow' style='height:29px;'><a href='javascript:void(0)' onclick="+"queryScore('"+stuNumId+"')"+">成绩查询</a></div>"+
					"<div id='newNum' class='col-sm-2 col-md-3 mysubrow' style='height:29px;'>"+str1+str2+"</div>"+
					"</div>");
				}
			}
		});
	}
}
//修改员工信息
function updateStuInfo(oldUserNum, userNumId, userNameId, emailId, phoneId, genderId, frontlinkId, backlinkId, showInfodivId, newNum){
	
	var newUserNum = $("#"+userNumId).val();
	var newUserName = $("#"+userNameId).val();
	var newGender = $("#"+genderId).val();
	var newEmail = $("#"+emailId).val();
	var newPhone = $("#"+phoneId).val();
	alert(newUserNum+newUserName+newGender+newEmail+newPhone);
	
	/*var str1 = "<div id='"+frontlinkId+"'><a href='javascript:void(0)' onclick="+"tb_showhidden3('"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">修改</a>" +"/"+ "<a href='javascript:void(0)' onclick="+"deleteUserInfo('"+userNumId+"','"+showInfodivId+"')"+">删除</a></div>";
	var str2 = "<div id='"+backlinkId+"' style='display:none;'><a href='javascript:void(0)' onclick="+"updateStuInfo('"+oldUserNum+"','"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">确定</a>" +"/"+"<a href='javascript:void(0)' onclick="+"tb_cancel3('"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">取消</a></div>";
	var newNum = $("#newNum");
	*/
	$.post("./AdminController", {"a":"UpdateUserInfo", "oldUserNum":oldUserNum, "newUserNum":newUserNum, "newUserName":newUserName, "newGender":newGender, "newEmail":newEmail, "newPhone":newPhone }, function(rst){
		tb_cancel3(userNumId, userNameId, genderId, emailId, phoneId, frontlinkId, backlinkId);
		
		if(rst=="success"){
			//学号修改后更新到该行数据的标识中
			/*var olduserNum = newUserNum;
			var str1 = "<div id='"+frontlinkId+"'><a href='javascript:void(0)' onclick="+"tb_showhidden3('"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">修改</a>" +"/"+ "<a href='javascript:void(0)' onclick="+"deleteUserInfo('"+userNumId+"','"+showInfodivId+"')"+">删除</a></div>";
			var str2 = "<div id='"+backlinkId+"' style='display:none;'><a href='javascript:void(0)' onclick="+"updateStuInfo('"+olduserNum+"','"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">确定</a>" +"/"+"<a href='javascript:void(0)' onclick="+"tb_cancel3('"+userNumId+"','"+userNameId+"','"+emailId+"','"+phoneId+"','"+genderId+"','"+frontlinkId+"','"+backlinkId+"')"+">取消</a></div>";
			*/
			/*newNum.html("");
			newNum.append("<div id='newNum' class='col-sm-2 col-md-3 mysubrow' style='height:29px;'>"+str1+str2+"</div>");*/
			
			alert("信息修改成功");
		}else{
			alert("修改失败");
		}
	});
}
//删除员工按钮事件
function deleteUserInfo(userNumId, showInfodivId){
	var userNum = $("#"+userNumId).val();
	var showInfodivId= $("#"+showInfodivId);
	$.post("./AdminController", {"userNum":userNum, "a":"DeleteUserInfo"}, function(rst){
		if(rst == "success"){
			showInfodivId.html("");
			alert("删除成功！");
		}else{
			alert("删除失败，请重试！");
		}
	});
}
//-------------------------------------------商品信息管理事件------------------------------------------------------
//查询所有商品信息并显示出来
function queryAllGoodsInfo(){
	$.post("./AdminController", {"a":"QueryAllGoodsInfo"}, function(rst){
		//alert(rst);
		var obj = JSON.parse(rst);
		
		var showInfodiv2 = $("#showInfodiv2");
		showInfodiv2.html("");// 清空该版的内容
		
		var total = obj["Total"];
		//拼头部
		showInfodiv2.append("<div class='row myrow'>"+
		"<div class='col-sm-1 col-md-2 mysubrow'>编号</div>"+
		"<div class='col-sm-3 col-md-2 mysubrow'>商品名</div>"+
		"<div class='col-sm-2 col-md-2 mysubrow'>商品类型</div>"+
		"<div class='col-sm-2 col-md-2 mysubrow'>销售价格</div>"+
		"<div class='col-sm-2 col-md-1 mysubrow'>库存量</div>"+
		"<div class='col-sm-2 col-md-1 mysubrow'>已售量</div>"+
		"<div class='col-sm-2 col-md-2 mysubrow'>操作</div>"	+
		"</div>");
		//拼内容
		for(var i=0;i<total;i++){//遍历输入每一条数据
			//拼id键值，用于区分每一条数据,需要定位的地方都定义一个id来辨别
			var showEachInfodivId = "showEachInfodiv2"+i;
			
			var goodsNumId = "userNum"+i;
			var goodsNameId = "userName"+i;
			var cateNameId = "cateName"+i;
			var priceId = "price"+i;
			var totalNumberId  = "gender"+i;
			var saleNumberId="saleNumber"+i;
			
			var frontlinkId = "frontlink2"+i;//修改删除
			var backlinkId = "backlink2"+i;//确认取消
			
			var oldgoodsNum = obj["Row"][i].goodsNum;//用于删除用户时作为传到后台数据处理的依据，而且编号更改后要及时更新
			
			//拼元素标签
			var str1 = "<div id='"+frontlinkId+"'><a href='javascript:void(0)' onclick="+"tb_showhidden4('"+goodsNumId+"','"+goodsNameId+"','"+cateNameId+"','"+priceId+"','"+totalNumberId+"','"+saleNumberId+"','"+frontlinkId+"','"+backlinkId+"')"+">修改</a>" +"/"+ "<a href='javascript:void(0)' onclick="+"deleteGoodsInfo('"+goodsNumId+"','"+showEachInfodivId+"')"+">删除</a></div>";
			var str2 = "<div id='"+backlinkId+"' style='display:none;'><a href='javascript:void(0)' onclick="+"updateGoodsInfo('"+oldgoodsNum+"','"+goodsNumId+"','"+goodsNameId+"','"+cateNameId+"','"+priceId+"','"+totalNumberId+"','"+saleNumberId+"','"+frontlinkId+"','"+backlinkId+"','"+showEachInfodivId+"')"+">确定</a>" +"/"+"<a href='javascript:void(0)' onclick="+"tb_cancel4('"+goodsNumId+"','"+goodsNameId+"','"+cateNameId+"','"+priceId+"','"+totalNumberId+"','"+saleNumberId+"','"+frontlinkId+"','"+backlinkId+"')"+">取消</a></div>";

			var str_goodsNum = "<input class='mytxt' type='text' id='"+goodsNumId+"' readonly='readonly' value="+obj["Row"][i].goodsNum+" style='border:none;'>";
			var str_goodsName = "<input type='text' id='"+goodsNameId+"' readonly='readonly' value="+obj["Row"][i].goodsName+" style='border:none;width:141px;'>";
			//var str_className = "<input type='text' id='"+classNameId+"' readonly='readonly' value="+obj["Row"][i].ClassName+" style='border:none;width:141px;'>";
			// StuInfo stuInfo = StuInfoArr.get(i);
			var str_cateName = "<input type='text' id='"+cateNameId+"' readonly='readonly' value="+obj["Row"][i].cateName+" style='border:none;'>";
			var str_price = "<input type='text' id='"+priceId+"' readonly='readonly' value="+obj["Row"][i].price+" style='border:none;'>";
			var str_totalNumber = "<input type='text' id='"+totalNumberId+"' readonly='readonly' value="+obj["Row"][i].totalNumber+" style='border:none;'>";
			var str_saleNumber = "<input type='text' id='"+saleNumberId+"' readonly='readonly' value="+obj["Row"][i].saleNumber+" style='border:none;'>";
			
			//拼html内容
			showInfodiv2.append("<div class='row myrow' style='height:35px;' id='"+showEachInfodivId+"'>"+
			//"<div class='col-sm-1 col-md-1 mysubrow' style='height:29px;'>"+(i+1)+"</div>"+
			"<div class='col-sm-3 col-md-2 mysubrow'>"+str_goodsNum+"</div>"+
			"<div class='col-sm-2 col-md-2 mysubrow'>"+str_goodsName+"</div>"+
			"<div class='col-sm-2 col-md-2 mysubrow'>"+str_cateName+"</div>"+
			"<div class='col-sm-2 col-md-2 mysubrow'>"+str_price+"</div>"+
			"<div class='col-sm-2 col-md-1 mysubrow'>"+str_totalNumber+"</div>"+
			"<div class='col-sm-3 col-md-1 mysubrow'>"+str_saleNumber+"</div>"+
			//"<div class='col-sm-2 col-md-2 mysubrow' style='height:29px;'><a href='javascript:void(0)' onclick="+"queryScore('"+stuNumId+"')"+">成绩查询</a></div>"+
			"<div id='newNum' class='col-sm-2 col-md-2 mysubrow' style='height:29px;'>"+str1+str2+"</div>"+
			"</div>");
		}
			
	});
}
//条件查询商品信息并展示
function queryGoodsInfobyitem(){
	
	var txtGoodsNum = $("#txtGoodsNum").val();
	var txtGoodsName = $("#txtGoodsName").val();
	var txtCateName = $("#txtCateName").val();
	
	if(txtGoodsNum == ""&&txtGoodsName == ""&&txtCateName==""){
		alert("条件为空无法查询");
	}else{
		
		$.post("./AdminController", {"txtGoodsNum":txtGoodsNum, "txtGoodsName":txtGoodsName, "txtCateName":txtCateName, "a":"QueryGoodsInfoByItem"}, function(rst){
			alert("222222222");
			if(rst!=null){
				alert(rst);
				var obj = JSON.parse(rst);

				var showInfodiv2 = $("#showInfodiv2");
				showInfodiv2.html("");// 清空该版的内容
				
				var total = obj["Total"];
				//拼头部
				showInfodiv2.append("<div class='row myrow'>"+
				"<div class='col-sm-1 col-md-2 mysubrow'>编号</div>"+
				"<div class='col-sm-3 col-md-2 mysubrow'>商品名</div>"+
				"<div class='col-sm-2 col-md-2 mysubrow'>商品类型</div>"+
				"<div class='col-sm-2 col-md-2 mysubrow'>销售价格</div>"+
				"<div class='col-sm-2 col-md-1 mysubrow'>库存量</div>"+
				"<div class='col-sm-2 col-md-1 mysubrow'>已售量</div>"+
				"<div class='col-sm-2 col-md-2 mysubrow'>操作</div>"	+
				"</div>");
				//拼内容
				for(var i=0;i<total;i++){//遍历输入每一条数据
					//拼id键值，用于区分每一条数据,需要定位的地方都定义一个id来辨别
					var showEachInfodivId = "showEachInfodiv2"+i;
					
					var goodsNumId = "userNum"+i;
					var goodsNameId = "userName"+i;
					var cateNameId = "cateName"+i;
					var priceId = "price"+i;
					var totalNumberId  = "gender"+i;
					var saleNumberId="saleNumber"+i;
					
					var frontlinkId = "frontlink2"+i;//修改删除
					var backlinkId = "backlink2"+i;//确认取消
					
					//用于删除用户时作为传到后台数据处理的依据，而且编号更改后要及时更新
					var oldgoodsNum = obj["Row"][i].goodsNum;
					
					//拼标签
					var str1 = "<div id='"+frontlinkId+"'><a href='javascript:void(0)' onclick="+"tb_showhidden3('"+goodsNumId+"','"+goodsNameId+"','"+cateNameId+"','"+priceId+"','"+totalNumberId+"','"+saleNumberId+"','"+frontlinkId+"','"+backlinkId+"')"+">修改</a>" +"/"+ "<a href='javascript:void(0)' onclick="+"deleteGoodsInfo('"+goodsNumId+"','"+showEachInfodivId+"')"+">删除</a></div>";
					var str2 = "<div id='"+backlinkId+"' style='display:none;'><a href='javascript:void(0)' onclick="+"updateGoodsInfo('"+oldgoodsNum+"','"+goodsNumId+"','"+goodsNameId+"','"+cateNameId+"','"+priceId+"','"+totalNumberId+"','"+saleNumberId+"','"+frontlinkId+"','"+backlinkId+"','"+showEachInfodivId+"')"+">确定</a>" +"/"+"<a href='javascript:void(0)' onclick="+"tb_cancel4('"+goodsNumId+"','"+goodsNameId+"','"+cateNameId+"','"+priceId+"','"+totalNumberId+"','"+saleNumberId+"','"+frontlinkId+"','"+backlinkId+"')"+">取消</a></div>";

					var str_goodsNum = "<input type='text' id='"+goodsNumId+"' readonly='readonly' value="+obj["Row"][i].goodsNum+" style='border:none;'>";
					var str_goodsName = "<input type='text' id='"+goodsNameId+"' readonly='readonly' value="+obj["Row"][i].goodsName+" style='border:none;width:141px;'>";
					//var str_className = "<input type='text' id='"+classNameId+"' readonly='readonly' value="+obj["Row"][i].ClassName+" style='border:none;width:141px;'>";
					// StuInfo stuInfo = StuInfoArr.get(i);
					var str_cateName = "<input type='text' id='"+cateNameId+"' readonly='readonly' value="+obj["Row"][i].cateName+" style='border:none;'>";
					var str_price = "<input type='text' id='"+priceId+"' readonly='readonly' value="+obj["Row"][i].price+" style='border:none;'>";
					var str_totalNumber = "<input type='text' id='"+totalNumberId+"' readonly='readonly' value="+obj["Row"][i].totalNumber+" style='border:none;'>";
					var str_saleNumber = "<input type='text' id='"+saleNumberId+"' readonly='readonly' value="+obj["Row"][i].saleNumber+" style='border:none;'>";
					//拼内容
					showInfodiv2.append("<div class='row myrow' style='height:35px;' id='"+showEachInfodivId+"'>"+
					//"<div class='col-sm-1 col-md-1 mysubrow' style='height:29px;'>"+(i+1)+"</div>"+
					"<div class='col-sm-3 col-md-2 mysubrow'>"+str_goodsNum+"</div>"+
					"<div class='col-sm-2 col-md-2 mysubrow'>"+str_goodsName+"</div>"+
					"<div class='col-sm-2 col-md-2 mysubrow'>"+str_cateName+"</div>"+
					"<div class='col-sm-2 col-md-2 mysubrow'>"+str_price+"</div>"+
					"<div class='col-sm-2 col-md-1 mysubrow'>"+str_totalNumber+"</div>"+
					"<div class='col-sm-3 col-md-1 mysubrow'>"+str_saleNumber+"</div>"+
					//"<div class='col-sm-2 col-md-2 mysubrow' style='height:29px;'><a href='javascript:void(0)' onclick="+"queryScore('"+stuNumId+"')"+">成绩查询</a></div>"+
					"<div id='newNum' class='col-sm-2 col-md-2 mysubrow' style='height:29px;'>"+str1+str2+"</div>"+
					"</div>");
				}
			}		
	   });
	}
}

//商品信息修改按钮显隐操作
function tb_showhidden4(goodsNumId,goodsNameId,cateNameId,priceId,totalNumberId,saleNumberId,frontlinkId,backlinkId){
	
	$("#"+frontlinkId).css("display","none");
	$("#"+backlinkId).css("display","inline");
	
	$("#"+goodsNumId).css("border", "solid");
	$("#"+goodsNumId).removeAttr("readonly");
	
	$("#"+goodsNameId).css("border", "solid");
	$("#"+goodsNameId).removeAttr("readonly");
	
	$("#"+cateNameId).css("border", "solid");
	$("#"+cateNameId).removeAttr("readonly");
	
	$("#"+priceId).css("border", "solid");
	$("#"+priceId).removeAttr("readonly");
	
	$("#"+totalNumberId).css("border", "solid");
	$("#"+totalNumberId).removeAttr("readonly");
	
	$("#"+saleNumberId).css("border", "solid");
	$("#"+saleNumberId).removeAttr("readonly");
}

//商品信息取消按钮显隐操作
function tb_cancel4(goodsNumId,goodsNameId,cateNameId,priceId,totalNumberId,saleNumberId,frontlinkId,backlinkId){
	$("#"+goodsNumId).attr("readonly", "readonly");
	$("#"+goodsNumId).css("border", "none");
	
	$("#"+goodsNameId).attr("readonly", "readonly");
	$("#"+goodsNameId).css("border", "none");
	
	$("#"+cateNameId).attr("readonly", "readonly");
	$("#"+cateNameId).css("border", "none");
	
	$("#"+priceId).attr("readonly", "readonly");
	$("#"+priceId).css("border", "none");
	
	$("#"+totalNumberId).attr("readonly", "readonly");
	$("#"+totalNumberId).css("border", "none");
	
	$("#"+saleNumberId).attr("readonly", "readonly");
	$("#"+saleNumberId).css("border", "none");
	
	$("#"+backlinkId).css("display","none");
	$("#"+frontlinkId).css("display","inline");
}

//删除商品信息
function deleteGoodsInfo(goodsNumId,showEachInfodivId){
	var goodsNum = $("#"+goodsNumId).val();
	var showEachInfodivId= $("#"+showEachInfodivId);
	$.post("./AdminController", {"goodsNum":goodsNum, "a":"DeleteGoodsInfo"}, function(rst){
		if(rst == "success"){
			showEachInfodivId.html("");
			alert("删除成功！");
		}else{
			alert("删除失败，请重试！");
		}
	});
}

//修改员工信息
function updateGoodsInfo(oldGoodsNum,goodsNumId,goodsNameId,cateNameId,priceId,totalNumberId,saleNumberId,frontlinkId,backlinkId,showEachInfodivId){
	var newGoodsNum = $("#"+goodsNumId).val();
	var newGoodsName = $("#"+goodsNameId).val();
	var newCateName = $("#"+cateNameId).val();
	var newPrice = $("#"+priceId).val();
	var newTotalNumber = $("#"+totalNumberId).val();
	var newSaleNumber = $("#"+saleNumberId).val();
	
	alert(oldGoodsNum+"-----"+newGoodsNum+newGoodsName+newCateName+newPrice+newTotalNumber+newSaleNumber);
	$.post("./AdminController", {"a":"UpdateGoodsInfo", "oldGoodsNum":oldGoodsNum, "newGoodsNum":newGoodsNum, "newGoodsName":newGoodsName, "newCateName":newCateName, "newPrice":newPrice, "newTotalNumber":newTotalNumber, "newSaleNumber":newSaleNumber }, function(rst){
		tb_cancel4(goodsNumId,goodsNameId,cateNameId,priceId,totalNumberId,saleNumberId,frontlinkId,backlinkId);
		
		if(rst=="success"){
			alert("信息修改成功");
		}else{
			alert("修改失败");
		}
	});
}