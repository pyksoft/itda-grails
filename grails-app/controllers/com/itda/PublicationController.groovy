package com.itda

class PublicationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
          
    def index = {
        redirect(action: "list", params: params)
    }
    //TODO delete
    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def publicationInstanceList
		if( auth.user() == message(code:'inthedoor.admin.user') ) {
		    [publicationInstanceList: Publication.list( params ), publicationInstanceTotal: Publication.count()]
		} else {
			def bizId = request.session.getAttribute(message(code:"inthedoor.session.businessKey"))
			[publicationInstanceList: Publication.listPub (bizId as long), publicationInstanceTotal: Publication.count()]
		}
    }

    def create = {
        def publicationInstance = new Publication()
        publicationInstance.properties = params
        return [publicationInstance: publicationInstance]
    }

    def save = {
        def publicationInstance = new Publication(params)
        if (publicationInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'publication.label', default: 'Publication'), publicationInstance.id])}"
            	redirect(action:show, id:publicationInstance.id)
        }
        else {
			render(view :'create', model: [publicationInstance: publicationInstance])
        }
    }

    def show = {
        def publicationInstance = Publication.get(params.id)
        if (!publicationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
            redirect(action: "list")
        }
        else {
            [publicationInstance: publicationInstance]
        }
    }

    def edit = {
        def publicationInstance = Publication.get(params.id)
        if (!publicationInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [publicationInstance: publicationInstance]
        }
    }

    def update = {
        def publicationInstance = Publication.get(params.id)
        if (publicationInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (publicationInstance.version > version) {
                    
                    publicationInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'publication.label', default: 'Publication')] as Object[], "Another user has updated this Publication while you were editing")
                    render(view: "edit", model: [publicationInstance: publicationInstance])
                    return
                }
            }
            publicationInstance.properties = params
            if (!publicationInstance.hasErrors() && publicationInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'publication.label', default: 'Publication'), publicationInstance.id])}"
                redirect(action: "show", id: publicationInstance.id)
            }
            else {
                render(view: "edit", model: [publicationInstance: publicationInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def publicationInstance = Publication.get(params.id)
        if (publicationInstance) {
            try {
                publicationInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'publication.label', default: 'Publication'), params.id])}"
            redirect(action: "list")
        }
    }
}
