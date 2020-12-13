
function necessary(){
	var need = true; 
	$('.need').each(function(){
		if($(this).val()==''){			
			alert($(this).attr('title')+' 입력하세요!');
			$(this).focus();
			need = false; 
			return need;
		}
	});
	return need;
}