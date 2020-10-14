<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<%@include file="/WEB-INF/views/include/plugin_js.jsp"%>
<%@include file="/WEB-INF/views/include/header.jsp"%>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script type="text/javascript" src="/js/product/read.js"></script>

<%-- 템플릿: 상품목록 --%>
<script id="template" type="text/x-handlebars-template">
	{{#each .}}
		<li class="replyLi" data-rv_num={{rv_num}}>
        	<i class="fa fa-comments bg-blue"></i>
            <div class="timeline-item" >
                <span class="time">
                	<i class="fa fa-clock-o"></i>{{prettifyDate rv_date_reg}}
                </span>
                <h3 class="timeline-header">
					<strong>{{checkRating rv_score}} <p class='rv_score' style="display:inline-block;">{{rv_score}}</p></strong> 
					</h3>
                <div class="timeline-body">
					NUM: {{rv_num}} <p style="float:right;">작성자: {{mem_id}}</p> <br>
					<p id='rv_content'>{{rv_content}}</p> </div>
				<div class="timeline-footer" style="float:right;">
					{{eqReplyer mem_id rv_num}}
				</div>
	         </div>			
         </li>
	{{/each}}
</script>

<%-- 버튼 클릭 이벤트 메소드/ 핸들바 사용자 정의 헬퍼 --%>
<script>
	$(document).ready(function(){

		/* 상품 목록 버튼 클릭 시 */
		$("#btn_list").on("click", function(){
			location.href="/product/listSearch${pm.makeSearch(pm.cri.page)}";
		});

		/* 
		 * 사용자 정의 헬퍼(prettifyDate)
		 * : 매개변수로 받은 timeValue를 원하는 날짜 형태로 바꿔준다.
		 */ 
		Handlebars.registerHelper("prettifyDate", function(timeValue) {
			var dateObj = new Date(timeValue);
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var date = dateObj.getDate();
			return year + "/" + month + "/" + date;
		});

		/* 
		 * 사용자 정의 헬퍼(checkRating)
		 * : 매개변수로 받은 후기 평점을 별표로 출력
		 */ 
		Handlebars.registerHelper("checkRating", function(rating) {
			var stars = "";
			switch(rating){
				case 1:
					 stars="★☆☆☆☆";
					 break;
				case 2:
					 stars="★★☆☆☆";
					 break;
				case 3:
					 stars="★★★☆☆";
					 break;
				case 4:
					 stars="★★★★☆";
					 break;
				case 5:
					 stars="★★★★★";
					 break;
				default:
					stars="☆☆☆☆☆";
			}
			return stars;
		});

		/* 
		 * 사용자 정의 헬퍼(eqReplyer)
		 * : 로그인 한 아이디와 리뷰의 아이디 확인 후, 수정/삭제 버튼 활성화 
		 */ 
		Handlebars.registerHelper("eqReplyer", function(replyer, rv_num) {
			var btnHtml = '';
			var mem_id = "${sessionScope.user.mem_id}";
			if (replyer == "${user.mem_id}") {
				btnHtml = "<a class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modifyModal'>"
					  + "MODIFY</a>"
					  + "<button class='btn btn-danger btn-xs' style='margin-left:5px;'" 
					  + "onclick='deleteReview("+rv_num+");'"
					  + "type='button' >DELETE</button>"; 
			}
			return new Handlebars.SafeString(btnHtml);
			

		});
				
	});
</script>

<%-- 스타일 --%>
<style>
     #star_grade a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade a.on{
        color: black;
    }
    
    #star_grade_modal a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade_modal a.on{
        color: black;
    }
    
    .popup {position: absolute;}
    .back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow:hidden;  z-index:1101;}
    .front { 
       z-index:1110; opacity:1; boarder:1px; margin: auto; 
      }
     .show{
       position:relative;
       max-width: 1200px; 
       max-height: 800px; 
       overflow: auto;       
     } 
</style>
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
					Product Detail 
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> 상품 목록</a></li>
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
								<div class="form-group container" style="margin:30px 0px; height:350px;" >
									<div style="float:left; width:30%; height:100%;">
										<img src="/product/displayFile?fileName=${vo.pdt_img}" style="display: inline; width:90%;">
									</div>
									<div style="display: inline-block; margin-left:20px;">
										<label for="exampleInputEmail1">Product Name</label><br>
										<span>${vo.pdt_name}</span><br><br>
										
										<label for="exampleInputEmail1">Company</label><br>
										<span>${vo.pdt_company}</span><br><br>
										
										<div>
											<label for="exampleInputEmail1" style="width:100px; margin-right:10px;">Price</label> 
											<label for="exampleInputEmail1" style="width:100px;">Discount</label> <br>
											<span style="width:100px; margin-right:10px; display:inline-block;">
												<fmt:formatNumber value="${vo.pdt_price}" pattern="###,###,###" />원
											</span>
											<span style="width:100px; display:inline-block;">
												<fmt:formatNumber value="${vo.pdt_discount}" pattern="###,###,###" />원
											</span>
										</div>
										<br>
										
										<div>
											<form method="get" action="/order/buy" >
												<label for="exampleInputEmail1">Amount</label><br>
												<input type="number" id="ord_amount" name="ord_amount" value="1" /><br><br>
												<input type="hidden" id="pdt_num" name="pdt_num" value="${vo.pdt_num}" />
												<button type="submit" id="btn_buy" class="btn btn-primary">Buy</button>
												<button type="button" id="btn_cart" class="btn btn-default">Cart</button>
											</form>
										</div>
										
									</div>
								</div>
								<!-- 상품 상세 -->
								<label for="detail">Detail</label><br>
								<div contenteditable="false" style="border: 1px solid grey; padding: 20px;">
									${vo.pdt_detail}
								</div>
								<br>
								
								<%-- 상품 후기 --%>
								<div class='popup back' style="display:none;"></div>
							    <div id="popup_front" class='popup front' style="display:none;">
							     	<img id="popup_img">
							    </div>
						    	<form role="form" action="modifyPage" method="post">
									<input type='hidden' name='bno' value="${boardVO.bno}">
									<input type='hidden' name='page' value="${cri.page}"> 
									<input type='hidden' name='perPageNum' value="${cri.perPageNum}">
									<input type='hidden' name='searchType' value="${cri.searchType}">
									<input type='hidden' name='keyword' value="${cri.keyword}">
								</form>
								
								<div>
									<!-- 상품후기쓰기 부분 -->
									 <div>
										<label for="review">Review</label><br>
										<div class="rating">
											<p id="star_grade">
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
										        <a href="#">★</a>
											</p>
										</div>
										<textarea id="reviewContent" rows="3" style="width:100%;"></textarea><br>
									
										<!-- 상품 후기 리스트 -->
									 	<ul class="timeline">
				 							 <!-- timeline time label -->
											<li class="time-label" id="repliesDiv">
												<span class="btn btn-default">
											    	상품후기 보기 <small id='replycntSmall'> [ ${totalReview} ] </small>
											    </span>
											    <button class="btn btn-primary" id="btn_write_review" type="button">상품후기쓰기</button>
											</li>
											<li class="noReview" style="display:none;">
												<i class="fa fa-comments bg-blue"></i>
												<div class="timeline-item" >
													 <h3 class="timeline-header">
														상품후기가 존재하지 않습니다.<br>
														상품후기를 입력해주세요.</h3>
												</div>
											</li>
											 
										</ul>
										<!-- 상품 후기 리스트 페이지부분 -->  
										<div class='text-center'>
											<ul id="pagination" class="pagination pagination-sm no-margin "></ul>
									 	</div>
									 </div>
									 
									 
									 <%-- Modal : 상품후기 수정/삭제 팝업 --%>
									<div id="modifyModal" class="modal modal-primary fade" role="dialog">
									  <div class="modal-dialog">
									    <!-- Modal content-->
									    <div class="modal-content">
									      <div class="modal-header" >
									        <button type="button" class="close" data-dismiss="modal">&times;</button>
									        <div class="modal-title">
												<p id="star_grade_modal">
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
											        <a href="#">★</a>
												</p>
									        </div>
									      </div>
									      <div class="modal-body" data-rv_num>
									        <p><input type="text" id="replytext" class="form-control"></p>
									      </div>
									      <div class="modal-footer">
									        <button type="button" class="btn btn-info" id="btn_modal_modify">MODIFY</button>
									        <button type="button" class="btn btn-default" data-dismiss="modal">CLOSE</button>
									      </div>
									    </div>
									  </div>
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