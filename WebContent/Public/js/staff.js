// 员工信息修改按钮事件
function update() {
	//alert("123ss");
	$(".txtCanEdit").removeAttr("readonly");
	$(".txtCanEdit").removeClass("myHideUpdateInput");
	$(".txtCanEdit").addClass("myUpdateInput");
	
	$("#div_update").css("display","none");
	//$("#div_update").addClass("myHide");
	
	$("#div_save").css("display","inline");

}


//员工信息修改取消按钮事件
function updateCancel() { 
	
	$(".txtCanEdit").attr("readonly","readonly");
	$(".txtCanEdit").removeClass("myUpdateInput");
	$(".txtCanEdit").addClass("myHideUpdateInput");
	
	
	$("#div_update").css("display","inline");
	$("#div_save").css("display","none");
	
}

//员工信息修改保存按钮事件
function save(){
	var UserNum = $("#txtNum").val();

	var UserName = $("#txtName").val();
	var Email = $("#txtEmail").val();
	var Phone = $("#txtPhone").val();
	var Gender = $("#txtGender").val();
	
	if(UserName != ""){
		if(Gender != ""){
			if(Phone != ""){
				if(Email!=""){
					//全部验证完成，可以执行提交
					$.post("./HomeController", {"UserName":UserName,"Email":Email , "Gender":Gender, "Phone":Phone ,"a":"UpdateStaffInfo"}, function(rst){
						if(rst == "success"){
							//alert("保存成功！");
							window.location.href="./HomeController";
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
			alert("性别不能为空！");
			$("#txtGender").focus();
		}
	}else{
		alert("姓名不能为空！");
		$("#txtName").focus();
	}
	
}
//-----------------------------------------------------------------------------------------------------
//修改员工密码
function updateStaffPwd(){
	
	var oldPwd=$("#oldPwd").val();
	var newPwd1=$("#newPwd1").val();
	var newPwd2=$("#newPwd2").val();
	
	if(oldPwd!=""){
		if(newPwd1!=""){
			if(newPwd2!=""){
				if(newPwd1==newPwd2){
			
					$.post('./HomeController', {"oldPwd" : oldPwd , "newPwd" : newPwd1 , "a" : "updateStaffPwd"
					} , function(rst) {
						if (rst == "success") { // 返回"success"，密码修改成功
							//alert("修改成功！");
							window.location.href="./HomeController";
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
//-----------------------------------------------------------------------------------------------------
//商品销售页面购买按钮事件
function sale(i){
	$("#"+"div_sale"+i).css("display","none");
	$("#div_saleEnter"+i).css("display","inline");
}
function saleCancel(i){
	$("#"+"div_sale"+i).css("display","inline");
	$("#div_saleEnter"+i).css("display","none");
}
//商品销售确认购买按钮事件
function saleGoods(i,totalNumber,goodsNum,goodsName,price){
	
	var saleNumber=$("#number"+i).val();
	
	if(saleNumber!=""){
		
		alert(i+"  "+goodsNum+"  "+totalNumber+"  "+goodsName+"  "+price+"  "+saleNumber);
		
		if(saleNumber<=totalNumber){
			$.post("./HomeController", {"goodsNum":goodsNum,"goodsName":goodsName , "saleNumber":saleNumber, "price":price ,"a":"SaleGoods"}, function(rst){
				if(rst == "success"){
					alert("购买成功！");
					window.location.href="./HomeController?a=EnterGoodsExport";
				}else{
					alert("购买失败，请重试！");
				}
			});
		}else{
			alert("库存量不足");
		}
	}else{
		alert("请输入购买数量!");
	}
}

//------------------------------------------------------------------------------------------------------
function saleBack1(){
	$("#1").css("display","none");
	$("#2").css("display","inline");
}
//员工确认退货按钮事件
function saleBack2(){

	var exportId=$("#id").val();
	var goodsNum=$("#goodsNum").val();
	var goodsName=$("#goodsName").val();
	
	var customerPhone=$("#customerPhone").val();
	var customerName=$("#customerName").val();
	var description=$("#description").val();
	if(customerPhone!=""){
		if(customerName!=""){
			if(description!=""){
				$.post("./HomeController",{"exportId":exportId , "goodsNum":goodsNum , "goodsName":goodsName , "customerPhone":customerPhone , "customerName":customerName , "description":description ,"a":"SaleBack"},function(rst){
					if(rst == "success"){
						alert("退货成功！");
					}else{
						alert("退货失败，请重试！");
					}
				});
			}else{
				alert("请填写退货描述！");
			}
		}else{
			alert("请填写顾客名字！");
		}
	}else{
		alert("请填写顾客电话！");
	}
}
//查询单号事件
function QueryExportInfoByExportId(){
	var exportId=$("#exportId").val();
	if(exportId!=""){
		
		$.post("./HomeController", {"exportId":exportId,"a":"QueryExportInfo"}, function(rst){
			if(rst!="none"){
				var obj = JSON.parse(rst);//转换成json格式数据
			    
			    $("#div_showExportInfo").css("display","inline");
			    $("#id").val(obj["Row"][0].Id);
			    $("#goodsNum").val(obj["Row"][0].GoodsNum);
			    $("#goodsName").val(obj["Row"][0].GoodsName);
			    $("#number").val(obj["Row"][0].Number);
			    $("#price").val(obj["Row"][0].Price);
			    $("#userNum").val(obj["Row"][0].UserNum);
			    $("#userName").val(obj["Row"][0].UserName);
			
			}else{
				alert("该单号不存在！");
			}
		    
		});
		/*$.ajax({
			url:"./HomeController",
			type:"post",
			datatype:"json",
			data:{
			exportId: exportId,	
			a: "QueryExportInfo",
			},
			
			success:function(result){
			alert("返回成功！"+result);
			if(result!="none"){
				
				var s=eval('('+result+')');
				alert(s.id);
				alert(s.subTime.year+"-"+s.subTime.month+"-"+s.subTime.day+"-"+s.subTime.hour);
				var key="Id";
				//var strHTML1='';
				//var json=JSON.parse(result);
				//var Remaintime=json.Remaintime;
				//strHTML1='<font color="red">'+Remaintime+'</font>'; 	
				//$("#showRemainTime").html(strHTML1);//显示到tbody中
				//if(Remaintime.equals("0:0:0")){
					//$('#questionForm').find('[name=submit]').click();
				//}
			}else{
				alert("该单号不存在！");
			}
			},
			error:function(){}
		});	*/
	
	}else{
		alert("请输入要查询的单号 ！");
	}	
}
//-------------------------------------------------------------------------------------------
//确认入货按钮事件
function goodsImport(i, goodsNum, goodsName){
	alert(goodsNum);
	var goodsNum=goodsNum;
	var goodsName=goodsName;
	
	var number=$("#number"+i).val();
	var price=$("#price"+i).val();
	alert(number);
	if(number!=""){
		if(price!=""){
			$.post("./HomeController", {"goodsNum":goodsNum , "goodsName":goodsName , "number":number , "price":price , "a":"GoodsImport"}, function(rst){
				if(rst == "success"){
					alert("入货成功！");
				}else{
					alert("入货失败，请重试！");
				}
			});
		}else{
			alert("请输入入货价格！");
		}
	}else{
		alert("请输入入货数量！");
	}
}



function changeDIV(){
	$('#div_updatePwd').show();
	$('#div_userInfo').hide();
	
	$("#mynavL1").removeClass("active");
	$("#mynavL2").addClass("active");
}
	
	
	
	