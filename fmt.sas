/* Fmt.sas */

%macro fmtgen(data,key,value,fmtname,type,lib);
data temp;
  set &data;
	fmtname="&fmtname";
	type="&type";
	start=&key;
	end=&key;
	label=&value;
run;
proc format cntlin=temp library=&lib;
run;
%mend;
