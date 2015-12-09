package com.itda.admin

class ItdaAttributeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [itdaAttributeInstanceList: ItdaAttribute.list(params), itdaAttributeInstanceTotal: ItdaAttribute.count()]
    }

    def create = {
        def itdaAttributeInstance = new ItdaAttribute()
        itdaAttributeInstance.properties = params
        return [itdaAttributeInstance: itdaAttributeInstance]
    }

    def save = {
        def itdaAttributeInstance = new ItdaAttribute(params)
        if (itdaAttributeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'itdaAttribute.label', default: 'ItdaAttribute'), itdaAttributeInstance.id])}"
            redirect(action: "show", id: itdaAttributeInstance.id)
        }
        else {
            render(view: "create", model: [itdaAttributeInstance: itdaAttributeInstance])
        }
    }

    def show = {
        def itdaAttributeInstance = ItdaAttribute.get(params.id)
        if (!itdaAttributeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'itdaAttribute.label', default: 'ItdaAttribute'), params.id])}"
            redirect(action: "list")
        }
        else {
            [itdaAttributeInstance: itdaAttributeInstance]
        }
    }

    def edit = {
        def itdaAttributeInstance = ItdaAttribute.get(params.id)
        if (!itdaAttributeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'itdaAttribute.label', default: 'ItdaAttribute'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [itdaAttributeInstance: itdaAttributeInstance]
        }
    }

    def update = {
        def itdaAttributeInstance = ItdaAttribute.get(params.id)
        if (itdaAttributeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (itdaAttributeInstance.version > version) {
                    
                    itdaAttributeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'itdaAttribute.label', default: 'ItdaAttribute')] as Object[], "Another user has updated this ItdaAttribute while you were editing")
                    render(view: "edit", model: [itdaAttributeInstance: itdaAttributeInstance])
                    return
                }
            }
            itdaAttributeInstance.properties = params
            if (!itdaAttributeInstance.hasErrors() && itdaAttributeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'itdaAttribute.label', default: 'ItdaAttribute'), itdaAttributeInstance.id])}"
                redirect(action: "show", id: itdaAttributeInstance.id)
            }
            else {
                render(view: "edit", model: [itdaAttributeInstance: itdaAttributeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'itdaAttribute.label', default: 'ItdaAttribute'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def itdaAttributeInstance = ItdaAttribute.get(params.id)
        if (itdaAttributeInstance) {
            try {
                itdaAttributeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'itdaAttribute.label', default: 'ItdaAttribute'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'itdaAttribute.label', default: 'ItdaAttribute'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'itdaAttribute.label', default: 'ItdaAttribute'), params.id])}"
            redirect(action: "list")
        }
    }
}
