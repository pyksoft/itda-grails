var ArchiveController = Class.extend({
    init: function(){
    	this.prevSizes = {};
    	this.prevOtherSizes = {};    	
    },
    
    showReview: function(id){
    	$('div#body > table').hide();
    	$('div#body > table#review').show();
    	displayReview(id);
    },

    backToDetails: function (){
    	$('div#body > table').hide();
    	$('div#body > table#search').show();
    }, 
    
    onSelectCheckboxInput: function(e){
    	$('input[name^=other]', e.data.blk).attr('checked', true);
    },
    
    onSelectRadioInput: function(e){
    	var blk = e.data.blk;
    	$('input:radio', blk).attr('checked', false);
    	$('input[value^=OTHER]', blk).attr('checked', true);
    },
    
    clearSearch: function() {
    	$('div#filters input:checkbox').attr('checked', false);	
    	$('div#filters input[value=4C]').attr('checked', true);	
    	$('div#filters input:text').val('');
    	$('div#filters select').find('option:first').attr('selected','selected');
    	var id = $('div#views .view-filter-ui .td-wolsp.itda-on').parent().attr('id');
    	if(id == 'All')
    		doSearch();
    	else
    		$('.itda-archive-icon.file-cabinet-icon').click();
    }    
    
});


var ArchiveUploadController = ArchiveController.extend({
    init: function(){
       this._super();
       this.uploadEntry = new ArchiveUploadEntry();
       this.uploadEntry.pdfFilter = [{title : "PDF Files", extensions : "PDF"}];
       this.uploadEntry.imageFilter = [{title : "Image Files", extensions : "JPEG,JPG,GIF,PNG"}];
       this.uploadEntry.pickFileElementId = 'pickFile';
       this.uploadEntry.progressElementId = 'progressBar';
       this.uploadEntry.maxFileSize = '15mb';
       //TEST ONLY
       //this.uploadEntry.pdfFile = 'test-only';
       //this.uploadEntry.imageFile = 'test-only';
       //this.uploadEntry.adTypeCode = 'DM';
       //this.uploadEntry.adDescription = 'test-only';
    },
    
    showUpload: function() {
    	$('div#body > table').hide();
    	var uEntry = this.uploadEntry;
    	var currStep = uEntry.pdfFile;
    	this.initPdfUploader(uEntry.pickFileElementId, uEntry.pdfFilter, uEntry.progressElementId);
    	if(currStep){
    		$('td.archive-right-col.my-upload > div').css('visibility', 'visible');
    		this.showDoneView('#Step1')
    	}else{
	        this.showNotDoneView('#Step1');
	        $('td.archive-right-col.my-upload > div').css('visibility', 'hidden');
	        $('#line3').hide();
	    }    
	    if(currStep)
	    	this.displayUploadedImage();

    	if(currStep){
    		$('#Step2').show();
	    	if(uEntry.imageFile) {
	    		this.showDoneView('#Step2')
	    	}else
	    		this.showNotDoneView('#Step2')
    	}else
    		$('#Step2').hide();
    	currStep = (currStep && uEntry.imageFile);
    	
    	if( currStep ) {
    		this.showStep3(uEntry, false);
    	}else
    		$('#Step3').hide();
    	currStep = (currStep && uEntry.adTypeCode);
    	
    	if( currStep ){
    		this.showStep4(uEntry, false);
    	}else
    		$('#Step4').hide();
    	currStep = (currStep && uEntry.adDescription);
    	
    	if( currStep ){
    		this.showStep5();
	        $('#line3').show();//upload button
    	}else
    		$('#Step5').hide();
    	
    	$('#myUpload input[type=checkbox]').val(true);
    	$('div#body > table#myUpload').show();
    }, 

    showDoneView: function(step) {
    	$(step + ' > td:first-child').html('<img src="/images/Transparent.gif" class="itda-archive-icon checked-box-icon">');
		$(step + ' .NotDone').hide();
		$(step + ' .Done').show();
		//$(step + ' .unchecked-box-icon').removeClass('unchecked-box-icon').addClass('checked-box-icon');    	
    },
    
    showNotDoneView: function(step) {
		$(step + ' .Done').hide();
		$(step + ' .NotDone').show();
    },
    
    
    editMarketingType: function(){
		this.showStep3(this.uploadEntry, true);
    },
    
    showStep3: function(uEntry, editFlag){
		$('#Step3').show();
    	if(uEntry.adTypeCode && !editFlag){
    		$('#marketingTypeValue').html(getEventType(uEntry.adTypeCode));
    		this.showDoneView('#Step3');
    	}else{
    		this.showNotDoneView('#Step3');
    		if(uEntry.adTypeCode)
    			$('#Step3 img.' + uEntry.adTypeCode).trigger('click');
    	}    	    	
    },
    
    showStep4: function(uEntry, editFlag){
		$('#Step4').show();
    	if(uEntry.adDescription && !editFlag){
    		$('#marketingNameValue').html(uEntry.adDescription);
    		this.showDoneView('#Step4');
    	}else{
    		this.showNotDoneView('#Step4');
    		if(uEntry.adDescription)
    			$('input[name="adDescription"]').val(uEntry.adDescription);
    	}    	    	
    },
    
    showStep5: function() {
    	var ctrl= this;
    	$('#Step5').show();
		var checked, prevSize, label = $('#size-header > a');
		var html = label.html();	
		if(ctrl.uploadEntry.adTypeCode=='NP') {
			label.html('Size');
		}else{ 
			label.html('Type');
		}
		var sizeDivs = $('#Step5 div[class$="-planner-event"]');
		sizeDivs.each(function( index ) {
			var currDiv = this;
			var display = $(currDiv).css('display');
			if(display == 'block'){
				prevSize = $('input:checked[name=size]', currDiv).val();
				ctrl.prevSizes[$(currDiv).attr('class')] = prevSize;
				prevOtherSize =  $.trim($('input:text', currDiv).val());
				ctrl.prevOtherSizes[$(currDiv).attr('class')] = prevOtherSize;
			}
			$('input:checked', currDiv).attr('checked', false);
			$('input:text[name="otherSize"]', currDiv).remove();			  
			$(currDiv).attr('style', 'display:none');
		});

		var cname = getEventClass(ctrl.uploadEntry.adTypeCode);
		var currSizeBlk = $('#Step5 div.'+ cname);
		currSizeBlk.attr('style', 'display:block');
		$('.otherSize', currSizeBlk).html("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' maxlength='30' name='otherSize' onclick='this.focus()'>");

		var size = ctrl.prevSizes[cname];
		$('input[value="'+size+'"]', currSizeBlk).attr('checked', true);
		$('input:text[name="size"]', currSizeBlk).val(ctrl.prevOtherSizes[cname]);
		
		//if((!checked && size)){
			//$('input[name=otherSize]', currSizeBlk).attr('checked', true)
		//}
		//$('input:radio', currSizeBlk)
		//	.unbind('click')
		//	.bind('click', {blk:currSizeBlk}, ctrl.onSelectBlock);
		
		$('input:text', currSizeBlk)
		.unbind('focus')
		.bind('focus', {blk:currSizeBlk}, ctrl.onSelectRadioInput);

		var blk = $('#my-uploads-offers-panel');
		$('input:text', blk)
			.unbind('focus')
			.bind('focus', {blk:blk}, ctrl.onSelectRadioInput);	
		
		var blks = $('#timeofyear-panel, #focus-panel');
		blks.each(function( index ) {
			var blk = this;
			$('input:text', blk)
			.unbind('focus')
			.bind('focus', {blk:blk}, ctrl.onSelectCheckboxInput);	
		});		
	
    },
    
    uploadImage: function() {
    	this.uploader.settings.filters = this.uploadEntry.imageFilter;
    	$('#'+this.uploadEntry.pickFileElementId).trigger('click');
    	// TODO clean up any interrupted upload
    },
    
    uploadPdf: function() {
    	this.uploader.settings.filters = this.uploadEntry.pdfFilter;
    	$('#'+this.uploadEntry.pickFileElementId).trigger('click');
    	//TODO clean up any interrupted upload
    },
    
    selectMarketingType: function(type, domEle) {
    	this.uploadEntry.adTypeCode = type;
    	$(domEle).parent().siblings(".bottom").children('img').addClass('itda-off');
    	$(domEle).removeClass('itda-off');
		if(this.uploadEntry.adDescription)
			this.showStep5();
    },
    
    saveMarketingType: function() {
 		$('#marketingTypeLabel').removeClass('red error');
    	if(!this.uploadEntry.adTypeCode) {
    		$('#marketingTypeLabel').addClass('red error');
    		return;
    	}
    	this.showUpload();
    },
    
    saveMarketingDesc: function() {
		$('#marketingNameLabel').removeClass('red error');
		var val = $('input[name="adDescription"]').val();
    	if($.trim(val) == '') {
    		$('#marketingNameLabel').addClass('red error');
    		return;
    	}else{
    		this.uploadEntry.adDescription =val;
    	}
    	this.showUpload();
    },    
    
    displayUploadedImage: function(){
    	$( "#" + this.uploader.settings.progress_bar ).progressbar('destroy');
    	$('#filelist').html('');
	    if(this.uploadEntry.imageFile){
	    	$('#adImage').html("<img src='archive/getUploadedAdImage/"+  this.uploader.id + "?file=" +escape(this.uploadEntry.imageFile)+"'/>");
    		$('#adImage img').attr('style', 'margin-top:15px;display: block;margin-left: auto;margin-right: auto; max-width:420px; max-height:480px');    	
    	} else {
	    	$('#adImage').html('<img class="itda-archive-icon pdf-icon" src="/images/Transparent.gif"/><br/>');
    		$('#adImage img').attr('style', 'margin-top:160px;display: block;margin-left: auto;margin-right: auto; max-width:420px; max-height:480px');    	
	    	$('#adImage').append(this.uploadEntry.pdfFile +'<br/>'+ this.uploadEntry.pdfSize);
	    }
    },
    
    upload2Archive: function(){
    	$('#errorMsg').html('');
    	$('input[name="pdfFile"]').val(this.uploadEntry.pdfFile);
    	$('input[name="imageFile"]').val(this.uploadEntry.imageFile);
    	$('input[name="uuid"]').val(this.uploader.id);
    	$('input[name="adTypeCode"]').val(this.uploadEntry.adTypeCode);
    	var data = itdaPostJson("/archive/upload2Archive", $("#uploadForm").serialize());
    	if(data.respText != 'Save completed')
    		$('#errorMsg').html('Error: ' + data.errors[0]).addClass('red error');
    	else{
    		this.resetUploadPanel();
    		this.backToDetails();
    		this.uploadCompleted();
    		$.jGrowl('Your PDF has been uploaded.'); 
    	}
    },
    
    resetUploadPanel: function(){
    	var ue = this.uploadEntry;
		$('#myUpload input:text').val('');
		$('#myUpload input:checkbox, #myUpload input:radio').removeAttr('checked');
    	$('#myUpload input[value=4C]').attr('checked', true);	
		this.uploader.destroy();
		this.uploader = null;
		ue.pdfFile = null;
		ue.imageFile = null;
		ue.adTypeCode = null;
		ue.adDescription = null;
		this.prevSizes = {};
		this.showNotDoneView("#myUpload");
		$('#myUpload .checked-box-icon').removeClass('checked-box-icon').addClass('unchecked-box-icon');    	
		$('#myUpload .red.error').removeClass('red error');
		$('#adImage, #errorMsg, #filelist').html('');
		$('td.bottom > img').addClass('itda-off'); 
    	//TODO clean up unneeded upload files
    },
    
    cancelUpload: function(){
    	var data = itdaPostJson("/archive/cancelUpload", {'id':escape(this.uploader.id)});
    	this.resetUploadPanel();
    	this.backToDetails();
    },    
    
    removeUploadedHdFile: function(e,id, clickedElem) {
    	e.stopPropagation();
    	clickedElem.blur();
    	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closeDialog(\'dialogBigger\');"></span><br/>';
    	html +=  "<h3>Are you sure you want to<br/>delete this file?</h3>";
    	html += "By clicking DELETE, you will permanently<br/>remove the high resolution PDF from your<br/>Archive. The JPG of this marketing will<br/>";
    	html += "remain in your Planner and Tracker for<br/>viewing purposes.<br/></br>";
    	html+= "<div>"
		html +=  '<div style="float:right;margin-right:10px"><input type="submit" onclick="archCtrl.confirmRmUploadedHDFile('+id+');this.blur();return false" value="" class="itda-archive-icon delete-red-btn"></div>';
		html +=  '<div style="float:right;margin-right:10px"><input type="submit" onclick="closeDialog(\'dialogBigger\');this.blur();return false;" value="" class="itda-archive-icon cancel-gray-btn"></div>';
		html +=	'</div>';
    	showItdaConfirmDialog(html , gdiaglogBigger , '400px', '200px');
    	$('input', gdiaglogBigger).blur();
    	return false;
    },
    
    confirmRmUploadedHDFile: function(id){
    	var data = itdaPostJson("/archive/removeUploadedHdFile", {'id':id});
    	if(data.respText == 'Save completed') {
    		closeDialog('dialogBigger');
    		$("#banner-text" + id).hide();
    	}
    },
    
    uploadCompleted: function() {
    	$('div#filters input:checkbox').attr('checked', false);	
    	$('div#filters input:text').val('');
    	$('div#filters select').find('option:first').attr('selected','selected');
    	var id = $('div#views .view-filter-ui .td-wolsp.itda-on').parent().attr('id');
    	if(id == 'myUploads')
    		doSearch();
    	else
    		$('.itda-archive-icon.my-uploads-icon').click();
    },
    
    initPdfUploader: function( browseBtnId, fileFilters, progressBarId ) {
    	if (this.uploader)
    		return;
    	this.uploader = new plupload.Uploader({
	    	runtimes : 'html5,flash,silverlight',
	    	max_file_size : this.uploadEntry.maxFileSize,
	    	url : "/archive/uploadAdFile",
	    	flash_swf_url : '/plupload156/js/plupload.flash.swf',
	    	silverlight_xap_url : '/plupload156/js/plupload.silverlight.xap',
	    	browse_button : browseBtnId,
	    	filters : fileFilters,
	    	progress_bar: progressBarId
    	});
    	
    	this.uploader.ctrl = this;
    	this.uploader.init();
    	this.uploader.settings.multipart_params = {uuid: this.uploader.id};
    	this.uploader.bind('FilesAdded', function(up, files) {
    		$('td.archive-right-col.my-upload > div').css('visibility', 'visible');
    		if(files.length > 1)
    			up.splice(0, files.length-1);
    		$.each(files, function(i, file) {
    			$('#filelist').html(
    				'<div id="' + file.id + '">' +
    				'Uploading ' + file.name + ', '+ plupload.formatSize(file.size) + 
    			'</div>');
    		});

    		up.refresh(); // Reposition Flash/Silverlight
    		$('#adImage').html('');
    		$( "#" + up.settings.progress_bar ).progressbar({value: false});    		
    		up.start();
    	});

    	this.uploader.bind('UploadProgress', function(up, file) {
    		$( "#" + up.settings.progress_bar ).progressbar( "option", {
    	          value: file.percent
    	        });
    	});

    	this.uploader.bind('UploadComplete', function(up, file) {
    		
    	});
    	
    	this.uploader.bind('Error', function(up, err) {
    		$('td.archive-right-col.my-upload > div').css('visibility', 'visible');
    		var msg; 
    		if(err.code == plupload.FILE_EXTENSION_ERROR) {
    			msg = "<div class='red error'>Error: Please select a file of the following type(s): " + up.settings.filters[0].extensions.replace(/,/g,", ") +"</div>";
    		} else if(err.code == plupload.FILE_SIZE_ERROR) {
    			msg = "<div class='red error'>Error: Please select a file smaller than " + up.ctrl.uploadEntry.maxFileSize.toUpperCase() +".</div>";
    		}else{
    			msg = "<div class='red error'>Error: " + err.message +"</div>";  
    		}
    		$('#adImage').html('');
    		$('#filelist').html(msg);  
			up.refresh(); // Reposition Flash/Silverlight
			up.removeFile(err.file);
    	});

    	this.uploader.bind('FileUploaded', function(up, file) {
    		var name = file.name.toUpperCase();
    		var archCtrl = up.ctrl;
    		if(file.status == plupload.DONE) {
	    		if(name.lastIndexOf('PDF') == (name.length-3)) {
	    			archCtrl.uploadEntry.pdfFile = file.name;
	    			archCtrl.uploadEntry.pdfSize = plupload.formatSize(file.size);
	    		}else
	    			archCtrl.uploadEntry.imageFile = file.name;
	    		$('#' + file.id ).append(", 100%");
	    		archCtrl.showUpload();
    		}else{
    			$('#' + file.id ).append(" -- Error:" + file.status);
    		}
    	});	
    }
});


var ArchiveUploadEntry = Class.extend({
    init: function(){
    }
});