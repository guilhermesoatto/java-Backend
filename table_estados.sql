create table estados(uf varchar2(2) not null,
uf_name varchar2 (20));
insert into estados values(
'AC','Acre');
insert into estados values('AL','Alagoas')              ;
insert into estados values('AM','Amazonas')                ;
insert into estados values('AP','Amap�')             ;
insert into estados values('BA','Bahia')                ;
insert into estados values('CE','Cear�')                ;
insert into estados values('DF','Distrito Federal')     ;
insert into estados values('ES','Esp�rito Santo')       ;
insert into estados values('GO','Goi�s')                ;
insert into estados values('MA','Maranh�o')             ;
insert into estados values('MG','Mato Grosso')          ;
insert into estados values('MS','Mato Grosso do Sul')   ;
insert into estados values('MT','Minas Gerais')         ;
insert into estados values('PA','Par�')                 ;
insert into estados values('PB','Para�ba')              ;
insert into estados values('PE',' Pernambuco')          ;
insert into estados values('PI','Piau�')                ;
insert into estados values('PR','Paran�')               ;
insert into estados values('RJ','Rio de Janeiro')       ;
insert into estados values('RN','Rio Grande do Norte')  ;
insert into estados values('RO','Rond�nia')             ;
insert into estados values('RR','Roraima')              ;
insert into estados values('RS','Rio Grande do Sul')    ;
insert into estados values('SC','Santa Catarina')       ;
insert into estados values('SE','Sergipe')              ;
insert into estados values('SP','S�o Paulo')			;
insert into estados values('TO','Tocantins');

select e.*, e.rowid from estados e
