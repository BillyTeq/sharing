#!/bin/awk -f
BEGIN {
    rule_matched=0;
    rule_begin_regex=".*name=\"("decoders_names")\".*";
    rule_end_regex=".*</decoder>";
    previous_line="";
    comment_end="-->";
}

{
    if ($0 ~ rule_begin_regex) {
        rule_matched=1;
    }
    else if ((rule_matched == 1) && (previous_line == comment_end)) {
        rule_matched=0;
    }
    else {
        print previous_line;
    }
    previous_line=$0;
}

END {
    if ((rule_matched == 0) || (previous_line != comment_end)) {
       print previous_line;
    }
}
