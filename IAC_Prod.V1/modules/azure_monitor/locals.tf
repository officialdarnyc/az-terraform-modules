locals {
    solutions = {
        for solution in var.solutions:
            lookup(solution, "name") => {
                name = lookup(solution, "name")
            }
    }
	
	application_insights = {
        for application_insight in var.application_insights:
            lookup(application_insight, "name") => {
                name = lookup(application_insight, "name")
            }
    }

}