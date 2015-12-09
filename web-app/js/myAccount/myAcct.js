(function ($) {
    $.fn.forceZipCode = function () {
        return this.each(function () {

            $(this).keyup(function() {
            	var val = $(this).val();
            	if (!/^[0-9]+$/.test(val)) {
                    $(this).val(val.replace(/[^0-9]/g, ''));
                }
            });

        });
    };
})(jQuery);

var gMyAcctDiag; 
function myAcctDiagInit(){
	if(!gMyAcctDiag) {
		gMyAcctDiag = $('#dialog-my-acct');
		var width = $('#dialog-my-acct').css('width');
		var height = $('#dialog-my-acct').css('height');
		gMyAcctDiag = $('#dialog-my-acct').dialog({  width:width, resizable: false , autoOpen : false, modal: true});
		gMyAcctDiag.prev().remove();
		gMyAcctDiag.css('height', height);
		gMyAcctDiag.parent().css('background-color', 'white')
		 .css('border-color', '#B69A2F')
		 .removeClass('ui-corner-all');
		$('td', gMyAcctDiag).css('font-weight', 'bold');
	}
	$("#errorList").hide();
	$("div.message").hide();
	return gMyAcctDiag;
}
function myZipCodesDialog(id, offNum, action){
	var diag = myAcctDiagInit();
	if(action == 'add')
		$(diag).html($('#addZipCodesContent').html());
	else{
		$(diag).html($('#delZipCodesContent').html());
		var zipcodes = $.trim($('#' + id).html());
		zipcodes = zipcodes.split(',');
		for(var i=0; i<zipcodes.length; i++)
			$('select[name=zipCodes]', diag).append('<option value="'+$.trim(zipcodes[i])+'"\>'+$.trim(zipcodes[i]));
	}
	$('.officeNum').html(offNum);
	$('input[type=hidden]', diag).val(id);
	$('input:text', diag).forceZipCode();
	diag.dialog('open');
}
function saveDeleteZipCodes(){
	var data='', id = $('input[type=hidden]', gMyAcctDiag).val();
	$('select[name=deleteZipCodes] option', gMyAcctDiag).each(
			function(i, option){
					data += '&deleteZipcodes=' + $(option).val();
			}
		);
	if(data !== ''){
		data ='id=' + id + data;
		var xhr = itdaPost("/myAccount/saveDeleteZipCodes", data, undefined, errorHandler, 'json');
		var data = toJson(xhr);
		if(data.respText == 'Save completed.') {
			var zipHtml = $.trim($('#'+id).html()); 
			$('select[name=deleteZipCodes] option', gMyAcctDiag).each(
					function(i, option){
						var  val = $(option).val();
						var ind = zipHtml.indexOf(val);
						if(ind >0)
							zipHtml = zipHtml.replace(', ' + val, '');
						else if(ind == 0)
							zipHtml = zipHtml.replace(val +',', '');
					}
				);
			$('#'+id).html(zipHtml);
			gMyAcctDiag.dialog('close');
		}else
			showErrors("#errorList", data.errors);
	}
	
}
function addZipCodes(){
	$('input:text', gMyAcctDiag).each(
			function(i, input){
				var val = $(input).val();
				if(5 == val.length){
					$(input).val('');
					if($('option[value='+val+']', gMyAcctDiag).size() == 0)
						$('select', gMyAcctDiag).append('<option value="'+val+'"\>'+val);
				}
			}	
		);
}
function selectZipCodes4Del(){
	$('select[name=zipCodes] option:selected', gMyAcctDiag).each(
			function(i, option){
				$('select[name=deleteZipCodes]', gMyAcctDiag).append('<option value="'+$(option).val()+'"\>'+$(option).val());
				$(option).remove();
			}
		);
}

function saveNewZipCodes(){
	var data='', id = $('input[type=hidden]', gMyAcctDiag).val();
	$('option', gMyAcctDiag).each(
			function(i, option){
				var  val = $(option).val();
				if($('#' + id).html().indexOf(val) < 0)
					data += '&newZipcodes=' + val;
			});
	if(data !== ''){
		data ='id=' + id + data;
		var xhr = itdaPost("/myAccount/saveNewZipCodes", data, undefined, errorHandler, 'json');
		var data = toJson(xhr);
		if(data.respText == 'Save completed.') {
			var zipList = $('#'+id);
			$('option', gMyAcctDiag).each(
					function(i, option){
						zipList.append(', ' + $(option).val());
					});
			gMyAcctDiag.dialog('close');
		}else
			showErrors("#errorList", data.errors);
	}
}
function myAcctDialog(id, action) {
	myAcctDiagInit();
	$('#dialog-my-acct h1 span').hide();
	if($('#dialog-my-acct h1 span#' +action).size() > 0)
		$('#dialog-my-acct h1 span#' +action).show();
	else
		$('#dialog-my-acct h1 span#action').show();
	 if( id === undefined ) {//new
		updateForm(undefined, gMyAcctDiag);
		$('input[name=update-btn]',gMyAcctDiag).hide();
		$('input[name=add-btn]',gMyAcctDiag).show();
	} else if( id != null ) {//edit
		var xhr = itdaPost("/accountSetup/" + action, {id: id}, undefined, errorHandler, 'json');		
		var jsonObj = toJson(xhr);
		updateForm(jsonObj, gMyAcctDiag);
		$('input[name=update-btn]',gMyAcctDiag).show();
		$('input[name=add-btn]',gMyAcctDiag).hide();
	}
	gMyAcctDiag.dialog('open');
}
function updateForm(jsonObj, startEle) {
	if(jsonObj)
		for(var key in jsonObj) {
			var input = $('input[name='+ key +']', startEle);
			var select = $('select[name='+ key +']', startEle);
			var textarea = $('textarea[name='+ key +']', startEle);
			if(input.length > 0)
				input.val(jsonObj[key]);
			else if(select.length > 0)
				select.val([jsonObj[key]]);
			else if(textarea.length > 0)
				textarea.val(jsonObj[key]);
		}
	else {
		$('textarea',gMyAcctDiag).val('');
		$('input',gMyAcctDiag).val('');
		$('select',gMyAcctDiag).val(['']);
	}		
}
