create table cidades (ibge_id int  NOT NULL, 
  uf varchar(2) NOT NULL, 
  name_city varchar(30) NOT NULL,
  capital char(1) null,
  lon varchar(11) not null,
  lat varchar(11) not null,
  no_accents varchar(30) not null,
  alternative_names varchar(30) null,
  microregion varchar(30) not null,
  mesoregion varchar(30) not null,
  constraint cidades_pk primary key (ibge_id)
)
