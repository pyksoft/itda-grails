package com.itda

class CompetitorController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        params.max = Math.min( params.max ? params.max.toInteger() : 10,  100)
        [ competitorInstanceList: Competitor.list( params ), competitorInstanceTotal: Competitor.count() ]
    }

    def show = {
        def competitorInstance = Competitor.get( params.id )

        if(!competitorInstance) {
            flash.message = "Competitor not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ competitorInstance : competitorInstance ] }
    }

    def delete = {
        def competitorInstance = Competitor.get( params.id )
        if(competitorInstance) {
            try {
                competitorInstance.delete(flush:true)
                flash.message = "Competitor ${params.id} deleted"
                redirect(action:list)
            }
            catch(org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "Competitor ${params.id} could not be deleted"
                redirect(action:show,id:params.id)
            }
        }
        else {
            flash.message = "Competitor not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def competitorInstance = Competitor.get( params.id )

        if(!competitorInstance) {
            flash.message = "Competitor not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ competitorInstance : competitorInstance ]
        }
    }

    def update = {
        def competitorInstance = Competitor.get( params.id )
        if(competitorInstance) {
            if(params.version) {
                def version = params.version.toLong()
                if(competitorInstance.version > version) {
                    
                    competitorInstance.errors.rejectValue("version", "competitor.optimistic.locking.failure", "Another user has updated this Competitor while you were editing.")
                    render(view:'edit',model:[competitorInstance:competitorInstance])
                    return
                }
            }
            competitorInstance.properties = params
            if(!competitorInstance.hasErrors() && competitorInstance.save()) {
                flash.message = "Competitor ${params.id} updated"
                redirect(action:show,id:competitorInstance.id)
            }
            else {
                render(view:'edit',model:[competitorInstance:competitorInstance])
            }
        }
        else {
            flash.message = "Competitor not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def create = {
        def competitorInstance = new Competitor()
        competitorInstance.properties = params
        return ['competitorInstance':competitorInstance]
    }

    def save = {
        def competitorInstance = new Competitor(params)
        if(!competitorInstance.hasErrors() && competitorInstance.save()) {
            flash.message = "Competitor ${competitorInstance.id} created"
            redirect(action:show,id:competitorInstance.id)
        }
        else {
            render(view:'create',model:[competitorInstance:competitorInstance])
        }
    }
}
