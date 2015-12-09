

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Zipcode List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New Zipcode</g:link></span>
        </div>
        <div class="body">
            <h1>Zipcode List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="latitude" title="Latitude" />
                        
                   	        <g:sortableColumn property="longitude" title="Longitude" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${zipcodeInstanceList}" status="i" var="zipcodeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${zipcodeInstance.id}">${fieldValue(bean:zipcodeInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:zipcodeInstance, field:'latitude')}</td>
                        
                            <td>${fieldValue(bean:zipcodeInstance, field:'longitude')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${zipcodeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
