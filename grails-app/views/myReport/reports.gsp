<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>In the Door Advertising</title>
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet" href="/css/itda.css" />
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
<link type="text/css" href="/jquery-1.7.1/css/smoothness/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
<script type="text/javascript" src="/jquery-1.7.1/js/jquery-1.7.1.min.js"></script >
<script type="text/javascript" src="/jquery-1.7.1/js/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" 	src="/loupe/jquery.loupe.js"></script>
<script type='text/javascript' src='/js/simpleClass.js'></script>
<script type='text/javascript' src='/js/fullCalUtil/calUtil.js'></script>
<script type='text/javascript' src='/js/fullcalendar-1.4.9.js'></script>
<script type='text/javascript' src='/js/date.js'></script>
<script type='text/javascript' src='/js/reports.js'></script>
<script type='text/javascript' src='/js/common.js'></script>
<script type='text/javascript' src='/js/jquery.cookie.js'></script>
<script type='text/javascript' src='/js/jquery-ui-numeric.js'></script>
</head>
<body style='border:none' id='reportPage'>
        <header>
                <nav>
				<g:include view="common/header.gsp" params="[controller:params.controller]"/>
                </nav>
        </header>
        <section>
			<div class='mainBody'>
				<div id="body">
					<div style='clear:both;height:10px'></div><%-- needed for IE and Safari --%>
						<table cellpadding='0px' border='0px' cellspacing='0px' class='mainBodyContent' id='search'>
							<tr>
							<td class='reportLeftCol'>
								<g:include view="myReport/leftColumn.gsp" />
							</td>
							<%-- report detail tabs --%>
							<td class='reportRightCol'>
								<g:include view="myReport/rightColumn.gsp" />
							</td>
							</tr>
						</table>
					<div style='clear:both;height:10px'></div>
				</div>
			</div>
        </section>
        <footer>
                <g:include view="common/footer.gsp"/>
        </footer>
	<div id="dialog-small" class="transition-bg" title="" style="font-size: 13; display: none; text-align:left;"></div>
	<div id='tmp' class='hide'></div> 
<div id="tipsDiag" title="" style="display:none;padding:7px;background-color:rgb(255,253,228);font-size:12px;font-weight:bold">
	<div>
		<div onclick="$('#tipsDiag').dialog('close');" style="float:left;position:relative;top:-8px;left:-8px" class="itda-archive-icon tips-long"></div>
		<div onclick="$('#tipsDiag').dialog('close');" style="float:right" class="itda-archive-icon close-blue-icon"></div>
		<div style='clear:both;height:20px'></div>
	</div>
</div>
<div id='dialogAdImage' title="" style="display:none"><div id="dialogCloseBtn"><input type="submit" onclick="closeDialog('dialogAdImage');return false" value="" class="itda-archive-icon close-btn" /></div><div id="adImageLarge"></div></div>  
</body>
</html>