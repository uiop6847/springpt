<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">

		<!-- Sidebar user panel (optional) -->
		<c:if test="${sessionScope.admin != null}">
		<div class="user-panel">
			<div class="pull-left image">
				<img src="/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
			</div>
			<div class="pull-left info">
				<p>${sessionScope.admin.admin_id}</p>
				<!-- Status -->
				<a href="#">
					<i class="fa fa-circle text-success"></i>
					Online
				</a>
			</div>
		</div>
		</c:if>
		
		<c:if test="${sessionScope.admin == null}">
		<div class="user-panel">
			
			<p style="color:#b8c7ce; margin-top:10px; padding-left:5px;">로그인해주세요.</p>
		</div>
		</c:if>
		

		<!-- search form (Optional) -->
		<form action="#" method="get" class="sidebar-form">
			<div class="input-group">
				<input type="text" name="q" class="form-control" placeholder="Search...">
				<span class="input-group-btn">
					<button type="submit" name="search" id="search-btn" class="btn btn-flat">
						<i class="fa fa-search"></i>
					</button>
				</span>
			</div>
		</form>
		<!-- /.search form -->

		<!-- Sidebar Menu -->
		<ul class="sidebar-menu" data-widget="tree">
			<li class="header">ADMIN MENU</li>
			<!-- <li class="active">
				<a href="#">
					<i class="fa fa-link"></i>
					<span>Link</span>
				</a>
			</li>
			<li>
				<a href="#">
					<i class="fa fa-link"></i>
					<span>Another Link</span>
				</a>
			</li> -->
			<!-- 카테고리 작업은 DB에서 수동으로 데이터를 입력한다. -->
			<c:choose>
				<c:when test="${sessionScope.admin != null}"> <!-- 로그인 O -->
					<li class="treeview">
						<a href="#">
							<i class="fa fa-link"></i>
							<span>상품 관리</span>
							<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="/admin/product/insert">상품 등록</a>
							</li>
							<li>
								<a href="/admin/product/list">상품 목록</a>
							</li>
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="fa fa-link"></i>
							<span>주문 관리</span>
							<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="#">주문 목록</a>
							</li>
						</ul>
					</li>
					<li class="treeview">
						<a href="#">
							<i class="fa fa-link"></i>
							<span>회원 관리</span>
							<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li>
								<a href="/admin/logout">로그아웃</a>
							</li>
							<li>
								<a href="#">회원 목록</a>
							</li>
						</ul>
					</li>
				</c:when>
			</c:choose>
		</ul>
		<!-- /.sidebar-menu -->
	</section>
	<!-- /.sidebar -->
</aside>