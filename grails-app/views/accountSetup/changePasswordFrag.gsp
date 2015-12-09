        <table width="100%">
            <tr>
            <td width="20%">
            	<h1>&nbsp;</h1>
            </td>
            <td width="100%">
            	<h1>Change My Username</h1>
            	<p style="padding: 0 0 15 25; color: #475659; font-size: 14;line-height:110%">
				 &nbsp;
				 <br/><br/>


            	<div style="padding: 0 0 0 25;">
			<g:formRemote name="form1" update="success" url="[controller:'accountSetup', action:'changePassword']">
					<g:if test="${params.frag}"><input type="hidden" name="frag" value="1"/></g:if>
				    <label>What is your user name?</label> <br/> <input type="password" name="password"/><br/><br/>
				    <label>What is your new user name?</label><br/> <input type="password" name="newPassword"/><br/><br/>
				    <label>Please verify new user name.</label><br/> <input type="password" name="confirmNewPassword"/><br/><br/>
				    <g:submitButton name="done" value="" class="done"/>
				</g:formRemote>
				</div>           
            </td>
            </tr>
            <tr>
            <td width="20%">
            	<h1>&nbsp;</h1>
            </td>
            <td width="100%">
            	<h1>Change My Password</h1>
            	<p style="padding: 0 0 15 25; color: #475659; font-size: 14;line-height:110%">
				 &nbsp;
				 <br/><br/>


            	<div style="padding: 0 0 0 25;">
			<g:formRemote name="form1" update="success" url="[controller:'accountSetup', action:'changePassword']">
					<g:if test="${params.frag}"><input type="hidden" name="frag" value="1"/></g:if>
				    <label>What is your password?</label> <br/> <input type="password" name="password"/><br/><br/>
				    <label>What is your new password?</label><br/> <input type="password" name="newPassword"/><br/><br/>
				    <label>Please verify new password.</label><br/> <input type="password" name="confirmNewPassword"/><br/><br/>
				    <g:submitButton name="done" value="" class="done"/>
				</g:formRemote>
				</div>           
            </td>
            </tr>
        </table>