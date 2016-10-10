//商品相关js

//执行商品上架操作
function UpToSale(goodsNum){
	//alert("准备上架");
	
	if(goodsNum != ""){
		$.post("./HomeController?a=UpToSale",{"goodsNum":goodsNum}, function(rst){
			if(rst == "success"){
				window.location.href="./HomeController?a=EnterGoodsImport";
			}else{
				alert("商品上架错误，请重试！");
			}
		} );
	}else{
		alert("操作错误！");
	}
}

//商品执行下架操作
function DownToSale(goodsNum){
	if(goodsNum != ""){
		$.post("./HomeController?a=DownToSale",{"goodsNum":goodsNum}, function(rst){
			if(rst == "success"){
				window.location.href="./HomeController?a=EnterGoodsImport";
			}else{
				alert("商品上架错误，请重试！");
			}
		} );
	}else{
		alert("操作错误！");
	}
}

//保存新增的商品类型
function SaveNewCategory(){
	var cateName = $("#txtCateName").val();
	var cateRemark = $("#txtCateRemark").val();
	
	
	if(cateName != ""){
		$.post("./HomeController?a=AddNewCategory",{"cateName":cateName, "cateRemark":cateRemark},function(rst){
			if(rst == "success"){
				$("#txtCateName").val("");
				$("#txtCateRemark").val("");
				$("#msgSaveCategory").removeClass("error");
				$("#msgSaveCategory").addClass("success");
				$("#msgSaveCategory").html("保存成功！");
			}else if(rst == "error1"){
				
				$("#txtCateName").val("");
				$("#txtCateRemark").val("");
				$("#msgSaveCategory").removeClass("success");
				$("#msgSaveCategory").addClass("error");
				
				$("#msgSaveCategory").html("商品分类已存在！");
			}else if(rst == "error2"){
				$("#msgSaveCategory").removeClass("success");
				$("#msgSaveCategory").addClass("error");
				
				$("#msgSaveCategory").html("新增失败！");
			}
		});
		
	}else{
		$("#msgSaveCategory").removeClass("success");
		$("#msgSaveCategory").addClass("error");
		
		$("#msgSaveCategory").html("商品类型名不能为空！");
	}
}


//商品名字input焦点获取出发事件
$("#txtCateName").focus(function(){
	$("#msgSaveCategory").html("");
});

$("#txtCateName").blur(function(){
	if($(this).val() == ""){
		$("#msgSaveCategory").removeClass("success");
		$("#msgSaveCategory").addClass("error");
		$("#msgSaveCategory").html("商品类型名不能为空！");
	}
});



//新增商品
function SaveNewGoodsInfo(type){
	var newGoodsName = $("#txtNewGoodsName").val();
	var newCategory = $("#selNewCategory").val();
	var newSalePrice = $("#txtNewSalePrice").val();
	var newRemark = $("#txtNewRemark").val();
	
	var goodsnum = $("#myGoodsNum").val();

	
//	alert(newGoodsName+"___"+newCategory+"___"+newSalePrice+"___"+newRemark+"___");
//	return;
	if(newGoodsName != ""){
		if(newCategory != 0){
			if(newSalePrice != "" && CheckIsNumber(newSalePrice)){
				if(newRemark.length < 250){
					//执行上传
					var providerName = $("#selProviderName").val();
					
					
					if(providerName != "0"){//提供供货商的信息
						var newTotalNumber = $("#txtNewTotalNumber").val();
						var price = $("#txtNewPrice").val();
						
						if(newTotalNumber != "0" && newTotalNumber !="" && CheckIsNumber(newTotalNumber)){
							if(price != "0" && price != "" && CheckIsNumber(price)){
								//showMsg("#msgNewGoodsInfo","验证完成，可以提交", "error", "success");
							}else{
								showMsg("#msgNewGoodsInfo","进货价格格式不正确！", "success", "error");
								return;
							}
						}else{
							showMsg("#msgNewGoodsInfo","初始进货量格式不正确！", "success", "error");
							return;
						}
					}else{
						if(type == "1"){
							showMsg("#msgNewGoodsInfo","请输入供货商相关信息！", "success", "error");
							return;
						}
					}
					//showMsg("#msgNewGoodsInfo","验证完成，可以提交", "error", "success");
					//return;
					var newIsSale;
					if($("#isUpToSale").is(":checked")){
						newIsSale = 1;
					}else{
						newIsSale = 0;
					}
					
//					alert("可以执行插入");
//					return;
					$.post("./HomeController?a=AddNewGoodsInfo", {"type":type,"goodsnum":goodsnum,"newGoodsName":newGoodsName, "newCategory":newCategory, "newSalePrice":newSalePrice,"newIsSale":newIsSale, "providerName":providerName, "newTotalNumber":newTotalNumber,"price":price ,"newRemark":newRemark}, function(rst){
						if(rst == "success"){
							showMsg("#msgNewGoodsInfo","添加成功！ [2秒后跳转]", "error", "success");
							setTimeout(function(){
								window.location.href="./HomeController?a=EnterGoodsImport";
							}, 2000);
						}else{
							showMsg("#msgNewGoodsInfo","添加失败！", "success", "error");
						}
					});
				}else{
					showMsg("#msgNewGoodsInfo","备注信息过长！", "success", "error");
				}
			}else{
				showMsg("#msgNewGoodsInfo","出售价格格式不正确！", "success", "error");
			}
		}else{
			showMsg("#msgNewGoodsInfo","请选择商品类型！", "success", "error");
		}
	}else{
		showMsg("#msgNewGoodsInfo","商品名字不能为空！", "success", "error");
	}
}

//展示信息
function showMsg(id, msg, removeClassName, addClassName){
	$(id).removeClass(removeClassName);
	$(id).addClass(addClassName);
	$(id).html(msg);
}


$("#txtNewGoodsName").focus(function(){ 
	showMsg("#msgNewGoodsInfo","", "error", "success");
	});

$("#txtNewSalePrice").focus(function(){ 
	showMsg("#msgNewGoodsInfo","", "error", "success");
});
$("#selNewCategory").focus(function(){ 
	showMsg("#msgNewGoodsInfo","", "error", "success");
});


//新增商品信息取消按钮事件
function CancelNewGoodsInfo(){
	aelrt("cancel");
	$("#txtNewGoodsName").val("");
	$("#selNewCategory").val("请选择--");
	$("#txtNewSalePrice").val("");
	$("#txtNewRemark").val("");
}


//供货商下拉列表的改变事件
function ShowImportInfo(){
	var providerName = $("#selProviderName").val();
	if(providerName == "0"){
		$("#div_importInfo").hide();
	}else{
		$("#div_importInfo").show();
	}
	
}

//检查是否为数字
function CheckIsNumber(number) {
    var t = /^\d+(\.\d+)?$/;
    return t.test(number);
}

//采购方法
function ToImport(goodsnum, goodsname, catename,price, totalnumber, issale){
	//alert(goodsnum);
//	$("#ModalLabel").html("采购");
//	$("#txtNewGoodsName").val(goodsname);
//	$("#txtNewGoodsName").attr("disabled","disabled");
//	//$("#selNewCategory option[text="+catename).attr("selected", true);
//	$("#selNewCategory option[value='"+catename+"']").attr("selected","selected");
//	$("#selNewCategory").attr("disabled","disabled");
//	
//	$("#txtNewSalePrice").val(price);
//	
//	if(issale == "1"){
//		$("#isUpToSale").attr("checked", "checked");
//	}else{
//		$("#isUpToSale").removeAttr("checked");
//	}
	//根据采购和新增区分显示
	ShowByType("Buy", goodsname, catename,price, totalnumber, issale, goodsnum);
}


function ShowByType(type, goodsname, catename, price, totalnumber, issale, goodsnum){
	if(type == "Buy"){
		$("#ModalLabel").html("采购");
		$("#txtNewGoodsName").val(goodsname);
		$("#txtNewGoodsName").attr("disabled","disabled");
		
		$("#selNewCategory option[value='"+catename+"']").attr("selected","selected");
		$("#selNewCategory").attr("disabled","disabled");
		
		$("#txtNewSalePrice").val(price);
		
		if(issale == "1"){
			$("#isUpToSale").attr("checked", "checked");
		}else{
			$("#isUpToSale").removeAttr("checked");
		}
		
		//var str1 = "<button type='button' class='btn btn-primary' onclick='SaveNewGoodsInfo( '"+goodsnum+"',1)'>保存</button>";
		
		$("#myGoodsNum").val(goodsnum);
		$("#span_btnSave").html("<button type='button' class='btn btn-primary' onclick='SaveNewGoodsInfo(1)'>保存</button>");
	}else{
		$("#ModalLabel").html("新增商品");
		$("#txtNewGoodsName").val("");
		$("#txtNewGoodsName").removeAttr("disabled");
		
		$("#selNewCategory option[value='0']").attr("selected","selected");
		$("#selNewCategory").removeAttr("disabled");
		
		$("#txtNewSalePrice").val("");
		$("#isUpToSale").removeAttr("checked");
		
		//selProviderName
		$("#selProviderName option[value='0']").attr("selected","selected");
		$("#div_importInfo").hide();
		
		
		//txtNewTotalNumber
		$("#txtNewTotalNumber").val("0");
		
		//txtNewPrice
		$("#txtNewPrice").val("");
		
		$("#span_btnSave").html("<button type='button' class='btn btn-primary' onclick='SaveNewGoodsInfo(2)'>保存</button>");
	}
	showMsg("#msgNewGoodsInfo","", "error", "success");
	$("#btnAddGoods").click();
}


//商品销售--购买方法
function ToSale(goodsnum, goodsname, cateid, catename, price, totalnumber){
	$("#txtGoodsName").val(goodsname);
	$("#txtGoodsName").attr("disabled", "disabled");
	
	$("#selCategory option[value='"+catename+"#"+cateid+"']").attr("selected","selected");
	$("#selCategory").attr("disabled","disabled");
	
	$("#txtTotalNumber").val(totalnumber);
	$("#txtTotalNumber").attr("disabled", "disabled");
	
	$("#txtSalePrice").val(price);
	$("#txtSalePrice").attr("disabled", "disabled");
	
	$("#div_totalMoney").hide();
	showMsg("#msgToSale","", "error", "success");
	
	$("#txtGoodsNum").val(goodsnum);
	
	$("#btnToSale").click();
}

//确定购买
function SureToBuy(){
	var totalnumber = parseInt( $("#txtTotalNumber").val());
	var price = parseInt($("#txtSalePrice").val());
	var number = parseInt($("#txtSaleNumber").val());
	var goodsnum = $("#txtGoodsNum").val();
	
	if(number != "" && CheckIsNumber(number) && number != "0"){
		if(number <= totalnumber){
			//执行上传
			if(goodsnum != ""){
				var totalmoney = parseInt(number)* parseInt(price);
				$("#totalMoney").html(totalmoney);
				
				$.post("./HomeController?a=SaleGoods",{"goodsnum":goodsnum, "goodsname":$("#txtGoodsName").val(),"totalnumber":totalnumber, "salenumber":number,"price":price},function(rst){
					if(rst == "success"){
						showMsg("#msgToSale","购买成功！[2秒后跳转]", "error", "success");
						setTimeout(function(){
							window.location.href="./HomeController?a=EnterGoodsExport";
						}, 2000);
					}else{
						showMsg("#msgToSale","购买失败，请重试！", "success", "error");
					}
				});
				
				
			}else{
				showMsg("#msgToSale","页面出错！", "success", "error");
			}
		}else{//超出库存量
			$("#totalMoney").html("0");
			showMsg("#msgToSale","购买数量超出库存！", "success", "error");
		}
		
	}else{
		showMsg("#msgToSale","请输入正确的购买数量！", "success", "error");
	}
	
}

//输入数量焦点离开事件
$("#txtSaleNumber").blur(function(){
	//alert("2222");
	var totalnumber = parseInt( $("#txtTotalNumber").val());
	var price = parseInt($("#txtSalePrice").val());
	var number = parseInt($("#txtSaleNumber").val());
	$("#div_totalMoney").show();

	if(number != "" && CheckIsNumber(number)  ){
		if(number <= totalnumber){
			var money = parseInt(price)*parseInt(number);
			$("#totalMoney").html(money);
			showMsg("#msgToSale","", "error", "success");
		}else{
			$("#totalMoney").html("0");
			showMsg("#msgToSale","购买数量超出库存！", "success", "error");
		}
	}else{
		showMsg("#msgToSale","请输入正确的购买数量！", "success", "error");
	}
});

$("#txtSaleNumber").keyup(function(){
	var totalnumber = parseInt( $("#txtTotalNumber").val());
	var price = parseInt($("#txtSalePrice").val());
	var number = parseInt($("#txtSaleNumber").val());
	$("#div_totalMoney").show();
	
	if(number != "" && CheckIsNumber(number)  ){
		if(number <= totalnumber){
			var money = parseInt(price)*parseInt(number);
			$("#totalMoney").html(money);
			showMsg("#msgToSale","", "error", "success");
		}else{
			
			$("#totalMoney").html("0");
			showMsg("#msgToSale","购买数量超出库存！", "success", "error");
		}
		
	}else{
		$("#totalMoney").html("0");
		showMsg("#msgToSale","请输入正确的购买数量！", "success", "error");
	}
});




