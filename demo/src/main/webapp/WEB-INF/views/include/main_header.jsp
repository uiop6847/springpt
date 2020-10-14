<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<style>
.bgGradient{
	background: linear-gradient(90deg, #2BC0E4,  #EAECC6) fixed;
}
#modify_dropdown {  
	display:none; /* 평상시에는 서브메뉴가 안보이게 하기 */ 
	height:auto; 
	padding:10px 0px; 
	margin:0px; 
	border:0px; 
	position:absolute; 
	width:130px; 
	z-index:200; 
}

#modify:hover #modify_dropdown{
	display:block;   /* 마우스 커서 올리면 서브메뉴 보이게 하기 */
}

</style>


<header class="main-header">
	<!-- Logo -->
	<a href="/" class="logo" style="background-color: #2BC0E4" >
			<span class="logo-mini"></span> <!-- logo for regular state and mobile devices --> 
		<span class="logo-lg">
			<b>SSO</b>MALL
		</span>
	</a>

	<!-- Header Navbar -->
	<nav class="navbar navbar-static-top bgGradient" role="navigation"  >
		<!-- Sidebar toggle button-->
		<a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button"> <span class="sr-only">Toggle navigation</span>
		</a>
		<!-- Navbar Right Menu -->
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<!-- Messages: style can be found in dropdown.less-->
				<!-- <li class="dropdown messages-menu">
					Menu toggle button
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-envelope-o"></i> <span class="label label-success">4</span>
					</a>
					<ul class="dropdown-menu">
						<li class="header">You have 4 messages</li>
						<li>
							inner menu: contains the messages
							<ul class="menu">
								<li>
									start message
									<a href="#">
										<div class="pull-left">
											User Image
											<img src="/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
										</div> Message title and timestamp
										<h4>
											Support Team <small><i class="fa fa-clock-o"></i> 5 mins</small>
										</h4> The message
										<p>Why not buy a new awesome theme?</p>
									</a>
								</li>
								end message
							</ul>
							/.menu
						</li>
						<li class="footer">
							<a href="#">See All Messages</a>
						</li>
					</ul>
				</li>
				/.messages-menu

				Notifications Menu
				<li class="dropdown notifications-menu">
					Menu toggle button
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-bell-o"></i> <span class="label label-warning">10</span>
					</a>
					<ul class="dropdown-menu">
						<li class="header">You have 10 notifications</li>
						<li>
							Inner Menu: contains the notifications
							<ul class="menu">
								<li>
									start notification
									<a href="#"> <i class="fa fa-users text-aqua"></i> 5 new members joined today
									</a>
								</li>
								end notification
							</ul>
						</li>
						<li class="footer">
							<a href="#">View all</a>
						</li>
					</ul>
				</li>
				Tasks Menu
				<li class="dropdown tasks-menu">
					Menu Toggle Button
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-flag-o"></i> <span class="label label-danger">9</span>
					</a>
					<ul class="dropdown-menu">
						<li class="header">You have 9 tasks</li>
						<li>
							Inner menu: contains the tasks
							<ul class="menu">
								<li>
									Task item
									<a href="#"> Task title and progress text
										<h3>
											Design some buttons <small class="pull-right">20%</small>
										</h3> The progress bar
										<div class="progress xs">
											Change the css width attribute to simulate progress
											<div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
												<span class="sr-only">20% Complete</span>
											</div>
										</div>
									</a>
								</li>
								end task item
							</ul>
						</li>
						<li class="footer">
							<a href="#">View all tasks</a>
						</li>
					</ul>
				</li> -->
				<!-- User Account Menu -->
				<%-- 로그인 안 한 상태 --%>
				<c:if test="${sessionScope.user == null}">
					<li class="dropdown user user-menu">
						<!-- Menu Toggle Button -->
						<a href="/member/join"> <!-- class="dropdown-toggle" data-toggle="dropdown" --> 
							<span class="hidden-xs">회원가입</span>
						</a>
					</li>
					<li class="dropdown user user-menu">
						<a href="/member/login"> 
							<span class="hidden-xs">로그인</span>
						</a>
					</li>
				</c:if>
				
				<%-- 로그인 한 상태 --%>
				<c:if test="${sessionScope.user != null}"> 
					<li class="dropdown user user-menu"> 
						<p class="hidden-xs" style="color:white; margin-top:14px;">
							최근 접속 시간: 
							<fmt:formatDate value="${sessionScope.user.mem_date_last}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</p>
					</li>
					<li class="dropdown user user-menu"> 
						<p class="hidden-xs" style="color:white; margin-top:14px; margin-left:15px; margin-right:15px;">
							${sessionScope.user.mem_name}님
						</p>
					</li>
					<li class="dropdown user user-menu">
						<a href="/member/logout"> 
							<span class="hidden-xs">로그아웃</span>
						</a>
					</li>
					<li class="dropdown user user-menu" id="modify">
						<a href="#">
							<span>회원정보 관리</span>
						</a>
						<ul class="dropdown-menu" id= "modify_dropdown">
							<li><a href="/member/checkPw?url=modify">회원정보 수정</a></li>
							<li><a href="/member/checkPw?url=changePw">비밀번호 변경</a></li>
							<li><a href="/member/checkPw?url=delete">회원 탈퇴</a></li>
						</ul>
					</li>	
					<li class="dropdown user user-menu">
						<a href="/cart/list"> 
							<span class="hidden-xs">장바구니</span>
						</a>
					</li>		
					<li class="dropdown user user-menu">
						<a href="/order/list">
							<span class="hidden-xs">주문조회</span>
						</a>
					</li>		
				</c:if>
					
				
					<!-- <ul class="dropdown-menu">
						The user image in the menu
						<li class="user-header">
							<p>
								Alexander Pierce - Web Developer <small>Member since Nov. 2012</small>
							</p>
						</li>
						<li class="user-header">
							<p>
								Alexander Pierce - Web Developer <small>Member since Nov. 2012</small>
							</p>
						</li>
						
						Menu Body
						<li class="user-body">
							<div class="row">
								<div class="col-xs-4 text-center">
									<a href="#">Followers</a>
								</div>
								<div class="col-xs-4 text-center">
									<a href="#">Sales</a>
								</div>
								<div class="col-xs-4 text-center">
									<a href="#">Friends</a>
								</div>
							</div>
							/.row
						</li>
						Menu Footer
						<li class="user-footer">
							<div class="pull-left">
								<a href="#" class="btn btn-default btn-flat">Profile</a>
							</div>
							<div class="pull-right">
								<a href="#" class="btn btn-default btn-flat">Sign out</a>
							</div>
						</li>
					</ul> -->
				
				<!-- Control Sidebar Toggle Button -->
				<li>
					<a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
				</li>
			</ul>
		</div>
	</nav>
</header>