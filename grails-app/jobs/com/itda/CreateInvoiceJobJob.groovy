package com.itda


class CreateInvoiceJobJob {
    def timeout = 2000000 // execute job once in 5 seconds
    static triggers = {
        cron name: 'createInvoiceTrigger', cronExpression: "0 0 6 * * ?"  //1 am everyday
      }

    def group = "createInvoiceGroup"


    def execute() {
        // execute task
    	/*For each invoice whose is due tomorrow
    	 * verify total is correct;
    	 */
    		
    	println "execute job";
    }
}
