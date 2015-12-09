import java.util.Enumeration;
import com.itda.UserSession;
class SecurityFilters {
	def filters = {
	
		// Ensure that all controllers and actions require an authenticated user,
		// except for the "public" controller
/*		debuggingFlashFilter(
			controller: "*",//for development only 
			action: "*") { 
				before = {
						println "debuggingFlashFilter return true";
					
					return true;
			}
		}

			
		portfolioEntry4FlashAdminFilter(
				controller: "(portfolio*)", 
				action: "(upload*)") { 
			before = { 
					//if(true) return true;
				println "portfolioEntry4FlashAdminFilter"
				if(request.getHeader('user-agent') == 'Shockwave Flash') {
					UserSession sess = UserSession.findBySessionId(params.token)  
					println ":" + sess.getLogin() + ":"
					if(sess && ["itdaweb.admin", "eportfolio.admin"].isCase(sess.getLogin()))
						return true
				}
				println "portfolioEntry4FlashAdminFilter checking needed";
				println request.getSession().getId() +":" +request.getHeader('user-agent') + ":" + params.token + ":" + params.token 
				
				return applicationContext.authenticationService.filterRequest( request,
							response, "${request.contextPath}/helper/login" )				 
			} 
		}
*/
		allControllers(controller: "*", action: "*") {
			before = {
				println "enter allControllers filter";
				// for debuggng flash only.
				//if ( ["myPortfolio"].isCase(controllerName) ) {
				//	println "allControllers filter returning true";
					
				//		return true
				//}

				// Exclude the "public" controller.
				if ( ["registration", "helper", "sendToVendor", null].isCase(controllerName) ) 
					return true
				
				//else if ( ("portfolio" == controllerName || "portfolioEntry" == controllerName) 
				//		   && actionName.startsWith("upload") )
				//{
				//	println "allControllers portfolio admin"
				//	return true;
				//}
				
				// This just means that the user must be authenticated. He does 
				// not need any particular role or permission. 
				println "allControllers checking needed";
				def xReqWith = request.getHeader('X-Requested-With');
				def accept = request.getHeader('Accept'); 
				if(applicationContext.authenticationService.isLoggedIn(request) == false) {
					if( xReqWith && accept && xReqWith == 'XMLHttpRequest' && accept.indexOf("json") > 0){
						response.status = 401;
						return false;
					}
					redirect(controller: 'helper', action:'login');
					return false;
				}
				//check authentication and Authorized user
				return applicationContext.authenticationService.filterRequest( request,
						response, "${request.contextPath}/helper/login" )				 
			} 
		}
				

	}
} 