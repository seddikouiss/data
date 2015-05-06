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


select * from order_facts ;



select * from trade_facts ;
insert into trade_facts values(603,1,1,1,1,1,1,1,1,50.00,50) ;
insert into trade_facts values(604,1,1,1,1,1,1,2,5,50.00,50) ;
insert into trade_facts values(605,1,1,1,1,1,1,7,5,50.00,50) ;
insert into trade_facts values(607,1,1,1,1,1,1,7,1,50.00,50) ;



show tables ;
select  * from dim_order_buy ;

select F.id_order_buy ,D.order,status,count(F.id_order_buy)
from trade_facts F, dim_order_buy D
where D.id_order_buy = F.id_order_buy
group by F.id_order_buy;