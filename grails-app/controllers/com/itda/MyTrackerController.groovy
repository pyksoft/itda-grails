package com.itda
import com.itda.CompetitorAd;
import grails.converters.JSON;

class MyTrackerController {
	def authenticationService
	def messageSource 

    def index = { 
		def start, end;
		def cal =  Calendar.getInstance();
		start = cal.get(Calendar.YEAR) - 10;
		end = start + 20;
		render(view: "myTracker", model:[start:start,end:end]) 
	}

	def saveNewCompetitor = { //protected
			def resp, respText;
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
    		params['business.id'] = bizId;
	        def competitorInstance = new Competitor(params)
	        if(!competitorInstance.hasErrors() && competitorInstance.save()) {
	        	respText = 'Save completed.';
	            resp = ["respText":respText, "competitor":competitorInstance];
	        }
	        else {
	        	def errMsgs = [];
        		for(err in competitorInstance.errors.allErrors) 
        			errMsgs.push messageSource.getMessage(err, null) ;	        	
	            resp = ["respText":"Save failed.", errors: errMsgs];
	        }			
            render resp as JSON			
	}

	def saveNewPublication = { //protected
			def resp, respText;
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
    		params['business.id'] = bizId;
	        def publicationInstance = new Publication(params)
	        if(!publicationInstance.hasErrors() && publicationInstance.save()) {
	        	respText = 'Save completed.';
	            resp = ["respText":respText, "publication":publicationInstance];
	        }else{
	        	def errMsgs = [];
        		for(err in publicationInstance.errors.allErrors) 
        			errMsgs.push messageSource.getMessage(err, null) ;	        	
	            resp = ["respText":"Save failed.", errors: errMsgs];
	        }			
            render resp as JSON			
	}
	def saveNewVendor = {//protected
			def resp, respText;
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
    		params['business.id'] = bizId;
	        def vendor = new Vendor(params)
	        if(!vendor.hasErrors() && vendor.save()) {
	        	respText = 'Save completed.';
	            resp = ["respText":respText, "vendor":vendor];
	        }
	        else {
	        	def errMsgs = [];
        		for(err in vendor.errors.allErrors) 
        			errMsgs.push messageSource.getMessage(err, null) ;	        	
	            resp = ["respText":"Save failed.", errors: errMsgs];
	        }			
            render resp as JSON			
	}	
	def saveResult = { //protected
			def resp;
			def errMsgs = [];
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long; 
    		PlannerEntry entry = PlannerEntry.findWhere(['id': params.entryId as long, 'business.id': bizId]);
			if(params.published == true) {
				if(params.rating == "0")
					errMsgs.push "Rating is required"; 
				if (entry.className == 'news-planner-event') {
					if(!params.placement) //not checked
						errMsgs.push  "Placement is required"; 
					if(params.numberCompetitiveAd == "")
						errMsgs.push  "Number of same-day competitive ads is required"; 
				}
				if(errMsgs.size() > 0) {
					resp = resp = ["respText":"Save failed.", errors: errMsgs];
					render resp as JSON
					return;
				}
			}

			//params['business.id'] = bizId;
    		def published = entry?.result?.published;
    		if(published == true)
    			params.published = true;
			Business biz = Business.get(bizId);
    		String login = authenticationService.getSessionUser().login;
    		entry = getPlannerResult(entry, biz, params);
	        if(!entry.result.hasErrors() && entry.result.save(flush:true)) {
	        	if(params.published) 
	        		updateRatingInfo(entry.portfolioEntry, entry.result, entry);//, entry.portfolioEntry, ratingInfo))
	            resp = ["respText":'Save completed.', "entry":entry];
	        }
	        else {
	        	response.status = 500;
	        	if(entry.result.hasErrors())
	        		for(err in entry.result.errors.allErrors) 
	        			errMsgs.push messageSource.getMessage(err, null);        	
	            resp = ["respText":'Save failed.', errors:errMsgs];
	        }			
            render  resp as JSON			
	}	
	
	def publishResult= {
		params.published = true;
		forward(action:'saveResult');
	}
	
	def getPlannerResult2 ( plannerId, bizId, params) { //protected
		PlannerEntry entry = PlannerEntry.findWhere(['id': plannerId, 'business.id': bizId]);
		Business biz = Business.get(bizId);
   		//String login = authenticationService.getSessionUser().login;
		return getPlannerResult ( entry, biz, params);
	}
	

	def getPlannerResult ( entry, biz, params) { //protected
		println params
		params['business.id'] = biz.id;
		params['author'] = biz.representativeName.split(' ')[0];
		params['location'] = (entry.office ? entry.office.city + " " + entry.office.state : "");
		params['plannerEntry.id'] = entry.id;
		if(entry['portfolioEntryId'])
		         params['portfolioEntry.id'] = entry['portfolioEntryId'];
		if(params.totalExpense)
			params.totalExpense = params.totalExpense.replaceAll(/[^0-9\.]/, '');
		if(params.grossSales)
			params.grossSales = params.grossSales.replaceAll(/[^0-9\.]/, '');
		if(params.returnOnInvest)
			params.returnOnInvest = params.returnOnInvest.replaceAll(/[^0-9\.]/, '');
		if(params.costPerLead)
			params.costPerLead = params.costPerLead.replaceAll(/[^0-9\.]/, '');
		if(params.costPerSale)
			params.costPerSale = params.costPerSale.replaceAll(/[^0-9\.]/, '');

		println params
		if(entry.result == null) {
			if(params.numberCompetitiveAd == "")
				params.numberCompetitiveAd = 0;
			entry.result = new Result(params)
			entry.result.runDate = entry.start;
		}else
			if(params.numberCompetitiveAd == "")
				params.remove('numberCompetitiveAd');
		entry.result.properties = params 
    	return entry;
	}
	
	def updateRatingInfo(portfolioEntry, result, plannerEntry){//, portfolioEntry, oldRating){
		if(portfolioEntry) {
	        def rating =  Result.executeQuery(  """select count(rating), avg(rating) from Result  
	            where published = true and portfolioEntry.id  =? 
	 		    group by portfolioEntry.id""", portfolioEntry.id);
			for(row in rating) {
				int count = row[0] as int;
				if(count > 0){
					portfolioEntry.numRating = count;
					portfolioEntry.rating = row[1] as double;
				}
			}
			
	        def review =  Result.executeQuery("""select count(review) FROM Result  
	            where published = true and review is not null 
	            and portfolioEntry.id  =? 
	 		    group by portfolioEntry.id""", portfolioEntry.id);
			 
			for(reviewCount in review) {
				if(reviewCount > 0){
					portfolioEntry.numReview = reviewCount as int;
				}
			}
			
			if (!portfolioEntry.save(flush:true)) {
				portfolioEntry.errors.each {
					log.error('saving issue ' +it); 
				}
			}
			
						
		}
		
		plannerEntry.costPerLead = result.costPerLead;
		plannerEntry.costPerSale = result.costPerSale;
		plannerEntry.returnOnInvest = result.returnOnInvest;
		plannerEntry.placement = result.placement;
		plannerEntry.save(flush:true);

	}
	
	def updateExpense = { //protected
		println params;
	    def updates = new org.codehaus.groovy.grails.web.json.JSONArray(params.json)
		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long; 
	    def result, respText, totalExpense = 0;
	    PlannerEntry.withTransaction {
			def count = Expense.executeUpdate('delete Expense f where f.plannerEntry.id = ? and f.business.id = ? ' , [params.id as long, bizId]);		    
		    def plannerEntry = getPlannerResult2(params.id as long, bizId, [:]);
		    for (item in updates) {
		        item['plannerEntry.id'] = plannerEntry.id
		        item['business.id'] = bizId
		        item.amount = item.amount.replaceAll(/[^0-9\.]/, '');
		        def p = new Expense(item)
		        p.save()
		        if(p.amount)
		        	totalExpense += p.amount;
		    }
        	 result = plannerEntry.result;
        	 result.totalExpense = totalExpense;
			 plannerEntry.totalExpense = totalExpense;
			 updateRoi(result, plannerEntry );
        	 if(result.hasErrors() || !result.save() || !plannerEntry.save()) {
        		 respText = 'Save failed.'
     	        if(result.hasErrors())
	        		for(err in result.errors.allErrors) 
	        			log.error messageSource.getMessage(err, null) ;	         			 

        	 }
        }
        def resp = ["respText":respText, 'result':result];
        render  resp as JSON			
	}
	
	def updateSale = { //protected
	    def updates = new org.codehaus.groovy.grails.web.json.JSONArray(params.json)
	    params.remove('json');
		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;

	    String respText='Saved completed.';
	    def result;
	    PlannerEntry.withTransaction {
    		def count = Sale.executeUpdate('delete Sale f where f.plannerEntry.id = ? and f.business.id = ? ' , [params.id as long, bizId]);		    
		    def plannerEntry = getPlannerResult2(params.id as long, bizId, [:]);
	    	params['plannerEntry.id'] = plannerEntry.id
	    	params['business.id'] = bizId	
	    	def grossSales = 0;
	    	
		    for (item in updates) {
		    	if(item.saleDate){
			        Date d = Date.parse('MM/dd/yyyy', item.saleDate);
			        def formatter = new java.text.SimpleDateFormat('EEE MMM dd hh:mm:ss z yyyy');
			        params['saleDate_day'] = item.saleDate[3..4] 
			        params['saleDate_month'] = item.saleDate[0..1]
			        params['saleDate_year'] = item.saleDate[6..9];
			        params.saleDate = formatter.format(d);
		    	}
		        params.description = item.description
		        params.amount = item.amount.replaceAll(/[^0-9\.]/, '');
		        println params;
		        def p = new Sale(params);
		         p.save()
		         if(p.hasErrors()){
 	        		for(err in p.errors.allErrors) 
	        			log.error messageSource.getMessage(err, null) ;	  
    		        respText = 'Save failed.'			        
		         }else {
		        	 if(p.amount)
		        		 grossSales += p.amount;
		         }
		    }
        	 result = plannerEntry.result;
        	 result.grossSales = grossSales;
			 plannerEntry.grossSales = grossSales;
			 updateRoi(result, plannerEntry );
        	 println 'saving result';
        	 if(!result.save()) {
        		 println 'saving plannerEntry';
	        	 if(/*result.hasErrors()  ||*/ !plannerEntry.save()) {
	        		 respText = 'Save failed.';
	 	        	for(err in result.errors.allErrors) 
		        			log.error messageSource.getMessage(err, null) ;	  
	        	 }
        	 }
	    }
        def resp = ["respText":respText, "result": result];
        render  resp as JSON			
	}
	
	def updateRoi(result, plannerEntry ) {
		if(result.grossSales != null && result.grossSales != null && result.totalExpense > 0) {
			result.returnOnInvest = (result.grossSales - result.totalExpense) / result.totalExpense * 100;
			plannerEntry.returnOnInvest = result.returnOnInvest;
		}		
	}			
/*	
   	def getDetail = {
			params['tab'] = 1;
    		println params
    		response.setHeader("Pragma", "");
    		render(view: "myTracker")
    }

   	def expenses = {
			params['tab'] = 0;
    		log.debug params
    		response.setHeader("Pragma", "");
    		render(view: "myTracker")
    }
*/	
	
    def updateDetail4UserSimple = { /* protected */
        	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
            def respText, entry = CompetitorAd.findWhere(['business.id':bizId , 'id':params.id as long]);		
    		updateCompetitorAd(entry, params, bizId);
            if(entry.save(flush:true)) {
            	respText = 'Save completed.'
            	println ('send is ' + params.send + ':' + params.send == true)
            } else {
    			for(err in 	entry.errors.allErrors)
            		log.error messageSource.getMessage(err, null) ;	
            	respText 'Save Failed.'  
            	entry = null;
            }

            def resp = [respText:respText,entry:entry]
            render  resp as JSON		
    }
	
	def updateCompetitorAd(ad, params, bizId){/* protected */
		def asso;
		params['business.id'] = bizId;
		if(params['vendor.id']){
			asso = Vendor.findWhere([id:params['vendor.id'] as long, 'business.id':bizId]);
			params.remove('vendor.id');
			ad.vendor = asso;		
		}
		if(params['publication.id']){
			asso = Publication.findWhere([id:params['publication.id'] as long, 'business.id':bizId]);
			params.remove('publication.id');
			ad.publication = asso;		
		}
		if(params['competitor.id']){
			asso = Competitor.findWhere([id:params['competitor.id'] as long, 'business.id':bizId]);
			params.remove('competitor.id');
			ad.competitor = asso;		
		}		
		ad.properties = params;
		return ad;
	}

	
/*	
    def updateDetail4User = { 
			def respText;
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
            CompetitorAd competitorAdInstance = CompetitorAd.findWhere(['business.id':bizId , 'id':params.id as long]);            		
//    		def todosParams, todoInstance, respText, todosTitle = '';
        	if(competitorAdInstance) {
        		params['business.id']  = bizId  
        		competitorAdInstance.properties = params;  	//TO DO blank out association
        	}
            if(competitorAdInstance && competitorAdInstance.save(flush:true)) {
            	respText = 'Save completed.'
            } else {
            	competitorAdInstance.errors.allErrors.each {
    		        log.error it
    			}
            	respText 'Save failed.'  
            }
            def resp = ["respText":respText, "result": competitorAdInstance];
            render  resp as JSON			
    	}
*/
    def deleteCompetitorAd4User = { /* protected */
			def respText;
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long ;
    		println 'deleteCompetitorAd4User ' +  bizId + ':'+ params.id
    		CompetitorAd ad = CompetitorAd.findWhere(['id': params.id as long, 'business.id': bizId]);
    		try {
        		ad.competitor = null;
        		ad.publication = null;
        		ad.vendor = null;
        		ad.business = null;
        		ad.delete(flush:true);
	            respText = 'Delete completed.'
    		}catch(Exception e){
            	respText = 'Delete failed.'  
    		}
            def resp = ["respText":respText]
            render  resp as JSON
    	}

	def deletePlannerEntry4User = { /* protected */
			def respText;
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
    		println 'deletePlannerEntry4User ' +  bizId + ':'+ params.id
    		PlannerEntry entry = PlannerEntry.findWhere(['id': params.id as long, 'business.id': bizId]);
    		try {
	    		entry.portfolioEntry = null;
	    		entry.result = null;
	    		entry.delete(flush:true);
	            respText = 'Delete completed.'
    		}catch(Exception e){
    			log.error ('cannot delete planner entry ' + params.id, e);
            	respText = 'Delete failed.'  
    		}
            def resp = ["respText":respText]
            render  resp as JSON
    	}
	
        def createJson4User = { /* protected */
        	def result ;
        	def bizId = authenticationService.getSessionUser().attributes['businessId'];
        	CompetitorAd competitorAdInstance = new CompetitorAd();
        	updateCompetitorAd(competitorAdInstance, params, bizId);
        	//params['business.id']  = bizId   
            //CompetitorAd competitorAdInstance = new CompetitorAd(params); //TO DO blank out association
        	competitorAdInstance.title = competitorAdInstance.getTitle(competitorAdInstance.className, bizId as long, competitorAdInstance.start);
        	if(competitorAdInstance.hasErrors()) {
        		for(err in competitorAdInstance.errors.allErrors) 
        			log.error messageSource.getMessage(err, null) ;	  
                result = ["respText":'Save failed.'];
                render result as JSON;
        	}

        	if(!competitorAdInstance.save(flush:true)) {
        		for(err in competitorAdInstance.errors.allErrors) 
        			log.error messageSource.getMessage(err, null) ;
                result = ["respText":'Save failed.'];
                render result as JSON;
        	}
        	
        	//result = ["respText":'Save completed.', 'competitorAd': competitorAdInstance];
            render competitorAdInstance as JSON
        }

		def listPlannerAd4User = { /* protected */
			params.ctrl = params.controller;
			forward(controller:'myPlanner', action:'listJson4User');
		}
	
        def listJson4User = { /* protected */
        	def bizId = authenticationService.getSessionUser().attributes['businessId']; 
            def vendors, publications, competitors;
            def entriesVendors  = new ArrayList();

            if (params['get-offices'] && 'true' == params['get-offices']) {
            	vendors = Vendor.listVendors (bizId as long)
            	publications = Publication.listPub (bizId as long)
            	competitors = Competitor.listCompetitors (bizId as long)
            }
        	params.businessId = bizId  
        	def entries =  CompetitorAd.listEntriesByBusinessByDateRange(params)

/*        	
            if (params['get-entries-offices'] && 'true' == params['get-entries-offices']) {
    	    	for(int i=0; i<entries.size() ; i++) {
    	    		if (entries[i].vendors) {
    	    			Iterator iter = entries[i].vendors.iterator();
    	    			while (iter.hasNext())  {
    	    		     Vendor vendor = (Vendor) iter.next();
    	    		     def hashmap = new HashMap();
    	    		     hashmap.put('competitorAdId', entries[i].id as Long)
    	    		     hashmap.put('vendorId', vendor.id as Long)
    	    		     entriesVendors.add hashmap
    	    			}
    	    		}
    	    		
    	    	}
            }
*/            
           	def result = ["entries": entries,
        	              "vendors": vendors  ? vendors : [],
        	              "competitors": competitors  ? competitors : [],
        	              "publications": publications ? publications : [],
        	              "ctrl" : params.controller]
    		response.contentType = "text/javascript; charset=UTF-8"  
    		response << params.callback  //+ '( { "entries" :'
            render result as JSON
    		
            //response << ')};'
        } 

	def unselectAdImage = {
    	long bizId = authenticationService.getSessionUser().attributes['businessId']; 
		def ad = CompetitorAd.findAd( params['id'] as long, bizId );
		def resp;
		if( ad ) {
			ad.imageFile = null;
	        resp = ["respText":"Save completed."];
        } else
	        resp = ["respText":"Save Failed."];			
        render resp as JSON			
    }
	
	def uploadAdImage = {
		log.warn "uploadAdImage"
		log.warn params
		if (  params.int("id") && params.name && params.file){
        	long bizId = authenticationService.getSessionUser().attributes['businessId']; 
			def ad = CompetitorAd.findAd( params['id'] as long, bizId ) //TO DO check again
			println 'bizId=' + bizId
			if( ad ) {
//				println 1
				String dirname = getUploadDir(params.id, bizId);
				File dir = new File(dirname);
				if(dir.exists() || dir.mkdirs()) {
					File file = new File ( dirname + params.name );
					params['file'].transferTo(file);
					ad.imageFile = params.name;
					response.writer.write  "Upload completed";	
					if(log.isDebugEnabled())
						log.debug ("upload file to " +file.getAbsolutePath())
				}else {
//					println 2
					response.status = 500;
					render "Upload failed";	
				}
			} else {
//				println 3
				log.error params.action+':402'+params.id+':'+bizId;
				response.writer.write "Upload failed";	
				response.status = 402;
			}				
		} else {
//			println 4
			response.status = 500;
			response.writer.write  "Upload failed";
		}
		if(! response.isCommitted())
			response.flushBuffer()			
    }

	def getImageFile = {
    		//println (request.getRequestURI())
    		println (request.getRequestURI() + ";" + params.params )
        	long bizId = authenticationService.getSessionUser().attributes['businessId']; 
			def ad = CompetitorAd.findAd( params['id'] as long, bizId )
			if(ad) {
				//String file = ad.imageFile ? getUploadDir(params.id, bizId) + ad.imageFile	: "Transparent.gif";
				sendResponse(getAdImageFile(params.id, bizId, ad.imageFile));
			}else {
				response.status = 500;
				if(! response.isCommitted())
					response.flushBuffer()	
			}
    	}	
	
    private String getUploadDir(String id, long bizId) {
		return message(code:"inthedoor.userContent.root.dir") + 
				'competitionAd' + File.separator + bizId + File.separator + id + File.separator;
    }
    
    private String getAdImageFile(String id, long bizId, String file) {
		if(file)
			return message(code:"inthedoor.userContent.root.dir") + 
				'competitionAd' + File.separator + bizId + File.separator + id + File.separator + file;
		else
			return message(code:"inthedoor.portfolio.root.dir") + File.separator + "Transparent.gif";
    }

	private void sendResponse(String result) { 	

	java.io.FileInputStream is;
	is = new java.io.FileInputStream( result );    			
	org.apache.commons.io.IOUtils.copy(is,response.outputStream)
	//println ("done reading file " + message(code:"inthedoor.portfolio.root.dir") + result)	
	if(! response.isCommitted())
		response.flushBuffer()		
	}

}
