<div id='newspaper-errors' class="errors" style='display:none'>
</div>

<table width="96%" style="margin:5px 30px 5px 20px">
		<tbody><tr>
			<td>
			<h1 style="margin-top:0px">New Newspaper</h1>
			</td>
		</tr>

	<tr><td width="50%">	  		
	  		     		

        <div>
           
            
            <form method="post" id='newPublication' style="text-align: left;">
            
                <div>
                    <table>
                        <tbody>
						            <tr>
						                <td colspan="2" valign="top" class="red">
						                     (*) indicates required field
						                </td>
						            </tr>                             
                        
                            <tr>
                                <td colspan="2" class="value " valign="top">
                                    <span class="red">*</span> Newspaper Name:<br>
                                    <input maxlength="128" size="35" id="newspaperOrPublicationName" name="newspaperOrPublicationName" type="text">
                                </td>
                            </tr> 
                            <tr class="prop">

                                <td colspan="2" class="value " valign="top">
                                    &nbsp; Newspaper Phone: xxx-xxx-xxxx<br>
                                    <input size="35" maxlength="12" id="publicationPhone" name="publicationPhone" type="text">
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" class="value " valign="top">

                                    <span class="red">*</span> Contact Name:<br>
                                    <input size="35" maxlength="128" value="N/A" name="contactName" type="text">
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" class="value " valign="top">
                                    Contact Phone: xxx-xxx-xxxx<br/>

                                    <input size="35" maxlength="12" value="000-000-0000" name="contactPhone" type="text">
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" class="value " valign="top">
                                    <span class="red">*</span> Email:<br>
                                    <input size="35" value="NA@none.none" name="email" type="text">
                                </td>
                            </tr> 
                            <tr class="prop">

                                <td colspan="2" class="value " valign="top">
                                    &nbsp; Alternate Email:<br>
                                    <input size="35" id="alternateEmail" name="alternateEmail" type="text">
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" class="value " valign="top">
                                    &nbsp;  Address:<br>

                                    <input size="35" maxlength="128" id="addressLine1" name="addressLine1" type="text">
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" class="value " valign="top">
                                    &nbsp;  City:<br>
                                    <input size="35" maxlength="128" id="city" name="city" type="text">
                                </td>

                            </tr> 
                         
                            <tr class="prop">
                                <td class="value " valign="top">
                                    &nbsp;  State:<br>
                                    <select name="state" id="state">
<option value=""></option>
<option value="AL">AL</option>
<option value="AK">AK</option>

<option value="AZ">AZ</option>
<option value="AR">AR</option>
<option value="CA">CA</option>
<option value="CO">CO</option>
<option value="CT">CT</option>
<option value="DE">DE</option>
<option value="DC">DC</option>
<option value="FL">FL</option>
<option value="GA">GA</option>

<option value="HI">HI</option>
<option value="ID">ID</option>
<option value="IL">IL</option>
<option value="IN">IN</option>
<option value="IA">IA</option>
<option value="KS">KS</option>
<option value="KY">KY</option>
<option value="LA">LA</option>
<option value="ME">ME</option>

<option value="MD">MD</option>
<option value="MA">MA</option>
<option value="MI">MI</option>
<option value="MN">MN</option>
<option value="MS">MS</option>
<option value="MO">MO</option>
<option value="MT">MT</option>
<option value="NE">NE</option>
<option value="NV">NV</option>

<option value="NH">NH</option>
<option value="NJ">NJ</option>
<option value="NM">NM</option>
<option value="NY">NY</option>
<option value="NC">NC</option>
<option value="ND">ND</option>
<option value="OH">OH</option>
<option value="OK">OK</option>
<option value="OR">OR</option>

<option value="PA">PA</option>
<option value="RI">RI</option>
<option value="SC">SC</option>
<option value="SD">SD</option>
<option value="TN">TN</option>
<option value="TX">TX</option>
<option value="UT">UT</option>
<option value="VT">VT</option>
<option value="VA">VA</option>

<option value="WA">WA</option>
<option value="WV">WV</option>
<option value="WI">WI</option>
<option value="WY">WY</option>
</select>
                                </td>
                                <td class="value " valign="top">
                                    &nbsp;  ZIP Code xxxxx<br>

                                    <input maxlength="5" id="zipcode" name="zipcode" type="text">
                                </td>
                            </tr> 
 
 						            <tr class="prop">
						                <td colspan="2" valign="top">
						                		<div>
						                		
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

 						            <tr class="prop">
						                <td valign="top" colspan="2">
						                		<div style='float:right'><input class="tracker-icon done-icon" type="submit" value="" onclick='saveNewPub();return false;'/></div>
						                		<div style='float:right;margin-right:10px'><input class="tracker-icon tracker-cancel-gray-btn" type="submit" value="" onclick='gNewPubDiag.dialog("close");return false;'/></div>
							             </td>
						
						            </tr>                        
								
</tbody></table>