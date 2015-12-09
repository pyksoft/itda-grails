grails {
	mail {
		//Development
		/*
		host = "localhost"
		port = 25
		username = "dev@localhost"
		password = "fakepassword"
		props = ["mail.smtp.auth":"false"]
		*/

		//Test
		host = "smtpout.secureserver.net"
		port = 465
		username = "itda@ondemand1.com"
		password = "itda1"
		//from = 'ITDA Test Only<itdasupport@ondemand1.com>'
		props = ["mail.smtp.auth":"true",
		"mail.smtp.socketFactory.port":"465",
		"mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
		"mail.smtp.socketFactory.fallback":"false"]
		
		//Production
		/*
		host = "smtp.critsend.com"
		//port = 587
		port = 465
		username = 
		password = 
		//from = 'In-the-Door Advertising Support<support@inthedooradvertising.com>'
		props = ["mail.smtp.auth":"true",
				//"mail.smtp.socketFactory.port":"587",
				//"mail.smtp.socketFactory.class":"javax.net.SocketFactory",
				"mail.smtp.socketFactory.port":"465",
				"mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
				"mail.smtp.socketFactory.fallback":"false"]
		*/
	}
}