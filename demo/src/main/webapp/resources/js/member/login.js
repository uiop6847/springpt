$(document).ready(function() {
	
	var form = $("#loginForm");
	
	// 로그인 버튼 클릭 시 
	$("#btn_login").on("click", function(){
		
		var mem_id = $("#mem_id");
		var mem_pw = $("#mem_pw");

		if(mem_id.val()==null || mem_id.val()==""){
			alert("Please enter your ID.");
			mem_id.focus();
			
		} else if(mem_pw.val()==null || mem_pw.val()==""){
			alert("Please enter your Password.");
			mem_pw.focus();

		} else {
			form.submit();
		}
	});
	
});

