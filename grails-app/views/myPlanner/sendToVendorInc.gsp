<table width="98%" style="margin:0px">
		<tbody><tr class='news-planner-event directmail-planner-event media-planner-event Media event-planner-event miscellaneous-planner-event'>
			<td>
			<h1 style="margin-top:0px">Send to Vendor</h1>
			</td>
		</tr>
<tr class='news-planner-event directmail-planner-event media-planner-event Media event-planner-event miscellaneous-planner-event'><td>	  		
        <div>
            <form method="post" id='sendForm' name='sendForm'>
            	<input name='id' id='id' type="hidden"/>
                <div>
                    <table>
                        <tbody>
                            <tr class='news-planner-event directmail-planner-event media-planner-event Media event-planner-event miscellaneous-planner-event'>
                                <td valign="top" style="text-align:right">
                                    <b>Vendor:</b>
                                </td>
                                <td colspan="2" valign="top">
                                	<input type='text' name='vendorDisplayName' readonly="readonly" style='border:0px none; font-weight:bold; position:relative; bottom:5px'/>
                                	<%-- <input type='hidden' name='vendor.id'/>
                                	<input type='hidden' name='publication.id'/>
                                	--%>
                                </td>
                            </tr> 
                            <tr class='news-planner-event directmail-planner-event media-planner-event Media event-planner-event miscellaneous-planner-event'>
                                <td valign="top" style="text-align:right">
                                    <b>To:</b>
                                </td>
                                <td colspan="2" valign="top">
                                   <input style='width:360px' maxlength="128" name="toEmail" type="text"/>
                                </td>
                            </tr> 
                            <tr class='news-planner-event directmail-planner-event media-planner-event Media event-planner-event miscellaneous-planner-event'>
                                <td valign="top" style="text-align:right">
                                    <b>Cc:</b>
                                </td>
                                <td colspan="2" valign="top">
                                    <input style='width:360px' maxlength="128" name="cc" type="text"/>
                                </td>
                            </tr> 
                            <tr class='news-planner-event directmail-planner-event media-planner-event Media event-planner-event miscellaneous-planner-event'>
                                <td valign="top" style="text-align:right">
                                    <b>Subject:</b>
                                </td>
                                <td colspan="2" valign="top">
                                    <input style='width:360px' maxlength="256" name="subject" type="text"/>
                                </td>
                            </tr> 

                            <tr class='news-planner-event directmail-planner-event media-planner-event Media event-planner-event miscellaneous-planner-event'>
                                <td valign="top" style="text-align:right">
                                    <b>Notes:</b>
                                </td>
                                <td colspan="2" valign="top">
                                    <textarea name="notes" style='width:360px'></textarea>
                                </td>
                            </tr> 
                            <tr class='directmail-planner-event'>
                                <td valign="top" style="text-align:right">
                                    <b>Quantity:</b>
                                </td>
                                <td colspan="2" valign="top">
                                    <input style='width:360px' maxlength="12" name="quantityDisplay" type="text" readonly/>
                                </td>
                            </tr> 
                            <tr class='directmail-planner-event'>
                                <td valign="top" style="text-align:right">
                                    <b>Zip Codes:</b>
                                </td>
                                <td colspan="2" valign="top">
                                    <textarea name="zipcodesDisplay" style='width:360px;height:50px'></textarea>
                                </td>
                            </tr>                            
                            <tr class='news-planner-event directmail-planner-event'>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                   <span style='border:1px solid #cccccc; padding: 4px'><input type="checkbox" name="changePhoneFlag" align="middle"/>&nbsp;<b>Change phone number to:</b>&nbsp;<input style='width:163px;border:0px none'  name="phone" type="text"/></span>
                                </td>
                            </tr> 
                            <tr class='directmail-planner-event news-planner-event'>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                    <span style='border:1px solid #cccccc; padding: 4px'>
                                    	<input type="checkbox" name="changeDatesFlag" style='margin-top:2px'/>&nbsp;<b>Change&nbsp;dates&nbsp;to:</b>&nbsp;<input style='width:222px;border:0px none' maxlength="128" name="dates" type="text"/></span>
                                </td>
                            </tr> 

                            <tr class='directmail-planner-event news-planner-event'>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                  <span style='border:1px solid #cccccc; padding: 4px'>
                                    <input type="checkbox" name="changeLogoFlag"/>&nbsp;<b>Replace logo:</b>&nbsp;<input style='width:243px;border:0px none' maxlength='128' name="logo" type="text"/>
                                  </span>
                                </td>
                            </tr> 
                            <tr class='directmail-planner-event news-planner-event'>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                  <span style='border:1px solid #cccccc; padding: 4px'>
                                    <input type="checkbox" name="changeOffersFlag"/>&nbsp;<b>Change offers to:</b>&nbsp;<input style='width:217px;border:0px none' maxlength="128" name="offers" type="text"/>
                                   </span>
                                </td>
                            </tr> 
                            <tr class='directmail-planner-event news-planner-event'>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                   <span style='border:1px solid #cccccc; padding: 4px'>
                                    <input type="checkbox" name="changeExpireDatesFlag"/>&nbsp;<b>Change expiration dates to:</b>&nbsp;<input style='width:149px;border:0px none' name="expireDates" type="text"/>
                                   </span>
                                </td>
                            </tr> 
                            <tr class='directmail-planner-event news-planner-event'>
                            	<td>&nbsp;</td>
                                <td colspan="2" valign="top">
                                   <span style='border:1px solid #cccccc; padding: 4px'>
                                    <input type="checkbox" name="changeAddressFlag"/>&nbsp;<b>Change address to:</b>&nbsp;<input style='width:205px;border:0px none' maxlength="128" name="address" type="text"/>
                                   </span>
                                </td>
                            </tr> 
                         
                            <tr class='directmail-planner-event news-planner-event'>
                                <td colspan="3" valign="top">
                                  <div >
                                	<div id='adImage' style='float:left; margin:50px 0 auto 75px;font-size:14px;line-height:1.5;color:#0076A3'>
                                	</div>
                                	<%--  
	                                <div style='float:left;width:20px'>&nbsp;</div>                                	                             
                                	<div style='float:right;border:1px solid #cccccc'>
	                                    &nbsp;<input type="checkbox" name="changeOtherFlag"/>
	                                    <b>Other changes:</b><br/>
	                                    <textarea name="otherChanges" style='border:0px none; width:205px'></textarea>
	                                </div>
	                                 --%>
                                </div>
                                </td>
                            </tr> 
                     
                        </tbody>

                    </table>
                </div>

               </form>
        </div>

	  		     		</td>
					</tr>

 						            <tr class='news-planner-event directmail-planner-event media-planner-event Media event-planner-event miscellaneous-planner-event'>
						                <td valign="top" colspan="2">
						                        <div style='float:right;margin-right:10px'><input class="planner-icon send-btn-red" type="submit" value="" onclick='sendToVendor();this.blur();return false;'/></div>
						                		<div style='float:right;margin-right:10px'><input class="planner-icon save-btn-orange" type="submit" value="" onclick='saveSendToVendorInfo();this.blur();return false'/></div>
						                		<div style='float:right;margin-right:10px'><input class="tracker-icon tracker-cancel-gray-btn" type="submit" value="" onclick='closeDialog("dialog-send-to-vendor");return false'/></div>
							             </td>
						
						            </tr>                        
								
</tbody></table>