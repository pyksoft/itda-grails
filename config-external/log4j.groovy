/***********************************************/
// log4j configuration
log4j = {
	// Example of changing the log pattern for the default console
	// appender:
	//
   // appenders {
	//	//stacktraceLog name:'stacktrace', file:'logs/stacktrace.log' , layout:pattern(conversionPattern: '%-5p %d{HH:mm:ss,SSS} %c{5} %m%n')
	//	StackTrace="error,stdout"
   // }
	
	appenders {
		environments {
				development	 {
					//console name:'stdout', layout:pattern(conversionPattern: '%-5p %d{yyyy-MM-dd HH:mm:ss,SSS} %c{5} %m%n')
					file name:'file', file:'logs/itda.log', layout:pattern(conversionPattern: '%-5p %d{yyyy-MM-dd HH:mm:ss,SSS} %c{5} %m%n')
				}
				test	 {
					console name:'stdout', layout:pattern(conversionPattern: '%-5p %d{yyyy-MM-dd HH:mm:ss,SSS} %c{5} %m%n')
					file name:'file', file:'logs/itda.log', layout:pattern(conversionPattern: '%-5p %d{yyyy-MM-dd HH:mm:ss,SSS} %c{5} %m%n')
				}
				production {
					rollingFile name:'file', maxFileSize: '3MB', maxBackupIndex:200, file:'/var/log/tomcat6/itda.log', layout:pattern(conversionPattern: '%-5p %d{yyyy-MM-dd HH:mm:ss,SSS} %c{5} %m%n')
					rollingFile name: "stacktrace", maxFileSize: '3MB', maxBackupIndex:200, file: "/var/log/tomcat6/itda-stacktrace.log"
				}
			}
		}
	
	
	root {
		error 'file'
		additivity = true
	}

	debug 'grails.app',
		  'com.itda',
		  'com.ondemand1',
		  'log4j.logger.org.hibernate'

	warn  'org.codehaus.groovy.grails.web.servlet',  //  controllers
		   'org.codehaus.groovy.grails.web', //  web processing
		   'org.codehaus.groovy.grails.web.sitemesh', //  layouts
		   'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
		   'org.codehaus.groovy.grails.web.mapping', // URL mapping
		   'org.codehaus.groovy.grails.commons', // core / classloading
		   'org.codehaus.groovy.grails.plugins', // plugins
		   'org.springframework',
		   'org.springframework.core.io',
		   'com.grailsrocks.authentication'
		  // 'grails.app'

   warn  'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
		   'org.hibernate'

		   
	error   'org.codehaus.groovy.grails.web.pages', //  GSP
			'groovy.grails.web.pages',
			'org.mortbay.log'
}
