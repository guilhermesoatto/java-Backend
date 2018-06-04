create table estados(uf varchar2(2) not null,
uf_name varchar2 (20));
insert into estados values(
'AC','Acre');
insert into estados values('AL','Alagoas')              ;
insert into estados values('AM','Amazonas')                ;
insert into estados values('AP','Amapá')             ;
insert into estados values('BA','Bahia')                ;
insert into estados values('CE','Ceará')                ;
insert into estados values('DF','Distrito Federal')     ;
insert into estados values('ES','Espírito Santo')       ;
insert into estados values('GO','Goiás')                ;
insert into estados values('MA','Maranhão')             ;
insert into estados values('MG','Mato Grosso')          ;
insert into estados values('MS','Mato Grosso do Sul')   ;
insert into estados values('MT','Minas Gerais')         ;
insert into estados values('PA','Pará')                 ;
insert into estados values('PB','Paraíba')              ;
insert into estados values('PE',' Pernambuco')          ;
insert into estados values('PI','Piauí')                ;
insert into estados values('PR','Paraná')               ;
insert into estados values('RJ','Rio de Janeiro')       ;
insert into estados values('RN','Rio Grande do Norte')  ;
insert into estados values('RO','Rondônia')             ;
insert into estados values('RR','Roraima')              ;
insert into estados values('RS','Rio Grande do Sul')    ;
insert into estados values('SC','Santa Catarina')       ;
insert into estados values('SE','Sergipe')              ;
insert into estados values('SP','São Paulo')			;
insert into estados values('TO','Tocantins');

select e.*, e.rowid from estados e
