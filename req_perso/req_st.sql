desc orders ;
select distinct ORD_OWNER_NAME from orders ;
--
select distinct ORD_OWNER_NAME from orders ;

select *  from  orders;
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
select count(*) * 2  from trade ;

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


