package com.itda
import java.io.File;
import java.util.Calendar;
import grails.converters.JSON;
import com.itda.admin.ItdaAttribute;

class PortfolioEntryController  extends PortfolioBaseController{
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']
	
                             
    def listPortfolioEntries = {
		if (! params.portfolioId )
			return new ArrayList()
		if (! params.offset )
			 params.offset = 0;
        //params.max = Math.min( params.max ? params.max.toInteger() : 1000,  1000)
		params.max = 1000;
		def results = PortfolioEntry.listPortfolioEntries(params.portfolioId as long)
		render(view:'list', model:[portfolioEntryInstanceList:results, 
		                           portfolioEntryInstanceTotal:results.size(), portfolioId:params.portfolioId])
    }
                             

    def list = {
		if (params.portfolioId )
				forward(action:'listPortfolioEntries')			
        params.max = Math.min( params.max ? params.max.toInteger() : 50,  50)
        [ portfolioEntryInstanceList: PortfolioEntry.list( params ), portfolioEntryInstanceTotal: PortfolioEntry.count() ]
    }

    def show = {
        def portfolioEntryInstance = PortfolioEntry.get( params.id )
println portfolioEntryInstance.pdfFile; 
println portfolioEntryInstance.imageFile; 
        if(!portfolioEntryInstance) {
            flash.message = "PortfolioEntry not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ portfolioEntryInstance : portfolioEntryInstance ] }
    }

	
/*	def delete = {
        def portfolioEntryInstance = PortfolioEntry.get( params.id )
        if(portfolioEntryInstance) {
            try {
                portfolioEntryInstance.delete(flush:true)
                flash.message = "PortfolioEntry ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "PortfolioEntry ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "PortfolioEntry not found with id ${params.id}"
            redirect(action:list)
        }
    }
*/
    def edit = {
        def portfolioEntryInstance = PortfolioEntry.get( params.id )

        if(!portfolioEntryInstance) {
            flash.message = "PortfolioEntry not found with id ${params.id}"
            redirect(action:list)
        }
        else {
        	
    		def portfolioRootDir = message(code:"inthedoor.portfolio.root.dir")
			def promoCodeList = ItdaAttribute.findAllValues("manufacturerCode");
    		def jpgFiles = [PortfolioEntry.UNKNOWN]
		    def pdfFiles = [PortfolioEntry.UNKNOWN]
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
    		
			def adSizeCodeList = null;
			if(portfolioEntryInstance.adTypeCode != PortfolioEntry.UNKNOWN)
				adSizeCodeList = ItdaAttribute.findAllValues('adSizeCode', portfolioEntryInstance.adTypeCode);
			else
				adSizeCodeList = ItdaAttribute.findAllValues( 'adSizeCode');

			
            return [ portfolioEntryInstance : portfolioEntryInstance,
                     jpgFiles:jpgFiles,
                     pdfFiles:pdfFiles,
					 promoCodeList:promoCodeList,
					 adTypeCodes:ItdaAttribute.findAllValues( 'adTypeCode'),
					 adSizeCodes:adSizeCodeList,
					 offerCodes:ItdaAttribute.findAllValues('offerCode')]
        }
    }

    def update = {
        def portfolioEntryInstance = PortfolioEntry.get( params.id )
        if(portfolioEntryInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(portfolioEntryInstance.version > version) {
                    
                    portfolioEntryInstance.errors.rejectValue("version", "portfolioEntry.optimistic.locking.failure", "Another user has updated this PortfolioEntry while you were editing.")
                    render(view:'edit',model:[portfolioEntryInstance:portfolioEntryInstance])
                    return
                }
            }
			println params;
            portfolioEntryInstance.properties = params
            if(!portfolioEntryInstance.hasErrors() && portfolioEntryInstance.save()) {
                flash.message = "PortfolioEntry ${params.id} updated"
                redirect(action:show,id:portfolioEntryInstance.id)
            }
            else {
                render(view:'edit',model:[portfolioEntryInstance:portfolioEntryInstance])
            }
        }
        else {
            flash.message = "PortfolioEntry not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
			println("params:" + params)
       def portfolioInstance = Portfolio.get( params.portfolioId )
       println ("portfolioInstance" + portfolioInstance)
	   if(portfolioInstance == null) {
	            flash.message = "Portfolio not found with id ${params.portfolioId}"
	            redirect(action:list)
	            return;
	    }
        def portfolioEntryInstance = new PortfolioEntry()
        portfolioEntryInstance.properties = params 
        portfolioEntryInstance.portfolioDate = portfolioInstance.portfolioDate        
		def portfolioRootDir = message(code:"inthedoor.portfolio.root.dir")
		def jpgFiles = [PortfolioEntry.UNKNOWN]
	    def pdfFiles = [PortfolioEntry.UNKNOWN]

	    new File(getPortfolioContentDir(portfolioInstance) ).eachFileRecurse groovy.io.FileType.FILES, { file ->  
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
try{
        return [portfolioEntryInstance:portfolioEntryInstance, 
                portfolioInstance:portfolioInstance,
				adSizeCodes:ItdaAttribute.findAllValues( 'adSizeCode'),  
				adTypeCodes:ItdaAttribute.findAllValues( 'adTypeCode'),
                jpgFiles:jpgFiles,
                pdfFiles:pdfFiles]
} catch (Exception e) { println(e)}
    }

    def save = {
        def portfolioEntryInstance = new PortfolioEntry(params)
	    def portfolioInstance = Portfolio.get( params.portfolioId )
	    portfolioEntryInstance.portfolio = portfolioInstance
        portfolioEntryInstance.portfolioDate = portfolioInstance.portfolioDate	    
        if(!portfolioEntryInstance.hasErrors() && portfolioEntryInstance.save()) {
            flash.message = "PortfolioEntry ${portfolioEntryInstance.id} created"
            redirect(action:show,id:portfolioEntryInstance.id)
        }
        else {
        	println("forward to create :" + params)
        	
			def portfolioRootDir = message(code:"inthedoor.portfolio.root.dir")
			def jpgFiles = [PortfolioEntry.UNKNOWN]
		    def pdfFiles = [PortfolioEntry.UNKNOWN]
		    new File(getPortfolioContentDir(portfolioInstance)).eachFileRecurse groovy.io.FileType.FILES, { file ->  
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

            render(view:'create',model:[portfolioEntryInstance:portfolioEntryInstance, 
                                        portfolioId:params.portfolioId,
                                        pdfFiles:pdfFiles,
                                        jpgFiles:jpgFiles])
        	}
        }
    }
	
    def uploadPdf = {
			log.warn "uploadPdf"
			log.warn params
			if (  ! params.int("portfolioId") )
			{
	            flash.message = "Please select a portfolio and then try to upload file."
	    		redirect(controller:"portfolio", action:"list",id:params.id)

			}
				
			if (  null == params.file )
			{
				render(view:'uploadPdf')
				return;
			}
				
			def port = Portfolio.get( params['portfolioId'] )
			if( port ) {
				def fileName = params['name']; 
				File file = new File ( message(code:"inthedoor.portfolio.root.dir") + 
						port.getPortfolioDate().format('yyyy-MM')
						+ File.separatorChar + PortfolioController.getCONTENT_DIR_NAME()
						+ File.separatorChar + fileName )
				params['file'].transferTo(file)
	            //flash.message = "PDF File Uploaded!"
	            //redirect(action:list,id:params.id)
	            //render "PDF File Uploaded!"
			} else {
	            //flash.message = "PDF File Not Uploaded! Please select a portfolio and then try again."
    			redirect(controller:"portfolio", action:"list",id:params.id)
			}
	}

	def uploadJpg = {
			log.warn "uploadJpg"
			log.warn params
			if (  ! params.int("portfolioId") )
			{
	            flash.message = "Please select a portfolio and then try to upload file."
	    		redirect(controller:"portfolio", action:"list",id:params.id)

			}
				
			if (  null == params.file )
			{
				render(view:'uploadJpg')
				return;
			}
				
			def port = Portfolio.get( params['portfolioId'] )
			if( port ) {
				def fileName = params['name']; 
				File file = new File ( message(code:"inthedoor.portfolio.root.dir") + 
						port.getPortfolioDate().format('yyyy-MM')
						+ File.separatorChar + PortfolioController.getCONTENT_DIR_NAME()
						+ File.separatorChar + fileName )
				if(log.isDebugEnabled())
					log.debug ("upload file to " +file.getAbsolutePath())
				params['file'].transferTo(file)
	            //flash.message = "JPG File Uploaded!"
	            //redirect(action:list,id:params.id)
			} else {
	            //flash.message = "JPG File Not Uploaded! Please select a portfolio and then try again."
    			redirect(controller:"portfolio", action:"list",id:params.id)
			}
	    }

    def delete = {
        def portfolioEntryInstance = PortfolioEntry.findWhere( id: params.id as long, category: Portfolio.PORTFOLIO_CATEGORY);

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
                flash.message = "Portfolio entry ${params.id} deleted"
                redirect(action:listPortfolioEntries,params:[portfolioId:collId]);
            }
            else {
                render(view:'show',model:[portfolioEntryInstance:portfolioEntryInstance])
            }
        }
        else {
            flash.message = "Portfolio entry not found with id ${params.id}"
             redirect(action:listPortfolioEntries,portfolioId:collId);
        }
    }


    public String getPortfolioContentDir(Portfolio portfolioInstance) {
		return getPortfolioBaseDir(portfolioInstance) + File.separator + PortfolioController.CONTENT_DIR_NAME + File.separator;
    }
	
	
}
