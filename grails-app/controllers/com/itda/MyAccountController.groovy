package com.itda
import grails.converters.JSON;

class MyAccountController {
	def authenticationService
	def messageSource

    def updateSettings = { 
		def respText;
		def login = authenticationService.getSessionUser().login;
		def user = Username.findWhere(login:login);
		def setting = ItdaSettings.findWhere(['username.id': user.id]);
		if(setting)
			setting.properties = params;
		else
			setting = new ItdaSettings(params);
		setting.username = user; //security reason; do this always
		if(!setting.save(flush:true)){
			respText = 'Save failed.'
	        for(err in setting.errors.allErrors) 
        		log.error messageSource.getMessage(err, null);	 
		}else{
			respText = 'Save completed.'
		}
		def resp = ["respText":respText];
		render resp as JSON;
    }
	
    def saveNewZipCodes = { 
		def respText = 'Save failed.';
		//protected
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
		def office = Office.findWhere(['id': params.id as long, 'business.id': bizId]);//Multi-tenant
		def newZipcodes = (params.newZipcodes instanceof String ? [params.newZipcodes] : params.newZipcodes)
		if(office){
			for(zipcode in newZipcodes) {
				def azc = new AdvertisingZipcode(zipcode:zipcode, lat:0, lon:0, city:'', office:office);
				office.advertisingZipcodes.add(azc);
			}
			if(!office.save(flush:true)){
		        for(err in office.errors.allErrors) 
	        		log.error messageSource.getMessage(err, null);	 
			}else{
				respText = 'Save completed.'
			}
		}
		def resp = ["respText":respText];
		render resp as JSON;
    }
	
    def saveDeleteZipCodes = { 
		def respText = 'Save failed.';
		//protected
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
		def office = Office.findWhere(['id': params.id as long, 'business.id': bizId]);//Multi-tenant
		def deleteZipcodes = (params.deleteZipcodes instanceof String ? [params.deleteZipcodes] : params.deleteZipcodes)
		if(office){
			def count = AdvertisingZipcode.executeUpdate('delete AdvertisingZipcode f where f.zipcode in ('+toListString(deleteZipcodes)+') and f.office.id = ?' , [office.id]);		    
			println(count+ " deleted ");
			if(count > 0){
				respText = 'Save completed.'
			}
		}
		def resp = ["respText":respText];
		render resp as JSON;
    }
	
	def toListString(arr){
		def listString = "";
		for(val in arr)
			if(listString != "")
				listString += ",'"  + val +	"'";
			else
				listString += "'"  + val +	"'";
		return listString;
	}
}
