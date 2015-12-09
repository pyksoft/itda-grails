package com.itda

//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;

//import com.grailsrocks.authentication.AuthenticationUser
import com.ondemand1.util.PassPhrase;
import javax.servlet.http.Cookie;
class HelperController {

	def authenticationService
//	def asynchronousMailService

	def error = { render(view: '/index') }
	
	def login = { 
			if (params.login && params.password) {
				if (authenticationService.sessionUser)
					authenticationService.logout( authenticationService.sessionUser )
				
				def loginResult = authenticationService.login( params.login, params.password)
				if (loginResult.result == 0) {
					if (log.debugEnabled) 
						log.debug("Login succeeded for " +params.login)
					def bizId = authenticationService.getSessionUser().attributes['businessId']; //set in onloggedin event handler
					def login = authenticationService.getSessionUser().login;
					def ses = new UserSession(login:login, loginTime: new Date(), 
							loggedIn:true, businessId:bizId, sessionId:session.getId());
					if(!ses.save(flush:true))
						ses.errors.each { 
							log.error(it);
						}
					if( login == message(code:'inthedoor.admin.user') || login == message(code:'eportfolio.admin.user')) {
						//publicationInstanceList =  Publication.list( [:] )
						redirect(controller:"portfolio", action:"list");
					} else {
						def user = Username.findWhere(login:login);
						def setting = ItdaSettings.findWhere(['username.id': user.id]);
						checkItdaSettings(setting, request, response);
						def count = UserSession.sessionCount(login)
						if(log.isDebugEnabled()) {
							log.debug "login count $count $flash.authSuccessURL"
						}
						redirect(flash.authSuccessURL ? flash.authSuccessURL : [uri:'/myPlanner'])
					}
				} else {                  
					flash.login = params.login
					flash.authenticationFailure = loginResult
					//if (log.debugEnabled) 
					//log.warn("Login failed for " + params.login + " - reason: " + loginResult.result)
					println("Login failed for " + params.login + " - reason: " + loginResult.result)
					redirect(flash.authFailureURL ? flash.authFailureURL : [uri:'/login.gsp'])
				}
			} else {
				def xReqWith = request.getHeader('X-Requested-With');
				def accept = request.getHeader('Accept'); 
				println('xReqWith ' + xReqWith  +  'accept ' +accept);
				if( xReqWith && accept && xReqWith == 'XMLHttpRequest' && accept.indexOf("json") > 0){
					response.status = 401;
					return;
				}
				flash.login = params.login
				flash.message = "Login/Signup to access requested resource."
				redirect(flash.authErrorURL ? flash.authErrorURL : [uri:'/login.gsp'])
			}
		}
	
	private void checkItdaSettings(setting, request, response){
		if(setting == null || setting.reportPopup == null){
			def c = new Cookie('reportPopup', '1');
			c.maxAge = -1;
			c.path = '/myReport';
			response.addCookie(c)
		}		
		if(setting == null || setting.trackerExpensePopup == null){
			def c = new Cookie('trackerExpensePopup', '1');
			c.maxAge = -1;
			c.path = '/myTracker';
			response.addCookie(c)
		}
		if (setting == null || setting.trackerSalePopup == null){
			def c = new Cookie('trackerSalePopup', '1');
			c.maxAge = -1;
			c.path = '/myTracker';
			response.addCookie(c)
		}
		if (setting == null || setting.trackerResultPopup == null){
			def c = new Cookie('trackerResultPopup', '1');
			c.maxAge = -1;
			c.path = '/myTracker';
			response.addCookie(c)
		}
		if (setting == null || setting.trackerCompetitionPopup == null){
			def c = new Cookie('trackerCompetitionPopup', '1');
			c.maxAge = -1;
			c.path = '/myTracker';
			response.addCookie(c)
		}
		if (setting == null || setting.trackerDetailPopup == null){
			def c = new Cookie('trackerDetailPopup', '1');
			c.maxAge = -1;
			c.path = '/myTracker';
			response.addCookie(c)
		}		
		if (setting == null || setting.plannerDetailPopup == null){
			def c = new Cookie('plannerDetailPopup', '1');
			c.maxAge = -1;
			c.path = '/myPlanner';
			response.addCookie(c)
		}		
		if (setting == null || setting.plannerPopup == null){
			def c = new Cookie('plannerPopup', '1');
			c.maxAge = -1;
			c.path = '/myPlanner';
			response.addCookie(c)
		}	
		if (setting == null || setting.accountCompetitorPopup == null){
			def c = new Cookie('accountCompetitorPopup', '1');
			c.maxAge = -1;
			c.path = '/accountSetup/competition';
			response.addCookie(c)
		}	
		if (setting == null || setting.accountManufacturerPopup == null){
			def c = new Cookie('accountManufacturerPopup', '1');
			c.maxAge = -1;
			c.path = '/accountSetup/manufacturers';
			response.addCookie(c)
		}	
		if (setting == null || setting.accountVendorPopup == null){
			def c = new Cookie('accountVendorPopup', '1');
			c.maxAge = -1;
			c.path = '/accountSetup/vendors';
			response.addCookie(c)
		}	
		if (setting == null || setting.accountPublicationPopup == null){
			def c = new Cookie('accountPublicationPopup', '1');
			c.maxAge = -1;
			c.path = '/accountSetup/newspapers';
			response.addCookie(c)
		}	
		
	}
	
	def logout = { 
		try {
			if (authenticationService.sessionUser)
				authenticationService.logout( authenticationService.sessionUser )
			UserSession sess = UserSession.findBySessionId(session.getId())
			if(sess) {
				sess.loggedIn = false;
				sess.logoutTime = new Date()
				if(!sess.save(flush:true))
					for (it2 in sess.errors) { log.error(it2) }
			}
			session.invalidate();
		} catch ( Exception e ){
			log.error ("error login out ", e);
		}
		redirect(flash.authSuccessURL ? flash.authSuccessURL : [uri:'/'])
	}
}
