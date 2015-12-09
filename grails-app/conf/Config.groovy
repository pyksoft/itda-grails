// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }
//grails.views.gsp.sitemesh.preprocess = false

grails.config.locations = [ "file:${userHome}/.grails/mail.groovy",
                            "file:${userHome}/.grails/log4j.groovy", 
							"file:${userHome}/.grails/datasource.groovy"]

grails.app.context = '/'
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [ html: ['text/html','application/xhtml+xml'],
                      xml: ['text/xml', 'application/xml'],
                      text: 'text/plain',
                      js: 'text/javascript',
                      rss: 'application/rss+xml',
                      atom: 'application/atom+xml',
                      css: 'text/css',
                      csv: 'text/csv',
                      all: '*/*',
                      json: ['application/json','text/json'],
                      form: 'application/x-www-form-urlencoded',
                      multipartForm: 'multipart/form-data'
                    ]
// The default codec used to encode data with ${}
grails.views.default.codec="none" // none, html, base64
grails.views.gsp.encoding="UTF-8"
grails.converters.encoding="UTF-8"

fileuploader {
	docs {
		maxSize = 1000 * 1024 * 1024 //4 mbytes
		allowedExtensions = ["zip", "pdf", "jpg"]
		path = "/data/itdaUpload/"
	}
}

grails.validateable.classes = [com.itda.command.CommentCommand]

// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true

// set per-environment serverURL stem for creating absolute links
environments {
    production {
        grails.serverURL = "http://www.inthedooradvertising.net"
    }
    development {
        grails.serverURL = "http://localhost:8080"
    }
    test {
        grails.serverURL = "http://localhost:8080"
    }
	qa {
		grails.serverURL = "http://wsip-68-15-73-170.oc.oc.cox.net:8080"
	}
}



/**********************************************/
//org.codehaus.groovy.grails.validation.ConstrainedProperty.registerNewConstraint(PhoneNumberConstraint.NAME, PhoneNumberConstraint.class)     
