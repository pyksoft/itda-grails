-- SELECT id, data INTO @x, @y FROM test.t1 LIMIT 1;
-- UPDATE items, month SET items.price=month.price WHERE items.id=month.id;
/*
DELIMITER //  
  
CREATE PROCEDURE `proc_WHILE` (IN param1 INT)  
BEGIN  
    DECLARE variable1, variable2 INT;  
    SET variable1 = 0;  
  
    WHILE variable1 < param1 DO  
        INSERT INTO table1 VALUES (param1);  
        SELECT COUNT(*) INTO variable2 FROM table1;  
        SET variable1 = variable1 + 1;  
    END WHILE;  
END // 
 */

alter table advertising_zipcode drop index zipcode;

update business
set email = concat(email, id)
where id > 20

alter table  business modify column
  promo_codes varchar(11) DEFAULT NULL

-----------------  
update portfolio set promo_code_id = 'nuear'  ;


update business set promo_code_id = promo_codes  ;
update business set promo_code_id = 'nuear' where promo_code_id is null;
alter table  business drop column  promo_codes; 

insert into manufacturer_promo_code (version, promo_code, manufacturer) values(0, "nuear", "NuEar");
insert into manufacturer_promo_code (version, promo_code, manufacturer) values(0, "starkey", "Star Key");
insert into manufacturer_promo_code (version, promo_code, manufacturer) values(0, "audible", "Audible");
insert into manufacturer_promo_code (version, promo_code, manufacturer) values(0, "allamerican", "All American");

insert into ad_type_code (version, ad_type_code, active, description) values(0, "NP", 0x01, "Newspaper");
insert into ad_type_code (version, ad_type_code, active, description) values(0, "DM", 0x01, "Direct Mail");
insert into ad_type_code (version, ad_type_code, active, description) values(0, "ME", 0x01, "Media");
insert into ad_type_code (version, ad_type_code, active, description) values(0, "EV", 0x01, "Event");
insert into ad_type_code (version, ad_type_code, active, description) values(0, "MI", 0x01, "Miscellaneous");
insert into ad_type_code (version, ad_type_code, active, description) values(0, "UNKNOWN", 0x00, "N/A");

insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "FP", "NP", 0x01, "Full Page", "Full Page");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "3_4V", "NP", 0x01, "3/4 Page V", "3/4 Page Vertical");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "2_3V", "NP", 0x01, "2/3 Page V", "2/3 Page Vertical");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "2_3H", "NP", 0x01, "2/3 Page H", "2/3 Page Horizontal");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_2V", "NP", 0x01, "1/2 Page V", "1/2 Page Vertical");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_2H", "NP", 0x01, "1/2 Page H", "1/2 Page Horizontal");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_3V", "NP", 0x01, "1/3 Page V", "1/3 Page Vertical");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_3H", "NP", 0x01, "1/3 Page H", "1/3 Page Horizontal");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_4H", "NP", 0x01, "1/4 Page H", "1/4 Page Horizontal");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_4V", "NP", 0x01, "1/4 Page V", "1/4 Page Vertical");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_5V", "NP", 0x01, "1/5 Page V", "1/5 Page Vertical");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_5H", "NP", 0x01, "1/5 Page H", "1/5 Page Horizontal");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_6V", "NP", 0x01, "1/6 Page V", "1/6 Page Vertical");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_6H", "NP", 0x01, "1/6 Page H", "1/6 Page Horizontal");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_62C", "NP", 0x01, "1/6 Page 2C", "1/6 Page 2 Column");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_63C", "NP", 0x01, "1/6 Page 3C", "1/6 Page 3 Column");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_8V", "NP", 0x01, "1/8 Page V", "1/8 Page Vertical");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "1_8H", "NP", 0x01, "1/8 Page H", "1/8 Page Horizontal");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "6CH", "NP", 0x01, "6CH", "6 Column Horizontal");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "2PI", "NP", 0x01, "2PI", "2 Panel Newspaper Insert");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "4PI", "NP", 0x01, "4PI", "4 Panel Newspaper Insert");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "Custom", "NP", 0x01, "Custom Size", "Custome Size");

insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "SL", "DM", 0x01, "Standard Letter", "Standard Letter");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "CL", "DM", 0x01, "Check Letter", "Check Letter");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "CH", "DM", 0x01, "Check", "Check");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "IM", "DM", 0x01, "Invitation Mailer", "Invitation Mailer");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "PCO", "DM", 0x01, "Postcard Outside", "Postcard Outside");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "PCI", "DM", 0x01, "Postcard Inside", "Postcard Inside");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "SMO", "DM", 0x01, "Self Mailer Outside", "Self Mailer Outside");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "SMI", "DM", 0x01, "Self Mailer Inside", "Self Mailer Inside");


insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "TV_30_SEC", "ME", 0x01, "TV 30 Sec", "TV 30 Seconds");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "TV_60_SEC", "ME", 0x01, "TV 60 Sec", "TV 30 Seconds");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "RADIO_30_SEC", "ME", 0x01, "Radio 30 Sec", "Radio 30 Seconds");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "RADIO_60_SEC", "ME", 0x01, "Radio 60 Sec", "Radio 60 Seconds");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "INTERNET_AD", "ME", 0x01, "Internet Ad", "Internet Ad");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "SOCIAL_MEDIA", "ME", 0x01, "Social Media", "Social Media");


insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "OPEN_HOUSE", "EV", 0x01, "Open House", "Open House");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "HEALTH_FAIR", "EV", 0x01, "Health Fair", "Health Fair");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "OUTREACH_PROGRAM", "EV", 0x01, "Outreach Program", "Outreach Program");

insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "LEAD_PULL", "MI", 0x01, "Lead Pull", "Lead Pull");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "BUS_AD", "MI", 0x01, "Bus Ad", "Bus Ad");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "BILLBOARD", "MI", 0x01, "Billboard", "Billboard");
insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "CONTEST", "MI", 0x01, "Contest", "Contest");

insert into ad_size_code (version, ad_size_code, ad_type_code_id, active, description, long_description) values(0, "UNKNOWN", "UNKNOWN", 0x00, "N/A", "N/A");

--------------------------------------
update result set helpful_count = 0, not_helpful_count = 0, location = 'San Diego CA';

DROP PROCEDURE IF EXISTS updateNumReview;
delimiter //
CREATE PROCEDURE updateNumReview()
begin  
        declare rowid  bigint;              -- define variables to store record fields
        declare val  int;              -- define variables to store record fields
        declare v_notfound                -- define the loop control variable
            BOOL default FALSE;
        declare csr_num_review                   -- define the cursor
            cursor for 
            select portfolio_entry_id, count(review) FROM result  where published = 0x01 and review is not null and portfolio_entry_id  is not null group by portfolio_entry_id;
        declare continue handler          -- handle cursor exhaustion
            for not found 
            set v_notfound := TRUE;       -- mark our loop control variable
        declare exit handler              -- handle other errors
            for sqlexception
            close csr_num_review;                -- free resources before exit
        open csr_num_review;                     -- open cursor 
        cursor_loop: loop
            fetch csr_num_review into            -- fetch record values
               rowid, val;
         if v_notfound then           -- exit the loop when the cursor is exhausted
                leave cursor_loop;
          end if;
         update portfolio_entry set num_review = val where id = rowid;
        end loop;
        close csr_num_review;                    -- free resources
end;
//

DROP PROCEDURE IF EXISTS updateRating;
delimiter //
CREATE PROCEDURE updateRating()
begin  
        declare rowid  bigint(20);              -- define variables to store record fields
        declare average, counts  double;              -- define variables to store record fields
        declare v_notfound                -- define the loop control variable
            BOOL default FALSE;
        declare csr_rating                   -- define the cursor
            cursor for 
            select portfolio_entry_id, avg(rating), count(rating) FROM result  where published = 0x01 and portfolio_entry_id  is not null group by portfolio_entry_id;
        declare continue handler          -- handle cursor exhaustion
            for not found 
            set v_notfound := TRUE;       -- mark our loop control variable
        declare exit handler              -- handle other errors
            for sqlexception
            close csr_rating;                -- free resources before exit
        open csr_rating;                     -- open cursor 
        cursor_loop: loop
            fetch csr_rating into            -- fetch record values
               rowid, average, counts;
            if v_notfound then           -- exit the loop when the cursor is exhausted
                leave cursor_loop;
            end if;
            update portfolio_entry set rating = average, num_rating = counts where id = rowid;
            select rowid, average, counts;
        end loop;
        close csr_rating;                    -- free resources
end;
//

select id, ad_size_code from portfolio_entry
where ad_size_code not in(select ad_size_code from ad_size_code);

update portfolio_entry set ad_size_id = ad_size_code;

select id, ad_type_code from portfolio_entry
where ad_type_code not in(select ad_type_code from ad_type_code);

update portfolio_entry set ad_type_id = ad_type_code;


CREATE TABLE `test_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ad_size_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKTest` (`ad_size_id`),
  CONSTRAINT `FKTest` FOREIGN KEY (`ad_size_id`) REFERENCES `ad_size_code` (`ad_size_code`)
) ENGINE=MyISAM AUTO_INCREMENT=520 DEFAULT CHARSET=latin1;

CREATE TABLE `test_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ad_size_id` varchar(255) not NULL,
  PRIMARY KEY (`id`),
   FOREIGN KEY (`ad_size_id`) REFERENCES `ad_size_code` (`ad_size_code`)
) ENGINE=MyISAM AUTO_INCREMENT=520 DEFAULT CHARSET=latin1;


CREATE TABLE `test_tbl` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ad_size_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=520 DEFAULT CHARSET=latin1;

ALTER TABLE test_tbl
    ADD CONSTRAINT test_constraint FOREIGN KEY
     (ad_size_id)
    REFERENCES ad_size_code (ad_size_code);
    
-----------------------------------------

 update business set date_created = '2011-01-01'; 
 
 ----------------------------------------------
 UPDATE planner_entry p, result r
    SET p.gross_sales =  r.gross_sales
    , p.total_expense = r.total_expense
    , p.return_on_invest = r.return_on_invest
    , p.cost_per_lead = r.cost_per_lead
    , p.placement = r.placement
    WHERE p.result_id = r.id
------------------------------------------    
alter table  portfolio drop column   promo_code_id;
alter table  portfolio_entry drop column  promo_code_id;

show index from portfolio_entry;


alter table  portfolio_entry drop column ad_type_id;
  
alter table  portfolio_entry drop column ad_size_id;
  
/*
alter table  portfolio_entry drop key FKF0E55ABBD8AB1B66;
alter table  portfolio_entry drop key FKF0E55ABBE3CFD686;
*/  
  -------------------------------

alter table vendor 
modify column phone varchar(255) default NULL;
modify column contact_phone varchar(255) default NULL;

alter table publication 
modify column contact_phone varchar(255) default NULL;

update portfolio_entry  set promo_code = promo_code_id;
-------------------------------
alter table vendor 
modify column phone varchar(255) default NULL;
modify column contact_phone varchar(255) default NULL;
------------------------------------------------------
update business set accepted_terms = 0;
alter table business modify column accepted_terms bit(1) not NULL;
------------------------------------------------

DROP PROCEDURE IF EXISTS updatePortfolioEntryTab;
delimiter //
CREATE PROCEDURE updatePortfolioEntryTab()
begin  
        declare rowid  bigint(20);              -- define variables to store record fields
        declare filename  varchar(200);              -- define variables to store record fields
        DECLARE offset TINYINT(3) UNSIGNED;
        declare v_notfound                -- define the loop control variable
            BOOL default FALSE;
        declare csr_rating                   -- define the cursor
            cursor for 
            select id, image_file FROM portfolio_entry  where ad_tab_number  is null;
        declare continue handler          -- handle cursor exhaustion
            for not found 
            set v_notfound := TRUE;       -- mark our loop control variable
        declare exit handler              -- handle other errors
            for sqlexception
            close csr_rating;                -- free resources before exit
        open csr_rating;                     -- open cursor 
        cursor_loop: loop
            fetch csr_rating into            -- fetch record values
               rowid, filename;
            if v_notfound then           -- exit the loop when the cursor is exhausted
                leave cursor_loop;
            end if;
             set offset := locate('/', filename);
			while offset > 0 DO
             set filename := substring(filename, offset+1);
             set offset := locate('/', filename);
   		   END WHILE;             	
            -- update portfolio_entry set unparsable_file = filename where id = rowid;
            -- update portfolio_entry set ad_tab_number = offset where id = rowid;
             update portfolio_entry set ad_tab_number = cast(substring(filename, 3, 1) as unsigned) where id = rowid;
            select rowid, filename;
        end loop;
        close csr_rating;                    -- free resources
end;
//
=========================================
 UPDATE planner_entry p, result r
    SET r.run_date =  p.start
    WHERE p.result_id = r.id

 select p.id, p.start, r.id, r.run_date from planner_entry p, result r WHERE p.result_id = r.id
 
update planner_entry set portfolio_entry_id = null where portfolio_entry_id not in (select id from portfolio_entry);
===========================================

update result r ,planner_entry p 
set p.gross_sales = r.gross_sales, 
p.total_expense = r.total_expense,
p.return_on_invest = r.return_on_invest, 
p.portfolio_entry_id = r.portfolio_entry_id
where p.id = r.planner_entry_id;

select r.gross_sales, r.total_expense, r.return_on_invest, r.portfolio_entry_id
, p.gross_sales, p.total_expense, p.return_on_invest, p.portfolio_entry_id, p.start
 from result r ,planner_entry p where p.id = r.planner_entry_id;
 
select id , portfolio_entry_id, planner_entry_id from result where portfolio_entry_id not in (select id from portfolio_entry)
update result set portfolio_entry_id = null where portfolio_entry_id not in (select id from portfolio_entry)

select id from planner_entry where portfolio_entry_id not in (select id from portfolio_entry) 
 select id , portfolio_entry_id, planner_entry_id from result where planner_entry_id not in (select id from planner_entry)
 update result set planner_entry_id = null where planner_entry_id not in (select id from planner_entry)
 
 =====================20120806
update portfolio set deleted = cast(0 as unsigned), category = 'portfolio';

update business set promo_code = promo_code_id;

ALTER TABLE business DROP FOREIGN KEY FKBBA4BFC0F5D1D790;
alter table business drop column promo_code_id;
update portfolio_entry set category = 'portfolio', deleted = 0x0;
alter table  portfolio modify column portfolio_date datetime not NULL;


--itdaAttribute table inserts
=============================20120905
alter table  portfolio_entry modify column portfolio_date datetime not NULL;

 UPDATE portfolio p, portfolio_entry r
    SET r.portfolio_date =  p.portfolio_date
    WHERE p.id = r.portfolio_id;
=======================================20120908
alter table download drop column login;

insert into payment_info
(version, business_id, card_number, card_type, date_created
, expire_month, expire_year, first_name, last_name, last_updated)
select version, business_id, card_number, card_type, date_created
, expire_month, expire_year, first_name, last_name, last_updated
from payment where id  in (1, 126);

update itda_attribute  set short_label = 'Direct Mail' where 
name = 'adTypeCode' and value = 'DM';

===========================================20120913
 SET foreign_key_checks = 0;
 delete from payment where ad_id is not null;
 SET foreign_key_checks = 1;
ALTER TABLE payment DROP FOREIGN KEY FKD11C32065E9066BA;
ALTER TABLE payment DROP  KEY FKD11C32065E9066BA;
ALTER TABLE payment DROP  column ad_id;
======================================================

update planner_entry set size = 'PC'  where size in ('PCI', 'PCO');
update planner_entry set size = 'SM'  where size in ('SMI', 'SMO');
update competitor_ad set size = 'PC'  where size in ('PCI', 'PCO');
update competitor_ad set size = 'SM'  where size in ('SMI', 'SMO');
update portfolio_entry set ad_size_code = 'PC'  where ad_size_code in ('PCI', 'PCO');
update portfolio_entry set ad_size_code = 'SM'  where ad_size_code in ('SMI', 'SMO');

=============================================20121026

update itda_attribute set value2 = '109'
where name = 'adSizeCode' and name2 = 'NP' and value = '2_3V' ;

update itda_attribute set value2 = '109'
where name = 'adSizeCode' and name2 = 'NP' and value = '2_3H';

update itda_attribute set value2 = '69'
where name = 'adSizeCode' and name2 = 'NP' and value = '1_63C'; 

update itda_attribute set value2 = '69'
where name = 'adSizeCode' and name2 = 'NP' and value = '1_62C';

update portfolio_entry set enable = false
where ad_Size_Code = '6CH';

update portfolio_entry set enable = false
where ad_Size_Code = '2PI';

update portfolio_entry set enable = false
where ad_Size_Code = '4PI';

update payment set description = replace(description, 'Ad #', 'AS #')
where description like 'Ad #%'

================================================20121103

update result set publish_cost_per_sale = 1

update result set publish_cost_per_sale = 1, cost_per_sale = total_Expense/tests_Sold;
===========================================================

update send_to_vendor set views = 0 , downloads = 0;
===========================================================

ALTER TABLE `zipcode` DROP PRIMARY KEY
ALTER TABLE `zipcode` ADD PRIMARY KEY ( `zipcode` )
alter table  zipcode modify column
  zipcode varchar(255) NOT NULL
--------------------------------------------------------
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Up to 3 Offices for $129/Month includes 15 GB of file storage','pricingPlanCode','3', 'Up to 3 Offices for $129/Month','129', '15 GB');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Up to 6 Offices for $199/Month includes 40 GB of file storage','pricingPlanCode', '6','Up to 6 Offices for $199/Month','199', '40 GB');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Up to 12 Offices $249/Month includes 75 GB of file storage','pricingPlanCode', '12', 'Up to 12 Offices for $249/Month','249', '75 GB');
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Unlimited Offices for $499/Month includes 100 GB of file storage','pricingPlanCode', '9999999','Unlimited Offices for $499/Month','499', '100 GB');

update result r ,planner_entry p 
set p.cost_per_sale = r.total_expense / r.tests_sold
where p.id = r.planner_entry_id;

----------------------------------------------------------------------

alter table  send_to_vendor drop column  change_other_flag; 
-----------------------------------------------------------------------
alter table  send_to_vendor modify column
  notes varchar(60000) DEFAULT NULL; 

-----------------------------------------------------------------------------------
-- mkdir /Data/userContent/tempUpload/
-- mkdir /Data/userContent/myUpload/  

 INSERT INTO `portfolio` (`id`,`version`,`status`,`back_page_image`,`state`,`upload_zip_name`,`portfolio_date`,`last_updated`,`cover_page_image`,`spine_image`,`date_created`,`description`, promo_code, category, deleted) VALUES
 (0,0,'Archive',NULL,'Ready',null,'1970-01-01',now(),NULL,NULL,now(),'My Uploads', 'nuear', 'myUploads', 0);
  
INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `short_label`, `value`) 
VALUES (0,NULL,true,NULL,'offerCode','Other','OTHER');

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'DM','Other','Custom', null);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'ME','Other','Custom', null);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'EV','Other','Custom', null);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'MI','Other','Custom', null);

 ALTER TABLE portfolio_entry DROP  column from_ad_store;

------------------------------------------------------------------------------

--local only 
alter table portfolio_entry drop column  off_Perc50 ;
alter table portfolio_entry drop column  off_Perc40;
alter table portfolio_entry drop column  off_Perc45;
alter table portfolio_entry drop column  off_Dol500 ;
alter table portfolio_entry drop column  dol995 ;
alter table portfolio_entry drop column  dol1495;
alter table portfolio_entry drop column  buy1get1;
alter table portfolio_entry drop column  try_Bfor_Buy;
alter table portfolio_entry drop column  low_As_Per_Month;
alter table portfolio_entry drop column  other_Offer;
alter table portfolio_entry drop column  other_Time_Of_Year;
alter table portfolio_entry drop column  other_Focus;

	
-------------------------------------------------------------------------------------------------------------
--2013-05-03	
mysql> select id, name, name2, long_label, short_label, value, value2  from itda_attribute
where name ='adSizeCode' and name2 is not null and value ='Custom' order by name, name2;
+----+------------+-------+-------------+-------------+--------+--------+
| id | name       | name2 | long_label  | short_label | value  | value2 |
+----+------------+-------+-------------+-------------+--------+--------+
| 83 | adSizeCode | DM    | Other Type  | Other       | Custom | NULL   |
| 85 | adSizeCode | EV    | Other Type  | Other       | Custom | NULL   |
| 84 | adSizeCode | ME    | Other Type  | Other       | Custom | NULL   |
| 86 | adSizeCode | MI    | Other Type  | Other       | Custom | NULL   |
| 43 | adSizeCode | NP    | Custom Size | Custom Size | Custom | 100    |

select name, value, name2, value2 from itda_attribute where name ='adSizeCode' and name2 is not null and value ='Custom';
delete from itda_attribute where name ='adSizeCode' and name2 is not null and value ='Custom';

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Size','adSizeCode', 'NP','Other','OTHER', 300);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'DM','Other','OTHER', 300);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'ME','Other','OTHER', 300);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'EV','Other','OTHER', 300);

INSERT INTO `itda_attribute` (`version`, `display_order`, `enabled`, `long_label`, `name`, `name2`, `short_label`, `value`,  `value2`) 
VALUES (0,NULL,true,'Other Type','adSizeCode', 'MI','Other','OTHER', 300);

select distinct ad_size_code from portfolio_entry  ;
select id, ad_type_code, ad_size_code, offer_code, other_size, other_focus, other_time_of_year, other_offer 
from portfolio_entry where other_focus is not null or other_size is not null or other_offer is not null 
or other_time_of_year is not null;

select id, category, ad_size_code from portfolio_entry where ad_size_code like '%custom%';
update portfolio_entry set ad_size_code = 'OTHER' where ad_size_code like '%custom%';
select id, category, ad_size_code from  portfolio_entry  where offer_code like 'Other%';
update portfolio_entry set offer_code = 'OTHER' where offer_code like 'Other%';


select id, size, custom_Size, other_size from planner_entry where custom_Size is not null;
update planner_entry set size = 'OTHER', other_Size = custom_Size where custom_Size is not null;
 
alter table planner_entry drop column  custom_Size ;


select id, size, custom_size, other_size from competitor_ad  where custom_Size is not null;
update competitor_ad set size = 'OTHER', other_Size = custom_Size where custom_Size is not null;
 
alter table competitor_ad drop column  custom_Size ;

-----------------------------------------------------------------------------------------
