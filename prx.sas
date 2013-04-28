/* prx.sas */

/*
Author of Macro PRXMATCH:
  Lei Zhang
	Celgene Corporation.
	86 Morris Avenue
	Summit, NJ 07901
	Phone: (908) 673-9000 
*/
%Macro PRXMATCH(Regex, Source, Action);
	%local RegexID RtnVal;
	%let RegexID=%sysfunc (PRXPARSE(&Regex));
	%let RtnVal=0;
	%if RegexID>0 %then %do;
		%if %length(&Action)=0 %then %let Action=P;
		%let Action=%upcase(&Action);
		%if &Action=P %then %do;
			%let rtnval=%sysfunc(PRXMatch(&RegexID, &Source));
		%end;
		%else %if &Action=E %then %do;
			%local Pos Len;
			%let Pos=0;
			%let Len=0;
			%syscall PRXSUBSTR(RegexID, Source, Pos, Len);
			%let RtnVal=;
			%if &Pos>0 %then %do;
				%let RtnVal=%substr(&Source, &Pos, &Len);
			%end;
			%syscall PRXFREE(RegexID);
		%end;
		%else %do;
			%let RtnVal=;
			%put Unknown action: &Action;
			%end;
		%end;
	%else %do;
		%put Errors found in the pattern: &Regex;
	%end;
&RtnVal
%Mend;
