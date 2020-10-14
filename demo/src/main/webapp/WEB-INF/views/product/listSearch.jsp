<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<head>
<%-- 스타일 처리 --%>
<style>
	ul{
   		list-style:none;
   		padding-left:0px;
    }
    .product{
    	display: inline-block;
    	margin: 10px;
    	padding:22px 40px;
    }
    .description{
    	margin: 10px;
    }
</style>

<%-- 버튼 처리 --%>
<script>
	/* 장바구니 버튼 클릭 이벤트 */
	var cart_click = function(pdt_num){
		$.ajax({
			url: "/cart/add",
			type: "post",
			dataType: "text",
			data: {pdt_num: pdt_num},
			success: function(data){
				var result = confirm("장바구니에 추가되었습니다.\n지금 확인하시겠습니까?");
				if(result){
					location.href="/cart/list";
				} else{}
			}
		});
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
					Product List 
				</h1>
				<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> 상품목록</a>
					</li>
				</ol>
			</section>

			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid">
				<%-- 상품 목록 표시 --%>
				<div style="width:100%; min-width:1400px; background-color:white; padding: 50px 180px;" class="container text-center">
					<h3>Search : ${scri.keyword}</h3><br>
					<ul class="pdtList">
						<%-- 상품이 존재하지 않는 경우 --%>
						<c:if test="${empty productList}">
							<span>검색 조건에 일치하는 상품이 존재하지 않습니다.</span>
						</c:if>
						
						<%-- 상품이 존재하는 경우 --%>
						<c:forEach items="${productList}" var="productVO" >
						<li class="product">
							${productVO.pdt_num}
							<div class="thumnail">
								<a href="/product/readSearch${pm.makeSearch(pm.cri.page)}&pdt_num=${productVO.pdt_num}">
									<img src="/product/displayFile?fileName=${productVO.pdt_img}" >
								</a>
							</div>
							<div class="description">
								<a href="/product/readSearch${pm.makeSearch(pm.cri.page)}&pdt_num=${productVO.pdt_num}" >${productVO.pdt_name}</a>
								<p>가격: <fmt:formatNumber value="${productVO.pdt_price}" pattern="###,###,###" />원<br>
								 	할인가: <fmt:formatNumber value="${productVO.pdt_discount}" pattern="###,###,###" />원</p>
							</div>
							<div class="btnContainer">
								<button class="btn btn-primary" id="btn_buy" type="button" 
									onclick="location.href = '/order/buy?pdt_num=${productVO.pdt_num}&ord_amount=1';">구매</button>
								<button class="btn btn-default" id="btn_cart" type="button" 
									onclick="cart_click(${productVO.pdt_num})">장바구니</button>
							</div>
						</c:forEach>
					</ul>
				</div>
				<%-- 페이지 표시 --%>
				<div class="box-footer container" style="width:100%; min-width:1400px;">
					<div class="text-center">
						<ul class="pagination">
							<c:if test="${pm.prev}">
								<li><a href="listSearch${pm.makeSearch(pm.startPage-1)}">&laquo;</a>
								</li>
							</c:if>

							<c:forEach begin="${pm.startPage}" end="${pm.endPage}"
								var="idx">
								<li <c:out value="${pm.cri.page == idx?'class =active':''}"/>>
									<a href="listSearch${pm.makeSearch(idx)}">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pm.next && pm.endPage > 0}">
								<li><a href="listSearch${pm.makeSearch(pm.endPage +1)}">&raquo;</a>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
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