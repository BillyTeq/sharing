#!/bin/awk -f
BEGIN {
    file="uncommented.txt"
    rule_matched=0;
    rule_begin_regex=regex
    previous_line="__undefined__";
    comment_end="-->";
    comment_begin="<!--";
    print > file
}

{
    if (($0 ~ rule_begin_regex) && (previous_line == comment_begin))
    {
        rule_matched=1;
        print $0 >> file
    }
    else if ((rule_matched == 1) && (previous_line == comment_end))
    {
        rule_matched=0;
    }
    else if (rule_matched ==1)
    {
        gsub("<!__", "<!--", previous_line)
        gsub("__>", "-->", previous_line)
        print previous_line;
    }
    else if (previous_line != "__undefined__")
    {
        print previous_line;
    }
    previous_line=$0;
}

END {
    if ((rule_matched == 0) || (previous_line != comment_end))
    {
       print previous_line;
    }
}
