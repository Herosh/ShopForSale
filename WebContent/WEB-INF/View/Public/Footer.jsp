<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Button trigger modal -->
	<button style="display: none;" type="button" class="btn btn-primary btn-lg"
		data-toggle="modal" data-target="#myModal">Launch demo modal
	</button>

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