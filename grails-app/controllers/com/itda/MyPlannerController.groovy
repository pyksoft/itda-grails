package com.itda
import java.util.Date;
import grails.converters.JSON;

class MyPlannerController {
	def authenticationService
	def asynchronousMailService
	def messageSource 
	
	def listMissingFiles = {
		
		
		def list = Business.findAll();
			def results = [:];
		for(biz in list) {
	   		def entries = PlannerEntry.findAllWhere('business.id':biz.id);
			for(entry in entries) {
				String dirname = getUploadDir(entry.id , entry.business.id as long);
				File file = null;
				if(entry.imageFile != null) {
					file = new File ( dirname + entry.imageFile );
					if(!file.exists()) {
						results.put(dirname + entry.imageFile, 'missing');
					}
				}
				if(entry.pdfFile != null) {
					file = new File ( dirname + entry.pdfFile );
					if(!file.exists()) {
						results.put(dirname + entry.pdfFile, 'missing');
					}
				}
	
			}
		}
		render results as JSON;
	}
	
    def index = {
		def start, end;
		def cal =  Calendar.getInstance();
		start = cal.get(Calendar.YEAR) - 10;
		end = start + 20;
      	render(view: "planner", model:[start:start,end:end]);
    }
	
    def getDetail = {
    		println params
    		render(view: "manageDetail")
     }

	def selectPortfolioEntry = {
		def respText, entry;
   		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long; 
        entry = PlannerEntry.findWhere(['business.id':bizId , 'id':params.id as long]);	
   		if(entry && params.selectedId && params.selectedId != 'undefined'){
            def portEntry = PortfolioEntry.getMyPortfolioEntry(params.selectedId, params.color); 
            if(portEntry){
            	entry.portfolioEntry = portEntry;
	            entry.color = portEntry.color + 'C';
	            entry.size = portEntry.adSizeCode;
            }else
            	entry.portfolioEntry = null;
		}else if(entry) {
			entry.portfolioEntry = null;
			entry.imageFile = null;
		}
		updateResultPortfolioId (entry);		
//println (params)            
        if(entry && entry.save(flush:true)) {
        	respText = 'Save completed.'
        } else {
        	if (entry)
        		for(err in 	entry.errors.allErrors)
        			log.error messageSource.getMessage(err, null) ;	
        	respText 'Save Failed.'  
        	//entry.portfolioEntry = null;
        }
		def portEntry = (entry?.portfolioEntry ? entry.portfolioEntry : null);
		def portfolioDesc = (entry?.portfolioEntry ? entry.portfolioEntry.portfolio.description : null)
        def resp = [respText:respText, portEntry:portEntry, portfolioDesc:portfolioDesc];
        render  resp as JSON
	}
	

	
	def saveSendToVendorInfo = {
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
        def respText, entry = PlannerEntry.findWhere(['business.id':bizId , 'id':params.id as long]);		
		//if(saveMyPlannerEntry(entry, params, bizId)){
		SendToVendor stvInfo = saveMySendToVendorInfo(entry, params, bizId);
		if(stvInfo){
        	respText = 'Save completed.'
        	println ('send is ' + params.send + ':' + params.send == true)
            if(params.send == 'true') {
            			sendToVendor(entry, getVendor(entry), stvInfo); 
            			stvInfo.sentToVendor = true;
            			if(!stvInfo.save(flush:true))
            				for(err in 	stvInfo.errors.allErrors)
            	        		log.error messageSource.getMessage(err, null) ;	
            }
        } else {
			//for(err in 	entry.errors.allErrors)
        		//log.error messageSource.getMessage(err, null) ;	
        	respText = 'Save Failed.';  
        	entry = null;
        }

        def resp = [respText:respText,entry:stvInfo, plannerEntryId:entry.id]
        //render  resp as JSON
		render(template:"sendToVendor_templ",model:resp, contentType:"text/json");
			
	}
	
	def getSendToVendorDetail = {
		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long
		//def entry = PlannerEntry.findWhere(['business.id':bizId , 'id':params.id as long]);
		def entry = SendToVendor.findWhere(['business.id':bizId , 'plannerEntry.id':params.id as long]);
		def resp = [respText:"Completed",entry:entry, plannerEntryId:params.id]
		render(template:"sendToVendor_templ",model:resp, contentType:"text/json");
	}

	def saveMySendToVendorInfo(entry, params, long bizId){
		log.debug('saveMySendToVendorInfo: ' + params);
		log.debug('saveMySendToVendorInfo: ' + entry);
		params['business.id']  = bizId ;
		params['plannerEntry.id']  = entry.id ;
		params.remove('uuid');
		params.remove('termsUuid');
		//uncheck checkboxes
		if(params['changePhoneFlag'] == null) 
			params['changePhoneFlag'] = false;
		if(params['changeDatesFlag'] == null) 
			params['changeDatesFlag'] = false;
		if(params['changeOffersFlag'] == null) 
			params['changeOffersFlag'] = false;
		if(params['changeLogoFlag'] == null) 
			params['changeLogoFlag'] = false;
		if(params['changeExpireDatesFlag'] == null) 
			params['changeExpireDatesFlag'] = false;
		if(params['changeAddressFlag'] == null) 
			params['changeAddressFlag'] = false;

		SendToVendor stvInfo = SendToVendor.findWhere('business.id':bizId, 'plannerEntry.id': entry.id);
		if(stvInfo)
			stvInfo.properties = params;
		else {
			params.termsUuid = java.util.UUID.randomUUID().toString();
			params.uuid = java.util.UUID.randomUUID().toString();
			stvInfo = new SendToVendor(params);
		}
		
		if(stvInfo.save(flush:true)) {
			return stvInfo;
		} else {
			for(err in 	stvInfo.errors.allErrors)
				log.error messageSource.getMessage(err, null) ;
			return null;
		}
	}

		
	def saveMyPlannerEntry(entry, params, long bizId){
		//zipcodes, 
		//todos, result, expenses, sales		
		//vendor, publication, office, 
    	params['business.id']  = bizId ;
		params.remove('sales');
		params.remove('expenses');
		params.remove('todos');
		params.remove('result.id');
		params.remove('portfolioEntry.id');
		def asso;

		if(params['zipcodes[]']){
			params.zipcodes = params['zipcodes[]'];
			params.remove('zipcodes[]');
		}
		if(params['vendor.id']){
			asso = Vendor.findWhere([id:params['vendor.id'] as long, 'business.id':bizId]);
			params.remove('vendor.id');
			entry.vendor = asso;		
		} 
		if(params['publication.id']){
			asso = Publication.findWhere([id:params['publication.id'] as long, 'business.id':bizId]);
			params.remove('publication.id');
			entry.publication = asso;		
		} 
		if(params['office.id']){
			asso = Office.findWhere([id:params['office.id'] as long, 'business.id':bizId]);
			params.remove('office.id');
			if(entry.office && entry.office.id != asso?.id)
				entry.zipcodes = null;
			entry.office = asso;		
		}

		entry.properties = params   ;	
        if(entry.save(flush:true)) {
        	return true;
        } else {
			for(err in 	entry.errors.allErrors)
        		log.error messageSource.getMessage(err, null) ;	
			return false;
        }		
	}
	def repeatPlannerEntry(entry, params, long bizId){
		if(params['repeatDates'] instanceof String)
			params['repeatDates'] = [params['repeatDates']];
		//def portEntryId = entry.portfolioEntry.?id;
		//println 'portEntryId ' + portEntryId;
		def prop = [color : entry.color, 
		            size : entry.size,
		            quantity: entry.quantity,
		            imageFile: entry.imageFile,
					pdfFile: entry.pdfFile,
		            selfNotes: entry.selfNotes,
		            vendorNotes: entry.vendorNotes,
		            otherSize : entry.otherSize,
		            className : entry.className,
		            //deadline : entry.deadline,
		            'business.id': bizId];
		if( entry.portfolioEntry)
		  prop['portfolioEntry.id'] = entry.portfolioEntry.id;
		def arrList = [];
		log.debug "params['repeatDates'] " + params['repeatDates'];
		
		
		for(rDate in params['repeatDates']){
			log.debug 'clonning ' + rDate;
			prop.start = new java.sql.Date(Date.parse('yyyy/MM/dd', rDate).getTime()); 
            prop.title = getTitleString (entry, bizId, prop.start);

			def clone = new PlannerEntry(prop);

			def todos = [];
			for(PlannerTodo todo in entry.todos) {
				PlannerTodo td = new PlannerTodo();
				td.title = todo.title;
				td.plannerEntry = clone;
				todos.add (td);
			}
			if(todos.size() > 0)
				clone.todos = todos;

			if(!clone.save())
				for(err in 	clone.errors.allErrors)
	        		log.error messageSource.getMessage(err, null) ;	
			else {
				arrList.add clone;
				if(entry.imageFile || entry.pdfFile)
					copyImageAndPdfFiles (clone, entry, bizId);
			}	
			
		}
        def resp = [respText:'Save completed.',entries:arrList];
        render  resp as JSON;	
	}
	def getVendor(entry){
		if(entry.className == 'news-planner-event')
			//return Publication.findWhere([id:entry['publicationId']]);
			return entry.publication;
		else
			//return Vendor.findWhere([id:entry['vendorId']]);
			return entry.vendor;
	}
	def sendToVendor(entry, vendor,sendToVendor) {
		println 'sending email to ' + sendToVendor.toEmail
		def ccaddresses = (sendToVendor.cc && sendToVendor.cc.trim() != '' ) ? sendToVendor.cc : [];
		String sender = message(code:"inthedoor.email.customerService");
		asynchronousMailService.sendAsynchronousMail {
			to sendToVendor.toEmail
			cc	ccaddresses
			from sender
			subject sendToVendor.subject
			body( view:"/myPlanner/sendToVendorEmail", 
					model:[entry:entry,vendor:vendor, sendToVendor:sendToVendor]);
		}		
	}

    def updateDetail4UserSimple = { /* protected */
        	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
        	def respText, entry = PlannerEntry.findWhere(['business.id':bizId , 'id':params.id as long]);

        	if(params['repeatDates']){
        		repeatPlannerEntry(entry, params, bizId);
        		return;
        	}    
        	
            if(saveMyPlannerEntry(entry, params, bizId)) {
            	respText = 'Save completed.';
            } else {
            	respText 'Save Failed.'  
            	entry = null;
            }

            def resp = [respText:respText,entry:entry];
            render  resp as JSON		

    }

    /*	
	def addAssociation(map, entry, params) {
    	if(params.vendors)
    		map['vendors'] = entry.vendors ;
    	else if(params.publications)
    		map['publications'] = entry.publications;
    	else if(params.offices)
    		map['offices'] = entry.offices ;
    }
*/    
    //def findOffices(long bizId) {
    //   	return Office.findAll("from Office as o where o.business.id=:bizId and o.availability <> 'false'",[bizId: bizId]) ;  	
    //}
    def addTodo = { 
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
            PlannerEntry plannerEntryInstance = PlannerEntry.findWhere(['business.id':bizId , 'id':params.id as long]);
        	if(plannerEntryInstance && params.title && params.title.trim() != '') {
    		    def  todoInstance = new PlannerTodo(title:params['title'], plannerEntry:plannerEntryInstance);
    			if(plannerEntryInstance.todos)
    				plannerEntryInstance.todos.add(todoInstance);
    			else {
    				Set todoSet = new HashSet();
    				todoSet.add(todoInstance);
    				plannerEntryInstance.todos = todoSet;
    			}
        	}
        	def respText;
            if(plannerEntryInstance && plannerEntryInstance.save(flush:true)) {
            	respText = 'Save completed.';
            } else {
    			for(err in 	entry.errors.allErrors)
            		log.error messageSource.getMessage(err, null) ;	
            	respText 'Save Failed.'  ;
            	//entry = null; 
            }
            def resp = [respText:respText,todos:plannerEntryInstance.todos]
            render  resp as JSON        	

    }
  
    def saveTodos = { 
		def respText;
		def plannerAd;
			long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
	         plannerAd = PlannerEntry.findWhere(['business.id':bizId , 'id':params.id as long]);
	    	if(plannerAd) {
	    		   PlannerEntry.withTransaction {
	    			   for(todo in  plannerAd.todos){
		    	   		   if(params[todo.id as String]){
		    	   			   todo.isCompleted = true;
		    	   		   }else{ 
		    	   			   todo.isCompleted = false;
		    	   		   }
	    			   	}
		    		   if(plannerAd.save())
		    			   respText = 'Save completed.';
		    		   else
		    			   respText = 'Save failed.';
	    		   	}
	    	}   	
	        def resp = [respText:respText,todos:plannerAd?.todos]
	        render  resp as JSON        	
    }
    
    def deleteTodo = { 
    		def respText;
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
            PlannerEntry plannerEntryInstance = PlannerEntry.findWhere(['business.id':bizId , 'id':params.entryId as long]);
        	if(plannerEntryInstance) {
    		    def  todoInstance = PlannerTodo.findWhere(['plannerEntry.id':plannerEntryInstance.id , 'id':params.id as long]);
    		   println  plannerEntryInstance.todos.size()
 
    		   //try{
	    		   PlannerEntry.withTransaction {
	    			   def todos = plannerEntryInstance.todos;
	    	   		    todos.remove(todoInstance);  
	    	   		    plannerEntryInstance.todos = todos;
	    	   		    try{
		    		        todoInstance.delete() 
	    	   		    }catch(Exception e){
	    	   		    	log.error e
	    	   		    }
		    		    respText = 'Save completed.';
	    		   }
    		   //}catch(Exception e){
    			//   log.error e
    		   //}
        	}
 		   //println  plannerEntryInstance.todos.size()
        	
            def resp = [respText:respText,todos:plannerEntryInstance.todos]
            render  resp as JSON        	

    }    
    	
        def createJson4User = { /* protected */
    		if(params['className[]']){
    			def eventType = params['className[]'];//jquery bug
    			params.remove('className[]');
    			params['className'] = eventType;
    		}
        	def bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
        	params['business.id']  = bizId ;   
    		params.remove('sales');
    		params.remove('expenses');
    		params.remove('todos');
    		params.remove('result.id');
    		params.remove('portfolioEntry.id');
			params.remove('zipcodes[]');
			params.remove('vendor.id');
			params.remove('publication.id');
			params.remove('office.id');
            PlannerEntry plannerEntryInstance = new PlannerEntry( params);
            plannerEntryInstance.title = getTitleString (plannerEntryInstance, bizId, plannerEntryInstance.start);
            //plannerEntryInstance.start = new java.sql.Date(plannerEntryInstance.start.getTime());
        	if(!plannerEntryInstance.save(flush:true)) {
        		println "not saved"
        	    if(plannerEntryInstance.hasErrors()) {
	        		plannerEntryInstance.errors.allErrors.each {
	    		        log.error it
	                    def result = ["respText":'Save failed.'];
	                    render result as JSON;
	    			}
        	    }
        	}
            render plannerEntryInstance as JSON
        }
	
		def getTitleString(PlannerEntry plannerEntryInstance, long bizId, java.sql.Date start) {
			String classname = plannerEntryInstance.className; 
			//println ':'+PortfolioEntry.start + ":" + bizId +':' + start +':'
			def count = PlannerEntry.executeQuery('select count(e) from PlannerEntry e where e.className = ? and e.business.id = ? and start = ?',
					classname, bizId, start);
			return plannerEntryInstance.getTitlePrefix(classname)  +  (count[0]+1);
		}
	

    /*    
        def getJson4User = {
            def plannerEntryInstance = PlannerEntry.get(params.id)
            if (!plannerEntryInstance) {
                flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'plannerEntry.label', default: 'PlannerEntry'), params.id])}"
                redirect(action: "list")
            }
            else {
                render plannerEntryInstance as JSON
            }
        }
     */   
        def listJson4User = { /* protected */
        	def bizId = authenticationService.getSessionUser().attributes['businessId'] 
            def offices, vendors, manufacturers, publications
            def entriesTodos = new ArrayList();
            def entriesSales = new ArrayList();
            def entriesExpenses = new ArrayList();
            

            if (params['get-offices'] && 'true' == params['get-offices']) {
            	offices = Office.findAll("from Office as o where o.business.id=:bizId and o.availability <> 'false'",[bizId: bizId as long])
            	vendors = Vendor.listVendors (bizId as long)
            	//manufacturers = Manufacturer.listManufacturers (bizId as long)
            	publications = Publication.listPub (bizId as long)
            }
        	params.businessId = bizId  
        	def entries =  PlannerEntry.listEntriesByBusinessByDateRange(params)

            if (params['get-entries-offices'] && 'true' == params['get-entries-offices']) {
    	    	for(int i=0; i<entries.size() ; i++) {
	   	           	if (params.view) {
	    	    		if (params.view && entries[i].sales) {
	    	    			def formatter = new java.text.SimpleDateFormat('MM/dd/yyyy');
	    	    			Iterator iter = entries[i].sales.iterator();
	    	    			while (iter.hasNext())  {
	    	    		     Sale sale = (Sale) iter.next();
	    	    		     def hashmap = new HashMap();
	    	    		     hashmap.put('entryId', entries[i].id as Long)
	    	    		     hashmap.put('id', sale.id as Long)
	    	    		     hashmap.put('description', sale.description)
	    	    		     hashmap.put('amount', sale.amount) ;
							 if(sale.saleDate)
								 hashmap.put('saleDate', formatter.format(sale.saleDate)); 
	    	    		     entriesSales.add hashmap
	    	    			}
	    	    		} 
	    	    		if ( params.view && entries[i].expenses) {
	    	    			Iterator iter = entries[i].expenses.iterator();
	    	    			while (iter.hasNext())  {
	    	    			 Expense exp = (Expense) iter.next();
	    	    		     def hashmap = new HashMap();
	    	    		     hashmap.put('entryId', entries[i].id as Long)
	    	    		     hashmap.put('id', exp.id as Long)
	    	    		     hashmap.put('description', exp.description)
	    	    		     hashmap.put('amount', exp.amount)
	    	    		     entriesExpenses.add hashmap
	    	    			}
	    	    		}
	   	           	}else{
	    	    		if (entries[i].todos) {
	    	    			Iterator iter = entries[i].todos.iterator();
	    	    			while (iter.hasNext())  {
	    	    		     PlannerTodo todo = (PlannerTodo) iter.next();
	    	    		     def hashmap = new HashMap();
	    	    		     hashmap.put('entryId', entries[i].id as Long)
	    	    		     hashmap.put('id', todo.id as Long)
	    	    		     hashmap.put('title', todo.title)
	    	    		     hashmap.put('isCompleted', todo.isCompleted)
	    	    		     entriesTodos.add hashmap
	    	    			}
	    	    		}	   	           		
	   	           	}
    	    	}
            }
           	def result = ["entries": entries,
        	              "offices": offices,
        	              "vendors": vendors,
        	              "publications": publications,
        	              "ctrl": 'myPlanner'];
           	if (params.view) {
           		result['entriesExpenses'] = entriesExpenses;
           		result['entriesSales'] = entriesSales;
           	}else {
           		def biz = Business.findWhere(id:bizId);
           		result['business'] = biz.businessName;
	            result["entriesTodos"] = entriesTodos;
           		result['today'] = 
           			(new java.text.SimpleDateFormat('MM/dd/yyyy')).format(new Date());
           	}
    		response.contentType = "text/javascript; charset=UTF-8"  
    		response << params.callback  //+ '( { "entries" :'
            render result as JSON
    		
            //response << ')};'
        }
	
    def deleteEntry4User = { /* protected */
			def respText;
    		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long 
    		println "---------------------------"+bizId+':'+params.id
    		def count = PlannerEntry.executeUpdate('delete PlannerEntry f where f.id = ? and f.business.id = ? ' , [params.id as long, bizId]);
        	if(count > 0) {
            	respText = 'Delete completed.'
            } else {
            	respText 'Delete Failed.'  
            }
            def resp = ["respText":respText]
            render  resp as JSON
    	}
        
    	def uploadAdImage = {
        		log.warn "uploadAdImage"
        		log.warn params
        		if (  params.int("id") && params.name && params.file){
                	long bizId = authenticationService.getSessionUser().attributes['businessId']; 
        			def ad = PlannerEntry.findWhere( [id:params['id'] as long, 'business.id':bizId] );
        			println 'bizId=' + bizId
        			if( ad ) {
        				def imageFileTypes = ['JPG', 'JPEG', 'GIF', 'PNG']
        				String dirname = getUploadDir(params.id, bizId);
        				File dir = new File(dirname);
        				if(dir.exists() || dir.mkdirs()) {
        					File file = new File ( dirname + params.name );
        					params['file'].transferTo(file);
							String[] components = params.name.split("\\.");
							String fileExt = components[components.length-1];
							log.debug("fileExt:" + fileExt +":" + imageFileTypes.contains(fileExt.toUpperCase()) +":" + imageFileTypes);
							if(imageFileTypes.contains(fileExt.toUpperCase()))
        						ad.imageFile = params.name;
							else
        						ad.pdfFile = params.name;
        					ad.portfolioEntry = null;
							updateResultPortfolioId (ad);
							ad.save();
        					response.writer.write  "Upload completed";	
        					if(log.isDebugEnabled())
        						log.debug ("upload file to " +file.getAbsolutePath())
        				}else {
//        					println 2
        					response.status = 500;
        					render "Upload failed";	
        				}
        			} else {
//        				println 3
        				log.error params.action+':402'+params.id+':'+bizId;
        				response.writer.write "Upload failed";	
        				response.status = 402;
        			}				
        		} else {
//        			println 4
        			response.status = 500;
        			response.writer.write  "Upload failed";
        		}
        		if(! response.isCommitted())
        			response.flushBuffer()			
            }
		
        	def updateResultPortfolioId (plannerEntry) {
				if(plannerEntry.result && plannerEntry.portfolioEntry) {
					plannerEntry.result.portfolioEntry = plannerEntry.portfolioEntry;
				}
			}

        	def getImageFile = {
            		//println (request.getRequestURI())
            		println (request.getRequestURI() + ";" + params )
                	long bizId = authenticationService.getSessionUser().attributes['businessId']; 
        			def ad = PlannerEntry.findWhere( [id:params['id'] as long, 'business.id':bizId] );
        			if(ad) {
        				String file = getUploadDir(params.id, bizId) + ad.imageFile;
        				println (file )
        				sendResponse(file);
        			}else {
        				response.status = 500;
        				if(! response.isCommitted())
        					response.flushBuffer()	
        			}
            	}	
        	
        	
            private String getUploadDir(def id, long bizId) {
        		String baseDir = message(code:"inthedoor.userContent.root.dir") + 
        		'plannerEntry' + File.separator + bizId + File.separator + id + File.separator;
            }

        	private void sendResponse(String result) { 
        		if ( result == null ) 
        			result = "Transparent.gif"    	
        	//response.setHeader("Pragma", "")
        	//response.setHeader("Cache-Control", "private")
        	//Calendar cal = Calendar.getInstance()
        	//cal.add(Calendar.DAY_OF_YEAR,35)
        	//response.setDateHeader("Expires", cal.getTimeInMillis())
        	//response.contentType = "application/octet-stream"
        	//if ( result == null ) 
        		//result = "Transparent.gif"
        	//println ("reading file " + message(code:"inthedoor.portfolio.root.dir") + result)
        	java.io.FileInputStream is;
        	is = new java.io.FileInputStream( result );    			
        	//if(params.download) {
        		//def index = result.lastIndexOf('/')
        		//def filename = result.substring(index+1)
        		//response.setHeader( 'Content-Disposition',	'attachment; filename="'+ filename +'"');
        	//}
        	org.apache.commons.io.IOUtils.copy(is,response.outputStream)
        	//println ("done reading file " + message(code:"inthedoor.portfolio.root.dir") + result)	
        	if(! response.isCommitted())
        		response.flushBuffer()		
        	}    
			
			private boolean copyImageAndPdfFiles (PlannerEntry newAd, PlannerEntry copiedAd, long bizId) {

				String dirname = getUploadDir(newAd.id, bizId);
				File dir = new File(dirname);
				if(dir.exists() || dir.mkdirs()) {
					String copieddirname = getUploadDir(copiedAd.id , bizId);
					File copiedfile = new File ( copieddirname + copiedAd.imageFile );
					if(copiedfile.exists()) {
						File file = new File ( dirname + newAd.imageFile );
						org.apache.commons.io.FileUtils.copyFile(copiedfile, file);
						log.debug ("copied file to " +file.getAbsolutePath());
					}
					
					copiedfile = new File ( copieddirname + copiedAd.pdfFile );
					if(copiedfile.exists()) {
						File file = new File ( dirname + newAd.pdfFile );
						org.apache.commons.io.FileUtils.copyFile(copiedfile, file);
						log.debug ("copied file to " +file.getAbsolutePath());
					}
					return true;
				}else {
					return false;
				}
			}  
}
