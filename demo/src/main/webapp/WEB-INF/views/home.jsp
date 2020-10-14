<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<head>
<script>
	if("${msg}"=="LOGIN_SUCCESS"){
		alert("로그인 되었습니다.\n환영합니다!");
		
	} else if("${msg}"=="LOGOUT_SUCCESS"){
		alert("로그아웃 되었습니다.");
		
	} else if("${msg}"=="REGISTER_SUCCESS"){
		alert("성공적으로 회원가입 되었습니다.\n로그인 해주세요.");
		
	} else if("${msg}"=="MODIFY_USER_SUCCESS"){
		alert("회원 정보가 수정되었습니다.");
		
	} else if("${msg}"=="CHANGE_PW_SUCCESS"){
		alert("비밀번호가 성공적으로 변경되었습니다.");
		
	}  else if("${msg}"=="DELETE_USER_SUCCESS"){
		alert("회원 탈퇴되었습니다. 감사합니다.");
		
	} 
</script>

</head>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- Main Header -->
		<%@include file="/WEB-INF/views/include/main_header.jsp"%>

		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/include/left.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					MAIN 
				</h1>
				<%-- realPath 주석 
				<%= application.getRealPath("/") %>
				--%>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> Main</a>
					</li>
				</ol>
			</section>

			
			<%-- MAIN CONTENT --%> 
			<!-- 웹애플리케이션에는 4개의 객체범위(영역) 메모리가 존재
			page,request, session, application영역
			 -->
			<section class="content container-fluid">
				<%-- 로그인 안 한 상태 --%>
				<c:if test= "${sessionScope.user == null}"> 
					<h4>쇼핑몰 이용을 위해 로그인 해 주세요 :) </h4>
				</c:if>
					
				<%-- 로그인 한 상태 --%>
				<c:if test="${sessionScope.user != null}">
					<div style="margin-top:80px;">
						<h3>welcome!<br/></h3>
						<h4>This is ShoppingMall Main page. <br/> 
							Please click on the menu you want to work on :)</h4>
					</div>
				</c:if>
				
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="/WEB-INF/views/include/footer.jsp" %>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li class="active">
					<a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a>
				</li>
				<li>
					<a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a>
				</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane active" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;"> <i class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

									<p>Will be 23 on April 24th</p>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li>
							<a href="javascript:;">
								<h4 class="control-sidebar-subheading">
									Custom Template Design
									<span class="pull-right-container">
										<span class="label label-danger pull-right">70%</span>
									</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
								</div>
							</a>
						</li>
					</ul>
					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
				<div class="tab-pane" id="control-sidebar-settings-tab">
					<form method="post">
						<h3 class="control-sidebar-heading">General Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading">
								Report panel usage
								<input type="checkbox" class="pull-right" checked>
							</label>

							<p>Some information about this general settings option</p>
						</div>
						<!-- /.form-group -->
					</form>
				</div>
				<!-- /.tab-pane -->
			</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->

</body>
</html>