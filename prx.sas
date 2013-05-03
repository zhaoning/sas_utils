/* prx.sas */

/*
Author of Macro PRXMATCH:
	Lei Zhang
	Celgene Corporation.
	86 Morris Avenue
	Summit, NJ 07901
	Phone: (908) 673-9000 
*/
%macro prxmatch(prx, source, action);
	%local prxid retstr;
	%let prxid=%sysfunc(prxparse(&prx));
	%let retstr=0;
	%if prxid>0 %then %do;
		%if %length(&action)=0 %then %let action=P;
		%let action=%upcase(&action);
		%if &action=P %then %do;
			%let retstr=%sysfunc(prxmatch(&prxid, &source));
		%end;
		%else %if &action=E %then %do;
			%local pos len;
			%let pos=0;
			%let len=0;
			%syscall prxsubstr(prxid,source,pos,len);
			%let retstr=;
			%if &pos>0 %then %do;
				%let retstr=%substr(&source,&pos,&len);
			%end;
			%syscall prxfree(prxid);
		%end;
		%else %do;
			%let retstr=;
			%put Unknown action: &action;
			%end;
		%end;
	%else %do;
		%put Errors found in the pattern: &prx;
	%end;
&retstr
%mend;




