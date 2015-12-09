package com.itda

import java.util.Date;
import java.util.Calendar;
import java.util.GregorianCalendar;

class PlannerJob {
	def messageSource;
	def asynchronousMailService;
   //def timeout = 5000l // execute job once in 5 seconds
	//def timeout = 2000000l;
	static triggers = {
		cron name: 'deadlineReminderTrigger', cronExpression: "0 0 10 * * ?" 
	  }

	def group = "deadlineReminderGroup"
    def execute() {//start job
		int numDay= messageSource.getMessage("inthedoor.planner.deadline.reminder", null, null) as int;
		String theSubject = messageSource.getMessage("inthedoor.planner.deadline.subject", null, null);
		String sender = messageSource.getMessage("inthedoor.email.customerService", null, null);
		Calendar calendar = new GregorianCalendar();
		calendar.add(Calendar.DAY_OF_MONTH, numDay);
		Date deadline = calendar.getTime();
		log.debug ("numDay " + numDay);
		log.debug("deadline " + deadline);
        def results = PlannerEntry.executeQuery("select z.business.id as biz from PlannerEntry z where z.deadline = ?", [deadline]);
		for (result in results) {
			log.debug("result "+ result);
			//log.debug("result "+ result.getClass());
			//Long bizId = result.getAt("biz") as Long;
			//log.debug("bizId:deadline " +bizId +":" + deadline);
			def biz = Business.get(result);
			
			asynchronousMailService.sendAsynchronousMail {
				to biz.email
				from sender
				subject theSubject
				body( view:"/email/deadlineReminder",
						model:[deadline:deadline]);
			}
		}
		
    }
}
