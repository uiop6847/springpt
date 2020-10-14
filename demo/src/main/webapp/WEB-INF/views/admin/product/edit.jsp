<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

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


<%-- ckEditor랑 버튼 클릭 이벤트 --%>
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
			var mainCGCode= $(this).val();
			var url = "/admin/product/subCGList/" + mainCGCode;

			// REST 방식으로 전송
			$.getJSON(url, function(data){
				// 받은 데이터로 subCategory에 템플릿 적용
				subCGList(data, $("#subCategory") ,$("#subCGListTemplate"))
				
			});
		});

		/* 상품 목록 버튼 클릭 시 */
		$("#btn_list").on("click", function(){
			var result = confirm("내용을 저장하지 않고, 목록으로 돌아가시겠습니까?");
			
			if(result){
				location.href="/admin/product/list${pm.makeSearch(pm.cri.page)}";
			} else {}
		});
	});
</script>
	
	
<%-- 2차 카테고리 템플릿 적용함수 --%>
<script>
	var subCGList = function(subCGStr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());
		var options = template(subCGStr);

		// 기존 option 제거(누적방지)
		$("#subCategory option").remove();
		target.append(options);
	}
</script>
<%-- 파일 변경 이벤트 메소드 --%>
<script>
	var fileChange = function(fis) {
		var str = fis.value;
		$("#fileName").html("파일이 변경됨");
	}
</script>


<%-- 수정 버튼 클릭 시 유효성 검사 --%>
<script type="text/javascript" src="/js/admin/edit.js"></script>


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
					Admin Page <small>Product Edit</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 상품 관리</a></li>
					<li class="active">상품 수정</li>
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
								<h3 class="box-title">EDIT THIS PRODUCT</h3>
							</div>
							<!-- /.box-header -->

							<form id='editForm' role="form" action="/admin/product/edit" method="post" enctype="multipart/form-data">
								<div class="box-body">
								 
									<div class="form-group">
										<input type="hidden" name="page" value="${cri.page}" />
										<input type="hidden" name="perPageNum" value="${cri.perPageNum}" />
										<input type="hidden" name="searchType" value="${cri.searchType}" />
										<input type="hidden" name="keyword" value="${cri.keyword}" />
									</div>
									
									<div class="form-group">
										<input name="pdt_num" type="hidden" value="${vo.pdt_num}" />
										<label for="exampleInputEmail1" style="width:30%; margin-right:20px;" >1차 카테고리</label>
										<label for="exampleInputEmail1" style="width:30%;" >2차 카테고리</label> <br />
										<select class="form-control" id="mainCategory" name="cg_code_prt" style="width:30%; margin-right:10px; display: inline-block;" >
											<option value="default">1차 카테고리 선택</option>
											<c:forEach items="${cateList}" var="list">
												<option value="${list.cg_code}"<c:out value="${vo.cg_code_prt == list.cg_code?'selected':''}"/>>${list.cg_name}</option>
											</c:forEach>
										</select>
										<select class="form-control" id="subCategory" name="cg_code" style="width: 30%; display: inline-block;">
										 	<option value="default">2차 카테고리 선택</option>
										 	<c:forEach items="${subCateList}" var="subList">
										  		<option value="${subList.cg_code}"<c:out value="${vo.cg_code == subList.cg_code?'selected':''}"/>>${subList.cg_name}</option>
										 	</c:forEach>
										</select>
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">Product Name</label> <input
											type="text" id="pdt_name" name="pdt_name" class="form-control"
											value="${vo.pdt_name}">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1">Company</label> <input
											type="text" id="pdt_company" name="pdt_company" class="form-control"
											value="${vo.pdt_company}">
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1" style="width:40%; margin-right:10px;">Price</label> 
										<label for="exampleInputEmail1" style="width:40%;">Discount</label> 
										<input style="width:40%; margin-right:10px; display: inline-block;"
											type="text" id="pdt_price" name="pdt_price" class="form-control" 
											value="${vo.pdt_price}" />
										<input style="width:40%; display: inline-block;"
											type="text" id="pdt_discount" name="pdt_discount" class="form-control "
											value="${vo.pdt_discount}" />
									</div>
									<div class="form-group">
										<label for="exampleInputPassword1">Detail</label>
										<textarea class="form-control" id="pdt_detail" name="pdt_detail" rows="8">
											${vo.pdt_detail}</textarea>
									</div>
									<div class="form-group">
										<input type="hidden" name="pdt_img" value="${vo.pdt_img}" />	
										<label for="exampleInputEmail1">Thumbnail Image</label> 
										<span id="fileName" style="margin-left:5px; font-size:14px;">현재 등록된 파일: <c:out value="${originFile}" /></span>
										<input onchange="fileChange(this)"
											type="file" id="file1" name="file1" class="form-control" />
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1" style="width:30%; margin-right:10px;">Amount</label> 
										<label for="exampleInputEmail1" style="width:15%;">Buy availability</label><br /> 
										<input style="width:30%; margin-right:10px; display: inline-block;"
											type="text" id="pdt_amount" name='pdt_amount' class="form-control" 
											value="${vo.pdt_amount}" />
										<select class="form-control" id="pdt_buy" name="pdt_buy" style="width: 15%; display: inline-block;">
										  <option 
										  	<c:out value="${vo.pdt_buy == 'Y'?'selected':''}"/>>Y</option>
										  <option
										  	<c:out value="${vo.pdt_buy == 'N'?'selected':''}"/>>N</option>
										</select>
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

									<button id="btn_submit" type="button" class="btn btn-primary" >Submit</button>
									<button id="btn_list" type="button" class="btn btn-default" >List</button>
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