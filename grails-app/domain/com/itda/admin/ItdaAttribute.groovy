package com.itda.admin

import java.util.ArrayList;

class ItdaAttribute implements Serializable{

	String name;
	String name2;
	String value;
	String value2;
	Float displayOrder;
	Boolean enabled = true;
	String shortLabel;
	String longLabel;
    static constraints = {
		//id composite: ['name', 'value']	, generator: 'assigned'//this is not working; grails still generate an id column 	
		name blank:false, nullable:false
		name2 nullable:true
		value blank:true, nullable:false, 
			validator: { val, ItdaAttribute obj -> //alternate key: name + value
				if(obj.name && obj.name && (obj.value || obj.value == "")) 
	            	return ! ItdaAttribute.findWhere(name:obj.name, name2:obj.name2, value:obj.value);
	            if(obj.name && (obj.value || obj.value == "")) 
	            	return ! ItdaAttribute.findWhere(name:obj.name, value:obj.value);
	            else 
	            	return false;
        	}
		value2 blank:true, nullable:true 

		displayOrder nullable:true
		enabled nullable:false
		shortLabel nullable:true
		longLabel nullable:true
            		
    }
	
	public static HashMap<String, String> findAllValueShortLabelPairs(String code) {
		def results = 
		ItdaAttribute.executeQuery("select p.value, p.shortLabel from ItdaAttribute p where p.name = ? and p.enabled = true", [code]);
		HashMap<String, String> vspairs = new HashMap<String, String>();
		if(results)
			for(result in results)
				vspairs[result[0]] = result[1];
				
		return vspairs;
	}
	
	public static HashMap<String, String> findAllShortLabelValuePairs(String code) {
		def results =
		ItdaAttribute.executeQuery("select p.value, p.shortLabel from ItdaAttribute p where p.name = ? and p.enabled = true", [code]);
		HashMap<String, String> vspairs = new HashMap<String, String>();
		if(results)
			for(result in results)
				vspairs[result[1]] = result[0];
				
		return vspairs;
	}
	
	public static ArrayList<String> findAllValues(String code) {
		def results = 
		ItdaAttribute.executeQuery("select p.value from ItdaAttribute p where p.name = ? and p.enabled = true", [code]);
		ArrayList values = new ArrayList<String>();
		if(results)
			for(val in results)
				values.add val;
				
		return values;
	}
	
	public static ArrayList<String> findAllValues(String code, String code2) {
		def results = 
		ItdaAttribute.executeQuery("select p.value from ItdaAttribute p where p.name = ? and p.enabled = true and p.name2 = ?", [code, code2]);
		ArrayList values = new ArrayList<String>();
		if(results)
			for(val in results)
				values.add val;
				
		return values;
	}	

	public static HashMap<String, String> findAllValueValue2Pairs(String code, def adTypes /* grails does not like String[] */) {
		def results = 
		ItdaAttribute.executeQuery("select p.value, p.value2 from ItdaAttribute p where p.name = :code and p.enabled = true and p.name2 in (:adTypes)", [code:code, adTypes:adTypes]);
		HashMap<String, String> vspairs = new HashMap<String, String>();
		if(results)
			for(result in results)
				vspairs[result[0]] = result[1];
				
		return vspairs;
	}	
		
}
