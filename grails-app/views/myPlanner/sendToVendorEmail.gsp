<%@ page contentType="text/html" %>
<%@ page import="com.itda.PlannerEntry" %>
<%
    def plannerService = grailsApplication.mainContext.getBean("plannerService");
	def portfolioEntry = entry.portfolioEntry;
%>
<body style="font-family: arial">
<%-- 

<table width="98%" style="margin:0px"><tbody>
--%>
                            <div style="font:bold 20px arial,sans-serif;width:100%">
                               <div style="float:left;margin-left:40px"><img src="http://www.inthedooradvertising.net/images/itd/reg/itda_logo.jpg"/></div>
                               <div style="float:right"><span style="vertical-align: -60px; color:#aaa"><g:if test="${portfolioEntry}">DOWNLOAD</g:if><g:else>&nbsp;</g:else></span></div>
                             </div>
                             <div style="clear:both;width:100%"><img src="http://www.inthedooradvertising.net/images/color-bar-574-11.png" style="width:100%"/></div>
                             <div style="font:bold 15px arial,sans-serif;margin-left:50px">
                                   ${entry['subject']}
                             </div>
                             <hr/>
                             <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
                             	<g:if test="${sendToVendor.notes}">
                                  ${sendToVendor.notes.replaceAll("(\r\n|\n)", "<br/>")}
                                </g:if>
                              </div>
                             <hr/>
                            <g:if test="${entry['className'] == 'news-planner-event' || entry['className'] == 'directmail-planner-event'}">
                            	<table style="font: 13.5px/17px arial,sans-serif;margin-left:50px"><tr>
                            		<td>
		                                <div>
		                                    <img style="max-height: 250px; max-width: 170px" src="${applicationContext.grailsApplication.config.grails.serverURL}/sendToVendor/download?uuid=${sendToVendor.uuid}&fileType=image">
		                                </div>
                            		</td>
                            		<td>
		                                <div>
		                                    ${PlannerEntry.getAdTitle(entry.className)}<br/>
		                                    ${plannerService.getAdFileNameText(portfolioEntry)}<br/>
		                                    ${portfolioEntry?.details}<br/>
		                                    ${plannerService.getAdSizeTextForCode(entry.size)}<br/>
		                                    ${plannerService.getAdColorTextForCode(entry.color)}<br/>
		                                </div>
                            		</td>
                            	</tr></table>
                            	<g:if test="${sendToVendor.changeOffersFlag || sendToVendor.changePhoneFlag || sendToVendor.changeDatesFlag || sendToVendor.changeLogoFlag || sendToVendor.changeExpireDatesFlag || sendToVendor.changeAddressFlag}">
                                	<hr/>
                                	<% int ind = 0; %>
	                                <div style="font: 15px/17px arial,sans-serif;margin-left:50px">
	                                   MODIFICATIONS:
	                                </div>
	                            	<g:if test="${sendToVendor['changeDatesFlag']}">
	                                <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
	                                    <span>
	                                    ${++ind}) Change the calendar dates to:&nbsp;${sendToVendor.dates}</span>
	                                </div>
	                            	</g:if>
	                            	<g:if test="${sendToVendor['changeExpireDatesFlag']}">
	                                <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
	                                  <span>
	                                    ${++ind}) Change the expiration dates to:&nbsp;${sendToVendor.expireDates}
	                                   </span>
	                                </div>
	                            	</g:if>
	                            	<g:if test="${sendToVendor['changePhoneFlag']}">
	                                <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
	                                   <span>
	                                   ${++ind}) Change the phone number to:&nbsp;${sendToVendor.phone}</span>
	                                </div>
	                            	</g:if>
	                            	<g:if test="${sendToVendor['changeAddressFlag']}">
	                                <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
	                                   <span>
	                                    ${++ind}) Change the address to:&nbsp;${sendToVendor.address}
	                                   </span>
	                                </div>
	                            	</g:if>
	                            	<g:if test="${sendToVendor['changeOffersFlag']}">
	                                <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
	                                  <span>
	                                    ${++ind}) Change the offers to:&nbsp;${sendToVendor.offers}
	                                  </span>
	                                </div>
	                            	</g:if>
	                            	<g:if test="${sendToVendor['changeLogoFlag']}">
	                                <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
	                                  <span>
	                                    ${++ind}) Add logo for:&nbsp;${sendToVendor.logo}
	                                  </span>
	                                </div>
	                            	</g:if>
	                            </g:if>
                            	<%--
                                <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
                                  <div>
	                                   Other changes:<br/>
	                                    ${entry.otherChanges}
	                                </div>
                                </div>
                                --%>
                     		</g:if>
                            <hr/>
                            <g:if test="${entry['className'] == 'directmail-planner-event'}">
                                <div style="font:15px/17px arial,sans-serif;margin-left:50px">
                                   QUANTITY AND ZIP CODES:<br/>
                                </div>
                                <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
                                    Quantity: ${entry.quantity}                                 
                                </div>
                                <div style="font: 13.5px/17px arial,sans-serif;margin-left:50px">
                                  Zip Codes:
								  <g:each status="i" in="${entry.zipcodes}" var="zip">
								     ${ i == 0 ? zip : ', ' + zip} 
								  </g:each>                             
                                </div>
                            </g:if>                                                        
                    		                       
                            <hr/>
                            <g:if test="${portfolioEntry || entry.pdfFile}">   
                                <div style="font:15px/17px arial,sans-serif;margin-left:50px">
                                   DOWNLOAD INSTRUCTIONS:<br/>
                                </div>
                                <div style="font:13.5px/17px arial,sans-serif;margin-left:50px">
                                   Please click the link below to access this file for <span style="font:bold 15px arial,sans-serif;">${sendToVendor.subject}.</span>
                                   <br/><br/>
                                   <%
								   		def filename = null;
										if (portfolioEntry)
								   			filename = "InTheDoorAdvertising-File-" +plannerService.getAdFileNameText(portfolioEntry);
										else
											filename = entry.pdfFile;
								    %>
                                   <a style="font:bold 15px/17px arial,sans-serif;" href="${applicationContext.grailsApplication.config.grails.serverURL}/sendToVendor/download?uuid=${sendToVendor.uuid}&fileType=pdf">${filename}</a>
                                   <br/><br/>
                                   <%--
                                   <img src="http://www.inthedooradvertising.net/images/itd/reg/itda_logo.jpg" style="margin-left:8px;width:261px;height:84px"/>
                                   <br/>
                                   <span style="font:bold 15px arial,sans-serif">Great Ads Deserve Great Placement!</span>
                                   <br/>
                                    --%>
                                </div>
                              </g:if> 
                              <!--  
                                <div style="font:15px/17px arial,sans-serif;margin-left:50px">
                                   <a href="http://www.inthedooradvertising.com" style="margin-left:23px;font:bold 15px/17px arial,sans-serif;">www.inthedooradvertising.com</a>
                                </div>
                              -->
<%-- ===================================================================================================================== --%>                        	
<%--                         	
                            <tr>
                                <td valign="top" style="text-align:right">
                                    <b>To:</b>
                                </td>
                                <td colspan="2" valign="top">
                                <g:if test="${entry['publicationId']}">
                                	${vendor['newspaperOrPublicationName']} 
                                </g:if>	
                                <g:else>
                                	${vendor['vendorName']}
                                </g:else>
                                </td>
                            </tr> 
                            <tr>
                                <td valign="top" style="text-align:right">
                                    <b>Attn:</b>
                                </td>
                                <td colspan="2" valign="top">
                                   ${entry.toEmail}
                                </td>
                            </tr>
                            <g:if test="${entry['className'] == 'directmail-planner-event'}">
                            <tr>
                                <td valign="top" style="text-align:right">
                                    <b>Quantity:</b>
                                </td>
                                <td colspan="2" valign="top">
                                	${entry.quantity}                                 
                                </td>
                            </tr> 
                            <tr>
                                <td valign="top" style="text-align:right">
                                    <b>Zip Codes:</b>
                                </td>
                                <td colspan="2" valign="top">
                                    ${entry.zipcodes}
                                </td>
                            </tr>
                            </g:if>                                                        
                            <tr>
                                <td valign="top" style="text-align:right">
                                    <b>Notes:</b>
                                </td>
                                <td colspan="2" valign="top">
                                   ${entry.vendorNotes}
                                </td>
                            </tr> 
                            <g:if test="${entry['className'] == 'news-planner-event' || entry['className'] == 'directmail-planner-event'}">
                            <tr>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                   <span style='border:1px solid #cccccc; padding: 4px'>
                                   <input type="checkbox" disabled name="changePhoneFlag" align="middle"/>&nbsp;<b>Change phone number to:</b>&nbsp;${entry.phone}</span>
                                </td>
                            </tr> 
                            <tr>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                    <span style='border:1px solid #cccccc; padding: 4px'>
                                    	<input type="checkbox" disabled name="changeDatesFlag" style='margin-top:2px'/>&nbsp;<b>Change&nbsp;dates&nbsp;to:</b>&nbsp;${entry.dates}</span>
                                </td>
                            </tr> 

                            <tr>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                  <span style='border:1px solid #cccccc; padding: 4px'>
                                    <input type="checkbox" disabled name="changeLogoFlag"/>&nbsp;<b>Replace logo:</b>&nbsp;${entry.logo}
                                  </span>
                                </td>
                            </tr> 
                            <tr>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                  <span style='border:1px solid #cccccc; padding: 4px'>
                                    <input type="checkbox" disabled name="changeOffersFlag"/>&nbsp;<b>Change offers to:</b>&nbsp;${entry.offers}
                                   </span>
                                </td>
                            </tr> 
                            <tr>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                   <span style='border:1px solid #cccccc; padding: 4px'>
                                    <input type="checkbox" disabled name="changeExpireDatesFlag"/>&nbsp;<b>Change expiration dates to:</b>&nbsp;${entry.expireDates}
                                   </span>
                                </td>
                            </tr> 
                            <tr>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                   <span style='border:1px solid #cccccc; padding: 4px'>
                                    <input type="checkbox" disabled name="changeAddressFlag"/>&nbsp;<b>Change address to:</b>&nbsp;${entry.address}
                                   </span>
                                </td>
                            </tr> 
                         
                            <tr>
                            	
                                <td colspan="3" valign="top">
                                  <div >
                                	<div  style='float:left; margin:50px 0 auto 75px;font-size:14px;line-height:1.5;color:#0076A3'>
                                	You have not<br/>yet selected a<br/>newspaper ad.<br/><br/><br/>
                                	</div>	   
	                                <div style='float:left;width:20px'>&nbsp;</div>                                	                             
                                	<div style='float:right;border:1px solid #cccccc'>
	                                    &nbsp;<input type="checkbox" disabled name="changeOtherFlag"/>
	                                    <b>Other changes:</b><br/>
	                                    ${entry.otherChanges}
	                                </div>


                                </div>
                                </td>
                            </tr> 
                     		</g:if>
                        </tbody>

                    </table>
                </div>

               </form>
        </div>

	  		     		</td>
					</tr>                   
								
</tbody></table>
--%>
</body>