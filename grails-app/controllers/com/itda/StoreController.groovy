package com.itda;
import com.itda.Portfolio;
import com.itda.admin.ItdaAttribute;
import grails.converters.JSON;
import java.text.SimpleDateFormat;

class StoreController extends ArchiveBaseController{
	def authenticationService;
	def messageSource;
	def paymentService;
	
	static allowedMethods = [purchasesWithin50Miles:'POST', getPrices:'POST', 
	                         getStoreEntries:'POST', buyNow:'POST']	
	
    def purchasesWithin50Miles = { 
			long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
			PortfolioEntry ad = PortfolioEntry.get(params.adId 	  as long);
			Business biz = Business.get(bizId);
			def purchases = [];
			for(Office off in biz.offices){
				if(off.deleted || off.availability == 'false')
					continue;
				def tmplist = OrderItemOfficeLocation.queryByLocation(off, ad);
				if (tmplist)
				   for (item in tmplist) {
					   	if(item[3] == bizId)
						   continue;
						 def itemMap = [purchasedDate:item[0], lat:item[1], lon:item[2]];
					 	purchases.add(itemMap);
				   }
			}
		 
			def resp = [purchases:purchases];
			render resp as JSON;
    }

    def index = { 
	    def c = Portfolio.createCriteria()
	    def ports = c.list(max:params.max, offset:params.offset, sort: 'portfolioDate', order:'desc') {
	    		ne("status", 'Inactive')
				ne("deleted", true)
	    		eq("category", Portfolio.AD_STORE_CATEGORY)
	    }
			render (view:'store', model:[portfolios: ports])
    }
		
    def getPrices = { 
			def prices = ItdaAttribute.findAllValueValue2Pairs('adSizeCode', ['NP', 'DM']);
	 		render prices as JSON;
    }

	def isPurchased = {
		
		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
		//Payment payment = Payment.findWhere('business.id': bizId, 'ad.id':params.adId as long);
        def c = OrderItem.createCriteria();
        def resultset = c.list(max:1, offset:0) {
            eq('business.id', bizId)
						isNotNull('approvalCode')
            eq('item.id', params.adId as long)
        }
		def resp = ['isPurchased':resultset.totalCount]; //zero or one
		render resp as JSON;
		
	}
	
    def buyNow = { 
			long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
			Business biz = Business.get(bizId);
			PaymentInfo payInfo = PaymentInfo.findWhere(['business.id': bizId]);
			PortfolioEntry ad = PortfolioEntry.get(params.id as long);
	
	    def obj = paymentService.processAdOrder(ad, payInfo, biz);
			
			if(obj instanceof Payment){
				render(template:"purchaseInfo",model:[payment:obj], contentType:"text/json");
				return;
			}

				def result = [error:obj]
		 		render result as JSON;
    }
								
    def getStoreEntries = {
        	def max = (params.companion == 'true') ? 5 : 6;
    	    params.max = Math.min(params.max ? params.max.toInteger() : max, 60) //for paginate tag
    	    params.offset =  Math.max(params.offset ? params.offset.toInteger() : 0, 0)
            ////////////////////////////////
            //viewFilter == All, Most Downloaded, Highest Rated
            def favorites = null;
    	    def resultset = [], resultset2, dates, totalCount = 0;
            switch(params.viewFilter) {

            case ['Favorites']:
            	resultset = getFavoriteStoreEntries(params);
            	resultset2 = [];
	        	for(res in resultset){
	        		resultset2.add(res.portfolioEntry);
	        	}
	        	break;

            	
            case ['All', 'Most Downloaded', 'Highest Rated']:
            	resultset = getAllStoreEntries(params);
        		break;
            }//switch
            totalCount = resultset.totalCount;
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
           	if(params.companion == 'true'){
           		
           		def desc = Portfolio.executeQuery(
					   'select p.description from Portfolio p where portfolioDate = ?',
           				 toDate(params.portfolioDate));
           		result['portfolioDescription'] = desc[0];
           	}
    		//response.contentType = "text/javascript; charset=UTF-8"; 
    		//response << params.callback;
            render result as JSON;           
        }
	
    def getAllStoreEntries (params) {
        def c = PortfolioEntry.createCriteria();
        def resultset = c.list(max:params.max, offset:params.offset) {

	    		eq("enable", true)
	    		eq("deleted", false)
	    		eq("category", Portfolio.AD_STORE_CATEGORY)

				def promoCodeId = authenticationService.getSessionUser().attributes['promoCodeId']				
				eq("promoCode", promoCodeId)
				
        		def fileName = params.fileName.trim()
				if(fileName != '')
					like("imageFile", '%/'+fileName + '%.%')

	    		if(params.portfolioDate != null && params.portfolioDate != 'null')
	    			eq("portfolioDate",  toDate(params.portfolioDate))
	    		if(params.adType.startsWith('Newspaper'))
	    			eq("adTypeCode", 'NP')
	    		else if(params.adType == 'Direct Mail Marketing')
	    			eq("adTypeCode", 'DM')
	    		
	    		if(params.viewFilter.startsWith('Most'))	
	    			gt('download', 0)
	    			
	    		else if(params.viewFilter.startsWith('Highest'))	
	    			ge('rating', 3.0 as Double)

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
	    			    	    		    	            		
    	        if(params.viewFilter.startsWith('Most')) 
    	        	order('download', 'desc')
    	        else if(params.viewFilter.startsWith('Highest'))
    	        	order('rating', 'desc')
    	        order('portfolioDate', 'desc')
				if(params.adTypeOrder && params.adTypeOrder == 'DM')//companion query only
					order('adTypeCode', 'asc')
				else
    	        	order('adTypeCode', 'desc')
    	        order('adPageNumber', 'asc')
    	        order('color', 'asc')	    		
         }//PortfolioEntry
        println 'count is ' + resultset.totalCount
        return resultset;
    }  

    def getFavoriteStoreEntries (params) {
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long
	            def c = Favorite.createCriteria();
	            def resultset = c.list(max:params.max, offset:params.offset) {
		            eq('business.id', bizId)
		            portfolioEntry{
		    			eq("deleted", false)
		    			eq("category", Portfolio.AD_STORE_CATEGORY)
	    	    		eq("enable", true)
						def promoCodeId = authenticationService.getSessionUser().attributes['promoCodeId'];				
						eq("promoCode", promoCodeId)

						def fileName = params.fileName.trim();
						if(fileName != '')
							like("imageFile", '%/'+fileName + '%.%')
	
	    	    		if(params.portfolioDate != null && params.portfolioDate != 'null')
	    	    			eq("portfolioDate", toDate(params.portfolioDate))
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
		
	
}
