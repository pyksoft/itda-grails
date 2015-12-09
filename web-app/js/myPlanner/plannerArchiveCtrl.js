var PlannerArchiveController = ArchiveController.extend( {
		
		init : function(name) {
	        this.ctrlName = name;
	        this.uploader = null;
		},
		
		fromArchive: function(view) {
			if($("#gPlannerDiag").children().size() == 0) {
				$.ajaxSetup( { "async": false } ); 		
				$.post('/archive/selectFile', {},  
		    		function (data, respText) {	
						$("#gPlannerDiag").html(data + "<div style='clear: both; height:10px'/>");
						$('#gPlannerDiag table#search tbody tr td.archive-left-col div#filters div#top.filter-element a#tips').hide();
					},
		    		'html');
				$.ajaxSetup( { "async": true } ); 		
			}
			$('.plannerContent, #planner-reports, #tipsplanner').hide();
			$("#gPlannerDiag").show();
			this.clearSearch();
			this.setupSearch(view);

			$('tr.view-filter-ui td').removeClass('itda-on').addClass('itda-off');
			$('#' + view.replace(' ', '')).children().toggleClass('itda-off itda-on');
			
			 $('form input[type="checkbox"').css('border-width', "0");//ie issue
		},
		
		setupSearch: function (view){
			document.forms['filter-form'].viewFilter.value = view;
			$('img.upload-pdf-btn').css('visibility', 'hidden');
			$('#gPlannerDiag span.ad-all').hide();
			var entry = gPlannerDetailEntries['id=' + $("#currentWorkingDayEvents").val()];
			$('#gPlannerDiag input[name="color"]').val([entry.color]);
			$('#gPlannerDiag input[name="size"]').val([entry.size]);
			initArchive(true, this);
			var adType = $('#gPlannerDiag span.ad-' + entry.className);
			adType.siblings('span').hide();
			adType.show().children('input').attr('checked', 'checked').click();
			$('#results-top img').hide();
			$('#back-2-planner').show();
			$('#gPlannerDiag .resultTitle').html('Select <b>' +getEventType(entry.className)+'</b> for <span style="text-transform:capitalize">' + $.fullCalendar.formatDate(entry.start,'dddd, MMMM dd, yyyy').toLowerCase()  + '</span>.'); 
		},
		
		uploadHdPdfDiag: function() {
			var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="'+this.ctrlName+'.noThanks();"></span><br/>';
			html +=  "<span class='h4'>You have just uploaded a low resolution file for viewing and tracking. </span>";
			html += "Would you like to upload a high resolution file for printing and modification?<br/><br/>";
			html+= "<div>"
			html +=  '<div style="float:right;margin-right:10px"><input type="submit" onclick="'+this.ctrlName+'.uploadAnother();return false;" value="" class="planner-icon btn-upload-pdf"></div>';
			html +=  '<div style="float:right;margin-right:10px"><input type="submit" onclick="'+this.ctrlName+'.noThanks();" value="" class="planner-icon no-thanks-btn"></div>';
			html +=	'</div>';
			showItdaConfirmDialog(html , gdiaglogSmall , '370px', '120px');
			$('input', gdiaglogSmall).blur();
		},
		
		uploadJpgDiag: function() {
			var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="'+this.ctrlName+'.noThanks();"></span><br/>';
			html +=  "<span class='h4'>You have just uploaded a PDF file<br>for printing. </span>";
			html += "<span>Would you like to select a<br/>JPG for viewing and tracking</span>?<br/><br/>";
			html+= "<div>"
			html +=  '<div style="float:right;margin-right:10px"><input type="submit" onclick="'+this.ctrlName+'.uploadAnother();return false;" value="" class="planner-icon btn-select-jpg"></div>';
			html +=  '<div style="float:right;margin-right:10px"><input type="submit" onclick="'+this.ctrlName+'.noThanks();" value="" class="planner-icon no-thanks-btn"></div>';
			html +=	'</div>';
			showItdaConfirmDialog(html , gdiaglogSmall , '350px', '120px');
			$('input', gdiaglogSmall).blur();
		},
		
		uploadAnother: function() {
			closeDialog('dialog-small');
			$('#pickfiles').click();
		},
		
		noThanks: function() {
			closeDialog('dialog-small');
			this.destroySelectAdUploader();
			$('#accordion').accordion('activate', -1);
		},
		
		initAdSelector :function (event) {
			 uploader = new plupload.Uploader({
				runtimes : 'html5,flash,silverlight',
				browse_button : 'pickfiles',
				container : 'container',
				max_file_size : '15mb',
				url : ctrl + '/uploadAdImage/' + event.id,
				flash_swf_url : '/plupload156/js/plupload.flash.swf',
				silverlight_xap_url : '/plupload156/js/plupload.silverlight.xap',
				filters : [
					{title : "Image file", extensions : "jpeg,jpg,gif,png"},
					{title : "PDF file", extensions : "pdf"}
				],
				jpgresize: false,
				pngresize: false
			});
			 
			uploader.ctrl = this; 

			uploader.bind('Init', function(up, params) {
			});

			uploader.init();

			uploader.bind('FilesAdded', function(up, files) {
				$.each(files, function(i, file) {
					$('#filelist').html(
						'<div id="' + file.id + '">' +
						file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
					'</div>');
				});

				up.refresh(); // Reposition Flash/Silverlight
				up.start();
			});

			uploader.bind('UploadProgress', function(up, file) {
				$('#' + file.id + " b").html(file.percent + "%");
			});

			uploader.bind('Error', function(up, err) {
				$('#filelist').append("<div>Error: " + err.message +
					"</div>"
				);

				up.refresh(); // Reposition Flash/Silverlight
			});

			uploader.bind('FileUploaded', function(up, file) {
				$('#' + file.id + " b").html("100%");
				var time = (new Date()).getTime();
				var entryContainer = gPlannerDetailEntries;

				entryContainer['id='+selectedPlannerEntry.id].portfolioEntry = null; //detail only
				var ext = file.name.split(".");
				ext = ext[ext.length-1].toLowerCase();
				if(ext == "jpg" || ext=="jpeg" || ext=="gif" || ext=="png") {
					entryContainer['id='+selectedPlannerEntry.id].imageFile = time;
					if(! entryContainer['id='+selectedPlannerEntry.id].pdfFile) {
						up.ctrl.uploadHdPdfDiag();
					}	else {
						up.ctrl.destroySelectAdUploader();
						$('#accordion').accordion('activate', -1);
					}
				}else{
					entryContainer['id='+selectedPlannerEntry.id].pdfFile = time;
					updateSummary(selectedPlannerEntry);
					if(! entryContainer['id='+selectedPlannerEntry.id].imageFile){
						up.ctrl.uploadJpgDiag();
					} else {
						up.ctrl.destroySelectAdUploader();
						$('#accordion').accordion('activate', -1);
					}
				}
				updateSummary(selectedPlannerEntry);
			});	
			
			this.uploader = uploader;
		}, 
		
		destroySelectAdUploader: function () {
			if(this.uploader == undefined)
				return;
			this.uploader.destroy();
			this.uploader = undefined;
			$('#container div.plupload').remove();
			$('#filelist').html('');
		}		
		
		
});

var TrackerController = PlannerArchiveController.extend( {

	init : function(name) {
        this.ctrlName = name;
	},
	
	initAdSelector :function (event) {
		 uploader = new plupload.Uploader({
			runtimes : 'html5,flash,silverlight',
			browse_button : 'pickfiles',
			container : 'container',
			max_file_size : '15mb',
			url : ctrl + '/uploadAdImage/' + event.id,
			flash_swf_url : '/plupload156/js/plupload.flash.swf',
			silverlight_xap_url : '/plupload156/js/plupload.silverlight.xap',
			filters : [
				{title : "Image file", extensions : "jpeg,jpg,gif,png"},
			],
			jpgresize: false,
			pngresize: false
		});

		uploader.ctrl = this; 
		
		uploader.bind('Init', function(up, params) {
		});

		uploader.init();

		uploader.bind('FilesAdded', function(up, files) {
			$.each(files, function(i, file) {
				$('#filelist').html(
					'<div id="' + file.id + '">' +
					file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
				'</div>');
			});

			up.refresh(); // Reposition Flash/Silverlight
			up.start();
		});

		uploader.bind('UploadProgress', function(up, file) {
			$('#' + file.id + " b").html(file.percent + "%");
		});

		uploader.bind('Error', function(up, err) {
			$('#filelist').append("<div>Error: " + err.message +
				"</div>"
			);

			up.refresh(); // Reposition Flash/Silverlight
		});

		uploader.bind('FileUploaded', function(up, file) {
			$('#' + file.id + " b").html("100%");
			var time = (new Date()).getTime();
			var entryContainer = gCompetitorAdDetailEntries;
			entryContainer['id='+selectedPlannerEntry.id].portfolioEntry = null; //detail only
			var ext = file.name.split(".");
			ext = ext[ext.length-1].toLowerCase();
			if(ext == "jpg" || ext=="jpeg" || ext=="gif" || ext=="png") 
				entryContainer['id='+selectedPlannerEntry.id].imageFile = time;
									
			$('#adImage').html("");
			updateSummary(selectedPlannerEntry);
			up.ctrl.destroySelectAdUploader();
			$('#accordion').accordion('activate', -1);
			
			
	    });	 
		
		this.uploader = uploader;
	}
});
