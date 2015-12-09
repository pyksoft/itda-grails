package com.itda;
import com.itda.Portfolio;
class MyPortfolioController extends PortfolioBaseController{
	def userAgentIdentService;

    def index = { }
    
	def listActivePortfolioEntries = {
    		//println (request.getRequestURI() + params)
    		def date = null;
    		if(params.id && (auth.user() == "itdaweb.admin" || auth.user() == "eportfolio.admin"))
    			date = Portfolio.get(params.id)?.portfolioDate
    		else
    			date = null //java.sql.Date.valueOf("2009-10-01" )
    			//println ('port date is ' +date)
    		def results = PortfolioEntry.listActivePortfolioEntries(date)
    		//println ('result xml is \n' +results.encodeAsXML())
    		render results.encodeAsXML()
    	} 

    	private void sendReponse(String result) {
    		if ( result == null ) 
    			result = "Transparent.gif"
			setHeaders(); 
        	if(params.download) {
        		def index = result.lastIndexOf('/')
        		def filename = result.substring(index+1)
        		response.setHeader( 'Content-Disposition',	'attachment; filename="'+ filename +'"');
        	}
			java.io.FileInputStream fis = new java.io.FileInputStream( result );
			streamContent(fis);
			fis.close();
    	}

        
        
    	def getFourColorSwf = {
    			log.debug (request.getRequestURI() + ";" + params.id + ":" + params.color)
    		if(params.id as int == -100) {
    			forward(action:"backContentImage", params:[id:params.id])
    			return;
    		}
    		//println (request.getRequestURI() + params.id)
    		def result= getAdFile(params.id as long, 4, "image")
    		response.contentType = "application/octet-stream"
    		sendReponse(result)
    	}
    	
    	def getFourColorPdf = {
    		//println (request.getRequestURI())
    			log.debug (request.getRequestURI() + ";" + params.id + ":" + params.color)
    		def result =getAdFile(params.id as long, 4, "pdf")
    		response.contentType = "application/pdf"
    		sendReponse(result)
    	}	
    	
    	def getOneColorSwf = {
    		//println (request.getRequestURI())
    			log.debug (request.getRequestURI() + ";" + params.id + ":" + params.color)
    		def result =getAdFile(params.id as long, 1, "image")
    		response.contentType = "application/octet-stream"
    		sendReponse(result)
    	}
    	
    	def getOneColorPdf = {
    		//println (request.getRequestURI())
    			println (request.getRequestURI() + ";" + params.id + ":" + params.color)
    		def result =getAdFile(params.id as long, 1, "pdf")
    		response.contentType = "application/pdf"
    		sendReponse(result)
    	}	
    	
    	def getTwoColorSwf = {
    		//println (request.getRequestURI())
    			println (request.getRequestURI() + ";" + params.id + ":" + params.color)
    		def result =getAdFile(params.id as long, 2, "image");
    		response.contentType = "application/octet-stream"
    		sendReponse(result)
    	}
    	
    	def getTwoColorPdf = {
    		//println (request.getRequestURI())
    			println (request.getRequestURI() + ";" + params.id + ":" + params.color)
    		def result =getAdFile(params.id as long, 2, "pdf");
    		response.contentType = "application/pdf"
    		sendReponse(result)
    	}
    	
    	def current = {
			println ":" +userAgentIdentService.isiPad() + ":" + userAgentIdentService.isiPhone()+ ":" + userAgentIdentService.isAndroid();
			if(userAgentIdentService.isiPad() ||  userAgentIdentService.isiPhone()
				//|| userAgentIdentService.isAndroid()
				)
			
			{
				render(view: "noFlashSupport");
				return;
			}
    			//log.debug request.referer
    			//println(request.referer) 
    		Portfolio port =  null;
    		if(params.id && (auth.user() == "itdaweb.admin" || auth.user() == "eportfolio.admin")){
    			port = Portfolio.get(params.id);
    			if(log.isDebugEnabled())
    				log.debug ('port.id = ' + port.id)
    		}		
    		else
    			port = Portfolio.find("from Portfolio as p where p.status='Active'")
            render(view: "current", model: [portfolioInstance: port])

    	}

    	def ePortfolio = {
    		println (request.getRequestURI())
    		setHeaders();
    		response.contentType = "application/octet-stream"				
    		InputStream stream = servletContext.getResourceAsStream("/WEB-INF/portfolio.swf");
    		streamContent(stream);
    	}

    	def frontCoverImage = {
    			println (request.getRequestURI())
    			Portfolio port = null;
    			if(params.id) 
    				port =  Portfolio.get(params.id)
    			else 
    				port =  Portfolio.find("from Portfolio as p where p.status='Active'")
    			println (getPortfolioCoverPageDir(port) + ':'+port.getCoverPageImage())
    			println ("port" + port);
    			if (port)
    				sendReponse (getPortfolioCoverPageDir(port) + port.getCoverPageImage())
    			println port.getCoverPageImage()
    		}

    	def spineImage = {
    			println (request.getRequestURI())
    			Portfolio port = null;
    			if(params.id) 
    				port =  Portfolio.get(params.id)
    			else 
    				port =  Portfolio.find("from Portfolio as p where p.status='Active'")
    			println ("port" + port);
    			println (getPortfolioSpineDir(port) + ':'+port.getSpineImage())
    			if (port)
    				sendReponse (getPortfolioSpineDir(port) + port.getSpineImage());
    			println port.getSpineImage()
    		}

    	def backContentImage = {
    			println (request.getRequestURI() + ':' + params.id + ':' +(params.id != "-100"));
    			Portfolio port = null;
    			if(params.id && params.id != "-100") 
    				port =  Portfolio.get(params.id)
    			else 
    				port =  Portfolio.find("from Portfolio as p where p.status='Active'")
    			println ("backContentImage port:" + port);
    			if (port)
        			println (getPortfolioBackPageDir(port) + ':'+port.getBackPageImage())
    			sendReponse (getPortfolioBackPageDir(port) + port.getBackPageImage());
    			println port.getBackPageImage()
    		}
 
            static final String BACK_PAGE_IMAGE_DIR_NAME = "backPageImage"
            static final String COVER_PAGE_IMAGE_DIR_NAME = "coverPageImage"
            static final String SPINE_IMAGE_DIR_NAME = "spineImage"
    	
		public String getPortfolioCoverPageDir(Portfolio portfolioInstance) {
    		return getPortfolioBaseDir(portfolioInstance) + File.separator + COVER_PAGE_IMAGE_DIR_NAME+ File.separator;
        }
		
        public String getPortfolioBackPageDir(Portfolio portfolioInstance) {
    		return getPortfolioBaseDir(portfolioInstance) +  File.separator + BACK_PAGE_IMAGE_DIR_NAME+ File.separator;
        }
		
        public String getPortfolioSpineDir(Portfolio portfolioInstance) {
    		return getPortfolioBaseDir(portfolioInstance) +  File.separator + SPINE_IMAGE_DIR_NAME+ File.separator;
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

	    private String getAdFile (long id, int color, String type) {
		def entry = PortfolioEntry.get(id);
		if(!entry) 
			return null;
		def rootDir;
		if (entry.category == Portfolio.PORTFOLIO_CATEGORY) 
			rootDir = message(code:"inthedoor.portfolio.root.dir") ; 
		else if (entry.category == Portfolio.AD_STORE_CATEGORY)
			rootDir = message(code:"inthedoor.adStore.root.dir");
		else
			rootDir = message(code:"inthedoor.userContent.root.dir") +  'myUploads' + '/';
				
		if(entry.category != Portfolio.MY_UPLOADS_CATEGORY && entry.color != color)	
			entry = PortfolioEntry.findWhere(portfolioDate:entry.portfolioDate,
								adPageNumber:entry.adPageNumber,
								adTabNumber:entry.adTabNumber,
								adTypeCode:entry.adTypeCode,
								color:color as int); //TODO create index
		if(!entry) 
			return null;
		else 
			return (type=='pdf') ? rootDir + entry.pdfFile : rootDir + entry.imageFile;
		}
		
		private PortfolioEntry authorizedImageFileAccess(long id) {
			PortfolioEntry entry = PortfolioEntry.get(id);
			if(entry.category == Portfolio.PORTFOLIO_CATEGORY  || entry.category == Portfolio.AD_STORE_CATEGORY){
				return entry;
			}else{
				long bizId = authenticationService.getSessionUser().attributes['businessId'];
				if(bizId == entry['business.id']) //My Uploads
					return entry;
				else  
					return null;
				
			}
			
		} 
		
		private PortfolioEntry authorizedHdFileAccess(long id) {
			long bizId;
			PortfolioEntry entry = PortfolioEntry.get(id);
			if(entry.category == Portfolio.PORTFOLIO_CATEGORY ){
				return entry;
			}else if(entry.category == Portfolio.MY_UPLOADS_CATEGORY){
				bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
				if(bizId == entry['business.id']) //My Uploads
					return entry;
				else  //send to vendor is handled separately
					return null;
			}else{ //Ad store
				OrderItem item = OrderItem.findWhere('business.id': bizId, 'portfolioEntry.id': entry.id)
				if(item && item.approvalCode && item.approvalCode != "")
					return entry;
				else
					return null;
			}
		}
}
