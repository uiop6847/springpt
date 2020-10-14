$(document).ready(function() {

	/* 주문 내역 확인 클릭 시  */
	$("#btn_orderList").on("click", function() {
		location.href="/order/list";
	});
	
	/* 쇼핑계속하기 클릭 시 */
	$("#btn_main").on("click", function() {
		location.href="/";
	});

});

