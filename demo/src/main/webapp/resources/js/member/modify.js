$(document).ready(function() {
	
	var form = $("#modifyForm");
	// 인증 확인 여부를 위한 변수
	var isCheckEmail = "true";
	
	/* 이메일 변경 시 이메일 인증 활성화 */
	$("#mem_email").on("change", function(){
		$("#btn_sendAuthCode").show();
		isCheckEmail = "false";
	});
	
	/* 이메일 인증 클릭 시 */
	$("#btn_sendAuthCode").on("click", function(){
		var receiveMail = $("#mem_email").val();
		
		if($("#mem_email").val()=="" || $("#mem_email").val()== null){
			$("#authcode_status").html("이메일을 먼저 입력해주세요.");
			return;
		}
		
		$("#authcode_status").css("color", "grey");
		$("#authcode_status").html('인증코드 메일을 전송중입니다.  잠시만 기다려주세요...');
		
		$.ajax({
			url: '/email/send',
			type: 'post',
			dataType: 'text',
			data: {receiveMail : receiveMail},
			success: function(data){
				$("#email_authcode").show();
				$("#authcode_status").css("color", "grey");
				$("#authcode_status").html('메일이 전송되었습니다.  입력하신 이메일 주소에서 인증코드 확인 후 입력해주세요.');
			}
		});
	});
	
	/* 인증코드 입력 후 확인 클릭 시 */
	$("#btn_checkAuthCode").on("click", function(){
		var code = $("#mem_authcode").val();
		
		$.ajax({
			url: '/member/checkAuthcode',
			type: 'post',
			dataType: 'text',
			data: {code : code},
			success: function(data){
				if(data == 'SUCCESS'){
					$("#email_authcode").hide();
					$("#authcode_status").css("color", "blue");
					$("#authcode_status").html('인증 성공');
					$("#mem_email").attr("readonly",true);
					$("#btn_sendAuthCode").attr("disabled", true);
					isCheckEmail = "true";
					return;
					
				} else {
					$("#email_authcode").hide();
					$("#authcode_status").css("color", "red");
					$("#authcode_status").html('인증 실패. 다시 시도해주세요.');
					return;
				}
			}
		});
	});
	
	
	/* 회원수정 버튼 클릭 시 */ 
	$("#btn_submit").on("click", function(){
		
		var mem_id = $("#mem_id");
		var mem_pw = $("#mem_pw");
		var mem_pw_check = $("#mem_pw_check");
		var mem_name = $("#mem_name");
		var mem_nick = $("#mem_nick");
		var mem_email = $("#mem_email");
		var mem_authcode = $("#mem_authcode");
		var mem_phone = $("#mem_phone");
		var mem_zipcode = $("input[name='mem_zipcode']");
		var mem_addr = $("input[name='mem_addr']");
		var mem_addr_d = $("input[name='mem_addr_d']");
		
		/* 유효성 검사 */
		 if(mem_pw.val()==null || mem_pw.val()==""){
			alert("현재 비밀번호를 입력해주세요.");
			mem_pw.focus();
			return;
			
		} else if(mem_name.val()==null || mem_name.val()==""){
			alert("이름을 입력해주세요.");
			mem_name.focus();
			return;
		
		} else if(mem_nick.val()==null || mem_nick.val()==""){
			alert("닉네임을 입력해주세요.");
			mem_nick.focus();
			return;
		
		} else if(mem_email.val()==null || mem_email.val()==""){
			alert("이메일을 입력해주세요.");
			mem_email.focus();
			return;

		} else if(isCheckEmail=="false" && 
					(mem_authcode.val()==null || mem_authcode.val()=="")){
			alert("이메일 인증 확인 후 인증 코드를 입력해주세요.");
			mem_authcode.focus();
			return;

		} else if(isCheckEmail=="false"){
			alert("이메일인증을 해주세요.");
			$("#btn_sendAuthCode").focus();
			return;
		
		} else if(mem_phone.val()==null || mem_phone.val()==""){
			alert("휴대폰 번호를 입력해주세요.");
			mem_phone.focus();
			return;

		} else if(mem_zipcode.val()==null || mem_zipcode.val()==""){
			alert("우편번호를 입력해주세요.");
			$("#btn_postCode").focus();
			return;
			
		} else if(mem_addr.val()==null || mem_addr.val()==""){
			alert("주소를 입력해주세요.");
			$("#btn_postCode").focus();
			return;
			
		} else if(mem_addr_d.val()==null || mem_addr_d.val()==""){
			alert("상세 주소를 입력해주세요.");
			mem_addr_d.focus();
			return;
		} 
		 
		// 현재 비밀번호 확인 검사
		var mem_pw_val = mem_pw.val();
		$.ajax({
			url: "/member/checkPwAjax",
			type: "post",
			datatype: "text",
			data: {mem_pw : mem_pw_val},
			success: function(data){
				if(data=='SUCCESS'){
					form.submit();
				} else{
					alert("비밀번호가 다릅니다.");
					mem_pw.val("");
					mem_pw.focus();
				}
			} 
		});
	});
	
	/* 취소 버튼 클릭 시 */
	$("#btn_cancle").on("click", function(){
		
		var result = confirm("회원 정보 수정을 취소하시겠습니까?");
		if(result){
			location.href="/"; 
		} else{}
	});
	
});

