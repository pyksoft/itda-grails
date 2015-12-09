package com.itda
import grails.converters.JSON;
import java.util.HashMap;
class PlannerEntryController {


    static allowedMethods = [save: "POST", updateDetail: "POST", update: "POST", delete: "POST"]

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [plannerEntryInstanceList: PlannerEntry.list(params), plannerEntryInstanceTotal: PlannerEntry.count()]
    }

    def create = {
        def plannerEntryInstance = new PlannerEntry()
        plannerEntryInstance.properties = params
        return [plannerEntryInstance: plannerEntryInstance]
    }

    def save = {
        def plannerEntryInstance = new PlannerEntry(params)
        if (plannerEntryInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'plannerEntry.label', default: 'PlannerEntry'), plannerEntryInstance.id])}"
            redirect(action: "show", id: plannerEntryInstance.id)
        }
        else {
            render(view: "create", model: [plannerEntryInstance: plannerEntryInstance])
        }
    }

    def show = {
        def plannerEntryInstance = PlannerEntry.get(params.id)
        if (!plannerEntryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'plannerEntry.label', default: 'PlannerEntry'), params.id])}"
            redirect(action: "list")
        }
        else {
            [plannerEntryInstance: plannerEntryInstance]
        }
    }

    
    def edit = {
        def plannerEntryInstance = PlannerEntry.get(params.id)
        if (!plannerEntryInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'plannerEntry.label', default: 'PlannerEntry'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [plannerEntryInstance: plannerEntryInstance]
        }
    }

    def update = {
        def plannerEntryInstance = PlannerEntry.get(params.id)
        if (plannerEntryInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (plannerEntryInstance.version > version) {
                    
                    plannerEntryInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'plannerEntry.label', default: 'PlannerEntry')] as Object[], "Another user has updated this PlannerEntry while you were editing")
                    render(view: "edit", model: [plannerEntryInstance: plannerEntryInstance])
                    return
                }
            }
            plannerEntryInstance.properties = params
            if (!plannerEntryInstance.hasErrors() && plannerEntryInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'plannerEntry.label', default: 'PlannerEntry'), plannerEntryInstance.id])}"
                redirect(action: "show", id: plannerEntryInstance.id)
            }
            else {
                render(view: "edit", model: [plannerEntryInstance: plannerEntryInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'plannerEntry.label', default: 'PlannerEntry'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def plannerEntryInstance = PlannerEntry.get(params.id)
        if (plannerEntryInstance) {
            try {
                plannerEntryInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'plannerEntry.label', default: 'PlannerEntry'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'plannerEntry.label', default: 'PlannerEntry'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'plannerEntry.label', default: 'PlannerEntry'), params.id])}"
            redirect(action: "list")
        }
    }
}
