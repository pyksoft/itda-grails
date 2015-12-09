package com.itda;
import java.util.Calendar;
import grails.converters.JSON;

import org.apache.jasper.compiler.Node.ParamsAction;
import org.hibernate.FetchMode;

class MyReportController {
	def authenticationService;
	
    def index = {
		def model= [:];
		long bizId = authenticationService.getSessionUser().attributes['businessId'] as long;
		def biz = Business.get(bizId);
      	model['offices'] = Office.findAll("from Office as o where o.business.id=:bizId and o.availability <> 'false'",[bizId: bizId as long]);
    	model['competitors'] = Competitor.listCompetitors (bizId as long);
    	model['vendors'] = Vendor.listVendors (bizId as long);
    	model['publications'] = Publication.listPub (bizId as long);
		model['periods'] = calculateReportPeriods(biz.dateCreated);
		def start, end, cal =  Calendar.getInstance();
		start = cal.get(Calendar.YEAR) - 10;
		end = start + 20;
		render(view: "reports",  model: [model:model, start:start, end:end]) ;
	}
//-------------------
    def generateReports = {
		if(params.tab && params.tab.indexOf('Competition') > 0)
			generateMyCompetitionReport();
		else
			generateMyMarketingReport();
		println params;
    }
	
	def generateMyMarketingReport () {
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long
	         def c = PlannerEntry.createCriteria();
	         def resultset = c.list(max:params.max, offset:params.offset) {
		        fetchMode("result", org.hibernate.FetchMode.EAGER)

				eq('business.id', bizId)
					           	
	            if( params.from && params.to){
				   Calendar cal = Calendar.getInstance();
				   cal.set(params['from_year'] as int, params['from_month'] as int, 1, 0, 0, 0);
				   cal.add(Calendar.MONTH, -1); //adjust for 0-based
				   println cal.getTime();
		           ge('start', cal.getTime());
				   cal.set(params['to_year'] as int, params['to_month'] as int, 1, 0, 0, 0); //include an extra month since it is 0-base
				  println cal.getTime();
		           lt('start', cal.getTime());
	            }
    			if(params.className) 
    				inList('className', 
    					(params.className instanceof String ? [params.className] : params.className));
    			if(params.offices) 
    				inList('office.id', 
    					(params.offices instanceof String ? [params.offices as long] : request.getParameterValues('offices').collect { it.toLong() } ));
    			if(params.vendors || params.publications) 
    				or{
    					if(params.vendors)
    						inList('vendor.id', 
    						(params.vendors instanceof String ? [params.vendors as long] : request.getParameterValues('vendors').collect { it.toLong() } ));
    					if(params.publications)
    						inList('publication.id', 
    						(params.publications instanceof String ? [params.publications as long] : request.getParameterValues('publications').collect { it.toLong() }));
    				}

    		  //if(params.grossSales)
			  //    isNotNull('grossSales')
    		  //if(params.totalExpense)
			  //    isNotNull('totalExpense')
    		  //if(params.returnOnInvest)
			   //   isNotNull('returnOnInvest')
    		  //if(params.costPerLead)
			   //   isNotNull('costPerLead')

				//if(params.placement || params.rating){
				//	result{ //join
				//	}
				//}

    		  if(params.grossSales == 'desc' || params.grossSales == 'asc')
			      order('grossSales', params.grossSales)
    		  if(params.totalExpense == 'desc' || params.totalExpense == 'asc')
			      order('totalExpense', params.totalExpense)
    		  if(params.returnOnInvest == 'desc' || params.returnOnInvest == 'asc')
			      order('returnOnInvest', params.returnOnInvest)
    		  if(params.costPerSale == 'desc' || params.costPerSale == 'asc')
			      order('costPerSale', params.costPerSale)
    		  if(params.costPerLead == 'desc' || params.costPerLead == 'asc')
			      order('costPerLead', params.costPerLead)
    		  if(params.sortByDate == 'desc' )
			      order('start', 'desc')
			  else
			  	  order('start', 'asc')
	          }//PlannerEntry
            println 'count is ' + resultset.totalCount
			def resp;
			if(resultset.totalCount > 0){
				resp = [respText:'Success',results:resultset, total:resultset.totalCount];	
				render(template:"report_templ",model:resp, contentType:"text/json");
			}else{
				resp = [respText:'No match'];
				render resp as JSON;
			}
        }

	def generateMyCompetitionReport () {
    	long bizId = authenticationService.getSessionUser().attributes['businessId'] as long
	         def c = CompetitorAd.createCriteria();
	         def resultset = c.list(max:params.max, offset:params.offset) {
		        ///// fetchMode("result", org.hibernate.FetchMode.EAGER)

				eq('business.id', bizId)
					           	
	            if( params.from && params.to){
				   Calendar cal = Calendar.getInstance();
				   cal.set(params['from_year'] as int, params['from_month'] as int, 1, 0, 0, 0);
				   cal.add(Calendar.MONTH, -1); //adjust for 0-based
				   println cal.getTime();
		           ge('start', cal.getTime());
				   cal.set(params['to_year'] as int, params['to_month'] as int, 1, 0, 0, 0); //include an extra month since it is 0-base
				  println cal.getTime();
		           lt('start', cal.getTime());
	            }
    			if(params.className) 
    				inList('className', 
    					(params.className instanceof String ? [params.className] : params.className));
    			if(params.competitors) 
    				inList('competitor.id', 
    					(params.competitors instanceof String ? [params.competitors as long] : request.getParameterValues('competitors').collect { it.toLong() } ));
    			if(params.vendors || params.publications) 
    				or{
    					if(params.vendors)
    						inList('vendor.id', 
    						(params.vendors instanceof String ? [params.vendors as long] : request.getParameterValues('vendors').collect { it.toLong() } ));
    					if(params.publications)
    						inList('publication.id', 
    						(params.publications instanceof String ? [params.publications as long] : request.getParameterValues('publications').collect { it.toLong() }));
    				}
	    		  if(params.sortByDate == 'desc' )
				      order('start', 'desc')
				  else
				  	  order('start', 'asc')
	          }//CompetitorAd
            println 'count is ' + resultset.totalCount
			def resp;
			if(resultset.totalCount > 0){
				resp = [respText:'Success',results:resultset, total:resultset.totalCount];	
				render(template:"competiton_report_templ",model:resp, contentType:"text/json");
			}else{
				resp = [respText:'No match'];
				render resp as JSON;
			}
        }

//---------------------
	def String [] convertAdTypeCodes( adTypes ) {
		def codes = [];
		def map = PortfolioController.offerCodeMap;
		for(offer in offers) 
			for(code in map.keySet()) 
				if(offer == map[code])
					codes.add(code)
					
		assert(codes.size() > 0)
		return codes;
	}
			
	def calculateReportPeriods(startDate) {
		def periods = [:];
		 
		Calendar cal = new GregorianCalendar();
		long now = cal.getTimeInMillis();
		
		long startTime = startDate.getTime();
		cal.setTimeInMillis(startTime);
		cal.set Calendar.YEAR, cal.getAt(Calendar.YEAR)+1;
		cal.set Calendar.MONTH, 1;
		cal.set Calendar.DAY_OF_MONTH, 1;
		cal.set Calendar.HOUR_OF_DAY , 0;
		cal.set Calendar.MINUTE, 0;
		cal.set Calendar.SECOND, 0;
		while( cal.getTimeInMillis() > startTime ){
			cal.add(Calendar.MONTH, -3);
		}		
		
		long startOfPeriod = cal.getTimeInMillis();
		while( startOfPeriod < now ){
			def period, month = cal.get(Calendar.MONTH);
			if(month == 1)
				period ='1st';
			else if(month == 4)
				period ='2nd';
			else if(month == 7)
				period ='3rd';
			else 
				period ='4th';

			periods[period + ' Quarter: '+ cal.get(Calendar.YEAR)] = cal.get(Calendar.MONTH)+'/01/'+cal.get(Calendar.YEAR);
			cal.add(Calendar.MONTH, 3);
			startOfPeriod = cal.getTimeInMillis();
		}
		return periods;
	}
}
