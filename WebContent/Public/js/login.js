//检查登录
function checkLogin(){
	var role = $("#role").val();
	if(role=="default"){
		alert("请选择角色");
	}else{
		// 获得输入的用户名和密码
		var username = $("#username").val();
		var password = $("#password").val();
		if(username!=""){   // 用户名不为空
			if(password !=""){      // 密码不为空
				// window.location.href = "./DoLogin"; //直接页面跳转
				//管理员登录
				if(role=="admin"){
					$.post('./AdminController',{"username":username, "password":password, "a":"CheckLogin"},function(rst){
						if(rst == "success"){  // 返回"success"，用户名和密码验证成功
							window.location.href="./AdminController";// 登录成功后回到（get)AdminController安排
							// index.jsp
						}else if(rst == "error"){ // 返回"error",用户名和密码验证失败
							alert("用户名或密码错误！请重新输入！");
						}else{
							alert("登录出错！");
						}
					});
				}else{
					$.post('./HomeController', {"username" : username,"password" : password,"a" : "CheckLogin"
					}, function(rst) {
						if (rst == "success") { // 返回"success"，用户名和密码验证成功
							window.location.href = "./HomeController";// 登录成功后回到（get）HomeController安排
							// index.jsp
						} else if (rst == "error") { // 返回"error",用户名和密码验证失败
							alert("用户名或密码错误！请重新输入！");
						} else {
							alert("deng");
						}
					});
				}
			}else{
				alert("密码不能为空!");
			}
		}else{
			alert("用户名不能为空！");
		}
	}
}
//---------------------------------------------------------------------------------------------------
