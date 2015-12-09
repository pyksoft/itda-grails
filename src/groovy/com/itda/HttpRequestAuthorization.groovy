package com.itda

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory; 

class HttpRequestAuthorization {
	private static final Log log = LogFactory.getLog(RegistrationController.class);

	//controller: "portfolioEntry", 
	//action: "(uploadJpg|uploadPdf|uploadZip)") { 
	//if(request.getHeader('user-agent') == 'Shockwave Flash') {
		//UserSession sess = UserSession.findBySessionId(params.token)  
		//if(sess && ["itdaweb.admin", "portfolio.admin"].isCase(sess.getLogin()))

	//controller: "portfolio", 
	//action: "(upload*)") { 
	//if(request.getHeader('user-agent') == 'Shockwave Flash') {
		//UserSession sess = UserSession.findBySessionId(params.token)  
		//if(sess && ["itdaweb.admin", "portfolio.admin"].isCase(sess.getLogin())) {	
	public static authorizePortfolioAccess (params) { // call from bootstrap on authorize call back method
		def request = params.request
		if(params.controllerName.startsWith('portfolio')) {
			if(params.user.login == "itdaweb.admin" || params.user.login == "eportfolio.admin")
				return true;
			else if(params.actionName.startsWith('upload') && request.getHeader('user-agent') == 'Shockwave Flash') {
				UserSession sess = UserSession.findBySessionId(request.getParameter("token"))  
				if(sess && ["itdaweb.admin", "eportfolio.admin"].isCase(sess.getLogin()))
					return true
			}
			//else if(/*params.actionName.startsWith("get") ||*/
			//		params.actionName == "current" ||
			//		params.actionName == "ePortfolio" ||
			//		params.actionName == "backContentImage" ||
			//		params.actionName == "frontCoverImage" ||
			//		params.actionName == "spineImage" /*||
			//		params.actionName == "listActivePortfolioEntries"*/)
			//	return true; //need to check user is current

			//log.debug "return false"
			log.warn "Access denied : " + params.dump()
			log.warn("authorizePortfolioAccess " + params.user.login)
			params.userlogin = params.user.login
			log.warn("authorizePortfolioAccess " + request.getHeader('user-agent'))
			log.warn("authorizePortfolioAccess " + params.request.getSession().getId())
			return false
		}		
	}
	
	public static authorizeAccountSetupAccess (params) { // call from bootstrap on authorize call back method
			if(params.user.login != "itdaweb.admin" && params.user.login != "eportfolio.admin")
				return true;
			params.userlogin = params.user.login
			log.warn "Access denied : " + params.dump()
			return false
	}
	
	public static authorizeAdminAccess (params) { // call from bootstrap on authorize call back method
		if(params.user.login == "itdaweb.admin")
			return true;
		params.userlogin = params.user.login
		log.warn "Access denied : " + params.dump()
		return false;
	}
	
	public static authorizeUserAccess (params) { // call from bootstrap on authorize call back method
		return true; //
	}	

	public static authorizePlannerAccess (params) { // call from bootstrap on authorize call back method
		//println(params.actionName)
		if(params.controllerName.startsWith('plannerEntry')) {
			if(params.user.login == "itdaweb.admin")
				return true;
			else if( !params.actionName  
					|| params.actionName == "getDetail"
					|| params.actionName.endsWith( "4User") )
				return true; //need to check user is current
			else {
				params.userlogin = params.user.login
				log.warn "Access denied : " + params.dump()
				return false
			}
		}		
	}
	
}
