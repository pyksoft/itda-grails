package com.itda
import java.io.File;
import groovy.util.AntBuilder;
import com.itda.admin.ItdaAttribute;

class PortfolioController extends PortfolioBaseController{
	def portfolioService;

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
     static final String BACK_PAGE_IMAGE_DIR_NAME = "backPageImage"
    static final String COVER_PAGE_IMAGE_DIR_NAME = "coverPageImage"
    static final String SPINE_IMAGE_DIR_NAME = "spineImage"

    def index = {
        redirect(action: "list", params: params)
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
				or {
					isNull("category")
					eq("category", Portfolio.PORTFOLIO_CATEGORY)
				}
			    eq("deleted", false)
			}
		}
		[portfolioInstanceList: portfolios, portfolioInstanceTotal: portfolios.totalCount]		
    }

    def create = {
        def portfolioInstance = new Portfolio()
        portfolioInstance.properties = params
		portfolioInstance.status = "Inactive"
        return [portfolioInstance: portfolioInstance, promoCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')]
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
        def baseDir = getPortfolioBaseDir(portfolioInstance);
		File file = new File ( baseDir + File.separatorChar + fileName );
        if(file.exists()) {
            log.warn  "File with the same name exists on th server for this portfolio:" + fileName;
            File renamedFile = new File ( baseDir + File.separatorChar +  System.currentTimeMillis() + '-' + fileName  );
            file.renameTo (renamedFile);
            log.warn "Renamed existing file for this portfolio to " + renamedFile.getName();
            file.delete();
			file = new File ( baseDir + File.separatorChar + fileName  );
        }
		log.debug (file.getAbsolutePath() + '2');
		params['file'].transferTo(file);
		
		def ant = new AntBuilder()   // create an antbuilder
		File portContentDir = new File( baseDir
						+ File.separatorChar + CONTENT_DIR_NAME );
		portContentDir.mkdir();

		ant.unzip(  src:file.absolutePath,
				dest:portContentDir.absolutePath,
				overwrite:"false" );	
		portfolioInstance.uploadZipName = fileName;
		portfolioInstance.state = "Uploaded";
		
        if (portfolioInstance.save(flush: true)) {
            flash.message = "Portfolio Content File Uploaded"
            redirect(action: "show", id: portfolioInstance.id)
        }
        else {
            render(view: "edit", model: [portfolioInstance: portfolioInstance])
        }
    }

    def uploadBackPageImage = {  //using swfupload
    	
    	if(! (params.name  || params.file)) { //1) show swfupload page
			render(view:'uploadBackPageImage')
			return;
    	} else if(params.file) { //2) upload file
			def port = Portfolio.get( params.id )
			if( port ) {
				def fileName = params['name']; 
				File file = new File ( getPortfolioBackPageDir(port)+ fileName )
				if(log.isDebugEnabled())
					log.debug ("upload file to " +file.getAbsolutePath())
				params['file'].transferTo(file)
				def portfolioInstance = Portfolio.get(params.id)
				portfolioInstance.backPageImage = fileName
		        if (portfolioInstance.save(flush: true)) {
		            flash.message = "Portfolio Back Page Uploaded"
		        }
			} 
    	}
    }
    
    def uploadCoverPageImage = {  //using swfupload
    	
    	if(! (params.name  || params.file)) { //1) show swfupload page
			render(view:'uploadCoverPageImage')
			return;
    	} else if(params.file) { //2) upload file
			def port = Portfolio.get( params.id )
			if( port ) {
				def fileName = params['name']; 
				File file = new File ( getPortfolioCoverPageDir(port)+ fileName )
				if(log.isDebugEnabled())
					log.debug ("upload file to " +file.getAbsolutePath())
				params['file'].transferTo(file)
				def portfolioInstance = Portfolio.get(params.id)
				portfolioInstance.coverPageImage = fileName
		        if (portfolioInstance.save(flush: true)) {
		            flash.message = "Portfolio Cover Page Uploaded"
		        }
			} 
    	} 
    }

    def uploadSpineImage = {  //using swfupload
    	
    	if(! (params.name  || params.file)) { //1) show swfupload page
			render(view:'uploadSpineImage')
			return;
    	} else if(params.file) { //2) upload file
			def port = Portfolio.get( params.id )
			if( port ) {
				def fileName = params['name']; 
				File file = new File ( getPortfolioSpineDir(port)+ fileName )
				if(log.isDebugEnabled())
					log.debug ("upload file to " +file.getAbsolutePath())
				params['file'].transferTo(file)
				def portfolioInstance = Portfolio.get(params.id)
				portfolioInstance.spineImage = fileName
		        if (portfolioInstance.save(flush: true)) 
		            flash.message = "Portfolio Spine Uploaded"
	        }
    	} 
    }
    
    public String getPortfolioCoverPageDir(Portfolio portfolioInstance) {
		return getPortfolioBaseDir(portfolioInstance) + COVER_PAGE_IMAGE_DIR_NAME+ File.separator;
    }
    public String getPortfolioBackPageDir(Portfolio portfolioInstance) {
		return getPortfolioBaseDir(portfolioInstance) + BACK_PAGE_IMAGE_DIR_NAME+ File.separator;
    }
    public String getPortfolioSpineDir(Portfolio portfolioInstance) {
		return getPortfolioBaseDir(portfolioInstance) + SPINE_IMAGE_DIR_NAME+ File.separator;
    }
   
    def save = {
        def portfolioInstance = new Portfolio(params)
		//portfolioInstance.uploadZipName = fileName
		portfolioInstance.category = Portfolio.PORTFOLIO_CATEGORY;	
		portfolioInstance.state = Portfolio.CREATED_STATE;
		boolean mkdir = false;

try{
		if (portfolioInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'portfolio.label', default: 'Portfolio'), portfolioInstance.id])}";
			boolean createDir = true;
			File contentDir = new File(getPortfolioContentDir(portfolioInstance));
			File coverPageDir = new File(getPortfolioCoverPageDir(portfolioInstance));
			File backPageDir = new File(getPortfolioBackPageDir(portfolioInstance));
			File spineDir = new File(getPortfolioSpineDir(portfolioInstance));
			mkdir = (contentDir.exists() || contentDir.mkdirs());
			mkdir = mkdir && (coverPageDir.exists() || coverPageDir.mkdirs());
			mkdir = mkdir && (backPageDir.exists() || backPageDir.mkdirs());
			mkdir = mkdir && (spineDir.exists() || spineDir.mkdirs());
			if(!mkdir)
	            flash.message = "Failed to create new directory for portfolio"				
            redirect(action: "show", id: portfolioInstance.id)
        }
        else {
            render(view: "create", model: [portfolioInstance: portfolioInstance,promoCodes:ItdaAttribute.findAllValues("manufacturerCode")])
        }
}catch(Throwable e){println e}
    }

    def show = {
        def portfolioInstance = Portfolio.get(params.id)
        if (!portfolioInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'portfolio.label', default: 'Portfolio'), params.id])}"
            redirect(action: "list")
        }
        else {
            [portfolioInstance: portfolioInstance]
        }
    }

    def edit = {
        def portfolioInstance = Portfolio.get(params.id)
        if (!portfolioInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'portfolio.label', default: 'Portfolio'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [portfolioInstance: portfolioInstance, promoCodes:ItdaAttribute.findAllWhere(name:'manufacturerCode')]
        }
    }

    def update = {
        def portfolioInstance = Portfolio.get(params.id)
        if (portfolioInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (portfolioInstance.version > version) {
                    
                    portfolioInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'portfolio.label', default: 'Portfolio')] as Object[], "Another user has updated this Portfolio while you were editing")
                    render(view: "edit", model: [portfolioInstance: portfolioInstance,promoCodes:ItdaAttribute.findAllValues("manufacturerCode")])
                    return
                }
            }
            portfolioInstance.properties = params
            if (!portfolioInstance.hasErrors() && portfolioInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'portfolio.label', default: 'Portfolio'), portfolioInstance.id])}"
                redirect(action: "show", id: portfolioInstance.id)
            }
            else {
                render(view: "edit", model: [portfolioInstance: portfolioInstance, promoCodes:ItdaAttribute.findAllValues("manufacturerCode")])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'portfolio.label', default: 'Portfolio'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
    		println "delete 1";
        def portfolioInstance = Portfolio.get(params.id)
        if (portfolioInstance) {
    		println "delete 2";
            try {
            	if (portfolioService.markPortfolioAsDelete(portfolioInstance)) {
				/*
                //if(portfolioInstance.delete(flush: true)) { 
            		println "delete 3";
	                flash.message = "Portfolio deleted"
	        		def portContentDir = message(code:"inthedoor.portfolio.root.dir") + 
	        		portfolioInstance.getPortfolioDate().format('yyyy-MM') ;
					File dir = new File ( portContentDir );
					if(dir.exists())
						dir.renameTo(new File(portContentDir + '-' + System.currentTimeMillis()));
		    		println "delete 4";
		    		*/
	                redirect(action: "list")
                } else {
            		println "delete 5 " + portfolioInstance.id;
                	if(portfolioInstance.hasErrors()) {
                		println "delete 6";
                		for(err in plannerEntry.errors.allErrors) {
                			log.error err;
            			} 
                	}
	        		def portContentDir = message(code:"inthedoor.portfolio.root.dir") + 
	        		portfolioInstance.getPortfolioDate().format('yyyy-MM') ;
					File dir = new File ( portContentDir );
					if(dir.exists())
						dir.renameTo(new File(portContentDir + '-' + System.currentTimeMillis()));                	
	                redirect(action: "list")
                }
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
        		println "delete 7";
        		log.error ("delete failed" , e);
                flash.message = "Delete failed"
                	if(portfolioInstance.hasErrors()) {
                		println "delete 8";
                		for(err in plannerEntry.errors.allErrors) {
                			log.error err;
            			} 
                	}
	                flash.message = "Delete failed"
                    forward(action: "show", id: params.id)
            }
        }
        else {
    		println "delete 9";
            flash.message = "Portfolio not found"
            redirect(action: "list")
        }
    }
	
	def loadPortfolio = {
		println (request.getRequestURL())
		def portfolioInstance = Portfolio.get(params.id)
		def portfolioRootDir = message(code:"inthedoor.portfolio.root.dir")
		def portfolioEntries = [:]
		def portfolioEntryFields;
		PortfolioEntry entry;
		def adSizeList = ItdaAttribute.findAllValues( 'adSizeCode');
		def offerCodeList = ItdaAttribute.findAllValues('offerCode');
		new File(getPortfolioContentDir(portfolioInstance)).eachFileRecurse() { file ->  
			String fileNameUpper = file.getName().toUpperCase();	 
			try {
				if (file.isFile() && 
						( fileNameUpper.endsWith('JPG') || 
						  fileNameUpper.endsWith('PDF') || 
						  fileNameUpper.endsWith('DETAIL.TXT') || 
						  fileNameUpper.endsWith('DESC.TXT') 
						)) { 
println('processing ' + file.getName() )
					portfolioEntryFields = [:]	
					entry = null
					String name = fileNameUpper  
					String adType = name[0..1]
					name = name.minus(adType)
					portfolioEntryFields['adType'] = adType
					
					String tab = name[0]
					name = name.minus(tab)
					portfolioEntryFields['tab'] = tab
					
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
println('adSize ' + adSize )
					
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
/*****************************************************************************************					
					//String key = adType + tab as String + pageNumber as String + adSize
					/* no longer use
					String variationOfferCode =  name[0..1];
					name = name.minus(variationOfferCode)
					portfolioEntryFields['variationOfferCode'] = variationOfferCode
					
					
					String year = "20" + name[2..3]
					String month = name[0..1]  
					portfolioEntryFields['date'] = java.sql.Date.valueOf(year+"-"+month+"-01" )
					* /
**********************************************************************************************/
					def key = adType + "-" +  tab + "-" +  pageNumber + "-" +  adSize + "-" +    
					offerCode+"-"+colorCode;// + "-" + variationOfferCode + "-" + month + "-" +  year;
					
					//entry = new PortfolioEntry(fontInfo:'-', adDescription:'-', dimensionInfo:'-');
					//entry = new PortfolioEntry(details:'-', adDescription:'-');
					if ( portfolioEntries[key] == null ) {        
						entry = new PortfolioEntry();
						entry.promoCode = portfolioInstance.promoCode;
						entry.setAdTypeCode(adType);
						entry.setAdSizeCode(adSize)
						entry.setAdPageNumber(pageNumber as int)
						entry.setAdTabNumber(tab as int)
						entry.setOfferCode(offerCode)
						entry.setColor(colorCode[0] as int)
						entry.setAdKey(key);
						//entry.setVariationOfferCode(variationOfferCode.toUpperCase())
						entry.setEnable(true)
						entry.setPortfolioDate(portfolioInstance.portfolioDate);
						entry.portfolio = portfolioInstance;
						portfolioEntries[key] = entry
					} 
					entry = portfolioEntries[key];
					def path = file.getPath().replaceAll("\\\\", "/").minus(portfolioRootDir );
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
				println e;
				e.printStackTrace();
				entry = createPortfolioEntry (portfolioEntryFields, portfolioInstance)
				def path = file.getPath().replaceAll("\\\\", "/").minus(portfolioRootDir );
				entry.unparsableFile = path;
				entry.portfolioDate =  portfolioInstance.portfolioDate;
				if ( fileNameUpper.endsWith('JPG') )
					entry.setImageFile(path);
				else if (fileNameUpper.endsWith('PDF')) 
					entry.setPdfFile(path)

				portfolioEntries[file.getName()] = entry
			}
		}
		println ("updating details and ad descriptions");
		for(key in portfolioEntries.keySet()){
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
				if(!saveInvalidPortfolioEntry 
										(value, adSizeList,ItdaAttribute.findAllValues( 'adTypeCode') ,offerCodeList)) {
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
/*	
   def uploadPortfolio = {
		   
    			def fileName = request.getFile('portfolioFile').originalFilename; 
				if(fileName) {
					fileName = fileName.replaceAll("\\\\", "-");
					fileName = fileName.replaceAll("/", "-");
					fileName = fileName.replaceAll(":", "-");
				} else
					fileName = String.format('''%1$tY%1$tm%1$td%1$tH%1$tM%1$tS''', Calendar.getInstance());
				//println('fileStream:' + fileName)
				File file = new File ( message(code:"inthedoor.upload.root.dir") + fileName )
				request.getFile('portfolioFile').transferTo(file)
				def ant = new AntBuilder()   // create an antbuilder
				File dir = new File(message(code:"inthedoor.portfolio.root.dir") + fileName)
				dir.mkdir();
				ant.unzip(  src:file.absolutePath,
						dest:dir.absolutePath,
						overwrite:"false" )
	}
*/

	
/*	
	private void sendReponse(String result) { 
		setHeaders()
		if ( result == null ) 
			result = "Transparent.gif"
		println ("reading file " + result)
		streamContent(new FileInputStream(result))
	}	

	private void setHeaders() {
    	response.setHeader("Pragma", "")
    	//response.setHeader("Cache-Control", "private")
    	Calendar cal = Calendar.getInstance()
    	cal.add(Calendar.DAY_OF_YEAR,35)
    	response.setDateHeader("Expires", cal.getTimeInMillis())
		response.contentType = "application/octet-stream"	
	}
	
	private void streamContent(InputStream is) {
		org.apache.commons.io.IOUtils.copy(is,response.outputStream)
		if(! response.isCommitted())
			response.flushBuffer()				
	}
*/
	def error = { render "error"}
	
	
	
}
