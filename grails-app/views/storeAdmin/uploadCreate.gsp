
<%@ page import="com.itda.Portfolio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="${message(code: 'portfolio.label', default: 'Portfolio')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
<link href="/css/main.css" rel="stylesheet" type="text/css" />
<link href="/css/itda.css" rel="stylesheet" type="text/css" />
<link href="/css/swfupload.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/swfupload/swfupload.js"></script>
<script type="text/javascript" src="/js/swfupload/swfupload.queue.js"></script>
<script type="text/javascript" src="/js/swfupload/fileprogress.js"></script>
<script type="text/javascript" src="/js/swfupload/queue/handlers.js"></script>
<script type="text/javascript">
		var swfu;

		window.onload = function() {
			var settings = {
				flash_url : "/swfupload.swf",
				upload_url: "/portfolioEntry/uploadZip?&token=${session.getId()}",
				<%--
				//file_post_name: "portfolioZipFile",

				//file_post_name: "jpgFile",
				//post_params: {"JSESSIONID" : ""},
				//file_size_limit : "100 MB",
				--%>
				file_types : "*.zip",
				file_types_description : "ZIP Files",
				file_upload_limit : 1,
				file_queue_limit : 0,
				custom_settings : {
					progressTarget : "fsUploadProgress",
					cancelButtonId : "btnCancel",
					upload_successful : false
					
				},
				debug: false,

				// Button settings
				button_image_url: "/images/XPButtonUploadText_61x22.png",
				button_width: "61",
				button_height: "22",
				button_placeholder_id: "spanButtonPlaceHolder",
				<%--
				//button_text: '<span class="theFont">Upload</span>',
				//button_text_style: ".theFont { font-size: 16; }",
				--%>
				button_text_left_padding: 12,
				button_text_top_padding: 3,
				
				// The event handler functions are defined in handlers.js
				file_queued_handler : fileQueued,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete,
				upload_start_handler : uploadStart,
				upload_progress_handler : uploadProgress,
				upload_error_handler : uploadError,
				upload_success_handler : uploadSuccess,
				upload_complete_handler : uploadComplete,
				queue_complete_handler : queueComplete	// Queue plugin event
			};

			swfu = new SWFUpload(settings);
	     };
	</script>        
        
    </head>
    <body style="background:none repeat scroll 0 0 #FFFFFF; border:1px solid #475659; color:#333333; font:15px verdana,arial,helvetica,sans-serif; margin:auto; text-align:center; width:1024px;">    
        <div class="logo">
		 <auth:ifLoggedIn><br/><br/><br/><br/><a href='/helper/logout' style="padding:0px 0px 0px 900px; font-size:11">Logout</a></auth:ifLoggedIn> 
        </div> 
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1>Upload Portfolio</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${portfolioInstance}">
            <div class="errors">
                <g:renderErrors bean="${portfolioInstance}" as="list" />
            </div>
            </g:hasErrors>
    <div id="content">
       	<form id="form1" action="/portfolio/save" method="post" enctype="multipart/form-data">
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="portfolioDate"><g:message code="portfolio.portfolioDate.label" default="Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'portfolioDate', 'errors')}">
                                	<% def date =  new GregorianCalendar()%>
                                    <g:datePicker name="portfolioDate" value="${date}" precision="month" years="${[date.get(Calendar.YEAR),date.get(Calendar.YEAR)+1]}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="portfolio.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${portfolioInstance.constraints.status.inList}" value="${portfolioInstance?.status}" valueMessagePrefix="portfolio.status"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="coverPageImage"><g:message code="portfolio.coverPageImage.label" default="Cover Page Image" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'coverPageImage', 'errors')}">
                                    <g:textArea name="coverPageImage" cols="40" rows="5" value="${portfolioInstance?.coverPageImage}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="backPageImage"><g:message code="portfolio.backPageImage.label" default="Back Page Image" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'backPageImage', 'errors')}">
                                    <g:textArea name="backPageImage" cols="40" rows="5" value="${portfolioInstance?.backPageImage}" />
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="uploadZipName"><g:message code="portfolio.uploadZipName.label" default="Portfolio Zip File" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'uploadZipName', 'errors')}">
                                        <%-- input type="file" name="portfolioZipFile"/ --%>
									<%--div>
										<div>
											<input type="text" id="txtFileName" disabled="true" style="border: solid 1px; background-color: #FFFFFF;" />
											<span id="spanButtonPlaceholder"></span>
										</div>
										<div class="flash" id="fsUploadProgress">
											 This is where the file progress gets shown.  SWFUpload doesn't update the UI directly.
														The Handlers (in handlers.js) process the upload events and make the UI updates -->
										</div>
										<input type="hidden" name="hidFileID" id="hidFileID" value="" />
										 This is where the file ID is stored after SWFUpload uploads the file and gets the ID back from upload.php -->
									</div--%>
									
									<div class="fieldset flash" id="fsUploadProgress">
									<span class="legend">Upload Queue</span>
									</div>
									<div id="divStatus">0 Files Uploaded</div>
									<div>
										<span id="spanButtonPlaceHolder"></span>
										<input id="btnCancel" type="button" value="Cancel All Uploads" onclick="swfu.cancelQueue();" disabled="disabled" style="margin-left: 2px; font-size: 8pt; height: 29px;" />
									</div>
									<input type="hidden" name="hidFileID" id="hidFileID" value="" />
									
						        </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <%-- div class="buttons">
                    <span class="button">
                    <input type="submit" class="save" name="create" value="Create" id="btnSubmit" />
                    </span>
                </div --%>
            </form>
	</div>
        </div>
    </body>
</html>
