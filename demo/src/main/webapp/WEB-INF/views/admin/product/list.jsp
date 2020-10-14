<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/plugin_js.jsp"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<head>

<%-- 버튼 클릭 이벤트 메소드 --%>
<script>
	$(document).ready(function(){
		/* 검색 버튼 클릭 시 */
		$("#btn_search").on("click", function(){
			self.location = "list"
				+ '${pm.makeQuery(1)}'
				+ "&searchType="
				+ $("select option:selected").val()
				+ "&keyword=" + $('#keyword').val();
		});

		
		/* 전체 선택 체크박스 클릭 시 */
		$("#checkAll").on("click", function(){
			// 전체선택 클릭 여부로 다른 체크박스 체크
			$(".check").prop('checked', this.checked);
		});
		
		/* 체크박스 중 선택안된 체크박스 존재 시 전체선택 해제 */ 
		$(".check").on("click", function(){
			$("#checkAll").prop('checked', false);
		});

		
		/* 선택 상품 수정 버튼 클릭 시 */ 
		$("#btn_edit_check").on("click", function(){

			// 체크여부 유효성 검사
			if($("input[name='check']:checked").length==0){
				alert("수정할 상품을 선택해주세요.");
				return;
			}
			
			var checkArr = [];
			var amountArr = [];
			var buyArr = [];
			
			var pdt_amount = $("#pdt_amount").val();
			var pdt_buy = $("#pdt_buy:selected").val();
			
			// 체크 된 상품의 value(pdt_num)을 가져옴
			$("input[name='check']:checked").each(function(i){
				var pdt_num = $(this).val();
				var pdt_amount = $("input[name='amount_"+pdt_num+"']").val();
				var pdt_buy = $("select[name='buy_"+pdt_num+"']").val();
				
				checkArr.push(pdt_num);			
				amountArr.push(pdt_amount);			
				buyArr.push(pdt_buy);
				
			});
			
			$.ajax({
				url: '/admin/product/editChecked',
				type: 'post',
				dataType: 'text',
				data: {
						checkArr : checkArr,
						amountArr : amountArr,
						buyArr : buyArr
					   },
				success : function(data) {
					alert("수정이 완료되었습니다.");
					location.href="/admin/product/list${pm.makeSearch(pm.cri.page)}";
				}
	
			});
		});
		
		/* 선택 상품 삭제 버튼 클릭 시 */
		$("#btn_delete_check").on("click", function(){

			// 체크여부 유효성 검사
			if($("input[name='check']:checked").length==0){
				alert("삭제할 상품을 선택해주세요.");
				return;
			}
		
			// 체크 된 상품이 존재할 경우 진행
			var result = confirm("선택한 상품을 삭제하시겠습니까?");
			if(result){
				
				var checkArr = [];
				var imgArr = [];
				
				// 체크 된 상품의 value(pdt_num)을 가져옴
				$("input[name='check']:checked").each(function(i){
					var pdt_num = $(this).val();
					var pdt_img = $("input[name='img_"+pdt_num+"']").val();
					
					checkArr.push(pdt_num);
					imgArr.push(pdt_img);
				});
				
				$.ajax({
					url: '/admin/product/deleteChecked',
					type: 'post',
					dataType: 'text',
					data: {
							checkArr : checkArr,
							imgArr : imgArr
						   },
					success : function(data) {
						alert("삭제가 완료되었습니다.");
						location.href = "/admin/product/list${pm.makeSearch(pm.cri.page)}";
					}
				});
			} else{}
		});

		/* 상품 리스트 - 삭제 버튼 클릭 시 */
		$("button[name=btn_delete]").on("click", function(){
			var result = confirm("이 상품을 삭제하시겠습니까?");
			if(result){
				$(".deleteForm").submit();
			} else{}
		});
	});
</script>
<script>
	/* 상품 수정 버튼 클릭 시 */
	var clickEdit = function(pdt_num){
		var url = '/admin/product/edit${pm.makeSearch(pm.cri.page)}&pdt_num=' + pdt_num;
		location.href= url;
	};
</script>

<%-- 메시지 처리 --%>
<script>
	if ("${msg}" == "INSERT_SUCCESS") {
		alert("상품등록이 완료되었습니다.");
		
	} else if ("${msg}" == "EDIT_SUCCESS") {
		alert("상품 수정이 완료되었습니다.");
		
	} else if ("${msg}" == "DELETE_SUCCESS") {
		alert("상품 삭제가 완료되었습니다.");
	}
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
					Admin Page <small>Product List</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 상품 관리</a></li>
					<li class="active">상품 목록</li>
				</ol>
			</section>

			<%-- MAIN CONTENT --%>
			<!-- Main content -->
			<section class="content container-fluid">

				<!--------------------------
		        | Your Page Content Here |
		        -------------------------->

				<div class="row">
					<!-- left column -->
					<%-- 검색 조건 설정 및 페이지 이동에도 해당 값 유지 --%>
					<div class="col-md-12">
						<div class="row text-center">
							<div style="display: inline-block; float: left; margin-left:15px;">
							<select name="searchType" style="width:180px; height:26px;">
								<option value="null"
									<c:out value="${cri.searchType == null?'selected':''}"/>>검색조건 선택</option>
								<option value="name"
									<c:out value="${cri.searchType eq 'name'?'selected':''}"/>>상품명</option>
								<option value="detail"
									<c:out value="${cri.searchType eq 'detail'?'selected':''}"/>>내용</option>
								<option value="company"
									<c:out value="${cri.searchType eq 'company'?'selected':''}"/>>제조사</option>
								<option value="name_detail"
									<c:out value="${cri.searchType eq 'name_detail'?'selected':''}"/>>상품명+내용</option>
								<option value="name_company"
									<c:out value="${cri.searchType eq 'name_company'?'selected':''}"/>>상품명+제조사</option>
								<option value="all"
									<c:out value="${cri.searchType eq 'all'?'selected':''}"/>>상품명+내용+제조사</option>
							</select> 
							<input type="text" name='keyword' id="keyword" style="width:250px; padding-left:5px;" value='${cri.keyword}' />
							<button id="btn_search" class="btn btn-default">검색</button>
							</div>
							<div style="display: inline-block; float: right; margin-right:15px;">
							<button id="btn_edit_check"  class="btn btn-default" >선택 상품 수정</button>
							<button id="btn_delete_check"  class="btn btn-default" >선택 상품 삭제</button>
							<button class="btn btn-primary"
								onClick="location.href='/admin/product/insert'">상품 등록</button>
							</div>	
						</div>
						<br>

						<div class="box" style="border: none;">
							<div class="box-body">
								<table class="table table-striped text-center">
									<tr>
										<th><input type="checkbox" id="checkAll" /></th>
										<th>상품 번호</th>
										<th>상품 이미지</th>
										<th>상품명</th>
										<th>판매가</th>
										<th>할인가</th>
										<th>제조사</th>
										<th>수량</th>
										<th>판매여부</th>
										<th>수정/삭제</th>
									</tr>
									
									<%-- 상품 리스트 출력 --%>
									<c:if test="${empty productList}">
										<tr>
											<td colspan="10"> 
												<p style="padding:50px 0px; text-align: center;"><td colspan="10"> 
											<p style="padding:50px 0px; text-align: center;">등록된 상품이 존재하지 않습니다.</p>
										</td></p>
											</td>
										<tr>
									</c:if>
									<c:forEach items="${productList}" var="productVO">
										<tr>
											<td><input type="checkbox" name="check" class="check" value="${productVO.pdt_num}" style=""></td>
											<td class="col-md-1">${productVO.pdt_num}</td>
											<td class="col-md-2">
												<img src="/admin/product/displayFile?fileName=${productVO.pdt_img}" style="width:80px;">
												

												<!--  용도?-->
												<input type="hidden" name="img_${productVO.pdt_num}" value="${productVO.pdt_img}" />



											</td>
											<td class="col-md-2"><a
												href="/admin/product/read${pm.makeSearch(pm.cri.page)}&pdt_num=${productVO.pdt_num}"
												style="color: black;"> ${productVO.pdt_name} </a></td>
											<td class="col-md-1">${productVO.pdt_price}</td>
											<td class="col-md-1">${productVO.pdt_discount}</td>
											<td class="col-md-2">${productVO.pdt_company}</td>
											
											<!-- 상품 전시(보임/숨김)기능 -->
											<td><input name="amount_${productVO.pdt_num}" type="number" style="width:80px; height:34px; padding-left:5px;" value="${productVO.pdt_amount}" /></td>
											<td>
												<select class="form-control" name="buy_${productVO.pdt_num}" style="width: 60px; display: inline-block;">
												  <option <c:out value="${productVO.pdt_buy == 'Y'?'selected':''}"/>>Y</option>
												  <option <c:out value="${productVO.pdt_buy == 'N'?'selected':''}"/>>N</option>
												</select>
											</td>
											<td class="col-md-2">
												<form class="deleteForm" method="post"
													action="/admin/product/delete${pm.makeSearch(pm.cri.page)}">
													<!-- 상품 코드 -->
													<input type="hidden" name="pdt_num"
														value="${productVO.pdt_num}">
													<!-- 파일 이미지명 -->
													<input type="hidden" name="pdt_img"
														value="${productVO.pdt_img}">
														<!-- 수정기능 -->
													<button type="button" name="btn_edit" class="btn btn-default" onclick="clickEdit(${productVO.pdt_num});">수정</button>
													
													<!-- 삭제기능 -->
													<button type="button" name="btn_delete" class="btn btn-danger">삭제</button>
												</form>
											</td>
										</tr>

									</c:forEach>
								</table>
							</div>
							<!-- /.box-body -->


							<!-- 페이징 기능 -->
							<div class="box-footer">

								<div class="text-center">
									<ul class="pagination">
										<!-- 이전표시 여부  [이전] -->
										<c:if test="${pm.prev}">
											<li><a href="list${pm.makeSearch(pm.startPage-1)}">&laquo;</a>
											</li>
										</c:if>
										<!-- 페이지목록번호 :  1  2  3  4  5  -->
										<c:forEach begin="${pm.startPage}" end="${pm.endPage}"
											var="idx">
											<li <c:out value="${pm.cri.page == idx?'class =active':''}"/>>
												<a href="list${pm.makeSearch(idx)}">${idx}</a>
											</li>
										</c:forEach>
										<!-- 다음표시 여부  [다음]-->
										<c:if test="${pm.next && pm.endPage > 0}">
											<li><a href="list${pm.makeSearch(pm.endPage +1)}">&raquo;</a>
											</li>
										</c:if>

									</ul>
								</div>

							</div>
							<!-- /.box-footer-->
						</div>
					</div>
					<!--/.col (left) -->

				</div>

			</section>
		</div>
		<!-- /.content -->
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