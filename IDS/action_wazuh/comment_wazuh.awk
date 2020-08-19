#!/bin/awk -f
BEGIN {
    file="commented.txt"
    rule_matched=0;
    rule_begin_regex=regex;
    rule_end_regex=".*</"rule_end">";
    comment_begin="<!--"
    comment_end="-->";
    print > file
}

{
    if (($0 ~ rule_begin_regex) && (previous_line != comment_begin)) 
    {
        rule_matched=1;
        print comment_begin;
        print $0;
        print $0 >> file
    }
    else if ((rule_matched == 1) && ($0 ~ rule_end_regex))
    {
        rule_matched=0;
        print $0;
        print comment_end;
    }
    else if (rule_matched ==1)
    {
        gsub("<!--", "<!__");
        gsub("-->", "__>");
        print $0;
    }
    else 
    {
       print $0;
    }
    previous_line = $0
}

END {
}
