/* dt.sas */
 
**
** 本库中所包含的宏主要用于处理：
** 分隔文本(DELIMITED TEXT, or `dt')
**;
 
%include "D:\CodeLib\ls.sas";
 
%macro dtlast(adt);
    %lsmake(templs,&adt)
    %lslast(templs)
    %lsrm(templs)
%mend;
 
%macro dtsubs(adt,dtsubs);
    %lsmake(left,&adt)
    %lsmake(right,&dtsubs)
    %lssubs(left,right)
    %ls2dt(left)
    %lsrm(left)
    %lsrm(right)
%mend;

%macro dtdlm(adt,dlm);
	%lsmake(templs,&adt)
	%ls2dt(templs,%str(*))
	%lsrm(templs)
%mend;

%macro dtcontain(adt,word);
	%local retstr;
	%lsmake(templs,&adt)
	%lscontain(templs,&word)
	%lsrm(templs)
%mend;
