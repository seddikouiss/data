use cube_st_from_st__db_v2 ;

 select * from trade_facts group by id_order_buy LIMIT 5 ;
 
 show tables ;
 
 select * from trade_facts;
 select * from order_facts;
 
 -- Pourcentages ....................
 
select id_counter,(count(*)/O.total) *100 as 'percent of order' 
from order_facts, (select count(*) as total from  order_facts) O
group by id_counter;
  
select id_time,(count(*)/O.total) *100 as 'percent of order' 
from order_facts, (select count(*) as total from  order_facts) O
group by id_time;


select id_product,(count(*)/O.total) *100 as 'percent of order' 
from order_facts, (select count(*) as total from  order_facts) O
group by id_product;


select sum(contrat_amount) from order_facts ;
