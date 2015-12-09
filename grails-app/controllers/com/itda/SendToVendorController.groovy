package com.itda

import java.io.InputStream;

class SendToVendorController {

    def download = { 
		log.info("downoad request " + params);
		
		if(params.uuid) {
			log.info("downoading")
			def stvEntry = SendToVendor.findWhere(uuid:params.uuid);
			def portfolioEntry = null;
			if(stvEntry && stvEntry.termsUuid == params.termsUuid) {
				log.debug("found uuid and terms");
				portfolioEntry = stvEntry.plannerEntry.portfolioEntry;
				if(portfolioEntry) {
					String color = portfolioEntry.color;
					getItdaPdf( color.substring(0,1) as int, portfolioEntry.id);//download pdf
					stvEntry.downloads += 1;
					stvEntry.save();
					return;
				}else{
				    if(stvEntry.plannerEntry.pdfFile){
						getCustomerPdf(stvEntry.plannerEntry);
						stvEntry.downloads += 1;
						stvEntry.save();
						return;
				    }
					flash.message = "No PDF is associated with this link. Please contact your customer directly for the file."
					render (view:"download", model:[entry:stvEntry]);
					return;
				}
			}else if(stvEntry && params.fileType == "image") {
				log.debug("found uuid and fileType is image");
				portfolioEntry = stvEntry.plannerEntry.portfolioEntry;
				if(portfolioEntry) {
					String color = portfolioEntry.color;
					getJpg( color.substring(0,1) as int, portfolioEntry.id);
					stvEntry.views += 1;
					stvEntry.save();
					return;
				}else if (stvEntry.plannerEntry.imageFile) {
					def plannerEntry = stvEntry.plannerEntry;
					String file = getUploadDir(plannerEntry.id, plannerEntry.business.id) + plannerEntry.imageFile;
					sendReponse(file, false);
					return;
				}
			} 
		     else if(stvEntry && params.fileType == "pdf") {  //show t&c page
				log.debug("found uuid" );
			   render (view:"download", model:[entry:stvEntry]);
			   return;
			}
			

		}
		log.debug("not found uuid and terms");
		
		response.status = 404;
		render (view:"common/error404");
		
	}

	private void getCustomerPdf(plannerEntry) {
		String file = getUploadDir(plannerEntry.id, plannerEntry.business.id) + plannerEntry.pdfFile;
		response.contentType = "application/pdf";
		sendReponse(file, true);
	}

		
	private void getItdaPdf(int color, long adId) {
		def result =getAdFile(adId, color, "pdf");
		response.contentType = "application/pdf";
		sendReponse(result, true);
	}
	
	private void getJpg(int color, long adId) {
		def result =getAdFile(adId, color, "image");
		response.contentType = "image/jpeg";
		sendReponse(result, false);
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
	
////////////////

	private String getUploadDir(long id, long bizId) {
		String baseDir = message(code:"inthedoor.userContent.root.dir") +
		'plannerEntry' + File.separator + bizId + File.separator + id + File.separator;
	}
	
///////////////////		
	
	private void sendReponse(String result, boolean download) {
		if ( result == null )
			result = "Transparent.gif"
		setHeaders();

		if (download) {
			def index = result.lastIndexOf('/')
			def filename = result.substring(index+1)
			response.setHeader( 'Content-Disposition',	'attachment; filename="'+ filename +'"');
		}
		FileInputStream fis = new java.io.FileInputStream( result );
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
