/* str.sas */

%macro align_right(str,length,char);
reverse(put(reverse(compress(&str))||repeat("&char",&length),$&length..))
%mend;

