<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/plugin_js.jsp"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<head>

<%-- 버튼 클릭 이벤트 메소드 --%>
<script type="text/javascript" src="/js/cart/list.js"></script>

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
					장바구니 <small>Cart List</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> MAIN</a></li>
					<li class="active">장바구니</li>
				</ol>
			</section>

			<%-- MAIN CONTENT --%>
			<!-- Main content -->
			<section class="content container-fluid">

				<div class="row">
					<!-- left column -->
					<div class="box" style="border: none;">
						<form method="post" action="/order/buyFromCart">
						<div class="btn-container" style="display: inline-block; float: right; margin:20px 10px 5px 5px;">
							<button id="btn_buy_check"  class="btn btn-primary" type="submit" >선택 상품 구매</button>
							<button id="btn_delete_check"  class="btn btn-default" >선택 상품 삭제</button>
						</div>
						<div class="box-body">
							<table class="table table-striped text-center">
								<tr>
									<th><input type="checkbox" id="checkAll" checked="checked"/></th>
									<th>번호</th>
									<th>상품 이미지</th>
									<th>상품명</th>
									<th>판매가</th>
									<th>할인가</th>
									<th>수량</th>
									<th>구매/삭제</th>
								</tr>
								
								<%-- 상품이 존재하지 않는 경우 --%>
								<c:if test="${empty cartProductList}">
									<tr>
										<td colspan="10"> 
											<p style="padding:50px 0px; text-align: center;">장바구니에 담긴 상품이 없습니다.</p>
										</td>
									<tr>
								</c:if>
								
								<%-- 상품이 존재하는 경우,  리스트 출력 --%>
								<%--JSTL 변수 선언 --%>
								<c:set var="i" value="${fn:length(cartProductList)}" />
								<c:forEach items="${cartProductList}" var="cartProductVO">
									<tr>
										<td class="col-md-1">
											<input type="checkbox" name="check" class="check" value="${cartProductVO.cart_code}" checked="checked" >
											<input type="hidden" id="pdt_num_${cartProductVO.cart_code}" name="pdt_num" value="${cartProductVO.pdt_num}" >
											<input type="hidden" name="cart_amount" value="${cartProductVO.cart_amount}" >
											<input type="hidden" name="cart_code" value="${cartProductVO.cart_code}" >
										</td>
										<td class="col-md-1">${i}</td>
										<td class="col-md-2">
											<a href="/product/read?pdt_num=${cartProductVO.pdt_num}&cg_code=${cg_code}">
												<img src="/product/displayFile?fileName=${cartProductVO.pdt_img}" style="width:100px;">
											</a>
										</td>
										<td class="col-md-2">
											<a href="/product/read?pdt_num=${cartProductVO.pdt_num}&cg_code=${cg_code}"
												style="color: black;"> ${cartProductVO.pdt_name} </a>
										</td>
										<td class="col-md-1">
											<p>${cartProductVO.pdt_price}</p>
											<input type="hidden" name="price_${cartProductVO.cart_code}" value="${cartProductVO.pdt_price}" /></td>
										<td class="col-md-1">
											<p>${cartProductVO.pdt_discount}</p>
											<input type="hidden" name="discount_${cartProductVO.cart_code}" value="${cartProductVO.pdt_discount}" /></td>
										<td class="col-md-2">
											<input type="number" name="cart_amount_${cartProductVO.cart_code}"
												style="width:60px; height:34px; padding-left:5px;" value="${cartProductVO.cart_amount}" />
											<button type="button" name="btn_modify" class="btn btn-default" value="${cartProductVO.cart_code}" >변경</button>
										</td>
										<td class="col-md-2">
											<button type="button" name="btn_buy" class="btn btn-primary" value="${cartProductVO.cart_code}"
												onclick="clickBuyBtn(${cartProductVO.pdt_num}, ${cartProductVO.cart_code});">구매</button>
											<button type="button" name="btn_delete" class="btn btn-default" value="${cartProductVO.cart_code}" >삭제</button>
										</td>
										<c:set var="i" value="${i-1}" ></c:set>
									</tr>

								</c:forEach>
							</table>
						</div>
						</form>
						<div class="box-body" style="margin: 7% 10%; padding-bottom:10%; min-width: 600px;">
							<table class="table table-striped text-center" >
								<tr>
									<td class="col-md-1">총 상품금액</td>
									<td class="col-md-1">결제 예정 금액</td>
								</tr>
								<tr >
									<td class="col-md-1" style="height:50px; text-align: center;"><p id="totalPrice">0</p></td>
									<td class="col-md-1" style="height:50px; text-align: center;"><p id="totalDiscount">0</p></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				<!--/.col (left) -->
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