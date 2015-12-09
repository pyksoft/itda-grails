var FullCalUtil = Class.extend( {
	
	init : function(name, fullCal) {
        this.ctrlName = name;
        //fullCal.data("loading", this.loading);
		this.cal = fullCal;
	},
	
	gotoDate: function() {
		var selYear = $('option:selected', this.yearSelect).val();
		var selMonth = $('option:selected', this.monthSelect).val();
		var selDay = $('option:selected', this.daySelect).val();
		if(selYear > 2000 && selMonth != "") {
			if(this.zeroBasedMonth)
				selMonth -= 1;
			
			var id = this.cal.data("id");
			if(id) {
				var date = new Date();
				date.setYear(selYear);
				date.setMonth(selMonth);
				initMultiSelectDatePicker (id, null, null, date);	
			}
			else
				this.cal.fullCalendar('gotoDate', selYear , selMonth, selDay);
			$('option[value=""]', this.monthSelect).attr('selected','selected');
			$('option[value=""]', this.yearSelect).attr('selected','selected');
		}
	},

	loading: function (isLoading, view) {
		/*
		if(!isLoading) {
			var year = view.start.getFullYear();
			var month = view.start.getMonth() + 1;
			$('option[value="'+month+'"]', this.monthSelect).attr('selected','selected');
			$('option[value="'+year+'"]', this.yearSelect).attr('selected','selected');
		}
		*/
	},
	
	setYearSelect: function(year) {
		$('option', year).removeAttr('selected');
		$('option[value=""]', year).html('Year');
		if(year)
			year.show();
		this.yearSelect = year;
		
		
	},
	setMonthSelect: function(month, zeroBasedMonth) {
		$('option', month).removeAttr('selected');
		$.each($('option', month), function(i, option){
			option = $(option);
			if(option.val()  != "") {
				var val = option.html();
				if(val && val.length >= 3)
				val = val.substr(0, 3);
				option.html(val);
			}
		});			
		$('option[value=""]', month).html('Month');
		if(month)
			month.show();
		
		this.monthSelect = month;
		this.zeroBasedMonth = zeroBasedMonth;
	},
	setDaySelect: function(day) {
		$('option[value=""]', day).html('Day');
		this.daySelect = day;
	},
	

});
