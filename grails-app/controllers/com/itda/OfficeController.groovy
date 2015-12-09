

package com.itda

class OfficeController {
	
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def addZipcode = {
		def office = Office.get(params.id)
    	if (params.zipcode) {
    		if( AdvertisingZipcode.availabilityQuery([params.zipcode]) ) {
    	        def advertisingZipcodeInstance = new AdvertisingZipcode(zipcode:params.zipcode,
    	                                                lat:0, lon:0, city:"---", office:office)
    	        if (advertisingZipcodeInstance.save(flush: true)) {
    	            flash.message = "$params.zipcode added"
    	        }
    	        else {
    	        	if(advertisingZipcodeInstance.hasErrors()) {
    	        		for(itt in advertisingZipcodeInstance.errors) {
    	        	          println itt
    	        	    }
    	        	}
    	            flash.message = "$params.zipcode cannot be added"
    	        }
    		} else {
    			def adZip = AdvertisingZipcode.findByZipcode(params.zipcode)
                flash.message = "$params.zipcode is assigned to office '" +
                		adZip.office.name + "' of business '" + adZip.office.business.businessName+ "'"  			
    		}
    	}
        render(view:"edit", model:[officeInstance:  office])
    }
                             
   def deleteZipcodes = {
        if(params.zipcodes) {
        	def zipcodes = (params.zipcodes instanceof String ? [params.zipcodes] : params.zipcodes)
        	println (zipcodes)
	        for(id in zipcodes) {
	            def instance = AdvertisingZipcode.get( id )
		        if(instance) {
		            try {
		            	instance.delete(flush:true)
		            }
		            catch(Exception e) {
		            	println e
		                flash.message = "One or more zip code could not be deleted2"
		            }
		        }
	        }
	        if (flash.message != "One or more zip code could not be deleted")
	        	flash.message = "Delete zip code completed"
        }
        render(view:"edit", model:[officeInstance: Office.get(params.id)] )
    }
                             
    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ officeInstanceList: Office.list( params ), officeInstanceTotal: Office.count() ]
    }

    def show = {
        def officeInstance = Office.get( params.id )

        if(!officeInstance) {
            flash.message = "Office not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ officeInstance : officeInstance ] }
    }

    def delete = {
        def officeInstance = Office.get( params.id )
        if(officeInstance) {
            try {
                officeInstance.delete(flush:true)
                flash.message = "Office ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Office ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Office not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def officeInstance = Office.get( params.id )

        if(!officeInstance) {
            flash.message = "Office not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ officeInstance : officeInstance ]
        }
    }

    def update = {
        def officeInstance = Office.get( params.id )
        if(officeInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(officeInstance.version > version) {
                    
                    officeInstance.errors.rejectValue("version", "office.optimistic.locking.failure", "Another user has updated this Office while you were editing.")
                    render(view:'edit',model:[officeInstance:officeInstance])
                    return
                }
            }
            officeInstance.properties = params
            if(!officeInstance.hasErrors() && officeInstance.save()) {
                flash.message = "Office ${params.id} updated"
                redirect(action:show,id:officeInstance.id)
            }
            else {
                render(view:'edit',model:[officeInstance:officeInstance])
            }
        }
        else {
            flash.message = "Office not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def officeInstance = new Office()
        officeInstance.properties = params
        return ['officeInstance':officeInstance]
    }

    def save = {
        def officeInstance = new Office(params)
        def conflictingZipcodes 
        if(!officeInstance.validate()) {
            render(view:'create',model:[officeInstance:officeInstance])
            return ;
        }
        int result = RegistrationController.calculateOfficeGeoProfile(officeInstance, message(code:"google.map.key"))
        if(result > 0) {  // there is an issue with the office address
        	if(result == 1) 
    	    	officeInstance.errors.reject("office.location.accuracy.level", 
    	    			[""] as Object[], 
    	    			"An accurate enough geo-location is not available for the specified address. Please enter a different address.")
    	    else 
 	  	       officeInstance.errors.reject("office.location.geocode.failed", [""] as Object[],
 	  	    		   "The server encountered an error.")
        }  else if (params.create){  // do we need to save the office location
        	if(officeInstance.save()) {
	            flash.message = "Office ${officeInstance.id} created"
	            redirect(action:show,id:officeInstance.id)
	            return
        	} else {
	  	       officeInstance.errors.reject("office.location.create.failed", [""] as Object[],
	    		   "The server encountered an error.")        	
        	}
        } else if(officeInstance.availability != "true"){ // calculate conflicting zipcodes 
        	conflictingZipcodes = AdvertisingZipcode.conflictingZipcodesQuery (officeInstance.territoryZipcodes)
        }
        render(view:'create',model:[officeInstance:officeInstance, conflictingZipcodes:conflictingZipcodes])	  	    		  
       
    }
}
