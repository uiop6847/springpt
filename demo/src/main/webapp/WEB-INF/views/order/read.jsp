<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<head>

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
					주문 상세 내역 <small>Order Detail</small>
				</h1>
			</section>

			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid">
			<div class="row">
				<!-- left column -->
				<div class="box" style="border: none;">
					<form id="orderForm" method="post" action="/order/buy">
						<div class="box-body" style="padding:30px 10px 100px 10px;">
							<%-- 주문내역 상단 버튼 --%>
							<div class="orderList" style="padding: 0px 40px;">
								<%-- 주문내역 테이블 --%>
								<table class="table  text-center" id="ordertbl">
									<thead id="thead">
										<tr style="background-color: aliceBlue;" >
											<td colspan="7" style="text-align:left;">
												<b>주문날짜: <fmt:formatDate value="${order.odr_date}" pattern="yyyy/MM/dd HH:mm:ss"/>
												(주문번호: ${order.odr_code} )</b>
											</td>
										<tr>
										<tr style="background-color: whitesmoke;">
											<td>IMAGE</td>
											<td>NAME</td>
											<td>PRICE</td>
											<td>DISCOUNT</td>
											<td>AMOUNT</td>	
											<td>TOTAL</td> 
											<td>REVIEW</td>
										</tr>
										<%-- 상품이 존재하지 않는 경우 --%>
										<tr>
											<c:if test="${empty orderList}">
												<span>구매한 상품이 존재하지 않습니다.</span>
											</c:if>
										</tr>
									<thead>
									
									<%-- 상품이 존재하는 경우,  리스트 출력 --%>
									<tbody>
									<c:forEach items="${orderList}" var="product" varStatus="status">
									<c:set var="totalPrice" value="${totalPrice + orderList[status.index].pdt_price * orderList[status.index].odr_amount}"></c:set>
										<tr id="row">
											<td class="col-md-2">
												<a href="/product/read?pdt_num=${product.pdt_num}">
													<img src="/product/displayFile?fileName=${product.pdt_img}" style="width:100px;">
												</a>
											</td>
											<td class="col-md-2">
												<a href="/product/read?pdt_num=${product.pdt_num}"
													style="color: black;"> ${product.pdt_name} </a>
											</td>
											<td class="col-md-1">
												<p><fmt:formatNumber value="${product.pdt_price}" pattern="###,###,###" /></p>
											</td>
											<td class="col-md-1">
												<p><fmt:formatNumber value="${product.odr_price}" pattern="###,###,###" /></p>
											</td>
											<td class="col-md-1">
												<p>${product.odr_amount}</p>
											</td>
											<td class="col-md-1">
												<p ><fmt:formatNumber value="${product.odr_price * product.odr_amount}"  pattern="###,###,###" /></p>
											</td>
											<td class="col-md-1">
												<button type="button" name="btn_review" class="btn btn-flat" 
												onclick="location.href='/product/read?pdt_num=${product.pdt_num}';" value="${product.pdt_num}" >상품후기 쓰기</button>
											</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
								<br><br><br>
							</div>
							<hr><br>
							
							<%-- 주문 정보 --%>
							<div class="orderInfo" style="min-width:1000px;" > 
								<div class="userInfo" style="display:inline-block; float:left; width:60%; padding: 0% 5%;">
									<div class="container" style="width:100%;">
										<span>[주문 정보]</span>
										<div class="form-group">
											<label for="inputName">* 이름</label> <input type="text"
												class="form-control" value="${order.odr_name}" readonly>
										</div>
										<div class="form-group">
											<label for="inputMobile">* 휴대폰 번호</label> <input type="tel"
												class="form-control" value="${order.odr_phone}" readonly>
										</div>
										<div class="form-group">
											<label for="inputAddr">* 주소</label> <br />
											<input type="text" id="sample2_postcode" name="odr_zipcode" class="form-control" 
												value = "${order.odr_zipcode}" 
												style="width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호" readonly>
											<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기" disabled="disabled"><br>
											<input type="text" id="sample2_address" name="odr_addr" class="form-control" 
												value = "${order.odr_addr}" 
												placeholder="주소" style=" margin:3px 0px;" readonly>
											<input type="text" id="sample2_detailAddress" name="odr_addr_d" class="form-control" 
												value = "${order.odr_addr_d}"
												placeholder="상세주소" readonly >
											<input type="hidden" id="sample2_extraAddress" class="form-control" 
												placeholder="참고항목">
										</div>
									</div>
								</div>
								
								<%-- 주문 금액 확인 --%>
								<div class="orderConfirm" style="display:inline-block; width:20%; margin: 0px 5%;">
								<br>
									<%-- 주문 금액 --%>
									<div style="width: 400px;">
										<span>[결제 금액]</span>
										<table class="table text-center" style="margin-top:15px;" >
											<tr>
												<td class="col-md-1">총 상품금액</td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<fmt:formatNumber value="${totalPrice}" pattern="###,###,###" />원</td>
											</tr>
											<tr>
												<td class="col-md-1">할인된 금액(-)</td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<fmt:formatNumber value="${totalPrice-order.odr_total_price}" pattern="###,###,###" />원</td>
											</tr>
											<tr>
												<td class="col-md-1"><label>결제 금액</label></td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<label><fmt:formatNumber value="${order.odr_total_price}" pattern="###,###,###" />원</label>
												</td>
											</tr>
										</table>
								
									</div>
								</div>
							</div>
						</div>
					</form>
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