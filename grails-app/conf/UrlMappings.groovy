class UrlMappings {
    static mappings = {
      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/"(view:"/index")
	  "500"(view:'/common/error500')
	  "404"(view:'/common/error404')
	  "403"(view:'/common/error403')
	}
}
