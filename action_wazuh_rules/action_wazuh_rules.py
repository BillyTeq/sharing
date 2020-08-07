from optparse import OptionParser
import os

##### CONFIGURATION ID RULES #####
WAZUH_RULES=[]
##################################

usage = "usage: python3 %prog (-c|-u) -i INPUT_FILE [-o OUTPUT_FILE]"
parser = OptionParser(usage = usage, version="v1.0")
parser.add_option("-i", "--input", dest="input", type="string",
                  help="takes this file as input", metavar="INPUT_FILE")
parser.add_option("-o", "--output", dest="output", type="string",
                  help="takes this file as output", metavar="OUTPUT_FILE")
parser.add_option("-c", "--comment", action="store_true", dest="comment",
                  help="comment wazuh rules", metavar="COMMENT")
parser.add_option("-u", "--uncomment", action="store_true", dest="uncomment",
                  help="uncomment wazuh rules", metavar="UNCOMMENT")
parser.add_option("-v", "--verbose", action="store_true", dest="verbose",
                  help="show bash commands")

(options, args) = parser.parse_args()

if len(WAZUH_RULES) == 0:
    parser.error("Missing rule id(s) in WAZUH_RULES array")

if options.input is None:
    parser.error("Missing input file")

if options.output is None:
    print("Output file not specified: modification will be done in %s" % options.input)
    options.output = options.input

if options.comment is None and options.uncomment is None:
    parser.error("Missing action option. Should either be -c (comment) or -u (uncomment)")

def execute_action(awk_script):
    tmp_file = options.output + ".tmp"
    wazuh_rule_ids = '|'.join([str(id) for id in WAZUH_RULES])

    awk_command = "awk -v rule_ids='%s' -f %s %s > %s" % (wazuh_rule_ids, awk_script, options.input, tmp_file)
    os.system(awk_command)

    mv_command = "mv %s %s " % (tmp_file, options.output)
    os.system(mv_command)

    if options.verbose:
        print("Commands:\n1.",  awk_command, "\n2.", mv_command)

if options.comment:
    print("Commenting wazuh rules", WAZUH_RULES, "...")
    execute_action("comment_wazuh_rules.awk")
elif options.uncomment:
    print("Uncommenting wazuh rules", WAZUH_RULES, "...")
    execute_action("uncomment_wazuh_rules.awk")

print("Done.")
