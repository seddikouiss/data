use st_base ;


desc orders ;
select distinct ORD_OWNER_NAME from orders ;
--
select distinct ORD_OWNER_NAME from orders ;

select count(*)  from  orders;
select PRD_NAME  from  orders;
show tables ;
select * from st_user ;
select * from entitlement_profile ;

select distinct BUYER_NAME,MAKER from trade ;
select distinct * from tradegroup ;

/** /
select * from orders O ,st_user  U where O.ORD_OWNER_NAME = 
/**/
select O.ORD_DATE, U.USR_ID ,U.USR_NAME,TG.TDG_ID , TG.TDG_NAME , O.PRD_NAME as 'Security',O.ORD_ORDER_STATUS,O.ORD_PRICE,O.ORD_QUANTITY,O.ORD_ORDER_STATUS,O.ORD_PRICE * O.ORD_QUANTITY as 'Contra Amount'
from orders O join st_user U on O.ORD_OWNER_ID = U.USR_ID join  tradegroup TG on TG.TDG_ID = U.TDG_ID;


select O.ORD_DATE as 'Creation_Date', U.USR_ID ,U.USR_NAME as 'User_Name', TG.TDG_ID  , TG.TDG_NAME as 'Counterparty_Name', O.PRD_NAME as 'Security_Name',O.PRD_ID as 'Security_ID',O.ORD_ORDER_STATUS,O.ORD_PRICE,O.ORD_QUANTITY,O.ORD_ORDER_STATUS,O.ORD_PRICE * O.ORD_QUANTITY as 'Contra Amount'
from orders O join st_user U on O.ORD_OWNER_ID = U.USR_ID join  tradegroup TG on TG.TDG_ID = U.TDG_ID;


select O.ORD_OWNER_ID,O.ORD_OWNER_NAME,count(*) as 'NB_Trade_SELLER'
from trade T join orders O on T.SELLER_ORDER_ID= O.ORD_ORDER_ID 
group by O.ORD_ORDER_ID,O.ORD_OWNER_ID,O.ORD_OWNER_NAME;


select MAKER,TAKER from trade ;

select CLI_ID from trade ;


/*
Le nombre d'orders trader(si un trade = 2 * orders):
*/
select count(*) from trade ;

/*
 Le nombre d'ordre soit de vente soit d'achat
*/

select * from trade 
where SELLER_ORDER_ID is null or BUYER_ORDER_ID is null;


select count(*)
from orders O ,trade T
where O.ORD_VERSION_ID = T.SELLER_ORDER_ID or O.ORD_VERSION_ID = T.BUYER_ORDER_ID;


select count(*) from orders
where ORD_ORDER_ID in (select BUYER_ORDER_ID from trade ) or  ORD_ORDER_ID in(select SELLER_ORDER_ID from trade );

select count(*) from orders ;

(select distinct BUYER_ORDER_ID from trade
where BUYER_ORDER_ID not in (select ORD_ORDER_ID from orders ));

select * from orders where ORD_ORDER_ID ='O20150331LX1000108708';
select * from trade where BUYER_ORDER_ID ='O20150331LX1000108708' or SELLER_ORDER_ID ='O20150331LX1000108708';
select * from orders where ORD_ORDER_ID ='O20150331LX1000108708' or ORD_VERSION_ID ='O20150331LX1000108708';



select O.ORD_DATE as 'Creation_Date', U.USR_ID ,U.USR_NAME as 'User_Name', TG.TDG_ID  , TG.TDG_NAME as 'Counterparty_Name', O.PRD_NAME as 'Security_Name',O.PRD_ID as 'Security_ID',O.ORD_ORDER_STATUS,O.ORD_PRICE,O.ORD_QUANTITY,O.ORD_ORDER_STATUS,O.ORD_PRICE * O.ORD_QUANTITY as 'Contra Amount'
from orders O join st_user U on O.ORD_OWNER_ID = U.USR_ID join  tradegroup TG on TG.TDG_ID = U.TDG_ID;


select  T.TRD_NUM,T.TRD_ID,T.PRD_NAME as 'SECURITY',T.TRD_STLMT_DATE as 'DATE',T.TRD_PRICE as 'Trade_Volume', T.TRD_QUANTITY as 'QUANTITY', T.TAKER, T.MAKER ,
		U_buyer.USR_ID as 'USR_ID_BUYER',U_buyer.USR_NAME as 'USR_NAME_BUYER', TG_BUYER.TDG_NAME as 'TDG_NAME_BUYER',
        U_seller.USR_ID as 'USR_ID_SELLER',U_seller.USR_NAME as 'USR_NAME_SELLER', TG_SELLER.TDG_NAME as 'TDG_NAME_SELLER',
        O_BUY.ORD_ORDER_STATUS as 'ORDER_STATUS_BUY',O_BUY.ORD_VERSION_ID as 'ID_ORD_BUY',O_SELL.ORD_ORDER_STATUS as 'ORDER_STATUS_SELL', O_SELL.ORD_VERSION_ID as 'ID_ORD_SELL'
        
from 	trade T, orders O_BUY , orders O_SELL, st_user U_buyer,st_user U_seller,tradegroup TG_BUYER, tradegroup TG_SELLER
where 	O_BUY.ORD_VERSION_ID  = T.BUYER_ORDER_ID  	and 
		O_SELL.ORD_VERSION_ID = T.SELLER_ORDER_ID  	and 
        T.SELLER_ID = U_seller.USR_ID				and
        T.BUYER_ID = U_buyer.USR_ID					and
        TG_BUYER.TDG_ID   = U_buyer.TDG_ID			and
        TG_SELLER.TDG_ID  = U_seller.TDG_ID
;


select  count(*)
from 	trade T, orders O_BUY , orders O_SELL, st_user U_buyer,st_user U_seller,tradegroup TG_BUYER, tradegroup TG_SELLER
where 	O_BUY.ORD_VERSION_ID  = T.BUYER_ORDER_ID  	and 
		O_SELL.ORD_VERSION_ID = T.SELLER_ORDER_ID  	and 
        T.SELLER_ID = U_seller.USR_ID				and
        T.BUYER_ID = U_buyer.USR_ID					and
        TG_BUYER.TDG_ID   = U_buyer.TDG_ID			and
        TG_SELLER.TDG_ID  = U_seller.TDG_ID
;



 
select count( *) ,O.ORD_VERSION_ID
from orders O, trade T
where O.ORD_VERSION_ID = T.BUYER_ORDER_ID or O.ORD_VERSION_ID = T.SELLER_ORDER_ID
group by O.ORD_VERSION_ID
;

select count(distinct SELLER_ORDER_ID) from trade ;


select 	O.ORD_VERSION_ID,O.ORD_DATE as 'Creation_Date',U.USR_NAME as 'User_Name',
		TG.TDG_NAME as 'Counterparty_Name',
		O.PRD_NAME as 'Security_Name',O.PRD_ID as 'Security_ID',
        O.ORD_ORDER_STATUS as 'STATUS',O.ORD_QUANTITY,O.ORD_PRICE as 'Order_volume',
        ORD_SIDE as 'ORD_TYPE',
        count(*) / 2 as 'NB_TRADE', T1.TRD_PRICE as 'Trade_Volume',
        if(T1.AGGRESSOR_SIDE is not null,
			if(strcmp(T1.AGGRESSOR_SIDE,O.ORD_SIDE) = 0 ,
				'TAKED',
				'MAKED')
			,NULL) as 'AGGRESSION'
from orders O join st_user U 		on O.ORD_OWNER_ID = U.USR_ID 
			  join  tradegroup TG 	on TG.TDG_ID = U.TDG_ID 
              left join Trade T1 	on O.ORD_VERSION_ID = T1.BUYER_ORDER_ID 
									or  O.ORD_VERSION_ID = T1.SELLER_ORDER_ID
group by O.ORD_VERSION_ID,Creation_Date,Counterparty_Name,Security_Name,O.ORD_ORDER_STATUS,O.ORD_QUANTITY,Order_volume,ORD_TYPE,Trade_Volume;

select ORD_ORDER_STATUS from orders ;
select * from trade T1
where T1.TRD_NUM = 265 or  T1.TRD_NUM = 51212;

select O.ORD_DATE as 'Creation_Date', U.USR_ID ,U.USR_NAME as 'User_Name', TG.TDG_ID  , TG.TDG_NAME as 'Counterparty_Name', O.PRD_NAME as 'Security_Name',O.PRD_ID as 'Security_ID',O.ORD_ORDER_STATUS,O.ORD_PRICE,O.ORD_QUANTITY,O.ORD_ORDER_STATUS,O.ORD_PRICE * O.ORD_QUANTITY as 'Contra Amount'
from orders O join st_user U on O.ORD_OWNER_ID = U.USR_ID join  tradegroup TG on TG.TDG_ID = U.TDG_ID;





-- -----*----------------
INSERT INTO `trade` VALUES (
51212,
'T20150330LX100000000219',
0,
'6',
'2015-04-16 12:54:05',
'71',
'RBC',
'53',
'Kim DAVIS',
'C20150330LX1000330053',
'O20150330LX1000006557',
62.779500000000000000,
1000000.000000000000000000,
NULL,
'P',
'0',
NULL,
NULL,
'1',
'<header><major>1</major><minor>0</minor></header><Trade><custom type=\"String\" name=\"MKR\">Bank Of India</custom><custom type=\"String\" name=\"TNR\">M1</custom><custom type=\"DateField\" name=\"VLD\">20150503-00:00:00.000</custom><custom type=\"DateField\" name=\"FXD\">20150430-00:00:00.000</custom><custom type=\"String\" name=\"TKR\">R5Admin</custom><custom type=\"String\" name=\"SYM\">USD/INR</custom></Trade><trailer></trailer>',
'USD/INR.FWD.M1','USD/INR','E20150330LX1000000003','E20150330LX1000000004','BUY','Bank Of India','R5Admin','M1','USD/INR'
);


select  count(distinct T1.TRD_ID)
from orders O join Trade T1 	on O.ORD_VERSION_ID = T1.BUYER_ORDER_ID 
									or  O.ORD_VERSION_ID = T1.SELLER_ORDER_ID
where O.ORD_SIDE='BUY';

select sum(TRD_PRICE)/2
from orders O left join Trade T1 	on O.ORD_VERSION_ID = T1.BUYER_ORDER_ID 
									or  O.ORD_VERSION_ID = T1.SELLER_ORDER_ID
;
select *
from Trade;

select 	sum(T1.TRD_PRICE)
from orders O join st_user U 		on O.ORD_OWNER_ID = U.USR_ID 
			  join  tradegroup TG 	on TG.TDG_ID = U.TDG_ID 
              left join Trade T1 	on O.ORD_VERSION_ID = T1.BUYER_ORDER_ID 
									or  O.ORD_VERSION_ID = T1.SELLER_ORDER_ID;


/* ***************************/
select 	O.ORD_VERSION_ID,O.ORD_DATE as 'Creation_Date',U.USR_NAME as 'User_Name',
		TG.TDG_NAME as 'Counterparty_Name',
		O.PRD_NAME as 'Security_Name',O.PRD_ID as 'Security_ID',
        O.ORD_ORDER_STATUS,O.ORD_QUANTITY,O.ORD_PRICE as 'Order_volume',
        ORD_SIDE as 'ORD_TYPE',
        ORD_Traded.NB_TRADED as 'NB_TRADE'/*, ORD_Traded.TRD_PRICE as 'Trade_Volume'*/
from orders O join st_user U 		on O.ORD_OWNER_ID = U.USR_ID 
			  join  tradegroup TG 	on TG.TDG_ID = U.TDG_ID 
              left 	join (select O.ORD_VERSION_ID,/*T.TRD_PRICE,*/ count(*) as 'NB_TRADED'
					from trade T join orders O 	on  O.ORD_VERSION_ID = T.SELLER_ORDER_ID 
												or  O.ORD_VERSION_ID = T.BUYER_ORDER_ID
					
					group by O.ORD_VERSION_ID/*,T.TRD_PRICE*/) ORD_Traded on  ORD_Traded.ORD_VERSION_ID = O.ORD_VERSION_ID
;


select O.ORD_VERSION_ID,T.TRD_PRICE, count(T.TRD_NUM) as 'NB_TRADED'
					from trade T join orders O 	on  O.ORD_VERSION_ID = T.SELLER_ORDER_ID 
												or  O.ORD_VERSION_ID = T.BUYER_ORDER_ID
					where O.ORD_SIDE='BUY'
					group by O.ORD_VERSION_ID,T.TRD_PRICE
;

select ORD_VERSION_ID,	if(strcmp(T1.AGGRESSOR_SIDE,'BUY'),TRD_PRICE,0) as 'TAKED',if(strcmp(T1.AGGRESSOR_SIDE,'SELL'),TRD_PRICE,0) as 'MAKED'
from orders O join Trade T1 	on O.ORD_VERSION_ID = T1.BUYER_ORDER_ID
								or  O.ORD_VERSION_ID = T1.SELLER_ORDER_ID
;
select ORD_VERSION_ID,	if((strcmp(T1.AGGRESSOR_SIDE,O.ORD_SIDE) = 0 ) ,'TAKED','MAKED') as 'AGGRESSION',
						T1.AGGRESSOR_SIDE,T1.BUYER_ORDER_ID,T1.SELLER_ORDER_ID
from orders O left join Trade T1 	on O.ORD_VERSION_ID = T1.BUYER_ORDER_ID
								or  O.ORD_VERSION_ID = T1.SELLER_ORDER_ID
;
select ORD_VERSION_ID,
	if(T1.AGGRESSOR_SIDE is not null,
		if(strcmp(T1.AGGRESSOR_SIDE,O.ORD_SIDE) = 0 ,
			'TAKED',
            'MAKED')
		,NULL) as 'AGGRESSION',
						T1.AGGRESSOR_SIDE,T1.BUYER_ORDER_ID,T1.SELLER_ORDER_ID
from orders O left join Trade T1 	on O.ORD_VERSION_ID = T1.BUYER_ORDER_ID
								or  O.ORD_VERSION_ID = T1.SELLER_ORDER_ID
;



/********* */
select 	O.ORD_VERSION_ID,O.ORD_DATE as 'Creation_Date',U.USR_NAME as 'User_Name',
		TG.TDG_NAME as 'Counterparty_Name',
		O.PRD_NAME as 'Security_Name',O.PRD_ID as 'Security_ID',
        O.ORD_ORDER_STATUS as 'STATUS',O.ORD_QUANTITY,O.ORD_PRICE as 'Order_volume',
        ORD_SIDE as 'ORD_TYPE',
        Traded.NB_TRADE, T1.TRD_PRICE as 'Trade_Volume',
        if(T1.AGGRESSOR_SIDE is not null,
			if(strcmp(T1.AGGRESSOR_SIDE,O.ORD_SIDE) = 0 ,
				'TAKED',
				'MAKED')
			,NULL) as 'AGGRESSION'
from orders O join st_user U 		on O.ORD_OWNER_ID = U.USR_ID 
			  join  tradegroup TG 	on TG.TDG_ID = U.TDG_ID 
              left join Trade T1 	on O.ORD_VERSION_ID = T1.BUYER_ORDER_ID 
									or  O.ORD_VERSION_ID = T1.SELLER_ORDER_ID
			  join (select count(*) / 2 as 'NB_TRADE',O.ORD_VERSION_ID 
					from orders O join Trade T2 on  O.ORD_VERSION_ID = T2.BUYER_ORDER_ID 
												or  O.ORD_VERSION_ID = T2.SELLER_ORDER_ID
					group by O.ORD_VERSION_ID
					) Traded on O.ORD_VERSION_ID = Traded.ORD_VERSION_ID
;


select 	sum(Traded.NB_TRADE)
from orders O join st_user U 		on O.ORD_OWNER_ID = U.USR_ID 
			  join  tradegroup TG 	on TG.TDG_ID = U.TDG_ID 
              left join Trade T1 	on O.ORD_VERSION_ID = T1.BUYER_ORDER_ID 
									or  O.ORD_VERSION_ID = T1.SELLER_ORDER_ID
			  join (select count(*)  as 'NB_TRADE',O.ORD_VERSION_ID 
					from orders O join Trade T2 on  O.ORD_VERSION_ID = T2.BUYER_ORDER_ID 
												or  O.ORD_VERSION_ID = T2.SELLER_ORDER_ID
					where O.ORD_SIDE='BUY'
					group by O.ORD_VERSION_ID
					) Traded on O.ORD_VERSION_ID = Traded.ORD_VERSION_ID
;

-- last version order view
select 	O1.ORD_VERSION_ID,O1.ORD_DATE as 'Creation_Date',U.USR_NAME as 'User_Name',
		TG.TDG_NAME as 'Counterparty_Name',
		O1.PRD_NAME as 'Security_Name',O1.PRD_ID as 'Security_ID',
        O1.ORD_ORDER_STATUS as 'STATUS',O1.ORD_QUANTITY,O1.ORD_PRICE as 'Order_volume',
        O1.ORD_SIDE as 'ORD_TYPE',
        Traded.NB_TRADE, Traded.TRD_PRICE as 'Trade_Volume',
        if(Traded.AGGRESSOR_SIDE is not null,
			if(strcmp(Traded.AGGRESSOR_SIDE,O1.ORD_SIDE) = 0 ,
				'TAKED',
				'MAKED')
			,'NO AGGRESSION') as 'AGGRESSION'
from orders O1 	join st_user U 		on O1.ORD_OWNER_ID = U.USR_ID 
				join  tradegroup TG 	on TG.TDG_ID = U.TDG_ID 
				left join	(select count(*)  as 'NB_TRADE',O2.ORD_VERSION_ID ,T2.BUYER_ORDER_ID,T2.SELLER_ORDER_ID,TRD_PRICE,AGGRESSOR_SIDE
							 from orders O2 join Trade T2 	on  O2.ORD_VERSION_ID = T2.BUYER_ORDER_ID 
														or  O2.ORD_VERSION_ID = T2.SELLER_ORDER_ID
							 group by O2.ORD_VERSION_ID ,T2.BUYER_ORDER_ID,T2.SELLER_ORDER_ID,T2.TRD_PRICE
							) Traded on O1.ORD_VERSION_ID = Traded.ORD_VERSION_ID                             
;
-- Version test---------------------------------------------------------------------------------------------------------

select 	O1.ORD_VERSION_ID,O1.ORD_DATE as 'Creation_Date',U.USR_NAME as 'User_Name',
		TG.TDG_NAME as 'Counterparty_Name',
		O1.PRD_NAME as 'Security_Name',O1.PRD_ID as 'Security_ID',
        O1.ORD_ORDER_STATUS as 'STATUS',O1.ORD_QUANTITY,O1.ORD_PRICE as 'Order_volume',
        O1.ORD_SIDE as 'ORD_TYPE',
        T1.TRD_NUM, T1.TRD_PRICE as 'Trade_Volume',
        if(T1.AGGRESSOR_SIDE is not null,
			if(strcmp(T1.AGGRESSOR_SIDE,O1.ORD_SIDE) = 0 ,
				'TAKED',
				'MAKED')
			,'NO AGGRESSION') as 'AGGRESSION'
from orders O1 	join st_user U 			on O1.ORD_OWNER_ID = U.USR_ID 
				join  tradegroup TG 	on TG.TDG_ID = U.TDG_ID
                left join Trade T1 		on O1.ORD_VERSION_ID = T1.BUYER_ORDER_ID 
										or O1.ORD_VERSION_ID = T1.SELLER_ORDER_ID
;
-- //Version test---------------------------------------------------------------------------------------------------------


select 	count(distinct T1.TRD_NUM)
from orders O1 	join st_user U 			on O1.ORD_OWNER_ID = U.USR_ID 
				join  tradegroup TG 	on TG.TDG_ID = U.TDG_ID
                left join Trade T1 		on O1.ORD_VERSION_ID = T1.BUYER_ORDER_ID 
										or O1.ORD_VERSION_ID = T1.SELLER_ORDER_ID
;



select count(distinct BUYER_ORDER_ID) from trade ;
select count(BUYER_ORDER_ID) from trade ;
select count(distinct ORD_VERSION_ID) from orders ;


select sum( TRD_PRICE) from trade  where (SELLER_NAME ='Peter TASK' or  BUYER_NAME ='Peter TASK') and PRD_NAME='USD/INR';
select sum(ORD_PRICE) from orders ;








