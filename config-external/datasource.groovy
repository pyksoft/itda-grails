dataSource {
	pooled = true
	dbCreate = "update"
	dialect = 'org.hibernate.dialect.MySQL5InnoDBDialect'	
	url = "jdbc:mysql://localhost/itdadb002"
	driverClassName = "com.mysql.jdbc.Driver"
	username = "itdauser002"
	password = "password"	
}

hibernate {
    cache.use_second_level_cache=true
    cache.use_query_cache=true
    //cache.provider_class='com.opensymphony.oscache.hibernate.OSCacheProvider' 
	cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}

// TEST
/*
dataSource {
	pooled = true
	dbCreate = "update"
	url = "jdbc:mysql://localhost:3306/itdadb002"
	driverClassName = "com.mysql.jdbc.Driver"
	username = "itdauser002"
	password = "password"	
}
*/

//PRODUCTiON
/*
dataSource {
	pooled = true
	dbCreate = "update"
	url = "jdbc:mysql://localhost/inthedoor?autoReconnectForPools=true"
	driverClassName = "com.mysql.jdbc.Driver"
	username = "inthedoor001"
	password = "pASSword12345"
	//Pa$$w0rd
	/*
	//properties {
		//maxActive = 50
		//maxIdle = 10
		//minIdle = 5
		//initialSize = 5
		//minEvictableIdleTimeMillis = 1800000
		//timeBetweenEvictionRunsMillis = 1800000
		//maxWait = 10000
	 //}
	 
}
*/
