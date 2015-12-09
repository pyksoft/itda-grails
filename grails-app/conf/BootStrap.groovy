import java.sql.Date;

import org.springframework.web.context.support.WebApplicationContextUtils
import com.itda.Username
import com.itda.Office
import com.itda.AdvertisingZipcode
import com.itda.PlannerEntry
import com.itda.Portfolio
import com.itda.PortfolioEntry
import com.itda.PlannerTodo
import com.itda.PlannerRepeatDate
import com.itda.Vendor
import com.itda.Result
import com.itda.Competitor
import com.itda.CompetitorAd
import com.itda.Publication
import com.itda.servlet.SessionListener;
import com.itda.UserSession;
import com.itda.Business;
import grails.converters.JSON;
/*
 * 1) register JSON marshaler 
 * 2) get application context
 * 3) register on onLoggedIn and onCheckAuthorized event handlers
 * 4) 
 
*/
class BootStrap {

     def init = { servletContext ->
		// init auth events
		def appCtx = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
		
		//def ctx=servletContext.getAttribute(ApplicationAttributes.APPLICATION_CONTEXT);
		
		//implement test on borrow
		
		def dataSource = appCtx.dataSourceUnproxied
		dataSource.setMinEvictableIdleTimeMillis(1000 * 60 * 15);
		dataSource.setTimeBetweenEvictionRunsMillis(1000 * 60 * 15);
		dataSource.setNumTestsPerEvictionRun(1);
		dataSource.setTestOnBorrow(true);
		dataSource.setTestWhileIdle(true);
		dataSource.setTestOnReturn(false);
		dataSource.setValidationQuery("SELECT 1");
		
		appCtx.authenticationService.events.onLoggedIn = { login -> 
			if (log.isInfoEnabled())
				log.info("logging in $login.login")
			//def biz = Business.businessForEmail(login.login) 
			def loginAcct = Username.findWhere(login:login.login)
			if(loginAcct)
				loginAcct = Business.findWhere(id:loginAcct.business.id)
			if(loginAcct)
			{
				login.attributes['businessId'] = loginAcct.id;
				login.attributes['promoCodeId'] = loginAcct.promoCode
				if (log.isDebugEnabled())
					log.debug("associated business is " + loginAcct.id + ":" + loginAcct.promoCode);
			}
			else if ('itdaweb.admin' != login.login && 'eportfolio.admin' != login.login) {
				if (log.isInfoEnabled())
					log.warn("associated business not found, logging out")
				appCtx.authenticationService.logout(login)
			}
		}
		
		appCtx.authenticationService.events.onCheckAuthorized = { params ->  
			boolean isDebug = log.isDebugEnabled()
			if (isDebug) {
				log.debug("onCheckAuthorized $params.user.login")
				log.debug("onCheckAuthorized $params.user.loggedIn")
				log.debug("onCheckAuthorized $params.controllerName")
				log.debug("onCheckAuthorized $params.actionName")
				log.debug("onCheckAuthorized " + params.request.getSession().getId())
			}

			if(params.controllerName.startsWith('portfolio')) {
				return com.itda.HttpRequestAuthorization.authorizePortfolioAccess(params)
			}else if(params.controllerName.startsWith('accountSetup')) {
				return com.itda.HttpRequestAuthorization.authorizeAccountSetupAccess(params)
			}else if(params.controllerName.startsWith('plannerEntry')) {
				return com.itda.HttpRequestAuthorization.authorizePlannerAccess(params)
			}else if(  params.controllerName == 'archive' 
					|| params.controllerName == 'myTracker'
					|| params.controllerName == 'myAccount'
					|| params.controllerName == 'myPortfolio'
					|| params.controllerName == 'myPlanner'
					|| params.controllerName == 'myReport'
					|| params.controllerName == 'store'					
					) {
				return com.itda.HttpRequestAuthorization.authorizeUserAccess(params)
			} else { //all other controllers
				return com.itda.HttpRequestAuthorization.authorizeAdminAccess(params)
			}
     	}		
		
       // def sf  = appCtx.getBean('sessionFactory')
        //SessionListener.setSessionFactory sf

        JSON.registerObjectMarshaller(Office) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['name'] = it.name
            returnArray['zipcodes'] = it.advertisingZipcodes            
            return returnArray
		}
		
        JSON.registerObjectMarshaller(AdvertisingZipcode) {
            def returnArray = [:]
            //returnArray['id'] = it.id
            returnArray['zipcode'] = it.zipcode
            return returnArray
		}
		
        JSON.registerObjectMarshaller(Vendor) {
            def returnArray = [:]
            returnArray['id'] = it.id;
            returnArray['name'] = it.vendorName;
            returnArray['email']= it.email;
            return returnArray
		}

        JSON.registerObjectMarshaller(Publication) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['name'] = it.newspaperOrPublicationName
            returnArray['email']= it.email;
            return returnArray
		}

        JSON.registerObjectMarshaller(Competitor) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['name'] = it.businessName
            return returnArray
		}

        JSON.registerObjectMarshaller(PlannerTodo) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['title'] = it.title
            returnArray['isCompleted'] = it.isCompleted
            return returnArray
		}
        JSON.registerObjectMarshaller(PlannerRepeatDate) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['repeatDate'] = it.repeatDate
            return returnArray
		}

        JSON.registerObjectMarshaller(PlannerEntry) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['start'] = it.start
            returnArray['todos'] = it.todos           
            returnArray['quantity'] = it.quantity
            returnArray['title'] = it.title
            returnArray['className'] = it.className            
            returnArray['size'] = it.size
            returnArray['otherSize'] = it.otherSize
            returnArray['color'] = it.color            
            returnArray['deadline'] = it.deadline
            returnArray['selfNotes'] = it.selfNotes
            returnArray['vendorNotes'] = it.vendorNotes
            returnArray['zipcodes'] = it.zipcodes            
            returnArray['portfolioEntry'] = it.portfolioEntry
            returnArray['vendor.id'] = it.vendor?.id
            returnArray['publication.id'] = it.publication?.id ;           
            returnArray['office.id'] = it.office?.id  ;  
            if(it.portfolioEntry != null)
                returnArray['portfolioDesc'] = it.portfolioEntry.portfolio.description;
           returnArray['result'] = it.result;
            returnArray['imageFile'] = it.imageFile;
		   if(it.pdfFile)
		   	returnArray['pdfFile'] = 1;

	       returnArray['sentToVendor']= it.sentToVendor;
	       if(it.sentToVendor == false) {
	            returnArray['toEmail'] = it. toEmail;
	            returnArray['cc'] = it. cc;
	            returnArray['subject'] = it. subject;
	            returnArray['phone'] = it. phone;
	            returnArray['dates'] = it. dates;
	            returnArray['offers'] = it. offers;
	            returnArray['logo'] = it. logo;
	            returnArray['expireDates'] = it. expireDates;
	            returnArray['address'] = it. address;
	        	returnArray['otherChanges'] = it. otherChanges;
	            if(it.changePhoneFlag)
	            	returnArray['changePhoneFlag'] = it. changePhoneFlag;
	            if(it.changeDatesFlag)
	            	returnArray['changeDatesFlag'] = it. changeDatesFlag;
	            if(it.changeOffersFlag)
	            	returnArray['changeOffersFlag'] = it. changeOffersFlag;
	            if(it.changeExpireDatesFlag)
	            	returnArray['changeExpireDatesFlag'] = it. changeExpireDatesFlag;
	            if(it.changeAddressFlag)
	            	returnArray['changeAddressFlag'] = it. changeAddressFlag;
	            if(it.changeLogoFlag)
	            	returnArray['changeLogoFlag'] = it. changeLogoFlag;
	            if(it.changeOtherFlag)
	            	returnArray['changeOtherFlag'] = it. changeOtherFlag;
        	}
		   return returnArray
		}

        JSON.registerObjectMarshaller(PortfolioEntry) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['rating'] = it.rating
            returnArray['numRating'] = it.numRating
            returnArray['numReview'] = it.numReview
           	returnArray['adSizeCode'] = it.adSizeCode;
            returnArray['adTypeCode'] = it.adTypeCode
            returnArray['color'] = it.color            
            returnArray['download'] = it.download
            returnArray['portfolioDate'] = it.portfolioDate
			if(it.category == Portfolio.MY_UPLOADS_CATEGORY) {
		   		returnArray['myUploads'] = 1;
				returnArray['imageFile'] = it.adDescription;
				returnArray['otherSize'] = it.otherSize;
			}else{
				returnArray['imageFile'] = it.imageFile
			}
            return returnArray
		}
        
        JSON.registerObjectMarshaller(CompetitorAd) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['start'] = it.start
            returnArray['title'] = it.title
            returnArray['className'] = it.className            
            returnArray['size'] = it.size
            returnArray['color'] = it.color            
            returnArray['otherSize'] = it.otherSize
            returnArray['notes'] = it.notes            
            returnArray['imageFile'] = it.imageFile
            returnArray['competitor.id'] = it.competitor?.id
            returnArray['publication.id'] = it.publication?.id
            returnArray['vendor.id'] = it.vendor?.id
            
            return returnArray
		}
        JSON.registerObjectMarshaller(Result) {
            def returnArray = [:]
            returnArray['id'] = it.id
            returnArray['publishTestsSet'] = it.publishTestsSet
            returnArray['publishTestsSold'] = it.publishTestsSold           
            returnArray['publishHearingAidsSold'] = it.publishHearingAidsSold
            returnArray['publishCalls'] = it.publishCalls  
            returnArray['calls'] = it.calls              
            returnArray['title'] = it.title
            returnArray['publishTestedNotSold'] = it.publishTestedNotSold            
            returnArray['testsSold'] = it.testsSold
            returnArray['hearingAidsSold'] = it.hearingAidsSold
            returnArray['testsSet'] = it.testsSet            
            returnArray['testedNotSold'] = it.testedNotSold
            returnArray['grossSales'] = it.grossSales
            returnArray['returnOnInvest'] = it.returnOnInvest            
            returnArray['costPerLead'] = it.costPerLead
            returnArray['costPerSale'] = it.costPerSale
            returnArray['publishGrossSales'] = it.publishGrossSales
            returnArray['publishReturnOnInvest'] = it.publishReturnOnInvest            
            returnArray['publishCostPerLead'] = it.publishCostPerLead
            returnArray['publishCostPerSale'] = it.publishCostPerSale
            returnArray['placement'] = it.placement
            returnArray['totalExpense'] = it.totalExpense            
            returnArray['numberCompetitiveAd'] = it.numberCompetitiveAd            
            returnArray['rating'] = it.rating 
            returnArray['review'] = it.review            
            returnArray['helpfulCount'] = it.helpfulCount            
            returnArray['notHelpfulCount'] = it.notHelpfulCount            
            returnArray['runDate'] = it.runDate
            returnArray['lastUpdated'] = it.lastUpdated
            //returnArray['author'] = it.author
           // returnArray['location'] = it.location
            return returnArray
		}
	}
	
     def destroy = {
    		 SessionListener.shutdown()
     }
} 