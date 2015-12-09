

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit Zipcode</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">Zipcode List</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Zipcode</g:link></span>
        </div>
        <div class="body">
            <h1>Edit Zipcode</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${zipcodeInstance}">
            <div class="errors">
                <g:renderErrors bean="${zipcodeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${zipcodeInstance?.id}" />
                <input type="hidden" name="version" value="${zipcodeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="latitude">Latitude:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:zipcodeInstance,field:'latitude','errors')}">
                                    <g:select from="${-90..90}" id="latitude" name="latitude" value="${zipcodeInstance?.latitude}" noSelection="['':'']"></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="longitude">Longitude:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:zipcodeInstance,field:'longitude','errors')}">
                                    <g:select from="${-180..180}" id="longitude" name="longitude" value="${zipcodeInstance?.longitude}" noSelection="['':'']"></g:select>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" value="Update" /></span>
                    <span class="button"><g:actionSubmit class="delete" onclick="return confirm('Are you sure?');" value="Delete" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
