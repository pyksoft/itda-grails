package com.itda
import com.ondemand1.util.*;
import com.grailsrocks.authentication.SignupForm;
import com.grailsrocks.authentication.AuthenticatedUser;
import com.grailsrocks.authentication.AuthenticationUser;
import com.itda.command.CommentCommand;
//import com.itda.admin.ManufacturerPromoCode;
import com.itda.admin.ItdaAttribute;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import grails.converters.JSON;

import java.util.ArrayList;


class RegistrationController {

	def authenticationService
	def asynchronousMailService

	def index = { redirect(action:"newRegistration") }
	/*	
	 def validateComment = {
	 CommentCommand cmd ->
	 //println cmd.name
	 //println ('cmd.comment:' + cmd.comment + ":")
	 if(! cmd.name || ! cmd.phone || ! cmd.comment){
	 //println cmd.errors.allErrors
	 return false;
	 }else{
	 println 'return true'
	 return true;
	 }
	 }
	 */	
	def resetPassword = {
		log.debug params;
		if (!params.email)
			return;
		
		def obj = Business.findWhere(email:params.email);
		log.debug("biz is " + obj.id);
		if(obj)
			obj = Username.findWhere('business.id':obj.id);
		log.debug("biz is " + obj);
		AuthenticationUser acct = null;
		if(obj)
			acct = AuthenticationUser.findWhere(login:obj.login);
		log.debug("acct is " + acct);
		if (acct) {
			String passwd = PassPhrase.getNext();
			acct.password =  authenticationService.encodePassword(passwd);

			if(acct.save(flush:true)) {
				flash.message = "Check your email"
				sendResetPasswordEmail(passwd, params.email)
			} else {
				flash.generalError = message(code:"general.error");
				log.warn "Attempt to change password of null account"
			}
		} else {
			flash.message = "Email not found"
		}
	}


	def newRegistrationFlow = {

		hasValidPromoCode {
			action {
				flow.promoCode = params.promocode;
				def codeList = ItdaAttribute.findAllValues("manufacturerCode");
				
				if(codeList.contains(flow.promoCode)) {
						return yes()
				}
				flash.message = "A valid promo code is required.";
				return no()
			}
			on("yes").to "enterOfficeLocationInfo"
			on("no").to "invalidPromoCode"
		}

		invalidPromoCode {

		}

		enterOfficeLocationInfo {

			on("addOffice") {
				def officeInstance = new Office(params)
				if(!flow.businessInstance)
					flow.businessInstance = new Business()
				officeInstance.business = flow.businessInstance;

				if(!officeInstance.validate()) {
					flow.officeInstance = officeInstance;
					return error();
				}

				if (flow.officeInstanceList?.size() ==  (message(code:"inthedoor.office.add.max") as int)){
					officeInstance.errors.reject("office.add.max", []as Object[], message(code:"inthedoor.office.add.max")
					+ " offices maximum can be entered for each sign up.")
					flow.officeInstance = officeInstance;
					return error();
				}

				def results = RegistrationController.calculateOfficeGeoProfile( officeInstance, message(code:"google.map.key"))
				if(results['result'] == 1) {
					officeInstance.errors.reject("office.location.accuracy.level", [address]as Object[], "An accurate enough geo-location is not available for the specified address. Please enter a different address.")
					return error();
				}else if (results['result'] == 2) {
					officeInstance.errors.reject(results['errorMessage'], [
						officeInstance.prettyPrintAddress()]
					as Object[], "The server encountered an error.")
					flow.officeInstance = officeInstance;
					return error();
				}

				if(!flow.officeInstanceList)
					flow.officeInstanceList = new ArrayList<Office>();

				if(flow.editIndex)
					flow.officeInstanceList.set(flow.editIndex as int, officeInstance);
				else
					flow.officeInstanceList.add(flow.officeInstanceList.size(), officeInstance);

				//log.debug("calculatingOverLappingTerr  " + flow.officeInstanceList.size());
				//calculateAndRemoveOverlappingTerritories(flow.officeInstanceList)
				//flow.hasConflict = hasConflict(flow);
				flow.editIndex = null
				flow.officeInstance = null
			}.to "enterOfficeLocationInfo"

			on("removeOffice") {
				def i = params['index']
				flow.officeInstanceList.remove(i as int)
				//if(needRecalculateOverlappingTerritories(flow.officeInstanceList))
				//  calculateOverlappingTerritories(flow.officeInstanceList)
				//flow.hasConfict = hasConflict(flow)
				flow.officeInstance = null
				flow.editIndex = null
			}.to "enterOfficeLocationInfo"

			on("editOffice") {
				def i = params['index']
				flow.officeInstance = flow.officeInstanceList.getAt(i as int)
				flow.editIndex = i;
				//flow.hasConfict = hasConflict(flow)
			}.to "enterOfficeLocationInfo"

			//on("officeConflictContactForm") {
			//flow.commentCommand = new CommentCommand()
			//}.to "officeConflictContactForm"

			on("next") {
				if(!flow.officeInstanceList) {
					def officeInstance = new Office(params);
					officeInstance.errors.reject("office.add.one", []as Object[], "Please add office location(s).")
					flow.officeInstance = officeInstance;
					return error();
				}
				def totalPrice = calculateSubscriptionCost(flow);
				/*
				 if(totalPrice == 0) {
				 def officeInstance = new Office(params)
				 officeInstance.errors.reject("office.add.unavailble", [] as Object[], "Oficce(s) not available. Please add additional office location(s).")
				 flow.officeInstance = officeInstance;
				 return error()
				 }*/
				flow.totalPrice = totalPrice;
				flow.businessInstance.offices = flow.officeInstanceList;
				flow.officeInstance =  null;
				//flow.businessInstance.save()
			}.to "officeLocationDetails"

			// on("back") {
			//    def officeInstance = new Office(params)
			//	   flow.officeInstance = officeInstance
			//  }.to "enterBusinessInfo"
		}
		/*	
		 //OFFICE DETAIL  
		 officeConflictContactForm {
		 on("done") {
		 def commentCommand = new CommentCommand(name:params.name, phone:params.phone, comment:params.comment)
		 if(!this.validateComment(commentCommand)) {
		 if(log.debugEnable()) log.debug "field error " + commentCommand.errors.fieldError
		 flow.commentCommand = commentCommand;
		 return error()
		 } else {
		 flow.submitConfictContactForm = true
		 //render( view:"registration/newRegistration/flow.officeInstanceList;")
		 //log.debug flow.officeInstanceList.size()
		 //log.debug flow.officeInstanceList.getAt(0).territoryZipcodes.size()
		 sendTerritoryConflictContactEmail(flow.officeInstanceList, commentCommand,
		 message(code:"inthedoor.email.customerService"))
		 flow.persistenceContext.clear(); // TODO replace this whenever someone fixes the hibernate issue
		 }
		 }.to "enterOfficeLocationInfo"		
		 }
		 */		
		//OFFICE DETAIL
		officeLocationDetails {
			on("next") {
				//flow.businessInstance.additionalZipcodes = params['additionalZipcodes']
			}.to "enterPaymentInfo"
			on("back") {
				//flow.businessInstance.additionalZipcodes = params['additionalZipcodes']
			}.to "enterOfficeLocationInfo"
			/*
			on("removeOffice") {
				def i = params['index']
				flow.officeInstanceList.remove(i as int)
				if(needRecalculateOverlappingTerritories(flow.officeInstanceList))
					calculateOverlappingTerritories(flow.officeInstanceList)
				//flow.hasConfict = hasConflict(flow)
				flow.remove('officeInstance');
				flow.remove('editIndex');
			}.to "needOfficeLocation"
			*/
		}
		//Remove OFFICE
		/*
		needOfficeLocation {
			action {
				def totalPrice = calculateSubscriptionCost(flow);
				if(totalPrice == 0) yes()
				else no()
			}
			on("yes").to "enterOfficeLocationInfo"
			on("no").to "officeLocationDetails"
		}
		*/
		//PAYMENT
		enterPaymentInfo {
			on("next") {
				println "enterPaymentInfo" + params;
				if(flow.totalPrice == 0) {
					businessInstance.errors.reject("business.registration.unavailble", []as Object[],
					"Your request cannot be processed.");
					return error();
				}

				flow.businessInstance.properties = params;
				flow.businessInstance.promoCode = flow.promoCode;
				def busValid = flow.businessInstance.validate();

				flow.paymentInstance = new Payment(params);
				flow.paymentInstance.business = flow.businessInstance;

				if(!flow.paymentInstance.validate() || !busValid ) {
					return error()
				} else {

					flow.paymentInstance.updateTotalPrice(1, flow.totalPrice as double, 0.0);

					StringBuffer paymentParams = flow.paymentInstance.authorizeCaptureHttpParamsAsStringBuffer()
					def url = message(code:"authorize.net.url")
					paymentParams.append('&').append( message(code:"authorize.net.params") )
					//if(log.isDebugEnabled())


					SignupForm form = new SignupForm()
					form.login = flow.businessInstance.email
					form.password = com.ondemand1.util.PassPhrase.getNext()
					//form.setPasswordConfirm("password")
					//if( flow.businessInstance.save(flush:true) && createAccount(form)) {
					//log.info(paymentParams.toString())
					def processor = new PaymentProcessor();
					processor.processPayment(url, paymentParams.toString())
					if(processor.isPaymentApproved())
					{
						//log.info("registration data: " + flow.businessInstance.toString())
						flow.paymentInstance.approvalCode = processor.getApprovalCode()
						flow.paymentInstance.transactionId = processor.getTransactionId()
						flow.paymentInstance.response = processor.getPaymentResponse()
						//flow.paymentInstance.cardNumber = flow.paymentInstance.cardNumberAsLast4String()
						if(log.isDebugEnabled())
							log.debug("payment response" + processor.getPaymentResponse())
						GregorianCalendar cal = new GregorianCalendar();
						cal.add(Calendar.MONTH, 1);
						def login = message(code:"authorize.net.api.login");
						def key = message(code:"authorize.net.api.key");
						String xml = processor.getCreateSubscriptionRequestText(login, key,
								flow.paymentInstance, cal.getTime(), flow.businessInstance);
						HashMap map = processor.processSubcription(message(code:"authorize.net.api.url"), xml);
						def subId = map.get("result_subscription_id");
						//if(subId == null)
						flow.paymentInstance.notes = map.toString();
						flow.paymentInstance.subscriptionId = (subId != null) ? subId: "SUBSCRIPTION FAILED" ;
						def paymentList = new ArrayList<Payment>();
						paymentList.add(0, flow.paymentInstance)
						flow.businessInstance.payments = paymentList;
						
						persistRegistrationtData(flow.businessInstance, form, flow.paymentInstance );
						def paymentInfo = new PaymentInfo(params);
						paymentInfo.business = flow.businessInstance;
						paymentInfo.save(flush:true);
					}else{
						String errorMessageCode = processor.getErrorMessageProp()
						String messageText = processor.getResponseText();
						flow.paymentInstance.errors.reject(errorMessageCode, []as Object[], messageText)
						log.warn("Unable to process payment " + processor.getPaymentResponse())
						return error()
					}
					//} else { //if save busi instance

					//}
				}//if param valid
				flow.persistenceContext.clear();
				//sessionFactory.currentSession.clear() // TODO replace this whenever someone fixes the hibernate issue
			}.to "finish"   //next

			on("back") {
				flow.paymentInstance = new Payment(params)
			}.to "officeLocationDetails"
		}
		finish {
			//the end

		}
		//RECEIPT
		//receipt {
		//	on("next") {
		//	}.to "finish"   //next
		//}




		/*   
		 confirmationAuthorizedOrder {
		 on("next") {
		 }.to "captureAuthorizedOrder"   //next                   
		 on("back") {
		 }.to "enterPaymentInfo"
		 }
		 captureAuthorizedOrder {
		 action {
		 def processor = new PaymentProcessor()
		 StringBuffer paymentParams = paymentInstance.priorAuthorizeCaptureHttpParamsAsStringBuffer()
		 def url = message(code:"authorize.net.url")
		 paymentParams.append('&').append( message(code:"authorize.net.params") )
		 processor.processPayment(url, paymentParams.toString()) 
		 if(processor.isPaymentApproved())
		 {
		 flow.paymentInstance.approvalCode = processor.getApprovalCode()
		 flow.paymentInstance.transactionId = processor.getTransactionId()
		 flow.paymentInstance.response = processor.getPaymentResponse()
		 return success()
		 }
		 else
		 {
		 String errorMessageCode = processor.getErrorMessageProp()
		 String messageText = processor.getResponseText();
		 flow.paymentInstance.errors.reject(errorMessageCode, [] as Object[], messageText)
		 log.warn("Unable to capture payment " + errorMessageCode + ":" + messageText)
		 paymentParams = paymentInfo.voidHttpParamsAsStringBuffer()
		 paymentParams.append('&').append( message(code:"authorize.net.params") )
		 pp.processPayment (url, paymentParams.toString())
		 return error()	    		 
		 }
		 }                   
		 on("success") {
		 }.to "end"
		 on("error") {
		 }.to "enterPaymentInfo"
		 }
		 */
	}

	private boolean needRecalculateOverlappingTerritories(ArrayList<Office> offList ) {
		boolean retVal = false
		for(Office office in offList) {
			if(office.territoryZipcodes.size() > office.advertisingZipcodes.size()) {
				retVal = true;
				office.advertisingZipcodes = null;
				def advertisingZipcodes = new ArrayList<AdvertisingZipcode>()
				for (it in office.territoryZipcodes) {
					advertisingZipcodes.add(new AdvertisingZipcode(zipcode:it.toString(),
							office:office))
					//////////////////////////////////DEBUG
					Zipcode zip = Zipcode.get(it)
					advertisingZipcodes[advertisingZipcodes.size()-1].lat = zip.getLatitude()
					advertisingZipcodes[advertisingZipcodes.size()-1].lon = zip.getLongitude()
					advertisingZipcodes[advertisingZipcodes.size()-1].city = zip.getCity()
				}
				office.advertisingZipcodes = advertisingZipcodes;
			}
		}
		return retVal
	}

	private void calculateAndRemoveOverlappingTerritories(ArrayList<Office> offList ) {
		for(int i=0; i<offList.size(); i++) {
			int j = i + 1;
			Office off1 = offList[i];
			while (j < offList.size()) {
				Office off2 = offList[j];
				/*			  
				 println (off1.upperLeftLat + ':'  +off1.upperLeftLon)
				 println (off1.lowerRightLat + ':'  +off1.lowerRightLon)
				 println (off2.upperLeftLat + ':'  +off2.upperLeftLon)
				 println (off2.lowerRightLat + ':'  +off2.lowerRightLon)
				 println (off2.upperLeftLon <= off1.lowerRightLon && off2.upperLeftLon >= off1.upperLeftLon ) 
				 println (off2.lowerRightLon <= off1.lowerRightLon && off2.lowerRightLon >= off1.upperLeftLon )
				 println (off2.upperLeftLat <= off1.upperLeftLat && off2.upperLeftLat >= off1.lowerRightLat )
				 println (off2.lowerRightLat <= off1.upperLeftLat && off2.lowerRightLat >= off1.lowerRightLat )
				 */
				if (
				(
				(off2.upperLeftLon <= off1.lowerRightLon && off2.upperLeftLon >= off1.upperLeftLon )
				|| (off2.lowerRightLon <= off1.lowerRightLon && off2.lowerRightLon >= off1.upperLeftLon )
				)
				&&
				(
				(off2.upperLeftLat <= off1.upperLeftLat && off2.upperLeftLat >= off1.lowerRightLat )
				|| (off2.lowerRightLat <= off1.upperLeftLat && off2.lowerRightLat >= off1.lowerRightLat )
				)
				)	{ //if
					if(log.isDebugEnabled()) log.debug (i +':' +j +' are overlapping')
					def overlaps = off1.territoryZipcodes.intersect(off2.territoryZipcodes)
					for(String overlap in overlaps) {
						if(log.isDebugEnabled()) log.debug( 'removing overlap:' + overlap )
						off2.advertisingZipcodes.remove(new AdvertisingZipcode(zipcode:overlap))

					}

				}//if
				else
				if(log.isDebugEnabled()) log.debug  (i +':' +j +' are not overlapping')
				j++
			}
		}
	}

	private double calculateSubscriptionCost(flow ) {
		double totalPrice = 0.0;
		long numOfOffices = flow.officeInstanceList.size() as long;
		if(numOfOffices <= 0)
			return totalPrice;
		
		def pricingPlanList = ItdaAttribute.findAllWhere(name:'pricingPlanCode');
		for(pricingPlan in pricingPlanList)
			if(numOfOffices <= (pricingPlan.name2 as long))	{
				totalPrice = pricingPlan.value as double;
				break;
			}
		double pricePerOffice = totalPrice / numOfOffices;
		for(officeInstance in flow.officeInstanceList) {
			officeInstance.monthlySubscriptionPrice = pricePerOffice;
		}
		flow.totalPrice = totalPrice;
		return totalPrice;
	}

	boolean persistRegistrationtData(Business biz, SignupForm form, Payment payment) {
		boolean savedData =false, createdAcct = false;
		try {
			def loginAcct = new Username(login:form.login, business:biz)
			def loginAcctList =  new ArrayList();
			loginAcctList.add(loginAcct);
			biz.usernames = loginAcctList
			////////1 saving business Data
			savedData = biz.save(flush:true);
			//println("saved registration data for ${biz.email}" )
			if (savedData && log.isDebugEnabled()) log.debug("saved registration data for ${biz.email} is ${savedData}" )

			if (!savedData) {
				log.warn loginAcctList;
				log.warn "Could not save biz data";
				for ( it in biz.errors.allErrors ) {
					log.warn it
				}
			}

		} catch (Exception e) {
			log.error("Error occurred while saving registration data: ", e)
			log.error((new JSON(biz)).toString(true))
		}
		try {
			///////////2 create login account
			createdAcct = createAccount(form);
			if (log.isDebugEnabled()) log.info("created login for ${form.login}" )
		} catch (Exception e) {
			log.error("Error occurred while creating login: ", e)
			log.error((new JSON(form)).toString(true))
		}

		try {
			if( savedData && createdAcct ) {
				sendWelcomeToItdaEmail(form.login, form.password, biz.email)
				sendOrderReceiptEmail(biz.offices, biz, payment)
				/*				String sender = message(code:"inthedoor.email.customerService");
				 asynchronousMailService.sendAsynchronousMail {
				 // Mail parameters
				 to biz.email
				 from sender
				 bcc message(code:"inthedoor.email.customerService")
				 subject 'Receipt For Your Order';
				 html '<body>Your username is ' + form.login + ' and your password is ' +
				 form.password + ' . Please log into http://itda.ondemand1.com to setup your account.</body>';
				 //attachBytes 'test.txt', 'text/plain', byteBuffer;
				 // Additional asynchronous parameters (optional) beginDate new Date(System.currentTimeMillis()+60000) // Starts after one minute, default current date endDate new Date(System.currentTimeMillis()+3600000) // Must be sent in one hour, default infinity maxAttemptsCount 3; // Max 3 attempts to send, default 1 attemptInterval 300000; // Minimum five minutes between attempts, default 300000 ms }		
				 }
				 */				return true;
			} else {
				//TODO
				// Send email to admin
				return false;
			}
		}catch (Exception e) {
			//TODO send synch mail
			log.error("Error occurred while sending email to ${biz.email}: ", e)

		}

	}

	private sendTerritoryConflictContactEmail(ArrayList<Office> officeList, CommentCommand cmd, String sender ) {
/*
		asynchronousMailService.sendAsynchronousMail {
			// Mail parameters
			to message(code:"inthedoor.email.territoryConflict");
			from sender
			subject 'Territory Conflict Contact Request'
			//html '<body>this is  test email</body> '
			body( view:"/registration/newRegistration/conflictContactEmail", model:[commentCommand:cmd, officeInstanceList:officeList]);
		}
*/
	}

	public sendWelcomeToItdaEmail( String username, String password, String email ) {
		String sender = message(code:"inthedoor.email.customerService");
		asynchronousMailService.sendAsynchronousMail {
			to email
			from sender
			subject 'Welcome to In the Door Advertising - Login details'
			body( view:"/registration/newRegistration/welcomeToItdaEmail",
					model:[username:username, password:password]);
		}
	}

	public sendOrderReceiptEmail( officeList, Business business, Payment payment ) {
		String sender = message(code:"inthedoor.email.customerService");
		asynchronousMailService.sendAsynchronousMail {
			to business.email
			from sender
			subject 'Your receipt # ' + payment.id
			body( view:"/registration/newRegistration/orderReceiptEmail",
					model:[businessInstance:business, paymentInstance:payment, officeInstanceList:officeList]);
		}
	}


	public static HashMap calculateOfficeGeoProfile (Office officeInstance, String key) {
		def geocoder = new GoogleGeocoder()
		def address = officeInstance.prettyPrintAddress()
		//def key = "ABQIAAAAWWWeHSSigDBANMd68WG4vBSi5MZNmHO4gmd_pR0hfPGnCjBUcBTtXfFoEh_ACa7ueqcbyQwtNJnCcw"//messageSource.message(code:"google.map.key")
		def googleGeocodeResult = geocoder.geocode(address, key)
		if(log.isDebugEnabled()) { log.debug( googleGeocodeResult as String ) }
		if(googleGeocodeResult[0] == GoogleGeocoder.G_GEO_SUCCESS)   {
			if(googleGeocodeResult[1].toInteger() < GoogleGeocoder.G_ACCURACY_LEVEL_POSTAL_CODE) {
				return [result:1, errorMessage:geocoder.getErrorMessageProp(googleGeocodeResult[0])] // need more accurate address
			}
			officeInstance.lat = new Double(googleGeocodeResult[2])
			officeInstance.lon = new Double(googleGeocodeResult[3])
			officeInstance.accuracyLevel = googleGeocodeResult[1].toInteger()
			def bbc = new BoundingBoxCalculator(googleGeocodeResult[2] as double,
					googleGeocodeResult[3] as double,
					(/*message(code:"inthedoor.office.radius")*/10 as int) * BoundingBoxCalculator.METERS_PER_MILE)
			def coord = bbc.calculateUpperLeftCoordinate()
			officeInstance.upperLeftLat = coord[0]
			officeInstance.upperLeftLon = coord[1]
			coord = bbc.calculateLowerRightCoordinate()
			officeInstance.lowerRightLat = coord[0]
			officeInstance.lowerRightLon = coord[1]
			def zipcodes = Office.query(officeInstance)
			//officeInstance.availability = AdvertisingZipcode.availabilityQuery(zipcodes)
			officeInstance.availability = 'true'
			//		   if(officeInstance.availability == 'true') {
			ArrayList adZipcodes = new ArrayList<AdvertisingZipcode>()
			ArrayList terrZipcodes = new ArrayList<String>()
			//zipcodes.each {
			for(it in zipcodes) {
				String zipcode =it.toString();
				terrZipcodes.add(zipcode)
				if(officeInstance.availability == 'true') {
					adZipcodes.add(new AdvertisingZipcode(zipcode:zipcode,	office:officeInstance))
					//////////////////////////////////
					Zipcode zip = Zipcode.findWhere(id:zipcode);
					adZipcodes[adZipcodes.size()-1].lat = zip.getLatitude()
					adZipcodes[adZipcodes.size()-1].lon = zip.getLongitude()
					adZipcodes[adZipcodes.size()-1].city = zip.getCity()
				}
			}
			officeInstance.advertisingZipcodes = adZipcodes
			officeInstance.territoryZipcodes = terrZipcodes
			return [result:0, errorMessage:geocoder.getErrorMessageProp(googleGeocodeResult[0])] //success
		}// success
		return [result:2, errorMessage:geocoder.getErrorMessageProp(googleGeocodeResult[0])] //unsuccessful
	}

	public sendResetPasswordEmail( String password, String email ) {
		String sender = message(code:"inthedoor.email.customerService");
		asynchronousMailService.sendAsynchronousMail {
			to email
			from sender
			subject 'Reset Password Request'
			body( view:"/registration/resetPasswordEmail",
					model:[password:password]);
		}
	}

	private boolean createAccount ( SignupForm form ) {

		def signupResult = authenticationService.signup( login:form.login,
				password:form.password, email:form.email, immediate:false, extraParams:[:])
		if ((signupResult.result == 0) || (signupResult.result == AuthenticatedUser.AWAITING_CONFIRMATION)) {
			if (signupResult == AuthenticatedUser.AWAITING_CONFIRMATION) {
				//log.info("Signup succeeded pending payment confirmation for [${form.login}] / [${form.email}]")
			} else {
				//log.info("Signup succeeded for [${form.login}]")
			}

			return true; //succeeded
		} else {
			//flash.authenticationFailure = signupResult
			//flash.signupForm = form
			//if (log.isDebugEnabled) log.debug("Signup failed for [${form.login}] reason ${signupResult.result}")
			return false;
		}
	}

	/*		
	 private boolean hasConflict (flow ) {
	 if(flow.officeInstanceList)
	 for(office in flow.officeInstanceList)
	 if(office.availability == 'false')
	 return true;
	 return false;
	 }
	 */		

	private static final Log log = LogFactory.getLog(RegistrationController.class);

	/*	def email = {
	 render( view:"/registration/newRegistration/orderReceiptEmail", 
	 model:[businessInstance:Business.get(56), 
	 paymentInstance:Payment.get(22), 
	 officeInstanceList:Office.findAll("from Office o where o.id in (59, 46)")]);
	 }
	 def email2 = {
	 sendWelcomeToItdaEmail( "eric001", 
	 "password001", 
	 "ericdho@gmail.com");
	 render "done"
	 }	
	 */	 	

}
