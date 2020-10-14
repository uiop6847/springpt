<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/plugin_js.jsp"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<head>
<script src="/ckeditor/ckeditor.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<%-- Handlebar Template --%>
<script id="subCGListTemplate" type="text/x-handlebars-template">
	<option value="default">2차 카테고리  선택</option>
	{{#each .}}
	<option value="{{cg_code}}">{{cg_name}} </option>
	{{/each}}
</script>


<%-- ckEditor랑 2차 카테고리 처리 이벤트 --%>
<script>
	$(document).ready(function(){
		/* ckEditor 작업 */
		// config.js를 사용하지 않고 개별 설정하는 부분
		var ckeditor_config = {
				resize_enabled : false,
				enterMode : CKEDITOR.ENTER_BR,
				shiftEnterMode : CKEDITOR.ENTER_P,
				toolbarCanCollapse : true,
				removePlugins : "elementspath", 
				// 파일 업로드 기능 추가
				// CKEditor를 이용해 업로드 사용 시 해당 주소에 업로드 됨
				filebrowserUploadUrl: '/admin/product/imgUpload'
		};
		CKEDITOR.replace("pdt_detail", ckeditor_config);
		// config.js의 설정을 사용하려면, 다음과 같이 사용
		// CKEDITOR.replace("desc", "");

		/* 1차 카테고리에 따른 2차 카테고리 작업 */
		$("#mainCategory").on("change", function(){
			var mainCGCode= $(this).val(); // 선택한 1차카테고리 코드
			var url = "/admin/product/subCGList/" + mainCGCode;   // url매핑주소를 경로형태로 사용 @PathVarialbe

			// REST 방식으로 전송
			$.getJSON(url, function(data){		// data : 2차카테고리 데이터정보
				// 받은 데이터로 subCategory에 템플릿 적용
				subCGList(data, $("#subCategory") ,$("#subCGListTemplate"))
				
			});

		});
	});
</script>
	
	
<%-- 2차 카테고리 템플릿 적용함수 --%>
<script>
	var subCGList = function(subCGStr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());
		var options = template(subCGStr); // 템플릿에 2차카테고리 데이터가 바인딩된 소스

		// 기존 option 제거(누적방지)
		$("#subCategory option").remove();
		target.append(options);
	}
</script>

<%-- 등록 버튼 클릭 시 유효성 검사 --%>
<script type="text/javascript" src="/js/admin/insert.js"></script>

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
					Admin Page <small>Product Insert</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 상품 관리</a></li>
					<li class="active">상품 등록</li>
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
								<h3 class="box-title">ADD NEW PRODUCT</h3>
							</div>
							<!-- /.box-header -->

							<form id='registerForm' role="form" action="/admin/product/insert" method="post" enctype="multipart/form-data">
								<div class="box-body">
									<div class="form-group">
										<label for="exampleInputEmail1" style="width:30%; margin-right:20px;" >1차 카테고리</label>
										<label for="exampleInputEmail1" style="width:30%;" >2차 카테고리</label> <br />
										<select class="form-control" id="mainCategory" name="cg_code_prt" style="width:30%; margin-right:10px; display: inline-block;" >
										  <option value="default">1차 카테고리 선택</option>
										  <c:forEach items="${cateList}" var="vo">
										  	<option value="${vo.cg_code}">${vo.cg_name}</option>
										  </c:forEach>
										</select>
										<select class="form-control" id="subCategory" name="cg_code" style="width: 30%; display: inline-block;">
										 	<option value="default">2차 카테고리 선택</option>
										</select>
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">Product Name</label> <input
											type="text" id="pdt_name" name="pdt_name" class="form-control"
											placeholder="Enter Product name">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">Company</label> <input
											type="text" id="pdt_company" name="pdt_company" class="form-control"
											placeholder="Enter company">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1" style="width:40%; margin-right:10px;">Price</label> 
										<label for="exampleInputEmail1" style="width:40%;">Discount</label> 
										<input style="width:40%; margin-right:10px; display: inline-block;"
											type="text" id="pdt_price" name="pdt_price" class="form-control" 
											placeholder="Enter price" />
										<input style="width:40%; display: inline-block;"
											type="text" id="pdt_discount" name="pdt_discount" class="form-control "
											placeholder="Enter discounted price" />
									</div>
									<div class="form-group">
										<label for="exampleInputPassword1">Detail</label>
										<textarea class="form-control" id="pdt_detail" name="pdt_detail" rows="8"
											placeholder="Enter ..."></textarea>
									</div>

									<div class="form-group">
										<label for="exampleInputEmail1">Thumbnail Image</label> <input
											type="file" id="file1" name="file1" class="form-control" />
									</div>
									
									<div class="form-group">
										<label for="exampleInputEmail1" style="width:30%; margin-right:10px;">Amount</label> 
										<label for="exampleInputEmail1" style="width:15%;">Buy availability</label><br /> 
										<input style="width:30%; margin-right:10px; display: inline-block;"
											type="text" id="pdt_amount" name='pdt_amount' class="form-control" 
											placeholder="Enter Amount" />
										<select class="form-control" id="pdt_buy" name="pdt_buy" style="width: 15%; display: inline-block;">
										  <option>Y</option>
										  <option>N</option>
										</select>
									</div>
								</div>

								<!-- /.box-body -->

								<div class="box-footer">
									<div>
										<hr>
									</div>

									<ul class="mailbox-attachments clearfix uploadedList">
									</ul>

									<button id="btn_submit" type="button" class="btn btn-primary">Submit</button>

								</div>
							</form>


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