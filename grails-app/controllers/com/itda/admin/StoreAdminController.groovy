package com.itda.admin

import com.itda.Portfolio;
import com.itda.PortfolioEntry;
import com.itda.PortfolioBaseController;
import com.itda.admin.ItdaAttribute;

import java.util.HashMap;
class StoreAdminController  extends PortfolioBaseController{
	
	def portfolioService;

	def index = {
	}
	
	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		if(! params.sort) {
			params.sort = 'portfolioDate'
			params.order  ='desc'
		}
		def c = Portfolio.createCriteria()
 		def portfolios = c.list(max:params.max, offset:params.offset, sort: params.sort, order:params.order) {
			and {
				eq("category", Portfolio.AD_STORE_CATEGORY)
			    eq("deleted", false)
			}
		}
		[portfolioInstanceList: portfolios, portfolioInstanceTotal: portfolios.totalCount]
	}
	
    def create = {
        def portfolioInstance = new Portfolio();
        portfolioInstance.properties = params;
		portfolioInstance.status = Portfolio.INACTIVE_STATUS;
        return [portfolioInstance: portfolioInstance, manufacturerCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')];
    }

    def save = {
        def portfolioInstance = new Portfolio(params);
		portfolioInstance.category = Portfolio.AD_STORE_CATEGORY;
		portfolioInstance.state = Portfolio.CREATED_STATE;
		portfolioInstance.portfolioDate =  new Date();
		try{
			if (portfolioInstance.save(flush: true)) {
				File contentDir = new File(getAdStoreRootDir() + portfolioInstance.id);
				boolean mkdir = (contentDir.exists() || contentDir.mkdirs());
				if(mkdir){
		            flash.message = "Ad collection created";
		            redirect(action: "show", id: portfolioInstance.id);
					return;
				}else				
		            flash.message = "Failed to create new directory for new ad collection";
	        }
		}catch(Throwable e){
			log.error(e, "failed to created new ad collection");
			log.error(params);			
		}
		
       render(view: "create", model: [portfolioInstance: portfolioInstance,
                                      	manufacturerCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')]);
    }
	
    def show = {
        def portfolioInstance = Portfolio.get(params.id)
        if (!portfolioInstance) {
            flash.message = "Ad collection not found"
            redirect(action: "list")
        }
        else {
            [portfolioInstance: portfolioInstance]
        }
    }

    def edit = {
        def portfolioInstance = Portfolio.get(params.id)
        if (!portfolioInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: ['Collection', params.id])}"
            redirect(action: "list")
        }
        else {
            return [portfolioInstance: portfolioInstance, 
				manufacturerCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')];
        }
    }

    def update = {
        def portfolioInstance = Portfolio.get(params.id)
        if (portfolioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (portfolioInstance.version > version) {
                    
                    portfolioInstance.errors.rejectValue("version", "default.optimistic.locking.failure", 
						[message(code: 'portfolio.label', default: 'Portfolio')] as Object[], 
						     "Another user has updated this Portfolio while you were editing");
                    render(view: "edit", model: [portfolioInstance: portfolioInstance,
						manufacturerCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')]);
                    return;
                }
            }
            portfolioInstance.properties = params;
            if (!portfolioInstance.hasErrors() && portfolioInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: ['Collection', portfolioInstance.id])}";
                redirect(action: "show", id: portfolioInstance.id);
            }
            else {
                render(view: "edit", model: [portfolioInstance: portfolioInstance, 
				manufacturerCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')]);
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: ['Collection', params.id])}";
            redirect(action: "list");
        }
    }

    def delete = {
        def portfolioInstance = Portfolio.get(params.id)
        if (portfolioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (portfolioInstance.version > version) {
                    
                    portfolioInstance.errors.rejectValue("version", "default.optimistic.locking.failure", 
					  [] as Object[], "Another user has updated this collection while you were editing");
                    render(view: "edit", model: [portfolioInstance: portfolioInstance,
                                         manufacturerCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')]);
                    return;
                }
            }
            if (portfolioService.markPortfolioAsDelete(portfolioInstance)) {
                flash.message = portfolioInstance.description + " collection deleted";
                redirect(action: "list");
            }
            else {
                render(view: "edit", model: [portfolioInstance: portfolioInstance, manufacturerCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: ['Portfolio', params.id])}";
            redirect(action: "list");
        }
    }
	
	
    public String getAdStoreRootDir() {
		String baseDir = message(code:"inthedoor.adStore.root.dir");  
		return baseDir;
    }

	public getAdCollectionRootDir (portfolioInstance) {
		String baseDir = message(code:"inthedoor.adStore.root.dir");  
		baseDir	+= portfolioInstance.id
		return baseDir;
		
	}

    def uploadZipContent = {
    	
		log.warn "uploadZipContent"
		log.warn params
    	def fileName = params.name;

		if ( null == fileName )
		{
			render(view:'uploadZipContent')
			return;
		}

		def portfolioInstance = Portfolio.get(params.id)
		def portDir = getPortfolioBaseDir(portfolioInstance);

		File file = new File (  portDir + File.separatorChar + fileName );
        if(file.exists()) {
            log.warn  "File with the same name exists on th server for this portfolio:" + fileName;
            File renamedFile = new File ( portDir + File.separatorChar +  System.currentTimeMillis() + '-' + fileName  );
            file.renameTo (renamedFile);
            log.warn "Renamed existing file for this portfolio to " + renamedFile.getName();
            file.delete();
			file = new File ( portDir + File.separatorChar + fileName  );
        }
		params['file'].transferTo(file);
		
		def ant = new AntBuilder()   // create an antbuilder
		File portContentDir = new File( portDir
						+ File.separatorChar + "content");//CONTENT_DIR_NAME );
		portContentDir.mkdir();

		ant.unzip(  src:file.absolutePath,
				dest:portContentDir.absolutePath,
				overwrite:"false" );	
		portfolioInstance.uploadZipName = fileName;
		portfolioInstance.state = "Uploaded";
		
        if (portfolioInstance.save(flush: true)) {
            flash.message = "Collection Content File Uploaded"
            redirect(action: "show", id: portfolioInstance.id)
        }
        else {
            render(view: "edit", model: [portfolioInstance: portfolioInstance,manufacturerCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')])
        }
    }
	
    def listCollectionEntries = {
		if (! params.collectionId )
			return new ArrayList()
		if (! params.offset )
			 params.offset = 0;
        //params.max = Math.min( params.max ? params.max.toInteger() : 1000,  1000)
		params.max = 1000;
		def results = PortfolioEntry.listCollectionEntries(params.collectionId as long);
		render(view:"listCollectionEntries", model:[portfolioEntryInstanceList:results, 
		                           portfolioEntryInstanceTotal:results.size(), collectionId:params.collectionId])
    }
	
    def showAdEntry = {
        def portfolioEntryInstance = PortfolioEntry.findWhere( id: params.id as long, category: Portfolio.AD_STORE_CATEGORY);

        if(!portfolioEntryInstance) {
            flash.message = "Ad Entry not found with id ${params.id}"
            redirect(action:listCollectionEntries, params:[collectionId: params.collectionId])
        }
        else { return [ portfolioEntryInstance : portfolioEntryInstance ] }
    }
	
    def updateAdEntry = {
        def portfolioEntryInstance = PortfolioEntry.findWhere( id: params.id as long, category: Portfolio.AD_STORE_CATEGORY);

        if(portfolioEntryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(portfolioEntryInstance.version > version) {
                    
                    portfolioEntryInstance.errors.rejectValue("version", "portfolioEntry.optimistic.locking.failure", "Another user has updated this Ad entry while you were editing.")
                    render(view:'edit',model:[portfolioEntryInstance:portfolioEntryInstance])
                    return
                }
            }
            portfolioEntryInstance.properties = params
            if(!portfolioEntryInstance.hasErrors() && portfolioEntryInstance.save()) {
                flash.message = "Ad entry ${params.id} updated"
                redirect(action:showAdEntry,id:portfolioEntryInstance.id)
            }
            else {
                render(view:'edit',model:[portfolioEntryInstance:portfolioEntryInstance])
            }
        }
        else {
            flash.message = "Ad entry not found with id ${params.id}"
            redirect(action:list)
        }
    }
	
    def editAdEntry = {
        PortfolioEntry portfolioEntryInstance = PortfolioEntry.findWhere( id: params.id as long, category: Portfolio.AD_STORE_CATEGORY);

        if(!portfolioEntryInstance) {
            flash.message = "Ad Entry not found with id ${params.id}"
            redirect(action:list)
        }
        else {
        	
    		def portfolioRootDir = message(code:"inthedoor.adStore.root.dir");
			def promoCodeList = ItdaAttribute.findAllValues("manufacturerCode");
			def adSizeCodeList = null;
			if(portfolioEntryInstance.adTypeCode != PortfolioEntry.UNKNOWN)
				adSizeCodeList = ItdaAttribute.findAllValues('adSizeCode',portfolioEntryInstance.adTypeCode);
			else
				adSizeCodeList = ItdaAttribute.findAllValues( 'adSizeCode');
    		def jpgFiles = [PortfolioEntry.UNKNOWN];
		    def pdfFiles = [PortfolioEntry.UNKNOWN];
    		new File(getPortfolioContentDir(portfolioEntryInstance.portfolio) ).eachFileRecurse groovy.io.FileType.FILES, { file ->  
    			try {
    					if( file.isFile() ) 
    						if( file.getName().toUpperCase().endsWith('JPG') ) {
    							def path = file.getPath().replaceAll("\\\\", "/").minus(portfolioRootDir );
    							jpgFiles += path
    							println (path)
    						}else if( file.getName().toUpperCase().endsWith('PDF') ) {
    							def path = file.getPath().replaceAll("\\\\", "/").minus(portfolioRootDir );
    							pdfFiles += path
    							println (path)
    						}
    			} catch (Exception e) { log.error(e)}
    		}
    		
            return [ portfolioEntryInstance : portfolioEntryInstance,
                     jpgFiles:jpgFiles,
                     pdfFiles:pdfFiles,
					 promoCodeList:promoCodeList,
					 adTypeCodes:ItdaAttribute.findAllValues('adTypeCode'),
					 adSizeCodes:adSizeCodeList,
					 offerCodes:ItdaAttribute.findAllValues('offerCode')]
        }
    }			
	def loadPortfolio = {
		log.debug (request.getRequestURL())
		def portfolioInstance = Portfolio.findWhere(id : params.id as long, category: Portfolio.AD_STORE_CATEGORY);
		def adCollectionRootDir = getAdCollectionRootDir(portfolioInstance);
		def adStoreRootDir = getAdStoreRootDir();
		def adSizeList = ItdaAttribute.findAllValues( 'adSizeCode');
		def offerCodeList = ItdaAttribute.findAllValues('offerCode'); 
		def portfolioEntries = [:];
		def portfolioEntryFields;
		PortfolioEntry entry;
		new File(adCollectionRootDir).eachFileRecurse() { file -> 
			def fileNameUpper = file.getName().toUpperCase();
			try {
				if (file.isFile() && 
						( fileNameUpper.endsWith('JPG') || 
						  fileNameUpper.endsWith('PDF') || 
						  fileNameUpper.endsWith('DETAIL.TXT') || 
						  fileNameUpper.endsWith('DESC.TXT') 
						)) { 
log.debug('processing ' + file.getName() )
					portfolioEntryFields = [:]	
					entry = null
					String name = fileNameUpper ; 
					String adStorePrefix = name[0..1];
					name = name.minus(adStorePrefix);
					//portfolioEntryFields['adStorePrefix'] = adStorePrefix;
					portfolioEntryFields['fileName'] = fileNameUpper;
					
					String adType = name[0..1]
					name = name.minus(adType)
					portfolioEntryFields['adType'] = adType
					/*
					String tab = name[0]
					name = name.minus(tab)
					portfolioEntryFields['tab'] = tab
					*/
					portfolioEntryFields['tab'] = '1';
					String pageNumber = name[0..1]
					name = name.minus(pageNumber)
					portfolioEntryFields['pageNumber'] = pageNumber
					
					String adSize; 
					if( adSizeList.contains(name[0..4]))  
						adSize = name[0..4]
					else if( adSizeList.contains(name[0..3]))  
						adSize = name[0..3]
					else if ( adSizeList.contains(name[0..2]))  
						adSize = name[0..2]
					else if  ( adSizeList.contains(name[0..1]))
						adSize = name[0..1] 
					name = name.minus(adSize)
					portfolioEntryFields['adSize'] = adSize
//println('adSize ' + adSize )
					
					String colorCode =  name[0..1];
					name = name.minus(colorCode)
					portfolioEntryFields['colorCode'] = colorCode
					
					String offerCode; 
					if( offerCodeList.contains(name[0..3]))  
					offerCode = name[0..3]
					else if ( offerCodeList.contains(name[0..2]))  
					offerCode = name[0..2]
					else if  ( offerCodeList.contains(name[0..1]))
					offerCode = name[0..1]          
					name = name.minus(offerCode)
					portfolioEntryFields['offerCode'] = offerCode

					def key = adType + "-" +    pageNumber + "-" +  adSize + "-" +    
					offerCode+"-"+colorCode;// + "-" + variationOfferCode + "-" + month + "-" +  year;
					
					//entry = new PortfolioEntry(fontInfo:'-', adDescription:'-', dimensionInfo:'-');
					//entry = new PortfolioEntry(details:'-', adDescription:'-');
					if ( portfolioEntries[key] == null ) {        
						entry = new PortfolioEntry();
						entry.promoCode = portfolioInstance.promoCode;
						entry.setAdTypeCode(adType);
						entry.setAdSizeCode(adSize)
						entry.setAdPageNumber(pageNumber as int);
						entry.setAdTabNumber(1 as int)
						entry.setOfferCode(offerCode)
						entry.setColor(colorCode[0] as int)
						entry.setAdKey(key);
						//entry.setVariationOfferCode(variationOfferCode.toUpperCase())
						entry.setEnable(true)
						entry.setPortfolioDate(portfolioInstance.portfolioDate);
						entry.portfolio = portfolioInstance;
						entry.category = Portfolio.AD_STORE_CATEGORY;
						portfolioEntries[key] = entry
					} 
					entry = portfolioEntries[key];
					def path = file.getPath().replaceAll("\\\\", "/").minus(adStoreRootDir );
						if ( fileNameUpper.endsWith('JPG') )
							entry.setImageFile(path);
						else if ( fileNameUpper.endsWith('DESC.TXT') )
							entry.setAdDescription(file.text)
						else if ( fileNameUpper.endsWith('DETAIL.TXT') )
							entry.setDetails(file.text)
						else if (fileNameUpper.endsWith('PDF')) 
							entry.setPdfFile(path)
				}
			} catch (Exception e) {
				log.error(e.message, e);
				entry = createPortfolioEntry (portfolioEntryFields, portfolioInstance);
				entry.category = Portfolio.AD_STORE_CATEGORY;
				def path = file.getPath().replaceAll("\\\\", "/").minus(adStoreRootDir);
				entry.unparsableFile = path;
				entry.portfolioDate =  portfolioInstance.portfolioDate;				
				if ( fileNameUpper.endsWith('JPG') )
					entry.setImageFile(path);
				else if (fileNameUpper.endsWith('PDF')) 
					entry.setPdfFile(path)
				portfolioEntries[file.getName()] = entry
			}
		}
		//println ("updating details and ad descriptions");
		for(key in portfolioEntries.keySet()){//iterate through entries and update detail & description of 1c and 2c entries
			if(key.endsWith("-4C")) {
				def entry4c = portfolioEntries[key];
				def keyCommon = key.substring(0, key.size() - 2);
				def entry2c = portfolioEntries[keyCommon + "2C"];
				def entry1c = portfolioEntries[keyCommon + "1C"];
				if(entry2c) {
					entry2c.details = entry4c.details
					entry2c.adDescription = entry4c.adDescription
				}
				if(entry1c) {
					entry1c.details = entry4c.details
					entry1c.adDescription = entry4c.adDescription
				}				
			}
		}
		int errCount = 0;
		portfolioEntries.each { key, PortfolioEntry value ->
			println ("saving " + key)
			value.portfolio = portfolioInstance
			if(!value.save(flush:true))  
				if(!saveInvalidPortfolioEntry (value, adSizeList, 
					ItdaAttribute.findAllValues( 'adTypeCode'),offerCodeList)) {

				errCount += 1;
				flash.message = errCount + " portfolio " + ((errCount > 1) ? 'entries ' : 'entry ')  + "failed to load. Please refer to the Portfolio Entry for more details."
				value.errors.allErrors.each {
					println it
				}
			}	
		}
		if (errCount == 0)
		{
			portfolioInstance.state = "Ready"
			portfolioInstance.save(flush:true)
		}
		forward(action:"list")
	}
	
    def deleteAdEntry = {
        def portfolioEntryInstance = PortfolioEntry.findWhere( id: params.id as long, category: Portfolio.AD_STORE_CATEGORY);

        if(portfolioEntryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(portfolioEntryInstance.version > version) {
                    
                    portfolioEntryInstance.errors.rejectValue("version", "portfolioEntry.optimistic.locking.failure", "Another user has updated this Ad entry while you were editing.")
                    render(view:'edit',model:[portfolioEntryInstance:portfolioEntryInstance])
                    return
                }
            }
			def collId = portfolioEntryInstance?.portfolio?.id;
			portfolioEntryInstance.deleted = true;
            if(portfolioEntryInstance.save(flush:true)) {
                flash.message = "Ad entry ${params.id} deleted"
                redirect(action:listCollectionEntries,params:[collectionId:collId]);
            }
            else {
                render(view:'show',model:[portfolioEntryInstance:portfolioEntryInstance])
            }
        }
        else {
            flash.message = "Ad entry not found with id ${params.id}"
             redirect(action:listCollectionEntries,collectionId:collId);
        }
    }
					
}
