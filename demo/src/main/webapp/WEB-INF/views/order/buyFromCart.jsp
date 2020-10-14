<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/plugin_js.jsp" %>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<head>
<%-- 버튼 클릭 이벤트 메소드 --%>
<script type="text/javascript" src="/js/order/buyFromCart.js"></script>
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
					상품구매 <small>주문내역</small>
				</h1>
			</section>

			
			<%-- MAIN CONTENT --%> 
			<section class="content container-fluid">
			<div class="row">
				<!-- left column -->
				<div class="box" style="border: none;">
					<form id="orderForm" method="post" action="/order/orderFromCart">
						<div class="box-body" style="padding:30px 10px 100px 10px;">
							<%-- 주문내역 상단 버튼 --%>
							<div class="orderList" style="padding: 0px 40px;">
								<div style="width:100%;">
									<span style="display: inline-block; float: left; margin:20px 10px 5px 0px;">[주문내역]</span>
									<div class="btn-container" style="display: inline-block; float: right; margin:20px 10px 5px 5px;">
										<button id="btn_delete_check"  class="btn btn-default" type="button">선택 상품 삭제</button>
									</div>
								</div>
								<%-- 주문내역 테이블 --%>
								<table class="table table-striped text-center" id="ordertbl">
									<thead id="thead">
										<tr>
											<th><input type="checkbox" id="checkAll" checked="checked"/></th>
											<th>IMAGE</th>
											<th>NAME</th>
											<th>PRICE</th>
											<th>DISCOUNT</th>
											<th>AMOUNT</th>
											<th>TOTAL</th>
										</tr>
										
										<%-- 상품이 존재하지 않는 경우 --%>
										<tr>
											<c:if test="${empty productList}">
												<span>구매할 상품이 존재하지 않습니다.</span>
											</c:if>
										</tr>
									<thead>
									
									<%-- 상품이 존재하는 경우,  리스트 출력 --%>
									<tbody>
									<c:forEach items="${productList}" var="productVO" varStatus="i">
										<tr id="productVO_${productVO.pdt_num}" class="productRow">
											<td class="col-md-1">
												<input type="checkbox" name="check" class="check" value="${productVO.pdt_num}" checked="checked" >
												<input type="hidden" id="amount_${productVO.pdt_num}" name="orderDetailList[${i.index}].odr_amount" value="${amountList[i.index]}" />
												<input type="hidden" name="orderDetailList[${i.index}].pdt_num" value="${productVO.pdt_num}" />
												<input type="hidden" name="orderDetailList[${i.index}].odr_price" value="${productVO.pdt_discount}" />
											</td>
											<td class="col-md-2">
												<a href="/product/read?pdt_num=${productVO.pdt_num}&cg_code=${cg_code}">
													<img src="/product/displayFile?fileName=${productVO.pdt_img}" style="width:100px;">
												</a>
											</td>
											<td class="col-md-2">
												<a href="/product/read?pdt_num=${productVO.pdt_num}&cg_code=${cg_code}"
													style="color: black;"> ${productVO.pdt_name} </a>
											</td>
											<td class="col-md-1">
												<p><fmt:formatNumber value="${productVO.pdt_price}" pattern="###,###,###" /></p>
												<input type="hidden" name="price" value="${productVO.pdt_price}" />
												<!-- 
												<input type="hidden" id="price_${productVO.pdt_num}" value="${productVO.pdt_price}"  />  -->
											<td class="col-md-1">
												<p><fmt:formatNumber value="${productVO.pdt_discount}" pattern="###,###,###" /></p>
												<input type="hidden" name="discount" value="${productVO.pdt_discount}" /> 
											<td class="col-md-1">
												<p>${amountList[i.index]}</p>
												<input type="hidden" name="amount" value="${amountList[i.index]}" /> 
											</td>
											<td class="col-md-1">
												<p><fmt:formatNumber value="${productVO.pdt_discount * amountList[i.index]}"  pattern="###,###,###" /></p>
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
										<div class="form-group" style="width:100%; margin-top:5px;">
											<input type="hidden" class="form-control" id="mem_id" name="mem_id" value="${user.mem_id}">
										</div>
										<div class="form-group">
											<label for="inputName">* 이름</label> <input type="text"
												class="form-control" id="odr_name" name="odr_name" value="${user.mem_name}">
										</div>
										<div class="form-group">
											<label for="inputMobile">* 휴대폰 번호</label> <input type="tel"
												class="form-control" id="odr_phone" name="odr_phone" value="${user.mem_phone}">
										</div>
										<div class="form-group">
											<label for="inputAddr">* 주소</label> <br />
											<input type="text" id="sample2_postcode" name="odr_zipcode" class="form-control" 
												value = "${user.mem_zipcode}"
												style="width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호" readonly>
											<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기"><br>
											<input type="text" id="sample2_address" name="odr_addr" class="form-control" 
												value = "${user.mem_addr}"
												placeholder="주소" style=" margin:3px 0px;" readonly>
											<input type="text" id="sample2_detailAddress" name="odr_addr_d" class="form-control" 
												value = "${user.mem_addr_d}"
												placeholder="상세주소" >
											<input type="hidden" id="sample2_extraAddress" class="form-control" 
												placeholder="참고항목">
										</div>
									</div>
								</div>
								
								<%-- 결제 방식 선택  및 주문 금액 확인 --%>
								<div class="orderConfirm" style="display:inline-block; width:20%; margin: 0px 5%;">
								<br>
									<%-- 결제 방식 --%>
									<div>
										<span>[결제 방식]</span><br>
										<div class="payment" style="margin-top:10px;">
											<input type="radio" name="payment" value="card" checked="checked">카드 결제
											<input type="radio" name="payment" value="tcash">실시간 계좌이체<br>
											<input type="radio" name="payment" value="phone">휴대폰 결제
											<input type="radio" name="payment" value="cash">무통장 입금
										</div>
									</div>
									<br><br><br>
									
									<%-- 주문 금액 --%>
									<div style="width: 400px;">
										<span>[결제 금액]</span>
										<table class="table text-center" style="margin-top:15px;" >
											<tr>
												<td class="col-md-1">총 상품금액</td>
												<td class="col-md-1" style="height:30px; text-align: center;"><p id="totalPrice">0</p></td>
											</tr>
											<tr>
												<td class="col-md-1"><label>결제 예정 금액</label></td>
												<td class="col-md-1" style="height:30px; text-align: center;">
													<label><p id="totalDiscount">0</p></label>
													<input type="hidden" id="odr_total_price" name="odr_total_price" value="0"/>
												</td>
											</tr>
											<tr>
												<td class="col-md-1" colspan="2" >
													<button id="btn_submit" class="btn btn-flat" type="button" style="padding: 10px 40px; background-color: grey; color:white;">결제하기</button>
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