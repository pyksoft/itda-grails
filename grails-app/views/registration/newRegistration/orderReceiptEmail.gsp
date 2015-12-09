<%@ page contentType="text/html" %>
<%@ page import="com.itda.Payment" %>
<body style="font-family: arial">
<table width="100%">
	<tr>
		<td valign="bottom" width="72%">
		<img src="${applicationContext.grailsApplication.config.grails.serverURL}/images/itd/reg/itda_logo.jpg"/>
		</td>
		<td valign="bottom" width="28%" style="padding-bottom: 10px; left; font-size: xx-large; color: #C0C0C0">
		 Receipt
		 </td>
	</tr>	
</table>
<hr/>
<table width="100%">
	<tr>
		<td valign="top" width="50%">
		<b>Billed To:</b>
		</td>
		<td valign="top" width="50%">
		 &nbsp;
		 </td>
	</tr>
	<tr>
		<td valign="top" width="50%" style="color: #0076A0">
		${businessInstance.email}
		</td>
		<td valign="top" width="50%">
		 <b>Order Number:</b> ${paymentInstance.id}
		 </td>
	</tr>
	<tr>
		<td valign="top" width="50%" style="color: #0076A0">
		${paymentInstance.firstName} ${paymentInstance.lastName}
		</td>
		<td valign="top" width="50%">
		 <b>Receipt Date:</b> ${(new Date()).format('MM/dd/yyyy')}
		 </td>
	</tr>
	<tr>
		<td valign="top" width="50%" style="color: #0076A0">
		${paymentInstance.billingAddress}
		</td>
		<td valign="top" width="50%">
		 <b>Order Total:</b> $${paymentInstance.totalPriceAsString()}
		 </td>
	</tr>
	<tr>
		<td valign="top" width="50%" style="color: #0076A0">
		${paymentInstance.city} ${paymentInstance.state}, ${paymentInstance.zipcode}
		</td>
		<td valign="top" width="50%">
		 <b>Billed To:</b> ${paymentInstance.cardNumberAsLast4String()}
		 </td>
	</tr>
</table>
<hr/>

<g:if test="${officeInstanceList}"> <%-- TODO check whether office is available --%>
	<div>
	<table width="100%">
		<thead>
			<tr>
				<th style="text-align: left">Description</th>
				<th style="text-align: left">Office&nbsp;Name</th>
				<th style="text-align: left">Price</th>
			</tr>
		</thead>
		<tbody>
				<tr>
					<td colspan="3"><hr/></td>
				</tr>
			<g:each in="${officeInstanceList}" status="i" var="officeInstance">
              <g:if test="${officeInstance.availability == 'true' }">  
				<tr>
					<td width="30%">${i == 0 ? (new Date()).format('MMMM') + ' Portfolio' : '&nbsp;'}</td>
					<td width="40%">${fieldValue(bean:officeInstance, field:'name')}</td>
					<td width="30%">Included
					</td>
				</tr>
			  </g:if>
			</g:each>
				<tr>
					<td colspan="3"><hr/></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;" width="70%">
					Subtotal: 
					</td>
					<td style="text-align: leftt;" width="30%">
					 $${paymentInstance.totalPriceAsString()}
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;" width="70%">
					Tax: 
					</td>
					<td style="text-align: left;" width="30%">
					 &nbsp;&nbsp;&nbsp;&nbsp;$0.00
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: right;" width="70%">
					Total: 
					</td>
					<td style="text-align: leftt;" width="30%">
					 $${paymentInstance.totalPriceAsString()}
					</td>
				</tr>
				<tr>
					<td colspan="3"><hr/></td>
				</tr>				
		</tbody>
	</table>
	</div>
<br/>
<table width="100%"><tr><td>
<b>Please retain for your record.</b><br/>
Please see <a href="#">Terms and Conditions</a> pertaining to this order.<br/> 
If you would like to check your Order History online, please my <a href="#">My Account</a> 
and select Order History.<br/><br/>

Copyright 2010 In the Door Advertising.  All rights reserved  
</td></tr></table>
</g:if>
</body>