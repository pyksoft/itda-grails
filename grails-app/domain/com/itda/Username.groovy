package com.itda

import java.io.Serializable;

class Username implements Serializable  {
	String login //same as the authentication user
    static belongsTo = [business:Business]    
                        
    static constraints = {
		login(blank:false, unique:true, size:6..64)
	}
}
