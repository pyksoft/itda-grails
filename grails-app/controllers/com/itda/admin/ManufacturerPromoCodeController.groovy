package com.itda.admin

class ManufacturerPromoCodeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [manufacturerPromoCodeInstanceList: ManufacturerPromoCode.list(params), manufacturerPromoCodeInstanceTotal: ManufacturerPromoCode.count()]
    }

    def create = {
        def manufacturerPromoCodeInstance = new ManufacturerPromoCode()
        manufacturerPromoCodeInstance.properties = params
        return [manufacturerPromoCodeInstance: manufacturerPromoCodeInstance]
    }

    def save = {
		println(params)
        def manufacturerPromoCodeInstance = new ManufacturerPromoCode(params)
        if (manufacturerPromoCodeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode'), manufacturerPromoCodeInstance.promoCode])}"
            redirect(action: "show", id: manufacturerPromoCodeInstance.promoCode)
        }
        else {
            render(view: "create", model: [manufacturerPromoCodeInstance: manufacturerPromoCodeInstance])
        }
    }

    def show = {
        def manufacturerPromoCodeInstance = ManufacturerPromoCode.get(params.id)
        if (!manufacturerPromoCodeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode'), params.promoCode])}"
            redirect(action: "list")
        }
        else {
            [manufacturerPromoCodeInstance: manufacturerPromoCodeInstance]
        }
    }

    def edit = {
        def manufacturerPromoCodeInstance = ManufacturerPromoCode.get(params.id)
        if (!manufacturerPromoCodeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [manufacturerPromoCodeInstance: manufacturerPromoCodeInstance]
        }
    }

    def update = {
        def manufacturerPromoCodeInstance = ManufacturerPromoCode.get(params.id)
        if (manufacturerPromoCodeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (manufacturerPromoCodeInstance.version > version) {
                    
                    manufacturerPromoCodeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode')] as Object[], "Another user has updated this ManufacturerPromoCode while you were editing")
                    render(view: "edit", model: [manufacturerPromoCodeInstance: manufacturerPromoCodeInstance])
                    return
                }
            }
            manufacturerPromoCodeInstance.properties = params
            if (!manufacturerPromoCodeInstance.hasErrors() && manufacturerPromoCodeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode'), manufacturerPromoCodeInstance.promoCode])}"
                redirect(action: "show", id: manufacturerPromoCodeInstance.promoCode)
            }
            else {
                render(view: "edit", model: [manufacturerPromoCodeInstance: manufacturerPromoCodeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def manufacturerPromoCodeInstance = ManufacturerPromoCode.get(params.id)
        if (manufacturerPromoCodeInstance) {
            try {
                manufacturerPromoCodeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode'), params.id])}"
            redirect(action: "list")
        }
    }
}
