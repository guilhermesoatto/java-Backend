create or replace package PCK_CIDADES is

  function fn_RetornaCidadePorId(p_ibge_id cidades.ibge_id%type) return cidades%rowtype;
  function fn_RetornaCapitais return sys_refcursor;
  function fn_RetornaEstadoMaiorMenor return varchar2;
	procedure sp_RetornaQntdCidadePorEstado(p_uf in cidades.uf%type,
                                          p_result out sys_refcursor);
	
	
end PCK_CIDADES;
/
create or replace package body PCK_CIDADES as

  function fn_RetornaCidadePorId(p_ibge_id cidades.ibge_id%type) return cidades%rowtype is
    l_city cidades%rowtype;
  
  begin
  
    select * into l_city from cidades a where a.ibge_id = p_ibge_id;
  
    return l_city;
  
  end;
  --
  function fn_RetornaCapitais return sys_refcursor is
    l_cities sys_refcursor;
  
  begin
  
    open l_cities for
      select * from cidades a where a.capital = '1' order by a.name_city;
  
    return l_cities;
  end;
  --
  function fn_RetornaEstadoMaiorMenor return varchar2 is
    l_maior    integer;
    l_ufbigger varchar2(200);
    l_menor    integer;
    l_ufsmall  varchar2(200);
  begin
  
    for x in (select a.uf, count(a.name_city) qtd
                from cidades a
               order by a.uf) loop
    
      if x.qtd > l_maior then
      
        select uf_name into l_ufbigger from estados where uf = x.uf;
      
        l_maior := x.qtd;
      end if;
    
      if x.qtd <= l_menor then
      
        select uf_name into l_ufsmall from estados where uf = x.uf;
      
        l_menor := x.qtd;
      end if;
    
    end loop;
    --group by a.uf;
    dbms_output.put_line('Estado com menor cidade :'|| l_ufsmall );
		dbms_output.put_line('Estado com maior cidade :'|| l_ufbigger);
    return '1' || l_ufsmall ||'| 2 ' || l_ufbigger    ;
  
  end;
	
	procedure sp_RetornaQntdCidadePorEstado(p_uf in cidades.uf%type,
                                          p_result out sys_refcursor) is
  v_joker varchar2(1);
	 
  begin 
	 select 'x' into v_joker from cidades e where e.uf = p_uf; 	
	
	 if v_joker = 'x' then
	    open p_result for select e.uf, count(e.name_city) 
			from cidades e
			where e.uf = p_uf 
			group by e.uf ;

	 else
		 open p_result for select e.uf, count(e.name_city) 
			from cidades e
			group by e.uf ;
	 end if;
			 
		
																					
	
end PCK_CIDADES;
/
