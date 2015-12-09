package com.itda

import java.io.Serializable;
import java.util.Date;

class UserSession implements Serializable {
	
	String login
    
    /**
     * Date/time at which this user logged in
     */
	Date loginTime

    /**
     * Date/time at which this user logged out
     */
	Date logoutTime

    /**
     * Date/time at which this user session expires
     */
	Date expirationTime

	/**
	 * Is the user currently logged in
	 */
	boolean loggedIn

	/**
	 * The domain object id of the user principal object for this account
	 */
    Long businessId   
    
    String sessionId
    
    static constraints = {
        login(size:1..128, blank:false, nullable:false)
        sessionId(size:1..128, blank:false, nullable:false, unique:true)
		logoutTime(nullable:true)
		expirationTime(nullable:true)
		businessId(nullable:true)
    }
    
    
    
    static sessionCount = { login ->
	def count = UserSession.executeQuery('select count(u) from UserSession u where u.login = ?', 
			[login])
	return count;
}
    
}