package com.itda

class BusinessController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [businessInstanceList: Business.list(params), businessInstanceTotal: Business.count()]
    }

    def create = {
        def businessInstance = new Business()
        businessInstance.properties = params
        return [businessInstance: businessInstance]
    }

    def save = {
        def businessInstance = new Business(params)
        if (businessInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'business.label', default: 'Business'), businessInstance.id])}"
            redirect(action: "show", id: businessInstance.id)
        }
        else {
            render(view: "create", model: [businessInstance: businessInstance])
        }
    }

    def show = {
        def businessInstance = Business.get(params.id)
        if (!businessInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'business.label', default: 'Business'), params.id])}"
            redirect(action: "list")
        }
        else {
            [businessInstance: businessInstance]
        }
    }

    def edit = {
        def businessInstance = Business.get(params.id)
        if (!businessInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'business.label', default: 'Business'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [businessInstance: businessInstance]
        }
    }

    def update = {
        def businessInstance = Business.get(params.id)
        if (businessInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (businessInstance.version > version) {
                    
                    businessInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'business.label', default: 'Business')] as Object[], "Another user has updated this Business while you were editing")
                    render(view: "edit", model: [businessInstance: businessInstance])
                    return
                }
            }
            businessInstance.properties = params
            if (!businessInstance.hasErrors() && businessInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'business.label', default: 'Business'), businessInstance.id])}"
                redirect(action: "show", id: businessInstance.id)
            }
            else {
                render(view: "edit", model: [businessInstance: businessInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'business.label', default: 'Business'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def businessInstance = Business.get(params.id)
        if (businessInstance) {
            try {
                businessInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'business.label', default: 'Business'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'business.label', default: 'Business'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'business.label', default: 'Business'), params.id])}"
            redirect(action: "list")
        }
    }
}
