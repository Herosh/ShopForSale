<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div
			style="background-image: url(./Public/images/headerpic.jpg); width: 100%; height: 200px; background-repeat: repeat; background-size: 100% 200px;">
			<!-- <h1 style="text-align: center;">æ¬¢è¿è¿å¥åå·¥ä¸»é¡µ</h1> -->
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
						<li class="active" id="mynavL1"><a href="./HomeController">ä¸ªäººä¿¡æ¯
								<span class="sr-only">(current)</span>
						</a></li>
						<li id="mynavL2"><a href="javascript:void(0);"
							onclick="changeDIV();">ä¿®æ¹å¯ç </a></li>
						<li id="mynavL3"><a
							href="./HomeController?a=EnterGoodsExport" target="_blank">ååéå®</a></li>
						<li id="munavL4"><a
							href="./HomeController?a=EnterGoodsImport" target="_blank">å¥è´§å¤ç</a>
						</li>
						<li id="munavL5"><a href="./HomeController?a=GoodsBack"
							target="_blank">éè´§å¤ç</a></li>
					</ul>

					<ul class="nav navbar-nav navbar-right">

						</li>

						<%
							if (session.getAttribute("username") == null) {
						%>
						<li><a href="./HomeController">ç»å½</a> <%
 	} else {
 %>
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false"><%=session.getAttribute("username")%> <span
								class="caret"></span></a>
							<ul class="dropdown-menu"
								style="background-color: #CCFFFF; font-size: 20px; font-weight: 600;">
								<li><a href="./HomeController?a=Exit">åæ¢è´¦æ·</a></li>
								<li role="separator" class="divider"></li>
								<li><a href="./HomeController?a=Exit">éåº</a></li>
							</ul></li>


						<%
							}
						%>
						<li><a href=" javascript:void(0);"> <!-- <span
								class="glyphicon glyphicon-log-out myError" aria-hidden="true"> -->
								</span>&nbsp; æ³¨å
						</a></li>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid --> </nav>
		</div>