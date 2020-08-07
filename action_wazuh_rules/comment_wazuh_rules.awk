#!/bin/awk -f
BEGIN {
    rule_matched=0;
    rule_begin_regex=".*id=\"("rule_ids")\".*";
    rule_end_regex=".*</rule>";
    comment_begin="<!--"
    comment_end="-->";
}

{
    if (($0 ~ rule_begin_regex) && (previous_line != comment_begin)) {
        rule_matched=1;
        print comment_begin;
        print $0;
    }
    else if ((rule_matched == 1) && ($0 ~ rule_end_regex)) {
        rule_matched=0;
        print $0;
        print comment_end;
    }
    else {
       print $0;
    }
    previous_line = $0
}

END {
}
