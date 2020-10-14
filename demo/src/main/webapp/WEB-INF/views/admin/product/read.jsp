<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/plugin_js.jsp"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<head>
<script src="/ckeditor/ckeditor.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<%-- ckEditor, 버튼 클릭 이벤트 메소드 --%>
<script>
	$(document).ready(function(){
		/* 상품 목록 버튼 클릭 시 */
		$("#btn_list").on("click", function(){
			location.href="/admin/product/list${pm.makeSearch(pm.cri.page)}";
		});
	});
</script>
	
</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- Main Header -->
		<%@include file="/WEB-INF/views/include/main_header_admin.jsp"%>

		<!-- Left side column. contains the logo and sidebar -->
		<%@include file="/WEB-INF/views/include/left_admin.jsp"%>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Admin Page <small>Product Detail</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 상품 관리</a></li>
					<li class="active">상품 상세</li>
				</ol>
			</section>


			<%-- MAIN CONTENT --%>
			<section class="content container-fluid">

				<!-- 상품등록 폼 -->
				<div class="row">
					<!-- left column -->
					<div class="col-md-12">
						<!-- general form elements -->
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">PRODUCT DETAIL</h3>
							</div>
							<!-- /.box-header -->
							
							<%-- 상품 상세 정보 출력 --%>
							<div class="box-body">
								<div class="form-group">
									<label for="exampleInputEmail1" style="width:40%; margin-right:10px;" >1차 카테고리</label>
									<label for="exampleInputEmail1" style="width:40%;" >2차 카테고리</label> <br />
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.cg_code_prt}</span>
									<span class="form-control" style="width:40%;  display:inline-block;">${vo.cg_code}</span>
									
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Product Name</label> 
									<span class="form-control">${vo.pdt_name}</span>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Company</label> 
									<span class="form-control">${vo.pdt_company}</span>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1" style="width:40%; margin-right:10px;">Price</label> 
									<label for="exampleInputEmail1" style="width:40%;">Discount</label> 
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.pdt_price}</span>
									<span class="form-control" style="width:40%; display:inline-block;">${vo.pdt_discount}</span>
								</div>
								<div class="form-group">
									<label for="detail">Detail</label><br>
									<div contenteditable="false" style="border: 1px solid #d2d2d2; padding: 20px;">
										${vo.pdt_detail}
									</div>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Thumbnail Image</label> 
									<span class="form-control"><c:out value="${vo.pdt_img}" /></span>
									<!-- TODO: 이미지파일 처리 필요 -->
									<!-- 
									<input
										type="file" id="file1" name="file1" class="form-control" />
									-->
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1" style="width:40%; margin-right:10px;">Amount</label> 
									<label for="exampleInputEmail1" style="width:40%;">Buy availability</label><br /> 
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">${vo.pdt_amount}</span>
									<span class="form-control" style="width:40%; display:inline-block;">${vo.pdt_buy}</span>
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1" style="width:40%; margin-right:10px;">Submit Date</label> 
									<label for="exampleInputEmail1" style="width:40%;">Update Date</label> <br />
									<span class="form-control" style="width:40%; margin-right:10px; display:inline-block;">
										<fmt:formatDate value="${vo.pdt_date_sub}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									<span class="form-control" style="width:40%; display: inline-block;">
										<fmt:formatDate value="${vo.pdt_date_up}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
									<!-- 
									<input type="text" id="pdt_date_up" name="pdt_date_up" class="form-control" 
										value="${vo.pdt_date_up}" readonly />
										 -->
								</div>
							</div>
							
							
							<!-- /.box-body -->

							<div class="box-footer">
								<div>
									<hr>
								</div>

								<ul class="mailbox-attachments clearfix uploadedList">
								</ul>

								<button id="btn_list" type="button" class="btn btn-primary" >GO List</button>
							</div>
						
						</div>
						<!-- /.box -->	
					</div>
					<!--/.col (left) -->

				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@include file="/WEB-INF/views/include/footer.jsp"%>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark">
			<!-- Create the tabs -->
			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li class="active"><a href="#control-sidebar-home-tab"
					data-toggle="tab"><i class="fa fa-home"></i></a></li>
				<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i
						class="fa fa-gears"></i></a></li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- Home tab content -->
				<div class="tab-pane active" id="control-sidebar-home-tab">
					<h3 class="control-sidebar-heading">Recent Activity</h3>
					<ul class="control-sidebar-menu">
						<li><a href="javascript:;"> <i
								class="menu-icon fa fa-birthday-cake bg-red"></i>

								<div class="menu-info">
									<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

									<p>Will be 23 on April 24th</p>
								</div>
						</a></li>
					</ul>
					<!-- /.control-sidebar-menu -->

					<h3 class="control-sidebar-heading">Tasks Progress</h3>
					<ul class="control-sidebar-menu">
						<li><a href="javascript:;">
								<h4 class="control-sidebar-subheading">
									Custom Template Design <span class="pull-right-container">
										<span class="label label-danger pull-right">70%</span>
									</span>
								</h4>

								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger"
										style="width: 70%"></div>
								</div>
						</a></li>
					</ul>
					<!-- /.control-sidebar-menu -->

				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab
					Content</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
				<div class="tab-pane" id="control-sidebar-settings-tab">
					<form method="post">
						<h3 class="control-sidebar-heading">General Settings</h3>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Report panel
								usage <input type="checkbox" class="pull-right" checked>
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