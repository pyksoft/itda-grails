package com.itda.command
import java.io.Serializable;
 
public class CommentCommand implements Serializable {
	String name
	String phone
	String comment
	static constraints = {
		name(blank:false)
		phone(matches:"[1-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", blank:false)
		comment(blank:false)
	}
	
}
