/* chk.sas */

%macro isdsname(str);
  %local rx_id match retstr;
	%let rx_id=%sysfunc(prxparse(/^([_a-zA-Z][_a-zA-Z0-9]*\.)?[_a-zA-Z][_a-zA-Z0-9]*\s*$/));
	%if rx_id>0 %then %do;
		%let match=%sysfunc(prxmatch(&rx_id,&str));
		%syscall prxfree(rx_id);
	%end;
	%if &match>0 %then
		%let retstr=Y;
	%else %if &match=0 %then
		%let retstr=N;
	&retstr
%mend;

%let foo=q2s.account;
%let bar=%isdsname(&foo);
%put foo=&foo bar=&bar;
