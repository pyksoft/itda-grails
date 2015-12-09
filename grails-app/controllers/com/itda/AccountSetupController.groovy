package com.itda
import java.util.Calendar;
import java.util.Map;

import com.ondemand1.util.PaymentProcessor;

//import sun.rmi.runtime.Log;
import grails.converters.JSON;
//import com.grailsrocks.authentication.AuthenticatedUser;
import com.grailsrocks.authentication.AuthenticationUser;

class AccountSetupController {
	
	def authenticationService
	def asynchronousMailService	
	def messageSource
	
	def myAccount = { forward(action:'contactInfo');}
	
	def usernamepassword = {
		def login = authenticationService.getSessionUser().login
		if( params.newPassword || params.confirmNewPassword || params.password) { 
			params.username = login //helps determines which view to render
			forward (action:'changePassword')
		} else if( params.newUsername) {
			changeUsername(flash, params)
		}
		[username:login]
			
		
	}
	def paymentInfo = {
		    println params;
			long bizId = authenticationService.getSessionUser().attributes['businessId'] ;
			/*Subscription
			Payment payInfo = Payment.findWhere(['business.id': bizId]);
			def msg;
			Map results;
			if(params.firstName != null){
				params.remove('business.id');
				params.remove('id');
				params.remove('date_created');
				payInfo.properties = params;
				
				if(payInfo.validate()) {
					def subId = payInfo.getSubscriptionId();
					if( subId == null || subId == "")
						results = createPaymentSubscription (payInfo, Business.findWhere([id:bizId]));
					else
						results = updatePaymentSubscription(payInfo, Business.findWhere([id:bizId]));
					println(results);
					boolean success = "Ok".equals(results.get("result_code"));
					if(success && payInfo.save(flush:true))
						flash.message = msg = 'Update completed.';
					else {
						if(! success)
							for(String key in results.keySet() )
								if(key.startsWith("E00") && key != "E00018") {
									payInfo.errors.reject("payment.subscription.update.failed", 
					    	    			[""] as Object[], 
					    	    			results[key]);
								}
							
						flash.message = msg = 'Update failed.';
					}
				} else {
					msg = 'Update failed.';
				}
			} 
			*/
			
			PaymentInfo payInfo = PaymentInfo.findWhere(['business.id': bizId]);
			def msg;
			if(params.firstName != null){
				params.remove('business.id');
				params.remove('id');
				params.remove('date_created');
				payInfo.properties = params;			
					if(payInfo.save(flush:true))
						flash.message = msg = 'Update completed.';
					else
						flash.message = msg = 'Update failed.';
			}		
			if(request.xhr) {
	        	def errMsgs = [];
				if(msg == 'Update failed.') {
		    		for(err in payInfo.errors.allErrors) 
		    			errMsgs.push messageSource.getMessage(err, null) ;	
				}
				if(msg == null) msg = 'Update completed.';
		        def resp = [respText:msg, errors: errMsgs];			
	            render resp as JSON;	
	            return;
			}
			[paymentInstance: payInfo]				
	}
	
	def subscriptionHistory = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
			   params.max = 10 //for paginate tag
			   params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
			   ////////////////////////////////
			  def c = Payment.createCriteria()
			  def payments = c.list(max:params.max, offset:params.offset, sort: 'id', order:'desc') {
			      //and {
			          eq("business.id", bizId)
			        //  eq("availability", "true")
			      //}
			  }                                                                        
			  //println('results count ' + offs.getTotalCount())
			  [paymentInstanceList:payments]
			
	}
	
	def contactInfo = {	
		def bizId = authenticationService.getSessionUser().attributes['businessId'] ;
		def biz = Business.get(bizId);
		def msg ;
		println params;
		if(params.email){
			if(params.email == biz.email || params.email == params.confirmEmail){
				params.id =  bizId
				biz.properties = params
				if(biz.save(flush:true))
					flash.message = msg = 'Update completed.';
				
				else
				    flash.message = msg = 'Update failed.';
						
			}else if (params.email != params.confirmEmail) {
			   // biz.errors.rejectValue('email',                          
			     //                       'business.email.doesnotmatch')
			   //flash.message = 'Email addresses do not match'
				msg = 'Update failed.';
				biz.errors.reject("business.email.mismatch", [""] as Object[],
	    		   "New emails do not match.")
			}
			
		} 
		if(request.xhr) {
        	def errMsgs = [];
			if(msg == 'Update failed.') {
	    		for(err in biz.errors.allErrors) 
	    			errMsgs.push messageSource.getMessage(err, null) ;	
			}
			if(msg == null) msg = 'Update completed.';
	        def resp = [respText:msg, errors: errMsgs];			
            render resp as JSON;	
            return;
		}
		[businessInstance: biz]		
	}

	def territory = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'];
		def biz = Business.findWhere([id:bizId]);
        def offices = Office.findAll("from Office as o where o.business.id=:bizId and o.availability = 'true'",[bizId: bizId])
		[officeInstanceList:offices, biz:biz];
		
	}
	
	def offices = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
        params.max = 5 //for paginate tag
        params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
 		////////////////////////////////
		def c = Office.createCriteria()
		def offs = c.list(max:5, offset:params.offset, sort: 'id', order:'asc') {
		    and {
		        eq("business.id", bizId)
		        eq("availability", "true")
				isNull("deleted")
		    }
		}                                                                        
		//println('results count ' + offs.getTotalCount())
		[officeInstanceList:offs, offset:params.offset]
	}
	
	def deleteOffice = {
		def bizId = authenticationService.getSessionUser().attributes['businessId']  as long;
		def office = Office.findWhere(id: params.id as long, 'business.id':bizId);

		def msg;
		if (office) {
			def plannerCount =  PlannerEntry.executeQuery("""select count(id) FROM PlannerEntry  where office.id = ? """, office.id);
			if(plannerCount[0] > 0)
				office.deleted = true;
			else
				office.availability = 'false';
			try {
				office.save(flush: true)
				msg = 'Delete completed.'
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				msg = 'Delete failed.'
			}
		}
		else {
				msg = 'Delete failed.'
		}
		
        	def errMsgs = [];
			if(msg == 'Delete failed.') {
	    		for(err in vendorInstance.errors.allErrors) 
	    			errMsgs.push messageSource.getMessage(err, null) ;	
			}
	        def resp = [respText:msg, errors: errMsgs];			
            render resp as JSON;	
	}
	
	def saveOffice = {
			params['business.id'] = authenticationService.getSessionUser().attributes['businessId'] ;
	        def officeInstance = new Office(params)
	        if(!officeInstance.validate()) {
				renderErrorsAsJson(officeInstance);
	            //render(view:'addOffice',model:[officeInstance:officeInstance])
	            return ;
	        }
	        def result = RegistrationController.calculateOfficeGeoProfile(officeInstance, message(code:"google.map.key"))
	        if(result[0] > 0) {  // there is an issue with the office address
	        	if(result[0] == 1) 
	    	    	officeInstance.errors.reject("office.location.accuracy.level", 
	    	    			[""] as Object[], 
	    	    			"An accurate enough geo-location is not available for the specified address. Please enter a different address.")
	    	    else 
	 	  	       officeInstance.errors.reject("office.location.geocode.failed", [""] as Object[],
	 	  	    		   "The server encountered an error.")
	        }  else {//if (params.create){  // do we need to save the office location
	        	//if(officeInstance.availability == 'false'){
			  	//       officeInstance.errors.reject("office.location.conflict", [""] as Object[],
		    //		   "This area is currently unavailable.")        	
		    		   //return;
	        	//}
				officeInstance.availability = 'true';
	        	if(officeInstance.save()) {
		            def resp = ["respText":'Save completed.'];
		            render resp as JSON;	    		  
		            return
	        	} else {
		  	       officeInstance.errors.reject("office.location.create.failed", [""] as Object[],
		    		   "The server encountered an error.")        	
					renderErrorsAsJson(officeInstance);
		            return ;
	        	}
	        } 
		}
	
	def editOffice = {
		def bizId = authenticationService.getSessionUser().attributes['businessId']  as long;
		def office = Office.findWhere(id: params.id as long, 'business.id':bizId);
		if(request.xhr){
			render(template:"office_templ",model:[office:office], contentType:"text/json");
			//render office as JSON;
			return;
		}
		forward(action:'offices');
	}	
	
def updateOffice = {
		def bizId = authenticationService.getSessionUser().attributes['businessId']  as long;
		def office = Office.findWhere(id: params.id as long, 'business.id':bizId);
		if (office) {
			params.remove('business.id');
			office.properties = params
			if (!office.hasErrors() && office.save(flush: true)) {
				//flash.message = "${message(code: 'default.updated.message', args: [message(code: 'office.label', default: 'Office'), office])}";
				if(request.xhr){
					render(template:"office_templ",model:[office:office], contentType:"text/json");
					return;
				}
			}
			else {
				if(request.xhr){
					renderErrorsAsJson(office);
					return;
				}
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'office.label', default: 'Office'), params.id])}";
			if(request.xhr){
				render(template:"vendor_templ",model:[office:vendorInstance], contentType:"text/json");
				return;
			}
			
				forward(action:'offices');
				return;
		}
	}
	
	def newspapers = {
		if(!params.edit && !params.add){
			def bizId = authenticationService.getSessionUser().attributes['businessId'] 
			    params.max = 5 //for paginate tag
			    params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
	            ////////////////////////////////
	            def c = Publication.createCriteria()
	            def pubs = c.list(max:5, offset:params.offset, sort: 'id', order:'asc') {
	                	eq("business.id", bizId)
	                	isNull("deleted")
	             }  
			[publicationInstanceList:pubs]
		}else if(params.edit == 'true' && flash.publicationInstance){
			[publicationInstance:flash.publicationInstance, edit:'true']
		}else if(params.add == 'true' && params.token == actionName){
			[publicationInstance:new Publication(), add:'true']
		}else 
			response.status = 404;
	}
	
	def vendors = {
		if(!params.edit && !params.add ){
			def bizId = authenticationService.getSessionUser().attributes['businessId'] 
			    params.max = 5 //for paginate tag
			    params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
	            ////////////////////////////////
	            def c = Vendor.createCriteria()
	            def pubs = c.list(max:5, offset:params.offset, sort: 'id', order:'asc') {
	                	eq("business.id", bizId)
						isNull("deleted")
	             }  
			[vendorInstanceList:pubs]
		}else if(params.edit == 'true' && flash.vendorInstance){
			[vendorInstance:flash.vendorInstance, edit:'true']
		}else if(params.add == 'true' && params.token == actionName){
			[vendorInstance:new Vendor(), add:'true']
		}else 
			response.status = 404;			
	}
	def manufacturers = {
		if(!params.edit && !params.add){
			def bizId = authenticationService.getSessionUser().attributes['businessId'] 
			    params.max = 5 //for paginate tag
			    params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
	            ////////////////////////////////
	            def c = Manufacturer.createCriteria()
	            def pubs = c.list(max:5, offset:params.offset, sort: 'id', order:'asc') {
	                	eq("business.id", bizId)
						isNull("deleted")
	             }  
			[manufacturerInstanceList:pubs]
		}else if(params.edit == 'true' && flash.manufacturerInstance){
			[manufacturerInstance:flash.manufacturerInstance, edit:'true']
		}else if(params.add == 'true' && params.token == actionName){
			[manufacturerInstance:new Manufacturer(), add:'true']
		}else 
			response.status = 404;				
	}
	def competition = {
		if(!params.edit && !params.add ){
			def bizId = authenticationService.getSessionUser().attributes['businessId'] 
			    params.max = 5 //for paginate tag
			    params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
	            ////////////////////////////////
	            def c = Competitor.createCriteria()
	            def pubs = c.list(max:5, offset:params.offset, sort: 'id', order:'asc') {
	                	eq("business.id", bizId)
	                	isNull("deleted")
	             }  
			[competitorInstanceList:pubs]
		}else if(params.edit == 'true' && flash.competitorInstance){
			[competitorInstance:flash.competitorInstance, edit:'true']
		}else if(params.add == 'true' && params.token == actionName){
			[competitorInstance:new Competitor(), add:'true']
		}else 
			response.status = 404;				
	}
/*	
	def planner = {
		response.contentType = "text/javascript; charset=UTF-8"
		//response.setHeader('Access-Control-Allow-Origin', '*');
		//response.setHeader('x-frame-options', 'SAMEORIGIN');
		//response.setHeader('X-Content-Type-Options', 'nosniff');
		//response.setHeader('X-XSS-Protection', '1; mode=block');
		
			// return file as stream //
			println params
			//response << params.callback
			java.io.InputStream is = 
				session.getServletContext().getResourceAsStream("/WEB-INF/" + params.id +'.js')
				
			response << params.callback  + is.text
			//org.apache.commons.io.IOUtils.copy(is,response.outputStream)
			//println ("done reading file " + message(code:"inthedoor.portfolio.root.dir") + result)	
			if(! response.isCommitted())
				response.flushBuffer()		
			
	}
*/	
	def changePassword = { // make sure user is changing his password
			println (params)
			if( !params.newPassword && !params.confirmNewPassword && !params.password) 
			{
				if(params.frag)
					render(view: "changePasswordFrag")
			}
			else if( params.newPassword != params.confirmNewPassword ) {
				flash.passwordsMismatch = "New passwords do not match"
					if(params.username)
						render(view: "usernamepassword", model:[username:params.username])
					if(params.frag)
						render(view: "changePasswordFrag")				
				return;
			} else if( params.newPassword.length() < 8 ) {
				flash.passwordShort = "New password must be at least 8 characters"
				if(params.username)
					render(view: "usernamepassword", model:[username:params.username])
				if(params.frag)
					render(view: "changePasswordFrag")
				return;
			}
			
			AuthenticationUser acct = 
				authenticationService.getUserPrincipal() as  AuthenticationUser
							
			if (acct) {
				if( acct.password !=  authenticationService.encodePassword(params.password) ) {
					flash.passwordsMismatch = "Password is incorrect"
					if(params.username)
						render(view: "usernamepassword", model:[username:params.username])
					if(params.frag)
							render(view: "changePasswordFrag")
					return;
				}
				
				acct.password = authenticationService.encodePassword(params.newPassword)
				if(acct.save(flush:true)) {
					flash.message = "Your password has been changed"
				} else
					flash.generalError = message(code:"general.error");	
					log.warn "Attempt to change password of null account"
				} 	
			if(params.username)
				render(view: "usernamepassword", model:[username:acct.login])
			if(params.frag)
				render(view: "changePasswordFrag")
		}
	
    def index = {/*view only*/ 
	}
		
	def savePublication = {
		println params;
		if(params.id)
			forward(action:"updatePublication");
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
		params['business.id'] = bizId;
		def publicationInstance = new Publication(params)
		if (publicationInstance.save(flush: true)) {
			if(request.xhr) {
		        def resp = [respText:'Update completed.'];			
	            render resp as JSON;	
	            return;
			}			
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listPublication' == params.token)
				render(view: "listPublication",  model: [publicationInstanceList: Publication.listPub (bizId as long)])		
			//else if ('newspapers' == params.token) {
				//forward(action: "newspapers")
			//}
		} else {
			if(request.xhr) {
				renderErrorsAsJson(publicationInstance);	
	            return;
			}		
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listPublication' == params.token)
				render(view: "listPublication", 
						model: [publicationInstance: publicationInstance, 
	                 			publicationInstanceList: Publication.listPub (bizId as long)])		
			//else if ('newspapers' == params.token) {
			//		render(view: "newspapers", 
			//				model: [publicationInstance: publicationInstance, 
			//				        token:'newspapers', add:'true'])		
			//}
		}
	}

	private renderErrorsAsJson(domainObject) {
    	def errMsgs = [];
    	for(err in domainObject.errors.allErrors) 
    			errMsgs.push messageSource.getMessage(err, null) ;	
        def resp = [respText:'Update failed.', errors: errMsgs];			
        render resp as JSON;		
	}
	
	def listPublication = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
        params.max = 5 //for paginate tag
        params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
 		////////////////////////////////
		def c = Publication.createCriteria()
		def vendors = c.list(max:5, offset:params.offset, sort: 'id', order:'asc') {
		    and {
		        eq("business.id", bizId)
				isNull("deleted")
		    }
		}
		[publicationInstanceList:vendors];                                                                     
	}

	def editPublication = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
		def publicationInstance = Publication.editPub( bizId  as long, params.id as long)
		if(request.xhr){
				render(template:"newspaper_templ",model:[pub:publicationInstance], contentType:"text/json");
				return;
		}
		if (!publicationInstance) {
			flash.message = "${message(code: 'default.not.found.message')}"
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listPublication' == params.token)
				render(view: "listPublication",  model: [publicationInstanceList: Publication.listPub (bizId as long)])		
			//else if ('newspapers' == params.token)
				//forward(action: "newspapers")					
		}
		else {
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listPublication' == params.token)
				render(view: "listPublication",  model: [publicationInstance: publicationInstance, 
				         publicationInstanceList: Publication.listPub (bizId as long), edit:'true'])
			//else if ('newspapers' == params.token) {
			//	flash.publicationInstance = publicationInstance
			//	forward(action: "newspapers", params:[id:params.id, edit:'true'])
			//}
		}
				
	}
	
	def updatePublication = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
		def publicationInstance = Publication.editPub(bizId  as long, params.id as long);
		params.remove('business.id');
		if (publicationInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (publicationInstance.version > version) {
					publicationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'publication.label', default: 'Publication')] as Object[], "Your edit was not saved. The Publication data you editing editing is out of date. Please try again.")
					if(request.xhr){
						renderErrorsAsJson(publicationInstance);
						return;
					}
					//must not render view/forward to action params.token for security reason;check that params.token is valid value
					//if('listPublication' == params.token) {
						render(view: "listPublication",  model: [publicationInstance: publicationInstance, 
							                             			publicationInstanceList: Publication.listPub (bizId as long), 
							                             			edit:'true'])		
					//}else {//if ('newspapers' == params.token) {
						//forward(action: "newspapers", params:[id:params.id, edit:'true'])	
					//	renderErrorsAsJson(publicationInstance);
					//}						
					return
				}
			}
			params.remove('business.id');
			publicationInstance.properties = params
			if (!publicationInstance.hasErrors() && publicationInstance.save(flush: true)) {
				//must not render view/forward to action params.token for security reason;check that params.token is valid value
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'publication.label', default: 'Publication'), publicationInstance.id])}";
				if(request.xhr){
					render(template:"newspaper_templ",model:[pub:publicationInstance], contentType:"text/json");
					return;
				}
			
//				if('listPublication' == params.token) {
					render(view: "listPublication",  
								model: [publicationInstanceList: Publication.listPub (bizId as long)]);
					return;
//				}else {//if ('newspapers' == params.token) {
					//forward(action: "newspapers")	
	//				render(template:"newspaper_templ",model:[pub:publicationInstance], contentType:"text/json");
	//			}						
			}
			else {						        
				//must not render view/forward to action params.token for security reason;check that params.token is valid value
				if(request.xhr){
					renderErrorsAsJson(publicationInstance);
					return;
				}
//				if('listPublication' == params.token)
					render(view: "listPublication",  
						model: [publicationInstance: publicationInstance,
						        publicationInstanceList: Publication.listPub (bizId as long)],edit:'true');
					return;
//				else {//if ('newspapers' == params.token) {
					//flash.publicationInstance = publicationInstance
					//forward(action: "newspapers", params:[id:params.id, edit:'true'])	
//					renderErrorsAsJson(publicationInstance);
//				}
			}
		} else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}";
			if(request.xhr){
				render(template:"newspaper_templ",model:[pub:publicationInstance], contentType:"text/json");
				return;
			}
			
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
//			if('listPublication' == params.token) {
					render(view: "listPublication",  
								model: [publicationInstanceList: Publication.listPub (bizId as long)]);
					return;
//			}else {//if ('newspapers' == params.token) {
				//forward(action: "newspapers")
//				render(template:"newspaper_templ",model:[pub:publicationInstance], contentType:"text/json");
//			}						
		}
	}
	
	def deletePublication = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
		def publicationInstance = Publication.editPub(bizId  as long, params.id as long);
		def msg;
		if (publicationInstance) {
			
			try {
				def count =  CompetitorAd.executeQuery("""select count(id) FROM CompetitorAd  where publication.id = ? """, publicationInstance.id);
				if(count[0] == 0)
					count =  PlannerEntry.executeQuery("""select count(id) FROM PlannerEntry  where publication.id = ? """, publicationInstance.id);
				if(count[0] > 0){
					publicationInstance.deleted = true;
					publicationInstance.save(flush: true);
				}else
					publicationInstance.delete(flush: true);
					flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
					msg = 'Delete completed.'
				
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
				msg = 'Delete failed.'
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
				msg = 'Delete failed.'
		}
		
		if(request.xhr) {
        	def errMsgs = [];
			if(msg == 'Delete failed.') {
	    		for(err in publicationInstance.errors.allErrors) 
	    			errMsgs.push messageSource.getMessage(err, null) ;	
			}
	        def resp = [respText:msg, errors: errMsgs];			
            render resp as JSON;	
            return;
		}		
		render(view: "listPublication",  
				model: [publicationInstanceList: Publication.listPub (bizId as long)])	
	}

	/********************* VENDOR ****************************************************/
	def listVendor = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
        params.max = 5 //for paginate tag
        params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
 		////////////////////////////////
		def c = Vendor.createCriteria()
		def vendors = c.list(max:5, offset:params.offset, sort: 'id', order:'asc') {
		    and {
		        eq("business.id", bizId)
				isNull("deleted")
		    }
		}
		[vendorInstanceList:vendors];                                                                     
	}

	def listVendorTabFrag = {
			render(view: "listVendorTabFrag",  model: [vendorInstanceList: listOfVendors()])		
		}
		
	def saveVendor = {
		if(params.id) {
				forward(action:"updateVendor");
				return;
		}
			
		params['business.id'] = authenticationService.getSessionUser().attributes['businessId'] ;
		def vendorInstance = new Vendor(params)
		if (vendorInstance.save(flush: true)) {
			if(request.xhr) {
		        def resp = [respText:'Update completed.'];			
	            render resp as JSON;	
	            return;
			}			
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listVendor' == params.token)
				render(view: "listVendor",  model: [vendorInstanceList: listOfVendors()])		
			//else if ('vendors' == params.token) {
			//	forward(action: "vendors")
			//}
		}
		else {
			if(request.xhr) {
				renderErrorsAsJson(vendorInstance);	
	            return;
			}
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listVendor' == params.token)
				render(view: "listVendor",  model: [vendorInstance: vendorInstance, vendorInstanceList: listOfVendors()])		
			//else if ('vendors' == params.token) {
			//	render(view: "vendors",  model: [vendorInstance: vendorInstance, token:'vendors', add:'true'])		
			//}
			//flash.message = "${message(code: 'default.created.message', args: [message(code: 'vendor.label', default: 'vendor'), vendorInstance.id])}"
		}
	}
	
	def editVendor = {
		def vendorInstance = Vendor.editVendor( authenticationService.getSessionUser().attributes['businessId']  as long, params.id as long)
		if(request.xhr){
			render(template:"vendor_templ",model:[vendor:vendorInstance], contentType:"text/json");
			return;
		}

		if (!vendorInstance) {
			flash.message = "${message(code: 'default.not.found.message')}"
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listVendor' == params.token) {
				render(view: "listVendor",  model: [vendorInstanceList: listOfVendors()])		
			//}
			//else if ('vendors' == params.token) {
			//	forward(action: "vendors")
			//}
		}
		else {
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listVendor' == params.token)
				render(view: "listVendor",  model: [vendorInstance: vendorInstance, edit:'true', 
				                                    vendorInstanceList: listOfVendors()])		
			//else if ('vendors' == params.token) {
			//	flash.vendorInstance = vendorInstance
			//	forward(action: "vendors", params:[id:params.id, edit:'true'])
			//}
		}
		
	}
	
	def updateVendor = {
		def vendorInstance = Vendor.editVendor(authenticationService.getSessionUser().attributes['businessId']  as long, params.id as long)
		if (vendorInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (vendorInstance.version > version) {
					vendorInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'vendor.label', default: 'Vendor')] as Object[], "Your edit was not saved. The Vendor data you editing editing is out of date. Please try again.")
					if(request.xhr){
						renderErrorsAsJson(vendorInstance);
						return;
					}
					//must not render view/forward to action params.token for security reason;check that params.token is valid value
					//if('listVendor' == params.token) {
						render(view: "listVendor",  model: [vendorInstanceList: listOfVendors()])		
					//}else {	
						//renderErrorsAsJson(vendorInstance);
					//}						
					return;
				}
			}
			params.remove('business.id');
			vendorInstance.properties = params
			if (!vendorInstance.hasErrors() && vendorInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'vendor.label', default: 'Vendor'), vendorInstance.id])}";
				if(request.xhr){
					render(template:"vendor_templ",model:[vendor:vendorInstance], contentType:"text/json");
					return;
				}
				
				//must not render view/forward to action params.token for security reason;check that params.token is valid value
				//if('listVendor' == params.token) {
					render(view: "listVendor",  model: [vendorInstanceList: listOfVendors()]);
					return;
				//}else {//if ('vendors' == params.token) {
					//render(template:"vendor_templ",model:[vendor:vendorInstance], contentType:"text/json");
				//}	
			}
			else {
				if(request.xhr){
					renderErrorsAsJson(vendorInstance);
					return;
				}
				//must not render view/forward to action params.token for security reason;check that params.token is valid value
				//if('listVendor' == params.token) {
					render(view: "listVendor",  model: [vendorInstance: vendorInstance, edit:'true', 
					                                    vendorInstanceList: listOfVendors()]);
					return;
				//}else {//if ('vendors' == params.token) {
					//renderErrorsAsJson(vendorInstance);
				//}						
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'vendor.label', default: 'Vendor'), params.id])}";
			if(request.xhr){
				render(template:"vendor_templ",model:[vendor:vendorInstance], contentType:"text/json");
				return;
			}
			
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listVendor' == params.token) {
				render(view: "listVendor",  model: [vendorInstanceList: listOfVendors()]);
				return;
			//}else {//if ('vendors' == params.token) {
			//	render(template:"vendor_templ",model:[vendor:vendorInstance], contentType:"text/json");
			//}						
		}
	}
	
	def deleteVendor = {
		def vendorInstance = Vendor.editVendor(authenticationService.getSessionUser().attributes['businessId']  as long, params.id as long)
		def msg;
		if (vendorInstance) {
			try {
				def count =  CompetitorAd.executeQuery("""select count(id) FROM CompetitorAd  where vendor.id = ? """, vendorInstance.id);
				if(count[0] == 0)
					count =  PlannerEntry.executeQuery("""select count(id) FROM PlannerEntry  where vendor.id = ? """, vendorInstance.id);
				if(count[0] > 0){
					vendorInstance.deleted = true;
					vendorInstance.save(flush: true);
				}else
					vendorInstance.delete(flush: true);
				
					flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
					msg = 'Delete completed.'
				
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
				msg = 'Delete failed.'
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
				msg = 'Delete failed.'
		}
		
		if(request.xhr) {
        	def errMsgs = [];
			if(msg == 'Delete failed.') {
	    		for(err in vendorInstance.errors.allErrors) 
	    			errMsgs.push messageSource.getMessage(err, null) ;	
			}
	        def resp = [respText:msg, errors: errMsgs];			
            render resp as JSON;	
            return;
		}		
		render(view: "/accountSetup/listVendor",  model: [vendorInstanceList: listOfVendors()]);
			return;
	}
	
	/********************* MANUFACTURERE ****************************************************/
	def listManufacturer = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
        params.max = 5 //for paginate tag
        params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
 		////////////////////////////////
		def c = Manufacturer.createCriteria()
		def vendors = c.list(max:5, offset:params.offset, sort: 'id', order:'asc') {
		    and {
		        eq("business.id", bizId)
				isNull("deleted")
		    }
		}
		[manufacturerInstanceList:vendors];                                                                     
	}
	
	def saveManufacturer = {
		if(params.id) {
				forward(action:"updateManufacturer");
				return;
		}
			
		params['business.id'] = authenticationService.getSessionUser().attributes['businessId'] ;
		def manufacturerInstance = new Manufacturer(params)
		if (manufacturerInstance.save(flush: true)) {
			if(request.xhr) {
		        def resp = [respText:'Update completed.'];			
	            render resp as JSON;	
	            return;
			}			
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listManufacturer' == params.token)
				render(view: "listManufacturer",  model: [manufacturerInstanceList: listOfManufacturers()]);
				return;
			//else if ('manufacturers' == params.token) {
			//	forward(action: "manufacturers")
			//}
		}
		else {
			if(request.xhr) {
				renderErrorsAsJson(manufacturerInstance);	
	            return;
			}
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listManufacturer' == params.token)
				render(view: "listManufacturer",  
						model: [manufacturerInstance: manufacturerInstance,
						        manufacturerInstanceList: listOfManufacturers()]);
				return;
			//else if ('manufacturers' == params.token) {
			//	render(view: "manufacturers",  
			//			model: [manufacturerInstance: manufacturerInstance,
			//			        token:'manufacturers', add:'true'])
			//}
			//flash.message = "${message(code: 'default.created.message', args: [message(code: 'manufacturer.label', default: 'manufacturer'), manufacturerInstance.id])}"
		}
	}
	
	def editManufacturer = {
		def manufacturerInstance = Manufacturer.editManufacturer( authenticationService.getSessionUser().attributes['businessId']  as long, params.id as long)
		if(request.xhr){
			render(template:"manufacturer_templ",model:[manu:manufacturerInstance], contentType:"text/json");
			return;
		}		
		if (!manufacturerInstance) {
			flash.message = "${message(code: 'default.not.found.message')}"
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listManufacturer' == params.token)
				render(view: "listManufacturer",  model: [manufacturerInstanceList: listOfManufacturers()]);
				return;
			//else if ('manufacturers' == params.token) {
			//	forward(action: "manufacturers")
			//}			
		}
		else {
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listManufacturer' == params.token)
				render(view: "listManufacturer",  
						model: [manufacturerInstance: manufacturerInstance,
						        manufacturerInstanceList: listOfManufacturers(), edit:'true']);
				return;
			//else if ('manufacturers' == params.token) {
				//flash.manufacturerInstance = manufacturerInstance
				//forward(action: "manufacturers", params:[id:params.id, edit:'true'])
			//}
		}
	}
	
	def updateManufacturer = {
		println params;
		println authenticationService.getSessionUser().attributes['businessId'];
		def manufacturerInstance = Manufacturer.editManufacturer(authenticationService.getSessionUser().attributes['businessId']  as long, params.id as long)
		if (manufacturerInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (manufacturerInstance.version > version) {
					manufacturerInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'manufacturer.label', default: 'Manufacturer')] as Object[], "Your edit was not saved. The Manufacturer data you editing editing is out of date. Please try again.")
					if(request.xhr){
						renderErrorsAsJson(manufacturerInstance);
						return;
					}		
					//must not render view/forward to action params.token for security reason;check that params.token is valid value
					//if('listManufacturer' == params.token) {
						render(view: "listManufacturer",  model: [manufacturerInstanceList: listOfManufacturers()])
					//}else {//if ('manufacturers' == params.token) {
						//flash.manufacturerInstance = manufacturerInstance
						//forward(action: "manufacturers", params: [id:params.id, edit:'true'])	
					//}						
					return;
				}
			}
			params.remove('business.id');
			manufacturerInstance.properties = params
			if (!manufacturerInstance.hasErrors() && manufacturerInstance.save(flush: true)) {
				//must not render view/forward to action params.token for security reason;check that params.token is valid value
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'manufacturer.label', default: 'Manufacturer'), manufacturerInstance.id])}";
				println("request.xhr " + request.xhr);
				if(request.xhr){
					render(template:"manufacturer_templ",model:[manu:manufacturerInstance], contentType:"text/json");
					return;
				}		

				//if('listManufacturer' == params.token) {
					render(view: "listManufacturer",  
							model: [manufacturerInstanceList: listOfManufacturers()]);
					return;
				//}else {//if ('manufacturers' == params.token) {
					//render(template:"manufacturer_templ",model:[pub:manufacturerInstance], contentType:"text/json");
					//forward(action: "manufacturers")	
				//}						
			}
			else {
				if(request.xhr){
					renderErrorsAsJson(manufacturerInstance);
					return;
				}		
				//must not render view/forward to action params.token for security reason;check that params.token is valid value
				//if('listManufacturer' == params.token) {
					render(view: "listManufacturer",  
							model: [manufacturerInstance: manufacturerInstance,
							        manufacturerInstanceList: listOfManufacturers(), edit:'true']);
					return;
				//}else{// if ('manufacturers' == params.token) {
					//flash.manufacturerInstance = manufacturerInstance
					//forward(action: "manufacturers", params: [id:params.id, edit:'true'])	
				//}						
			}
		}else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'manufacturer.label', default: 'Manufacturer'), params.id])}";
			if(request.xhr){
				render(template:"manufacturer_templ",model:[pub:manufacturerInstance], contentType:"text/json");
				return;
			}		
			
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listManufacturer' == params.token) {
				render(view: "listManufacturer",  model: [manufacturerInstanceList: listOfManufacturers()]);
				return;
			//}else {//if ('vendors' == params.token) {
			//}						
		}
	}
	
	def deleteManufacturer = {
		def manufacturerInstance = Manufacturer.editManufacturer(authenticationService.getSessionUser().attributes['businessId']  as long, params.id as long)
		def msg;
		if (manufacturerInstance) {
			try {
				manufacturerInstance.deleted = true;
				manufacturerInstance.save(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
				msg = 'Delete completed.'
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
				msg = 'Delete failed.'
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
				msg = 'Delete failed.'
		}
		
		if(request.xhr) {
        	def errMsgs = [];
			if(msg == 'Delete failed.') {
	    		for(err in manufacturerInstance.errors.allErrors) 
	    			errMsgs.push messageSource.getMessage(err, null) ;	
			}
	        def resp = [respText:msg, errors: errMsgs];			
            render resp as JSON;	
            return;
		}		
		
		//must not render view/forward to action params.token for security reason;check that params.token is valid value
		//if('listManufacturer' == params.token)
			render(view: "listManufacturer",  model: [manufacturerInstanceList: listOfManufacturers()]);
		//else if ('manufacturers' == params.token)
			//forward(action: "manufacturers")	
	}
	
	/********************* competitor ****************************************************/
	def listCompetitor = {
		def bizId = authenticationService.getSessionUser().attributes['businessId'] 
        params.max = 5 //for paginate tag
        params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
 		////////////////////////////////
		def c = Competitor.createCriteria()
		def vendors = c.list(max:5, offset:params.offset, sort: 'id', order:'asc') {
		    and {
		        eq("business.id", bizId)
				isNull("deleted")
		    }
		}
		[competitorInstanceList:vendors];                                                                     
	}
	
	private listOfCompetitors() {
			def bizId = authenticationService.getSessionUser().attributes['businessId'] ;
			if(log.isDebugEnabled()) log.info(Competitor.listCompetitors (bizId as long).size())
			return Competitor.listCompetitors (bizId as long)
		
	}
	
	def saveCompetitor = {
		if(params.id) {
				forward(action:"updateCompetitor");
				return;
		}
			
		params['business.id'] = authenticationService.getSessionUser().attributes['businessId'] ;
		def competitorInstance = new Competitor(params)
		if (competitorInstance.save(flush: true)) {
			if(request.xhr) {
		        def resp = [respText:'Update completed.'];			
	            render resp as JSON;	
	            return;
			}			
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listCompetitor' == params.token)
				render(view: "listCompetitor",  model: [competitorInstanceList: listOfCompetitors()]);
				return;
			//else if ('competition' == params.token) {
			//	forward(action: "competition")
			//}
		} else {
			if(request.xhr) {
				renderErrorsAsJson(competitorInstance);	
	            return;
			}
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listCompetitor' == params.token)
				render(view: "listCompetitor",  model: [competitorInstance: competitorInstance,
				                                        competitorInstanceList: listOfCompetitors()]);
				return;
			//else if ('competition' == params.token) {
			//	render(view: "competition",  model: [competitorInstance: competitorInstance,
			//	                                     token:'competition', add:'true'])
			//}
		}
	}
	
	def editCompetitor = {
		def competitorInstance = Competitor.editCompetitor( authenticationService.getSessionUser().attributes['businessId']  as long, params.id as long)
		if(request.xhr){
			render(template:"competitor_templ",model:[comp:competitorInstance], contentType:"text/json");
			return;
		}		
		if (!competitorInstance) {
			flash.message = "${message(code: 'default.not.found.message')}"
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			if('listCompetitor' == params.token)
				render(view: "listCompetitor",  model: [competitorInstanceList: listOfCompetitors()])		
			else if ('competition' == params.token) {
				forward(action: "competition")
			}
		}
		else {
			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listCompetitor' == params.token)
				render(view: "listCompetitor",  model: [competitorInstance: competitorInstance, edit:'true',
				                                        competitorInstanceList: listOfCompetitors()]);
				return;
			//else if ('competition' == params.token) {
			//	flash.competitorInstance = competitorInstance
			//	forward(action: "competition", params:[id:params.id, edit:'true'])
			//}
		}		
	}
	
	def updateCompetitor = {
		def competitorInstance = Competitor.editCompetitor(authenticationService.getSessionUser().attributes['businessId']  as long, params.id as long)
		if (competitorInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (competitorInstance.version > version) {
					competitorInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'competitor.label', default: 'Competitor')] as Object[], "Your edit was not saved. The Competitor data you editing editing is out of date. Please try again.")
					if(request.xhr){
						renderErrorsAsJson(competitorInstance);
						return;
					}		
					//must not render view/forward to action params.token for security reason;check that params.token is valid value
					//if('listCompetitor' == params.token) {
						render(view: "listCompetitor",  
								model: [competitorInstanceList: listOfCompetitors()]);		
					//}else {//
					//	renderErrorsAsJson(competitorInstance);
					//}	
					return;
				}
			}
			params.remove('business.id');
			competitorInstance.properties = params
			if (!competitorInstance.hasErrors() && competitorInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'competitor.label', default: 'Competitor'), competitorInstance.id])}";
				if(request.xhr){
					render(template:"competitor_templ",model:[comp:competitorInstance], contentType:"text/json");
					return;
				}		

				//must not render view/forward to action params.token for security reason;check that params.token is valid value
				//if('listCompetitor' == params.token) {
					render(view: "listCompetitor",  
							model: [competitorInstanceList: listOfCompetitors()]);
					return;
				//}else {//if ('competition' == params.token) {}	
			}
			else {
				if(request.xhr){
					renderErrorsAsJson(competitorInstance);
					return;
				}		
				//must not render view/forward to action params.token for security reason;check that params.token is valid value
				//if('listCompetitor' == params.token) {
					render(view: "listCompetitor", model: [competitorInstanceList: listOfCompetitors(), 
					                       				competitorInstance: competitorInstance, edit:'true']);
					return;
				//}else {
				//	renderErrorsAsJson(competitorInstance);
				//}	
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'competitor.label', default: 'Competitor'), params.id])}";
			if(request.xhr){
				render(template:"competitor_templ",model:[pub:competitorInstance], contentType:"text/json");
				return;
			}		

			//must not render view/forward to action params.token for security reason;check that params.token is valid value
			//if('listManufacturer' == params.token) {
				render(view: "listCompetitor",  
						model: [competitorInstanceList: listOfCompetitors()]);
				return;
			//}	
		}
	}
	
	def deleteCompetitor = {
		def competitorInstance = Competitor.editCompetitor(authenticationService.getSessionUser().attributes['businessId']  as long, params.id as long)
		def msg;
		if (competitorInstance) {
			try {
				def count =  CompetitorAd.executeQuery("""select count(id) FROM CompetitorAd  where competitor.id = ? """, competitorInstance.id);
				if(count[0] > 0){
					competitorInstance.deleted = true;
					competitorInstance.save(flush: true)
				}else
					competitorInstance.delete(flush: true);
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
					msg = 'Delete completed.'
		
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
				msg = 'Delete failed.'
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
				msg = 'Delete failed.'
		}
		
		if(request.xhr) {
        	def errMsgs = [];
			if(msg == 'Delete failed.') {
	    		for(err in competitorInstance.errors.allErrors) 
	    			errMsgs.push messageSource.getMessage(err, null) ;	
			}
	        def resp = [respText:msg, errors: errMsgs];			
            render resp as JSON;	
            return;
		}		
		
		render(view: "listCompetitor",  model: [competitorInstanceList: listOfCompetitors()]);	
	}
		
	private changeUsername (flash, params) { 
			println (params)
			
			if( params.newUsername != params.confirmNewUsername ) {
				flash.passwordsMismatch = "New user names do not match"
			}else if( params.newUsername ==~  /.*\s+.*/ ){ 
				flash.passwordShort = "New user name must not contain any space character"
			}else if( params.newUsername.length() < 6 ) {
				flash.passwordShort = "New user name must be at least 6 characters"
			}else if('itdaweb.admin' ==  params.newUsername 
					|| 'eportfolio.admin' == params.newUsername 
					|| Username.findWhere(login:params.newUsername)
					){
				flash.passwordsMismatch = "New user name is not available"				
			}else{
				def acct = authenticationService.getUserPrincipal() as  AuthenticationUser
				def user = Username.findWhere(login:acct.login)
				def userSess = UserSession.findWhere(sessionId:session.getId())
				Username.withTransaction  { status ->
					acct.login = params.newUsername
					user.login = params.newUsername
					userSess.login = params.newUsername
				}
				if(user.login != params.newUsername) {
					flash.generalError = message(code:"general.error");	
					log.warn ("Cannot change username for " + acct.login);
				}else {
					flash.message = "Your username has been changed. Please login again."
					forward(controller:'helper', action:'logout')
				}
			}
			return false;
			//render(view: "usernamepassword", model:[username:acct.login])
	}

	def modifyZipCodesRequest = {
			def bizId = authenticationService.getSessionUser().attributes['businessId'];
			//def biz = Business.findWhere([id:bizId]);
	        def offices = Office.findAll("from Office as o where o.business.id=:bizId and o.availability = 'true'",[bizId: bizId])

		log.debug 'sending modify zip code email ' + params;
		String sender = message(code:"inthedoor.email.customerService");
		asynchronousMailService.sendAsynchronousMail {
			to sender //send to itda cs
			from sender
			subject 'Modify Zip Codes Request From ' + params.name;
			body( view:"/accountSetup/modifyZipCodesEmail", 
					model:[officeInstanceList:offices]);
		}
        def resp = [respText:"Send completed."];			
        render resp as JSON;		
	}	
	
	private Map createPaymentSubscription (Payment payInfo, Business biz) {
		def processor = new PaymentProcessor();
		def login = message(code:"authorize.net.api.login");
		def key = message(code:"authorize.net.api.key");

		Calendar cal = new GregorianCalendar();
		cal.setTimeInMillis(payInfo.getDateCreated().getTime());
		cal.add(Calendar.MONTH, 1);
		cal.add(Calendar.HOUR_OF_DAY, -10);
		long currTime = System.currentTimeMillis();
		if(cal.getTimeInMillis() < currTime) {
			cal.setTimeInMillis(currTime);
			cal.add(Calendar.HOUR_OF_DAY, 10);
		}
			
		
		String xml = processor.getCreateSubscriptionRequestText(login, key, payInfo, cal.getTime(), biz);
		HashMap map = processor.processSubcription(message(code:"authorize.net.api.url"), xml);								
		return map;
	}
	
	private Map updatePaymentSubscription (Payment payInfo, Business biz) {
		def processor = new PaymentProcessor();
		def login = message(code:"authorize.net.api.login");
		def key = message(code:"authorize.net.api.key");

		String xml = processor.getUpdateSubscriptionRequestText(login, key, payInfo, biz);
		HashMap map = processor.processSubcription(message(code:"authorize.net.api.url"), xml);
		//payInfo.notes = map.toString();
		return map;
	}
}
