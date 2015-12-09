package com.itda

class ZipcodeController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ zipcodeInstanceList: Zipcode.list( params ), zipcodeInstanceTotal: Zipcode.count() ]
    }

    def show = {
        def zipcodeInstance = Zipcode.get( params.id )

        if(!zipcodeInstance) {
            flash.message = "Zipcode not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ zipcodeInstance : zipcodeInstance ] }
    }

    def delete = {
        def zipcodeInstance = Zipcode.get( params.id )
        if(zipcodeInstance) {
            try {
                zipcodeInstance.delete(flush:true)
                flash.message = "Zipcode ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Zipcode ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Zipcode not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def zipcodeInstance = Zipcode.get( params.id )

        if(!zipcodeInstance) {
            flash.message = "Zipcode not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ zipcodeInstance : zipcodeInstance ]
        }
    }

    def update = {
        def zipcodeInstance = Zipcode.get( params.id )
        if(zipcodeInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(zipcodeInstance.version > version) {
                    
                    zipcodeInstance.errors.rejectValue("version", "zipcode.optimistic.locking.failure", "Another user has updated this Zipcode while you were editing.")
                    render(view:'edit',model:[zipcodeInstance:zipcodeInstance])
                    return
                }
            }
            zipcodeInstance.properties = params
            if(!zipcodeInstance.hasErrors() && zipcodeInstance.save()) {
                flash.message = "Zipcode ${params.id} updated"
                redirect(action:show,id:zipcodeInstance.id)
            }
            else {
                render(view:'edit',model:[zipcodeInstance:zipcodeInstance])
            }
        }
        else {
            flash.message = "Zipcode not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def zipcodeInstance = new Zipcode()
        zipcodeInstance.properties = params
        return ['zipcodeInstance':zipcodeInstance]
    }

    def save = {
        def zipcodeInstance = new Zipcode(params)
        if(!zipcodeInstance.hasErrors() && zipcodeInstance.save()) {
            flash.message = "Zipcode ${zipcodeInstance.id} created"
            redirect(action:show,id:zipcodeInstance.id)
        }
        else {
            render(view:'create',model:[zipcodeInstance:zipcodeInstance])
        }
    }
}
