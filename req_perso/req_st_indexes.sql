create index  idx_id_counter on order_facts(id_counter);
create index  idx_id_time on order_facts(id_time);
create index  idx_contra_amount on order_facts(contrat_amount);

create index idx_year on dim_time(year) ;
create index idx_month on dim_time(month) ;
create index idx_day on dim_time(day) ;

create index idx_user on dim_counter(user) ;
create index idx_counetr on dim_counter(counter) ;



/*
Foreihn key !!!!!!!!
*/


