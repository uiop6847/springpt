$(document).ready(function() {
	
	var form = $("#registerForm");
	
	/* 상품 등록 버튼 클릭 시 */
	$("#btn_submit").on("click", function(){
		var result = confirm("상품을 등록하시겠습니까?");
		
		if(result){
			// 유효성 검사
			var mainCategory = $("#mainCategory option:selected");
			var subCategory = $("#subCategory option:selected");
			var pdt_name = $("#pdt_name");
			var pdt_company = $("#pdt_company");
			var pdt_price = $("#pdt_price");
			var pdt_discount = $("#pdt_discount");
			var ckeditor = CKEDITOR.instances['pdt_detail'];
			var file1 = $("#file1");
			var pdt_amount = $("#pdt_amount");
			var pdt_buy = $("#pdt_buy");
			var fileSize = file1.size;
			var fileFormat  = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/;
			var maxSize = 5 * 1024 * 1024; // 5MB
			
			if(mainCategory.val()==null || mainCategory.val()=="default"){
				alert("1차 카테고리를 선택해주세요.");
				mainCategory.focus();
				return;
				
			} else if(subCategory.val()==null || subCategory.val()=="default"){
				alert("2차 카테고리를 선택해주세요.");
				subCategory.focus();
				return;
				
			} else if(pdt_name.val()==null || pdt_name.val()==""){
				alert("상품명을 입력해주세요.");
				pdt_name.focus();
				return;
				
			} else if(pdt_company.val()==null || pdt_company.val()==""){
				alert("제조사를 입력해주세요.");
				pdt_company.focus();
				return;
				
			}else if(pdt_price.val()==null || pdt_price.val()==""){
				alert("상품 가격을 입력해주세요.");
				pdt_price.focus();
				return;
				
			}else if(pdt_discount.val()==null || pdt_discount.val()==""){
				alert("할인 가격을 입력해주세요.");
				pdt_discount.focus();
				return;
				
			}else if(ckeditor.getData()==null || ckeditor.getData()==""){
				alert("상품 상세 내용을 입력해주세요.");
				ckeditor.focus();	
				return;
				
			}else if(file1.val()==null || file1.val()==""){
				alert("이미지 파일을 추가해주세요.");
				file1.focus();
				return;
				
			}else if(!file1.val().match(fileFormat)){
				alert("이미지 파일만 업로드 가능합니다.");
				file1.focus();
				return;
				
			}else if(fileSize > maxSize){
				alert("파일 사이즈는 5MB까지만 가능합니다.");
				file1.focus();
				return;
				
			}else if(pdt_amount.val()==null || pdt_amount.val()==""){
				alert("상품 수량을 입력해주세요.");
				pdt_amount.focus();
				return;
				
			}else {
				form.submit();
			}
		} else {}
		
	});
	
});

