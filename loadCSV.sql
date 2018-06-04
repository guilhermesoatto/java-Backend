CREATE OR REPLACE FUNCTION LOAD_CSV ( p_table in varchar2,
 p_dir in varchar2 DEFAULT 'ORA_DIR' ,
 P_FILENAME in varchar2,
 p_ignore_headerlines IN INTEGER DEFAULT 1,
 p_delimiter in varchar2 default ',',
 p_optional_enclosed in varchar2 default '"' )
 return number
 is
/***************************************************************************
-- PROCEDURE LOAD_CSV
-- PURPOSE: This Procedure read the data from a CSV file.
-- And load it into the target oracle table.
-- Finally it renames the source file with date.
--
-- P_FILENAME
-- The name of the flat file(a text file)
--
-- P_DIRECTORY
-- Name of the directory where the file is been placed.
-- Note: The grant has to be given for the user to the directory
-- before executing the function
--
-- P_IGNORE_HEADERLINES:
-- Pass the value as '1' to ignore importing headers.
--
-- P_DELIMITER
-- By default the delimiter is used as ','
-- As we are using CSV file to load the data into oracle
--
-- P_OPTIONAL_ENCLOSED
-- By default the optionally enclosed is used as '"'
-- As we are using CSV file to load the data into oracle
--

**************************************************************************/
 l_input utl_file.file_type;
 l_theCursor integer default dbms_sql.open_cursor;
 l_lastLine varchar2(4000);
 l_cnames varchar2(4000);
 l_bindvars varchar2(4000);
 l_status integer;
 l_cnt number default 0;
 l_rowCount number default 0;
 l_sep char(1) default NULL;
 L_ERRMSG varchar2(4000);
 V_EOF BOOLEAN := false;
 
 begin
 
 l_cnt := 1;
 for TAB_COLUMNS in (
 select column_name, data_type from user_tab_columns where table_name=p_table order by column_id
 ) loop
 l_cnames := l_cnames || tab_columns.column_name || ',';
 l_bindvars := l_bindvars ;
 
 l_cnt := l_cnt + 1;
 end loop;
 l_cnames := rtrim(l_cnames,',');
 L_BINDVARS := RTRIM(L_BINDVARS,',');
 
 L_INPUT := UTL_FILE.FOPEN( P_DIR, P_FILENAME, 'r' );
 IF p_ignore_headerlines > 0
 THEN
 BEGIN
 FOR i IN 1 .. p_ignore_headerlines
 LOOP
 UTL_FILE.get_line(l_input, l_lastLine);
 END LOOP;
 EXCEPTION
 WHEN NO_DATA_FOUND
 THEN
 v_eof := TRUE;
 end;
 END IF;
 
 if not v_eof then
 dbms_sql.parse( l_theCursor, 'insert into ' || p_table || '(' || l_cnames || ') values (' || l_bindvars || ')', dbms_sql.native );
 
 loop
 begin
 utl_file.get_line( l_input, l_lastLine );
 exception
 when NO_DATA_FOUND then
 exit;
 end;
 
 if length(l_lastLine) > 0 then
 for i in 1 .. l_cnt-1
 LOOP
 
 dbms_sql.bind_variable( l_theCursor, ':b'||i,
 rtrim(rtrim(ltrim(ltrim(
 REGEXP_SUBSTR(l_lastline,'(^|,)("[^"]*"|[^",]*)',1,i),p_delimiter),p_optional_enclosed),p_delimiter),p_optional_enclosed));
 end loop;
 begin
 l_status := dbms_sql.execute(l_theCursor);
 l_rowCount := l_rowCount + 1;
 exception
 when OTHERS then
 L_ERRMSG := SQLERRM;
 end;
 end if;
 end loop;
 
 dbms_sql.close_cursor(l_theCursor);
 utl_file.fclose( l_input );
 commit;
 end if;
-- insert into cidades (FILENAME,TABLE_NAME,NUM_OF_REC,IMPORT_DATE)
 --values ( P_FILENAME, P_TABLE,l_rowCount,sysdate );
 
 UTL_FILE.FRENAME(
 P_DIR,
 P_FILENAME,
 P_DIR,
 REPLACE(P_FILENAME,
 '.csv',
 '_' || TO_CHAR(SYSDATE, 'DD_MON_RRRR_HH24_MI_SS_AM') || '.csv'
 ));
 commit;
 RETURN L_ROWCOUNT;
 end LOAD_CSV;
