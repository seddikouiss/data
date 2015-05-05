use cube_st_from_st__db_v2 ;

 select * from trade_facts group by id_order_buy LIMIT 5 ;
 
 show tables ;
 
 select id_order_sell from trade_facts