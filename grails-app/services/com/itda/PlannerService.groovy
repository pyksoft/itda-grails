package com.itda

class PlannerService {

    static transactional = false;

	def getAdFileNameText(portfolioEntry) {
		if(portfolioEntry == null)
			return '';
		String filePath = portfolioEntry.imageFile;
		int begin = filePath.lastIndexOf("/") + 1;
		int end = filePath.lastIndexOf(".");
		if(begin < end)
			return filePath.substring(begin, end);
		else
			return filePath.subSequence(begin);
	}

    def getAdColorTextForCode(colorCode) {
		if(colorCode == null)
			return '';
		if(colorCode == '4C' || colorCode == '4')
			return "Four-Color";
		if(colorCode == '2C' || colorCode == '2')
			return "Two-Color";
		if(colorCode == '1C' || colorCode == '1')
			return "One-Color";
    }
	
	def getAdSizeTextForCode(String key) {
		if(key == null)
			return '';
		key = key.replace('-', '_')
	    if(key=="FP") return 'Full Page';
	    if(key=="3_4V") return '3/4 Page Vertical';
	    if(key=="2_3V") return '2/3 Page Vertical';
	    if(key=="2_3H") return '2/3 Page Horizontal';
	    if(key=="1_2V") return '1/2 Page Vertical';
	    if(key=="1_2H") return '1/2 Page Horizontal';
	    if(key=="1_3V") return '1/3 Page Vertical';
	    if(key=="1_3H") return '1/3 Page Horizontal';
	    if(key=="1_4H") return '1/4 Page Horizontal';
	    if(key=="1_4V") return '1/4 Page Vertical';
	    if(key=="1_5V") return '1/5 Page Vertical';
	    if(key=="1_5H") return '1/5 Page Horizontal';
	    if(key=="1_6V") return '1/6 Page Vertical';
	    if(key=="1_6H") return '1/6 Page Horizontal';
	    if(key=="1_8V") return '1/8 Page Vertical';
	    if(key=="1_8H") return '1/8 Page Horizontal';
	    if(key=="1_62C") return '1/62 Column';
	    if(key=="1_63C") return '1/63  Column';
	    if(key=="SL") return 'Standard Letter';
	    if(key=="CL") return 'Check Letter';
	    if(key=="CH") return 'Check';
	    if(key=="IM") return 'Invitation Mailer';
	    if(key=="SM") return 'Self Mailer';
	    if(key=="PC") return 'Postcard';
	}

}
