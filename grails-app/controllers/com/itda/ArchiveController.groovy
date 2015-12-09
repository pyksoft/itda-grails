package com.itda


import java.io.InputStream;
import java.util.Calendar;
import com.itda.Favorite;
import com.itda.Username;
import com.itda.UserComment;
import com.sun.corba.se.impl.encoding.OSFCodeSetRegistry.Entry;

import grails.converters.JSON;
class ArchiveController extends ArchiveBaseController{

	def authenticationService
	def messageSource 
	
    def index = { 
	    def c = Portfolio.createCriteria()
	    def ports = c.list(max:params.max, offset:params.offset, sort: 'portfolioDate', order:'desc') {
	    		ne("status", 'Inactive')
				ne("deleted", true)
	    		ne("category", Portfolio.MY_UPLOADS_CATEGORY)
	    } 
	    println 'ports.size =' + ports.size()
 		render (view:'archive', model:[portfolios: ports])
    }

    def selectFile = { 
	    def c = Portfolio.createCriteria()
	    def ports = c.list(max:params.max, offset:params.offset, sort: 'portfolioDate', order:'desc') {
	    		ne("status", 'Inactive')
				ne("deleted", true)
	    } 
	    //println 'ports.size =' + ports.size()
		params.max = 6;
		params.offset =0;
 		render (view:'archiveSearchAndReview', model:[portfolios: ports]);
    }
	
    def getArchivedEntries = {
        	println params;
        	def max = (params.companion == 'true') ? 5 : 6;
    	    params.max = Math.min(params.max ? params.max.toInteger() : max, 60) //for paginate tag
    	    params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
            ////////////////////////////////
            //viewFilter == All, Most Downloaded, Highest Rated
            def favorites = null;
    	    def resultset = [], resultset2, dates, totalCount = 0;
            switch(params.viewFilter) {

            case ['Favorites']:
            	resultset = getFavoriteArchivedEntries(params);
            	resultset2 = [];
	        	for(res in resultset){
	        		resultset2.add(res.portfolioEntry);
	        	}
	        	break;

            case ['Purchased']:
            	resultset = getPurchasedArchivedEntries(params);
            	resultset2 = [];
	        	for(res in resultset){
				//log.debug((new JSON(res)).toString(true))	;	
					
	        		resultset2.add(res.item);
	        	}
	        	break;

            case ['Previously Run', 'Scheduled']:
            	resultset = getPlannerArchivedEntries(params);
            	resultset2 = [];
            	dates =[];//for display only
            	for(res in resultset){
            		resultset2.add(res.portfolioEntry);
            		dates.add(res.start)
            	}
            	break;
            	
            case ['All', 'Most Downloaded', 'Highest Rated', 'My Uploads']:
            	resultset = getAllArchivedEntries(params);
        		break;
            }//switch
            //println 'count is ' + resultset.totalCount
            totalCount = resultset.totalCount;
            //println 'size is ' + resultset.size()            
            favorites = [];
            if(params.viewFilter != 'Favorites') {
               	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long
            	for(entry in resultset) {
            		def fav = Favorite.findWhere(['portfolioEntry.id': entry.id, 'business.id': bizId]) 
            		if(fav)
            			favorites.add(entry.id);
            	}
            }
           	def result = ["entries": (resultset2 ? resultset2 : resultset), 
           	              'totalCount': totalCount,
        	              "favorites": favorites];
           	if(dates)
           		result['dates'] = dates;
           //	println ("params.companion == 'true'  " + (params.companion == 'true'))
           	if(params.companion == 'true'){
           		
           		def desc = Portfolio.executeQuery('select p.description from Portfolio p where portfolioDate = ?',
           				Date.parse('yyyy-MM-dd', params.portfolioDate));
           		//println 'setting description to ' + desc;
           		result['portfolioDescription'] = desc[0];
           	}
    		response.contentType = "text/javascript; charset=UTF-8"  
    		response << params.callback  //+ '( { "entries" :'
            render result as JSON           
        }
    
    def getPdf  = {
    	println(params);
    	def act;
    	if(params.color == '4')
    		act = 'getFourColorPdf';
    	else if(params.color == '2')
       		act = 'getTwoColorPdf';
       	else //if(params.color == '1')//my  upload entries may not have a color
       		act = 'getOneColorPdf';
       	//else {
       	//	response.status = 404;
       	//	return;
       	//}
		def id = params.id as long;
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
		def download = new Download('business.id':bizId, 'portfolioEntry.id': id);
		download.save();
		PortfolioEntry.executeUpdate('update PortfolioEntry set download = download +1 where id = ?',[id]);
		forward(controller:'myPortfolio', action: act);
    }

    def getJpg  = {
    	if(params.color == '4' || params.color[0] == '4')
    		forward(controller:'myPortfolio', action:'getFourColorSwf');
    	else if(params.color == '2' || params.color[0] == '2')
       		forward(controller:'myPortfolio', action:'getTwoColorSwf')
       	else //if(params.color == '1' || params.color[0] == '1') //my upload entries may not have a color
       		forward(controller:'myPortfolio', action:'getOneColorSwf')
       	//else
       		//response.status = 404;
    }   
    
    def addToFavorites = {
    		println params
        def respText 
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long
    	def fav = Favorite.findWhere(['portfolioEntry.id': params.id as long, 'business.id': bizId]);
        if(!fav) {
	    	def port = PortfolioEntry.get(params.id as long)
	    	params.remove('id');
	    	fav = new Favorite(params)
	    	fav.business = Business.get(bizId)
	    	fav.portfolioEntry = port;
	        
	    	if(fav.save(flush:true)) {
	    		respText = '<span class="itda-archive-icon favorite-pink-icon" style="float:left; margin:0 7px 50px 0;"></span> This piece has been added to your favorites.'
	    	}else {
	    		respText =  'Add failed'
	    	}
        } else
    		respText = '<span class="itda-archive-icon favorite-pink-icon" style="float:left; margin:0 7px 50px 0;"></span> This piece has been added to you favorites.'
        	
        def resp = [respText:respText,id:fav?.id]
        render  resp as JSON  	 	
    }

    def removeFromFavorites = {
            def respText 
        	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long
        	def favs = Favorite.executeUpdate('delete Favorite f where f.portfolioEntry.id = ? and f.business.id = ?',
        			[params.id as long, bizId]);
        	
            println favs
        	if (favs > 0) //(fav.delete(flush:true)) {
        		respText = '<span class="ui-icon ui-icon-circle-check" style="float:left; margin:0 7px 50px 0;"></span> This piece has been removed from your favorites.'
        	else 
        		respText =  'Delete failed'
        	//}
            def resp = [respText:respText]
            render  resp as JSON  	 	
        }
    
	def addToPlanner = {
    		println params
		def respText = "Completed"
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] 
        PlannerEntry plannerEntry = new PlannerEntry(params)
    	plannerEntry.business = Business.get(bizId);
    	plannerEntry. portfolioEntry = PortfolioEntry.get(params.entryId);
    	plannerEntry.className = PlannerEntry.getAdEventType(plannerEntry. portfolioEntry.adTypeCode); 
    	plannerEntry.start = new java.sql.Date(Date.parse('yyyy-MM-dd', params.addPlannerDate).getTime());
		def count = PlannerEntry.executeQuery('select count(e) from PlannerEntry e where e.className = ? and e.business.id = ? and start = ?',
				plannerEntry.className, bizId, plannerEntry.start);
		plannerEntry.title = plannerEntry.getTitlePrefix(plannerEntry.className)  +  (count[0]+1);
    	
    	//plannerEntry.title = plannerEntry.getTitle(plannerEntry. portfolioEntry, bizId, plannerEntry.start );
    	//plannerEntry.end = plannerEntry.start;
    	if(plannerEntry.hasErrors()) {
    		for(err in plannerEntry.errors.allErrors) {
    			log.error err;
			} 
    		respText = 'Add to planner failed.  Please try again.'    		
    	}else 

    	if(!plannerEntry.save(flush:true)) {
    	    if(plannerEntry.hasErrors()) {
    	    	for(err in plannerEntry.errors.allErrors) {
    	    		log.error err   	    		
				}
    	    }
    	    respText = 'Add to planner failed.  Please try again.'
    	}
    	
        def result = ['respText':respText]		
         render result as JSON
	}
    
    
    def getPlannerArchivedEntries (params) {
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long
	            def c = PlannerEntry.createCriteria();
	            def resultset = c.list(max:params.max, offset:params.offset) {
	            	Calendar cal = Calendar.getInstance()
	            	cal.set(Calendar.HOUR_OF_DAY, 0);
	            	cal.set(Calendar.MINUTE, 0);
	            	cal.set(Calendar.SECOND, 0);
	            	cal.set(Calendar.MILLISECOND, 0);	  
					//println cal;          	
		            if(params.viewFilter == 'Previously Run')
		            	lt('start', cal.getTime())
		            else //Scheduled 
		            	ge('start', cal.getTime())
		            eq('business.id', bizId)
		            portfolioEntry{
		    			def fileName = params.keyword.trim()
	    	    		eq("enable", true)
						if(fileName != '')
							like("imageFile", '%/'+fileName + '%.%')
	
	    	    		if(params.portfolioDate != null && params.portfolioDate != 'null')
	    	    			eq("portfolioDate", Date.parse('yyyy-MM-dd', params.portfolioDate))
	    	    		if(params.adType.startsWith('Newspaper'))
	    	    			eq("adTypeCode", 'NP')
	    	    		else if(params.adType == 'Direct Mail Marketing')
	    	    			eq("adTypeCode", 'DM')
	    	    		

            	        if(params.color != null)
            	        	if(params.color instanceof String)
            	        		eq("color", params.color[0] as Integer)
            	        	else if(params.color.length == 2)
            	        	{
            	        		def colors = [1, 2, 4]
            	        		for(acolor in params.color)
            	        			colors -= (acolor[0] as int);
            	        	    ne('color', colors[0])
            	        	}
	            	        
	            	        
	            	    or {
		    	    		if(params.anatomy != null)	
		    	    			eq("anatomy", true)
		    	    		if(params.product != null)	
		    	    			eq("product", true)
		    	    		if(params.patient != null)	
		    	    			eq("patient", true)
		    	    		if(params.map != null)	
		    	    			eq("map", true)
		    	    		if(params.calendar != null)	
		    	    			eq("calendar", true)
		    	    		if(params.testing != null)	
		    	    			eq("testing", true)
		    	    		if(params.coupons != null)	
		    	    			eq("coupons", true)
		    	    		if(params.policies != null)	
		    	    			eq("policies", true)
		    	    		if(params.company != null)	
		    	    			eq("company", true)
		    	    		if(params.address != null)	
		    	    			eq("address", true)
		    	    		if(params.phone != null)	
		    	    			eq("phone", true)
		    	    		if(params.testimonial != null)
		    	    			eq("testimonial", true)
		    	    		if(params.sale != null)	
		    	    			eq("sale", true)
		    	    		if(params.trial != null)	
		    	    			eq("trial", true)
		    	    		if(params.seminar != null)	
		    	    			eq("seminar", true)
		    	    		if(params.advertorial != null)	
		    	    			eq("advertorial", true)
		    	    		if(params.features != null)	
		    	    			eq("features", true)
		    	    		if(params.benefits != null)	
		    	    			eq("benefits", true)
		    	    		if(params.upgrade != null)	
		    	    			eq("upgrade", true)
		    	    		if(params.tinnitus != null)	
		    	    			eq("tinnitus", true)
		    	    		if(params.notice != null)	
		    	    			eq("notice", true)
		    	    		if(params.opening != null)	
		    	    			eq("opening", true)
		    	    		if(params.hearingTest != null)	
		    	    			eq("hearingTest", true)
		    	    		if(params.consultDemo != null)	
		    	    			eq("consultDemo", true)
		    	    		if(params.endorsement != null)	
		    	    			eq("endorsement", true)
		    	    		if(params.technology != null)	
		    	    			eq("technology", true)
		    	    		if(params.thanksgiving != null)	
		    	    			eq("thanksgiving", true)
		    	    		if(params.christmas != null)	
		    	    			eq("christmas", true)
		    	    		if(params.newYear != null)	
		    	    			eq("newYear", true)
		    	    		if(params.valentine != null)	
		    	    			eq("valentine", true)
		    	    		if(params.president != null)	
		    	    			eq("president", true)
		    	    		if(params.july4 != null)	
		    	    			eq("july4", true)
		    	    		if(params.spring != null)	
		    	    			eq("spring", true)
		    	    		if(params.summer != null)	
		    	    			eq("summer", true)
		    	    		if(params.fall!= null)	
		    	    			eq("fall", true)
		    	    		if(params.winter!= null)	
		    	    			eq("winter", true)

	    	    			if(params.offer) 
	    	    				inList('offerCode', 
	    	    						convertToOfferCodes(params.offer instanceof String ? [params.offer] : params.offer))
	    	    			if(params.size) 
	    	    				inList('adSizeCode', 
	    	    						(params.size instanceof String ? [params.size] : params.size))
	    	    		}
	    	    			    	    		    	            		
            	       // order('portfolioDate', 'desc')
            	        //order('adTypeCode', 'desc')
            	        //order('adPageNumber', 'asc')
            	        //order('color', 'asc')	
            	        //resultTransformer(new org.hibernate.transform.AliasToBeanResultTransformer(PortfolioEntry.class))
            	       //resultTransformer(CriteriaSpecification.ROOT_ALIAS)
	             }//PortfolioEntry
		          order('start', 'asc')
 	          }//PlannerEntry
	            println 'count2 is ' + resultset.totalCount
	       return resultset;
        }
    
    def getAllArchivedEntries (params) {
        def c = PortfolioEntry.createCriteria();
        def resultset = c.list(max:params.max, offset:params.offset) {

	    		eq("enable", true)
	    		eq("deleted", false)
				//eq("category", Portfolio.PORTFOLIO_CATEGORY)

				def promoCodeId = authenticationService.getSessionUser().attributes['promoCodeId']				
				eq("promoCode", promoCodeId)
				
	    		if(params.portfolioDate != null && params.portfolioDate != 'null')
	    			eq("portfolioDate", Date.parse('yyyy-MM-dd', params.portfolioDate))
	    		if(params.adType.startsWith('Newspaper'))
	    			eq("adTypeCode", 'NP')
	    		else if(params.adType == 'Direct Mail Marketing')
	    			eq("adTypeCode", 'DM')
				println  params.viewFilter;
	    		if(params.viewFilter.startsWith('Most'))	
	    			gt('download', 0)  //take into account my content
	    		else if(params.viewFilter.startsWith('Highest'))	
	    			ge('rating', 3.0 as Double)
				else if(params.viewFilter.startsWith('My')) {//My Uploads
					long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
					 eq("category", Portfolio.MY_UPLOADS_CATEGORY)
					 eq("business.id", bizId)

				  }else {// All
					  and {
						  or {
							  eq("category", Portfolio.PORTFOLIO_CATEGORY)
							  and {
								   long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
								   eq("category", Portfolio.MY_UPLOADS_CATEGORY)
								   eq("business.id", bizId)
							   }
						  }
					  }
				  }

				

    	        if(params.color != null)
    	        	if(params.color instanceof String)
    	        		eq("color", params.color[0] as Integer)
    	        	else if(params.color.length == 2)
    	        	{
    	        		def colors = [1, 2, 4]
    	        		for(acolor in params.color)
    	        			colors -= (acolor[0] as int);
    	        	    ne('color', colors[0])
    	        	}
        	        
					
					        	        
        	    or {
    	    		if(params.anatomy != null)	
    	    			eq("anatomy", true)
    	    		if(params.product != null)	
    	    			eq("product", true)
    	    		if(params.patient != null)	
    	    			eq("patient", true)
    	    		if(params.map != null)	
    	    			eq("map", true)
    	    		if(params.calendar != null)	
    	    			eq("calendar", true)
    	    		if(params.testing != null)	
    	    			eq("testing", true)
    	    		if(params.coupons != null)	
    	    			eq("coupons", true)
    	    		if(params.policies != null)	
    	    			eq("policies", true)
    	    		if(params.company != null)	
    	    			eq("company", true)
    	    		if(params.address != null)	
    	    			eq("address", true)
    	    		if(params.phone != null)	
    	    			eq("phone", true)
    	    		if(params.testimonial != null)
    	    			eq("testimonial", true)
    	    		if(params.sale != null)	
    	    			eq("sale", true)
    	    		if(params.trial != null)	
    	    			eq("trial", true)
    	    		if(params.seminar != null)	
    	    			eq("seminar", true)
    	    		if(params.advertorial != null)	
    	    			eq("advertorial", true)
    	    		if(params.features != null)	
    	    			eq("features", true)
    	    		if(params.benefits != null)	
    	    			eq("benefits", true)
    	    		if(params.upgrade != null)	
    	    			eq("upgrade", true)
    	    		if(params.tinnitus != null)	
    	    			eq("tinnitus", true)
    	    		if(params.notice != null)	
    	    			eq("notice", true)
    	    		if(params.opening != null)	
    	    			eq("opening", true)
    	    		if(params.hearingTest != null)	
    	    			eq("hearingTest", true)
    	    		if(params.consultDemo != null)	
    	    			eq("consultDemo", true)
    	    		if(params.endorsement != null)	
    	    			eq("endorsement", true)
    	    		if(params.technology != null)	
    	    			eq("technology", true)
    	    		if(params.thanksgiving != null)	
    	    			eq("thanksgiving", true)
    	    		if(params.christmas != null)	
    	    			eq("christmas", true)
    	    		if(params.newYear != null)	
    	    			eq("newYear", true)
    	    		if(params.valentine != null)	
    	    			eq("valentine", true)
    	    		if(params.president != null)	
    	    			eq("president", true)
    	    		if(params.july4 != null)	
    	    			eq("july4", true)
    	    		if(params.spring != null)	
    	    			eq("spring", true)
    	    		if(params.summer != null)	
    	    			eq("summer", true)
    	    		if(params.fall!= null)	
    	    			eq("fall", true)
    	    		if(params.winter!= null)	
    	    			eq("winter", true)
						
	    			if(params.offer) 
	    				inList('offerCode', 
	    						convertToOfferCodes(params.offer instanceof String ? [params.offer] : params.offer))
						
	    			if(params.size) 
	    				inList('adSizeCode', 
	    						(params.size instanceof String ? [params.size] : params.size))
					
	        		def kword = params.keyword.trim()
					if(kword) {
						like("imageFile", '%/'+kword + '%.%')
						like("otherSize", '%'+kword + '%')
						like("otherOffer", '%'+kword + '%')
						like("otherFocus", '%'+kword + '%')
						like("otherTimeOfYear", '%'+kword + '%')
					}
					
					if(params.otherFocus) {
		        		kword = params.otherFocus.trim()
						if(kword) 
							like("otherFocus", '%'+kword + '%')
					}	
					if(params.otherOffer) {
		        		kword = params.otherOffer.trim()
						if(kword)
							like("otherOffer", '%'+kword + '%')
					}
					if(params.otherTimeOfYear) {
						kword = params.otherTimeOfYear.trim()
						if(kword)
							like("otherTimeOfYear", '%'+kword + '%')
					}
					if(params.otherSize) {
						if(params.otherSize instanceof String)
							params.otherSize = [params.otherSize]
						for(def osize in params.otherSize){
							if(osize){
								like("otherSize", '%'+osize + '%')
								osize = osize.trim()
							}
						}
					}	

    	        }        	        
	    			    	    		    	            		
    	        if(params.viewFilter.startsWith('Most')) 
    	        	order('download', 'desc')
    	        else if(params.viewFilter.startsWith('Highest'))
    	        	order('rating', 'desc')
    	        order('portfolioDate', 'desc')
    	        order('adTypeCode', 'desc')
    	        order('adPageNumber', 'asc')
    	        order('color', 'asc')	 
         }//PortfolioEntry
        println 'count is ' + resultset.totalCount
        return resultset;
    }  
    
    def getFavoriteArchivedEntries (params) {
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long
	            def c = Favorite.createCriteria();
	            def resultset = c.list(max:params.max, offset:params.offset) {
		            eq('business.id', bizId)
		            portfolioEntry{
	    	    		eq("enable", true)
		    			//eq("category", Portfolio.PORTFOLIO_CATEGORY)
	    	    		eq("deleted", false)
						
						and {
							or {
								ne("category", Portfolio.MY_UPLOADS_CATEGORY)
								and {
									 eq("category", Portfolio.MY_UPLOADS_CATEGORY)
									 eq("business.id", bizId)
								 }
							}
						}

						def promoCodeId = authenticationService.getSessionUser().attributes['promoCodeId'];				
						eq("promoCode", promoCodeId)
		    			
						def fileName = params.keyword.trim()
						if(fileName != '')
							like("imageFile", '%/'+fileName + '%.%')
	
	    	    		if(params.portfolioDate != null && params.portfolioDate != 'null')
	    	    			eq("portfolioDate", Date.parse('yyyy-MM-dd', params.portfolioDate))
	    	    		if(params.adType.startsWith('Newspaper'))
	    	    			eq("adTypeCode", 'NP')
	    	    		else if(params.adType == 'Direct Mail Marketing')
	    	    			eq("adTypeCode", 'DM')

            	        if(params.color != null)
            	        	if(params.color instanceof String)
            	        		eq("color", params.color[0] as Integer)
            	        	else if(params.color.length == 2)
            	        	{
            	        		def colors = [1, 2, 4]
            	        		for(acolor in params.color)
            	        			colors -= (acolor[0] as int);
            	        	    ne('color', colors[0])
            	        	}
	            	        
	            	        
	            	    or {
		    	    		if(params.anatomy != null)	
		    	    			eq("anatomy", true)
		    	    		if(params.product != null)	
		    	    			eq("product", true)
		    	    		if(params.patient != null)	
		    	    			eq("patient", true)
		    	    		if(params.map != null)	
		    	    			eq("map", true)
		    	    		if(params.calendar != null)	
		    	    			eq("calendar", true)
		    	    		if(params.testing != null)	
		    	    			eq("testing", true)
		    	    		if(params.coupons != null)	
		    	    			eq("coupons", true)
		    	    		if(params.policies != null)	
		    	    			eq("policies", true)
		    	    		if(params.company != null)	
		    	    			eq("company", true)
		    	    		if(params.address != null)	
		    	    			eq("address", true)
		    	    		if(params.phone != null)	
		    	    			eq("phone", true)
		    	    		if(params.testimonial != null)
		    	    			eq("testimonial", true)
		    	    		if(params.sale != null)	
		    	    			eq("sale", true)
		    	    		if(params.trial != null)	
		    	    			eq("trial", true)
		    	    		if(params.seminar != null)	
		    	    			eq("seminar", true)
		    	    		if(params.advertorial != null)	
		    	    			eq("advertorial", true)
		    	    		if(params.features != null)	
		    	    			eq("features", true)
		    	    		if(params.benefits != null)	
		    	    			eq("benefits", true)
		    	    		if(params.upgrade != null)	
		    	    			eq("upgrade", true)
		    	    		if(params.tinnitus != null)	
		    	    			eq("tinnitus", true)
		    	    		if(params.notice != null)	
		    	    			eq("notice", true)
		    	    		if(params.opening != null)	
		    	    			eq("opening", true)
		    	    		if(params.hearingTest != null)	
		    	    			eq("hearingTest", true)
		    	    		if(params.consultDemo != null)	
		    	    			eq("consultDemo", true)
		    	    		if(params.endorsement != null)	
		    	    			eq("endorsement", true)
		    	    		if(params.technology != null)	
		    	    			eq("technology", true)
		    	    		if(params.thanksgiving != null)	
		    	    			eq("thanksgiving", true)
		    	    		if(params.christmas != null)	
		    	    			eq("christmas", true)
		    	    		if(params.newYear != null)	
		    	    			eq("newYear", true)
		    	    		if(params.valentine != null)	
		    	    			eq("valentine", true)
		    	    		if(params.president != null)	
		    	    			eq("president", true)
		    	    		if(params.july4 != null)	
		    	    			eq("july4", true)
		    	    		if(params.spring != null)	
		    	    			eq("spring", true)
		    	    		if(params.summer != null)	
		    	    			eq("summer", true)
		    	    		if(params.fall!= null)	
		    	    			eq("fall", true)
		    	    		if(params.winter!= null)	
		    	    			eq("winter", true)
            	        }
	            	        
	            	        
	    	    		or {
	    	    			if(params.offer) 
	    	    				inList('offerCode', 
	    	    						convertToOfferCodes(params.offer instanceof String ? [params.offer] : params.offer))
	    	    		}
	    	    		or {
	    	    			if(params.size) 
	    	    				inList('adSizeCode', 
	    	    						(params.size instanceof String ? [params.size] : params.size))
	    	    		}
	    	    			    	    		    	            		
            	        order('portfolioDate', 'desc')
            	        order('adTypeCode', 'desc')
            	        order('adPageNumber', 'asc')
            	        order('color', 'asc')	
            	        //resultTransformer(new org.hibernate.transform.AliasToBeanResultTransformer(PortfolioEntry.class))
            	       //resultTransformer(CriteriaSpecification.ROOT_ALIAS)
	             }//PortfolioEntry
	          }//PlannerEntry
	            println 'count is ' + resultset.totalCount
	       return resultset;
        }

    def getPurchasedArchivedEntries (params) {
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
	            def c = OrderItem.createCriteria();
				c.fetchMode("item", org.hibernate.FetchMode.EAGER);
	            def resultset = c.list(max:params.max, offset:params.offset) {
					ne('approvalCode', "")
					isNotNull('approvalCode')
		            eq('business.id', bizId)
		            item{
	    	    		//eq("enable", true)
		    			eq("category", Portfolio.AD_STORE_CATEGORY)
	    	    		//eq("deleted", false)

						def promoCodeId = authenticationService.getSessionUser().attributes['promoCodeId'];				
						eq("promoCode", promoCodeId)
		    			
						def fileName = params.keyword.trim()
						if(fileName != '')
							like("imageFile", '%/'+fileName + '%.%')
	
	    	    		if(params.portfolioDate != null && params.portfolioDate != 'null')
	    	    			eq("portfolioDate", Date.parse('yyyy-MM-dd', params.portfolioDate))
	    	    		if(params.adType.startsWith('Newspaper'))
	    	    			eq("adTypeCode", 'NP')
	    	    		else if(params.adType == 'Direct Mail Marketing')
	    	    			eq("adTypeCode", 'DM')

            	        if(params.color != null)
            	        	if(params.color instanceof String)
            	        		eq("color", params.color[0] as Integer)
            	        	else if(params.color.length == 2)
            	        	{
            	        		def colors = [1, 2, 4]
            	        		for(acolor in params.color)
            	        			colors -= (acolor[0] as int);
            	        	    ne('color', colors[0])
            	        	}
	            	        
	            	        
	            	    or {
		    	    		if(params.anatomy != null)	
		    	    			eq("anatomy", true)
		    	    		if(params.product != null)	
		    	    			eq("product", true)
		    	    		if(params.patient != null)	
		    	    			eq("patient", true)
		    	    		if(params.map != null)	
		    	    			eq("map", true)
		    	    		if(params.calendar != null)	
		    	    			eq("calendar", true)
		    	    		if(params.testing != null)	
		    	    			eq("testing", true)
		    	    		if(params.coupons != null)	
		    	    			eq("coupons", true)
		    	    		if(params.policies != null)	
		    	    			eq("policies", true)
		    	    		if(params.company != null)	
		    	    			eq("company", true)
		    	    		if(params.address != null)	
		    	    			eq("address", true)
		    	    		if(params.phone != null)	
		    	    			eq("phone", true)
		    	    		if(params.testimonial != null)
		    	    			eq("testimonial", true)
		    	    		if(params.sale != null)	
		    	    			eq("sale", true)
		    	    		if(params.trial != null)	
		    	    			eq("trial", true)
		    	    		if(params.seminar != null)	
		    	    			eq("seminar", true)
		    	    		if(params.advertorial != null)	
		    	    			eq("advertorial", true)
		    	    		if(params.features != null)	
		    	    			eq("features", true)
		    	    		if(params.benefits != null)	
		    	    			eq("benefits", true)
		    	    		if(params.upgrade != null)	
		    	    			eq("upgrade", true)
		    	    		if(params.tinnitus != null)	
		    	    			eq("tinnitus", true)
		    	    		if(params.notice != null)	
		    	    			eq("notice", true)
		    	    		if(params.opening != null)	
		    	    			eq("opening", true)
		    	    		if(params.hearingTest != null)	
		    	    			eq("hearingTest", true)
		    	    		if(params.consultDemo != null)	
		    	    			eq("consultDemo", true)
		    	    		if(params.endorsement != null)	
		    	    			eq("endorsement", true)
		    	    		if(params.technology != null)	
		    	    			eq("technology", true)
		    	    		if(params.thanksgiving != null)	
		    	    			eq("thanksgiving", true)
		    	    		if(params.christmas != null)	
		    	    			eq("christmas", true)
		    	    		if(params.newYear != null)	
		    	    			eq("newYear", true)
		    	    		if(params.valentine != null)	
		    	    			eq("valentine", true)
		    	    		if(params.president != null)	
		    	    			eq("president", true)
		    	    		if(params.july4 != null)	
		    	    			eq("july4", true)
		    	    		if(params.spring != null)	
		    	    			eq("spring", true)
		    	    		if(params.summer != null)	
		    	    			eq("summer", true)
		    	    		if(params.fall!= null)	
		    	    			eq("fall", true)
		    	    		if(params.winter!= null)	
		    	    			eq("winter", true)
            	        }
	            	        
	            	        
	    	    		or {
	    	    			if(params.offer) 
	    	    				inList('offerCode', 
	    	    						convertToOfferCodes(params.offer instanceof String ? [params.offer] : params.offer))
	    	    		}
	    	    		or {
	    	    			if(params.size) 
	    	    				inList('adSizeCode', 
	    	    						(params.size instanceof String ? [params.size] : params.size))
	    	    		}
	    	    			    	    		    	            		
            	        order('portfolioDate', 'desc')
            	        order('adTypeCode', 'desc')
            	        order('adPageNumber', 'asc')
            	        order('color', 'asc')	
	             }//PortfolioEntry
	          }//PlannerEntry
	            println 'count is ' + resultset.totalCount
	       return resultset;
        }
	    
    def getCustomerReviews = {
    	//TODO: find portfolio entry for requestor
		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
		def reviews, entry = PortfolioEntry.get(params.id);
		if(entry.category == Portfolio.MY_UPLOADS_CATEGORY && entry['business.id'] != bizId) //multi-tenant
			reviews = [];
		else
    		reviews = Result.findAllWhere('portfolioEntry.id':params.id as long, published:true);		
		render(template:"result_templ",model:[reviews:reviews, bizId:bizId], contentType:"text/json");
        //render reviews as JSON
    }
	
	def addCommentForReview = {
    	//def review = Result.findWhere('portfolioEntry.id':params.id as long);
		def resp;
		def errMsgs = []
		if(params.id && params.comment != ""){
			long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;	
			def user = Username.findWhere('business.id':bizId);	
	    	def c = new UserComment(comment:params.comment,'review.id':params.id,'user.id':user.id);
			if(c.save(flush:true)){
	            def respText = 'Save completed.';
				def arr = [c.comment, c.user.login, c.dateCreated]
	            resp = [respText:respText,comment:arr];
	            render  resp as JSON;
				return;	
            }else{
        		for(err in c.errors.allErrors) 
        			errMsgs.push messageSource.getMessage(err, null) ;	        	
	        }			 
		}
        resp = ["respText":"Save failed.", errors: errMsgs];
        render  resp as JSON;		
	}

    def getComments = {
    	//def list = UserComment.findAllWhere('review.id':params.id as long);	
		def list = UserComment.executeQuery("select c.comment, c.user.login, c.dateCreated "+
				   "from UserComment c, Username u "+
        	       "where c.user.id = u.id and " +
					"c.review.id = ?", 
					[params.id as long]);
		def resp = [respText:"Success",list:list];	
        render resp as JSON;
    }
	
    def wasHelpful = {
		def login = authenticationService.getSessionUser().login;    	
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
		def id = params.id as long;
		def vote = HelpfulCommentVote.findWhere('business.id':bizId, 'result.id':id, login:login);
		def result = Result.get(id);
		def helpful = null, respText = null;
		if(vote){
				vote.vote = params.vote;
    	}else{
	    		//TODO: verify manufacture code
				vote = new HelpfulCommentVote('login':login, 'business.id':bizId, 'result.id': id, vote:params.vote);
    	}
		vote.save(flush:true);
		updateVoteCounts(result);
		def resp = [respText:"Success",notHelpfulCount:result.notHelpfulCount,helpfulCount:result.helpfulCount];
		render  resp as JSON;  	 	
		
    }
	
    def updateVoteCounts(plannerEntryResult){	
		def resultSet = HelpfulCommentVote.executeQuery('select vote, count(vote) from HelpfulCommentVote where result.id = ? group by vote', plannerEntryResult.id);
		for(row in resultSet) {
			println row[0] +":"+row[1]
			if(row[0] == "Yes")
				plannerEntryResult.helpfulCount = row[1] as long;
			else
				plannerEntryResult.notHelpfulCount = row[1] as long;			
		}
		plannerEntryResult.save(flush:true);
    }
	
	def uploadAdFile = {
		log.debug params
		if (params.uuid && params.name && params.file){
			long bizId = authenticationService.getSessionUser().attributes['businessId'];
			Upload up = Upload.findWhere(['uuid':params.uuid, 'business.id':bizId]);
			if(!up)
				up = new Upload('uuid':params.uuid, 'business.id':bizId); 

			def imageFileTypes = ['JPG', 'JPEG', 'GIF', 'PNG']
			String dirname = getTmpUploadDir(up.uuid, bizId);
			File dir = new File(dirname);
			if(dir.exists() || dir.mkdirs()) {
				File file = new File ( dirname + params.name );
				params['file'].transferTo(file);
				if(log.isDebugEnabled())
					log.debug ("upload file to " +file.getAbsolutePath())
				file = null;
				String[] components = params.name.split("\\.");
				String fileExt = components[components.length-1];
				log.debug("fileExt:" + fileExt +":" + imageFileTypes.contains(fileExt.toUpperCase()) +":" + imageFileTypes);
				if(imageFileTypes.contains(fileExt.toUpperCase())){
					if(up.imageFile && up.imageFile != params.name)
						file = new File ( dirname + up.imageFile ); //mark old file for delete
					up.imageFile = params.name;
				}else{
					if(up.pdfFile && up.pdfFile != params.name)
						file = new File ( dirname + up.pdfFile );//mark old file for delete
					up.pdfFile = params.name;
				}
				up.save();
				response.writer.write  "Upload completed";
				if(file)
					file.delete(); //delete old file
			}else {
				response.status = 500;
				render "Upload failed";
			}

		} else {
			response.status = 500;
			response.writer.write  "Upload failed";
		}
		if(! response.isCommitted())
			response.flushBuffer()
	}
	
	def getUploadedAdImage = {
		if (params.id && params.file){
			long bizId = authenticationService.getSessionUser().attributes['businessId'];
			Upload up = Upload.findWhere(['uuid':params.id, 'imageFile': params.file, 'business.id':bizId]);
			String dirname = getTmpUploadDir(up.uuid, bizId);
			File dir = new File(dirname + up.imageFile);
			if(dir.exists()) {
				sendReponse(dirname + up.imageFile);
			}else {
				response.status = 404;
				render "Not Found";
			}

		} else {
			response.status = 404;
			render "Not Found";
		}
		if(! response.isCommitted())
			response.flushBuffer()
	}	

	def cancelUpload = {
		def respText;
		long bizId = authenticationService.getSessionUser().attributes['businessId'];
		Upload up;
		if(params.id)
			up = Upload.findWhere(['uuid':params.id, 'business.id':bizId]);
		if (up){
			String dirname = getTmpUploadDir(up.uuid, bizId);
			File dir = new File(dirname);
			if(dir.deleteDir()) {
				respText = "success";
			}else {
				respText =  "failed";
			}

		} else {
			respText = "Not Found";
		}
		def resp = [respText:respText]
		render resp as JSON;
	}
			
	def upload2Archive = {
		def respText, errMsgs = [];
		long bizId = authenticationService.getSessionUser().attributes['businessId'];
		String dir = getTmpUploadDir(params.uuid, bizId);
		File pdfFile = new File(dir + params.pdfFile);
		File imgFile = new File(dir + params.imageFile);
		
		if(pdfFile.exists() && imgFile.exists()) {
			def promoCodeId = authenticationService.getSessionUser().attributes['promoCodeId'];
			Portfolio port = Portfolio.findWhere('category':Portfolio.MY_UPLOADS_CATEGORY, 'promoCode':promoCodeId);
			if(promoCodeId && port) {
				String myUploadBaseDir = getMyUploadDir();
				String relPathName = bizId + '/' + params.uuid + '/';
				File newDir =  new File(myUploadBaseDir + relPathName) ;
				if(!newDir.exists() && ! newDir.mkdirs())
				{
					def resp = [respText:"Failed 0"	];
					render  resp as JSON;
				}
				File newPdfLoc = new File ( myUploadBaseDir + relPathName + params.pdfFile );
				pdfFile.renameTo(newPdfLoc);
				File newImgLoc = new File ( myUploadBaseDir + relPathName + params.imageFile );
				imgFile.renameTo(newImgLoc);
				params.pdfFile = relPathName + params.pdfFile;
				params.imageFile = relPathName + params.imageFile;
	
				params['business.id'] = bizId;
				params['portfolio.id'] = port.id;
				params.category = Portfolio.MY_UPLOADS_CATEGORY;
				params.adTabNumber = 1000;
				params.adPageNumber = 1000;
				params.promoCode = promoCodeId;
				params.enable = true;
				params.details = params.adDescription;
				params.portfolioDate = new Date();
				params.adKey = params.uuid;
				if(!params.size)
					params.adSizeCode = 'OTHER';
				else {
					params.adSizeCode = params.size;
				}
				if(!params.offerCode || params.offerCode == 'OTHER'){	
					params.offerCode = 'OTHER';
				} else {
					if(!offerCodeMap)
						offerCodeMap = com.itda.admin.ItdaAttribute.findAllShortLabelValuePairs('offerCode');
					params.offerCode = offerCodeMap[params.offerCode];
				}
	
				if(params.color)
					params.color =params.color[0];
				else
					params.color = 4;
			    PortfolioEntry pEntry = new PortfolioEntry(params);
				if(	pEntry.save(flush:true) ) {
					respText = "Save completed";
				}else{
					for(err in pEntry.errors.allErrors)
						errMsgs.push messageSource.getMessage(err, null) ;
					respText = "Save failed";
					newPdfLoc.renameTo(pdfFile);
					newImgLoc.renameTo(imgFile);
				}
			} else {
				respText = "Failed";
				errMsgs.push "Your request cannot be processed at this time."
			}
		}else{
			respText = "Failed";
			errMsgs.push "Uploaded files not found"
		}
			
		def resp = [respText:respText, errors: errMsgs];
		render  resp as JSON;
		
	}
	
	def removeUploadedHdFile = {
		def respText = "Save failed", errMsgs = [];
		long bizId = authenticationService.getSessionUser().attributes['businessId'];
		PortfolioEntry entry = PortfolioEntry.findWhere(id:params.id as long, 'business.id': bizId);
		println entry;
		if(entry && entry.pdfFile) {
			String myUploadsDir = getMyUploadDir();
			File file = new File (myUploadsDir + entry.pdfFile);
			println file
			if(file.delete()) {
				entry.deleted = true;
				
				if(entry.save(flush:true))
					respText = "Save completed";
				else
				if(entry.hasErrors()) {
					for(err in entry.errors.allErrors) {
						log.error err;
					}
				}
			}else
			println "file nto deleted"
		}
		def resp = [respText:respText];
		render resp as JSON;
	}
		
	private String getTmpUploadDir(def uuid, long bizId) {
		String val = message(code:"inthedoor.userContent.root.dir") +
		 'tempUploads' + '/' + bizId + '/' + uuid + '/';
		return val;
	}

	private String getMyUploadDir() {
		return message(code:"inthedoor.userContent.root.dir") +
			  'myUploads' + '/';
	}

	private void sendReponse(String result) {
		if ( result == null )
			result = "Transparent.gif";
		setHeaders();
		java.io.FileInputStream fis = new java.io.FileInputStream( result );
		streamContent(fis);
		fis.close();
	}
	
	private void setHeaders() {
		response.setHeader("Pragma", "")
		Calendar cal = Calendar.getInstance()
		cal.add(Calendar.DAY_OF_YEAR,35)
		response.setDateHeader("Expires", cal.getTimeInMillis())
	}
	
	private void streamContent(InputStream is) {
		org.apache.commons.io.IOUtils.copy(is,response.outputStream)
		if(! response.isCommitted())
			response.flushBuffer()
	}
}
