/* chk.sas */

%macro isdsname(str);
	%local retstr match;
	%let match=0;
	%let match=%prxmatch(/^([_a-zA-Z][_a-zA-Z0-9]*\.)?[_a-zA-Z][_a-zA-Z0-9]*\s*$/,&str);
	%if &match>0 %then
		%let retstr=Y;
	%else
		%let retstr=N;
	&retstr
%mend;

