package com.itda

class AdvertisingZipcodeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [advertisingZipcodeInstanceList: AdvertisingZipcode.list(params), advertisingZipcodeInstanceTotal: AdvertisingZipcode.count()]
    }

    def create = {
        def advertisingZipcodeInstance = new AdvertisingZipcode()
        advertisingZipcodeInstance.properties = params
        return [advertisingZipcodeInstance: advertisingZipcodeInstance]
    }

    def save = {
        def advertisingZipcodeInstance = new AdvertisingZipcode(params)
        if (advertisingZipcodeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode'), advertisingZipcodeInstance.id])}"
            redirect(action: "show", id: advertisingZipcodeInstance.id)
        }
        else {
            render(view: "create", model: [advertisingZipcodeInstance: advertisingZipcodeInstance])
        }
    }

    def show = {
        def advertisingZipcodeInstance = AdvertisingZipcode.get(params.id)
        if (!advertisingZipcodeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode'), params.id])}"
            redirect(action: "list")
        }
        else {
            [advertisingZipcodeInstance: advertisingZipcodeInstance]
        }
    }

    def edit = {
        def advertisingZipcodeInstance = AdvertisingZipcode.get(params.id)
        if (!advertisingZipcodeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [advertisingZipcodeInstance: advertisingZipcodeInstance]
        }
    }

    def update = {
        def advertisingZipcodeInstance = AdvertisingZipcode.get(params.id)
        if (advertisingZipcodeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (advertisingZipcodeInstance.version > version) {
                    
                    advertisingZipcodeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode')] as Object[], "Another user has updated this AdvertisingZipcode while you were editing")
                    render(view: "edit", model: [advertisingZipcodeInstance: advertisingZipcodeInstance])
                    return
                }
            }
            advertisingZipcodeInstance.properties = params
            if (!advertisingZipcodeInstance.hasErrors() && advertisingZipcodeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode'), advertisingZipcodeInstance.id])}"
                redirect(action: "show", id: advertisingZipcodeInstance.id)
            }
            else {
                render(view: "edit", model: [advertisingZipcodeInstance: advertisingZipcodeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def advertisingZipcodeInstance = AdvertisingZipcode.get(params.id)
        if (advertisingZipcodeInstance) {
            try {
                advertisingZipcodeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode'), params.id])}"
            redirect(action: "list")
        }
    }
}
