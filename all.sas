/* all.sas */

proc sort data=sashelp.vextfl out=temp;
  where substrn(fileref,1,3)='#LN' and index(lowcase(xpath),'.sas')>0;
	by descending fileref;
data _null_;
	set temp(obs=1);
	lastbs=length(xpath)-length(scan(xpath,-1,'\'));
	call symput('sas_utils_path',substrn(xpath,1,lastbs-1));
run;

%include "&sas_utils_path\ls.sas";
%include "&sas_utils_path\dt.sas";
%include "&sas_utils_path\str.sas";
%include "&sas_utils_path\fmt.sas";
%include "&sas_utils_path\chk.sas";
%include "&sas_utils_path\prx.sas";
