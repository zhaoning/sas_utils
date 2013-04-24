/* ls.sas */
 
**
** 本库中所包含的宏主要用于处理：
** 列表(LIST, or `ls')
**;
 
 
%macro lsmake(lsname,adt,dlm);
    %if &dlm= %then %do;
       %let dlm=%str( );
    %end;
    %local i;
    %let i=1;
    %let lii=%qscan(&adt,&i,&dlm);
    %do %while (&lii^=);
       %global &lsname._&i;
       %let &lsname._&i=&lii;
       %let i=%eval(&i+1);
       %let lii=%qscan(&adt,&i,&dlm);
    %end;
    %global &lsname._count;
    %let &lsname._count=%eval(&i-1);
%mend;
 
%macro ls2dt(lsname,dlm);
    %if ^%eval(&&&lsname._count) %then %do;
       %put Macro ls2dt failed because of variable &lsname._count.;
       %return;
    %end;
    %if ^%symexist(dlm) %then %do;
       %let separator=%str( );
    %end;
    %else %if &dlm= %then %do;
       %let separator=%str( );
    %end;
    %else %do;
       %let separator=%str(&dlm);
    %end;
    %local retstr;
    %local i;
    %do i=1 %to &&&lsname._count;
       %if &i=1 %then
           %let retstr=&retstr &&&lsname._&i;
       %else
           %let retstr=&retstr&separator&&&lsname._&i;
    %end;
    &retstr
%mend;
 
%macro lslast(lsname);
    %if ^%eval(&&&lsname._count) %then %do;
       %put Macro lslast failed because of variable &lsname._count.;
       %return;
    %end;
    &&&&&lsname._&&&lsname._count
%mend;
 
%macro lsrm(lsname);
    %do i=1 %to &&&lsname._count;
       %symdel &lsname._&i;
    %end;
    %symdel &lsname._count;
%mend;
 
%macro lscontain(lsname,word);
    %if ^%eval(&&&lsname._count) %then %do;
       %put Macro lscontain failed because of variable &lsname._count.;
       %return;
    %end;
    %local retstr;
    %local i;
    %do i=1 %to &&&lsname._count;
       %if &retstr=Y or &&&lsname._&i=&word %then %do;
           %let retstr=Y;
       %end;
    %end;
    %if &retstr^=Y %then %do;
       %let retstr=N;
    %end;
    &retstr
%mend;
 
%macro lssubs(lsname,lsnamesubs);
    %if ^%eval(&&&lsname._count) %then %do;
       %put Macro lssubs failed because of variable &lsname._count.;
       %return;
    %end;
    %if ^%eval(&&&lsnamesubs._count) %then %do;
       %put Macro lssubs failed because of variable &lsnamesubs._count.;
       %return;
    %end;
    %local retstr;
    %do i=1 %to &&&lsname._count;
       %if %lscontain(&lsnamesubs,&&&lsname._&i)=N %then %do;
           %let retstr=&retstr &&&lsname._&i;
       %end;
    %end;
    %lsrm(&lsname)
    %lsmake(&lsname,&retstr)
%mend;
 
%macro lsfill(lsname,pattern,placeholder);
  %if &placeholder= %then %do;	
		%let placeholder=%str(#);
	%end;
	%local retstr i;
	%do i=1 %to &&&lsname._count;
		%let retstr=&retstr %sysfunc(tranwrd(&pattern,&placeholder,&&&lsname._&i));
	%end;
	&retstr
%mend;

 
