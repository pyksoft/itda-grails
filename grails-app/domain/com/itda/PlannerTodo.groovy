package com.itda

class PlannerTodo {
	String title
	Boolean isCompleted = false
    static belongsTo = [plannerEntry:PlannerEntry]    

    static constraints = {
		title(nullable:false)
		isCompleted(nullable:false)
	}
	
}
