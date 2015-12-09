<%@ page import="com.itda.Portfolio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Ad Collection Upload</title>
<link href="/css/main.css" rel="stylesheet" type="text/css" />
<link href="/css/itda.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/jquery-1.7.1/js/jquery-1.7.1.min.js"></script >
<script type="text/javascript" src="/plupload152/js/plupload.full.js"></script>
<script type="text/javascript">
		window.onload =function() {
	    	 uploader = new plupload.Uploader({
	    		runtimes : 'html5,flash,silverlight',
	    		browse_button : 'pickfiles',
	    		container : 'container',
	    		max_file_size : '300mb',
	    		url : "/${params.controller}/uploadZipContent/${params.id}",
	    		flash_swf_url : '/plupload152/js/plupload.flash.swf',
	    		silverlight_xap_url : '/plupload152/js/plupload.silverlight.xap',
	    		filters : [{title : "ZIP Files", extensions : "zip"}]
	    	});

	    	uploader.bind('Init', function(up, params) {
	    		$('#filelist').html("<div>Current runtime: " + params.runtime + "</div>");
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
	    		uploader.start();
	    		//e.preventDefault();		
	    	});

	    	uploader.bind('UploadProgress', function(up, file) {
	    		$('#' + file.id + " b").html(file.percent + "%");
	    	});

	    	uploader.bind('Error', function(up, err) {
	    		$('#filelist').append("<div>Error: " + err.message +
	    			//(err.file ? ",<br/>File: " + err.file.name : "") +
	    			"</div>"
	    		);

	    		up.refresh(); // Reposition Flash/Silverlight
	    	});

	    	uploader.bind('FileUploaded', function(up, file) {
	    		$('#' + file.id + " b").html("100%");
	    	});	
	    }

</script>        
        
    </head>
    <body style="background:none repeat scroll 0 0 #FFFFFF; border:1px solid #475659; color:#333333; font:15px verdana,arial,helvetica,sans-serif; margin:auto; text-align:center; width:1024px;">    
        <div class="logo">
		 <auth:ifLoggedIn><br/><br/><br/><br/><a href='/helper/logout' style="padding:0px 0px 0px 900px; font-size:11">Logout</a></auth:ifLoggedIn> 
        </div> 
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list">List Ad Collections</g:link></span>
        </div>
        <div class="body">
            <h1>Upload Collection Content</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${portfolioInstance}">
            <div class="errors">
                <g:renderErrors bean="${portfolioInstance}" as="list" />
            </div>
            </g:hasErrors>
    <div id="content">
       	<form id="form1" action="uploadZipContent/${params.id}" method="post" enctype="multipart/form-data">
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Ad Collection Zip File
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'uploadZipName', 'errors')}">
								<div id="container" style="position: relative;">
									<a id="pickfiles"
									class="planner-detail-link-black" href="javascript:void(0);"
									style="display: inline; position: relative; z-index: 0; margin:0 25px">Select File</a>
									<div id="filelist"></div>
								</div>
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
