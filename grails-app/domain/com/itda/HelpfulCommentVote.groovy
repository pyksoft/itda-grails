package com.itda

import java.util.Date;

class HelpfulCommentVote {

	Business business;
	String login;
	Result result; //result from a planner entry
	String vote;
	Date dateCreated; 
	Date lastUpdated;
    static constraints = {
    	login(size:1..128, nullable:false)
		vote(inList:[ "Yes", "No"], nullable:false) 
		business(nullable:false)
		result(nullable:false)
    }
}
