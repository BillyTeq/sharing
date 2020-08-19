from optparse import OptionParser
import os

##### CONFIGURATION DECODERS NAMES ###################
WAZUH_DECODERS = []
### Example : WAZUH_DECODER = ["decoder1", "decoder2"]
######################################################

##### CONFIGURATION ID RULES #########################
WAZUH_RULES = []
### Example : WAZUH_RULES = ["123", "345", "456"]
######################################################

usage = "usage: python3 %prog (-c|-u) (-r|-d) -i INPUT_FILE [-o OUTPUT_FILE] [-w arg1 arg2 ...]"
parser = OptionParser(usage = usage, version="v1.0")
parser.add_option("-i", "--input", dest="input", type="string",
                  help="takes this file as input", metavar="INPUT_FILE")
parser.add_option("-o", "--output", dest="output", type="string",
                  help="takes this file as output", metavar="OUTPUT_FILE")
parser.add_option("-c", "--comment", action="store_true", dest="comment",
                  help="comment decoders/rules", metavar="COMMENT")
parser.add_option("-u", "--uncomment", action="store_true", dest="uncomment",
                  help="uncomment decoders/rules", metavar="UNCOMMENT")
parser.add_option("-r", "--rules", action="store_true", dest="rules",
                  help="action on rules")
parser.add_option("-d", "--decoders", action="store_true", dest="decoders",
                  help="action on decoders")
parser.add_option("-v", "--verbose", action="store_true", dest="verbose",
                  help="show bash commands")
parser.add_option("-w", "--overwrite", action="store_true", dest="overwrite",
                  help="overwrite array configuration with arguments")

(options, args) = parser.parse_args()

## IF SOMETHING GOES WRONG ##

if options.comment is None and options.uncomment is None:
    parser.error("Missing action option. Should either be -c (comment) or -u (uncomment)")

if options.comment is True and options.uncomment is True:
    parser.error("Too much action options. Should either be -c (comment) or -u (uncomment)")

if options.decoders is None and options.rules is None:
    parser.error("Missing type of wazuh xml file. Should either be -r (rules) or -d (decoders)")

if options.decoders is True and options.rules is True:
    parser.error("Too much type of wazuh xml file. Should either be -r (rules) or -d (decoders)")

if options.input is None:
    parser.error("Missing input file")

if not os.path.exists(options.input):
    parser.error("Input file doesn't exist, check the path...")


def process_item(array_config, item_type):
    if options.overwrite:
        if len(args) == 0:
            parser.error("Missing " + item_type + "(s) in arguments (overwrite option)")
        array_config = args
    
    if len(array_config) == 0:
        parser.error("Missing " + item_type + "(s) in configuration array")
    
    if options.output is None:
        print("Output file not specified: modification will be done in %s" % options.input)
        options.output = options.input
    
    if options.comment:
        print("Commenting " + item_type + "(s) : ", array_config, "...")
        modify_file(item_type, array_config, "comment_wazuh.awk")
        print_result("commented.txt", array_config)
    elif options.uncomment:
        print("Uncommenting " + item_type + "(s) : ", array_config, "...")
        modify_file(item_type, array_config, "uncomment_wazuh.awk")
        print_result("uncommented.txt", array_config)  


def modify_file(rule_end, array_config, awk_script):
    tmp_file = options.output + ".tmp"
    list_regex = '|'.join([str(name) for name in array_config])

    if options.decoders:
        regex = ".*name=\"(" + list_regex + ")\".*"
    elif options.rules:
        regex = ".*id=\"(" + list_regex + ")\".*";

    awk_command = "awk -v regex='%s' -v rule_end='%s' -f %s %s > %s" % (regex, rule_end, awk_script, options.input, tmp_file)
    os.system(awk_command)

    mv_command = "mv %s %s " % (tmp_file, options.output)
    os.system(mv_command)

    if options.verbose:
        print("Commands:\n1.",  awk_command, "\n2.", mv_command)


def print_result(result_file, array_config):
    
    ACTION_FAILED = []
    ACTION_SUCCEDED = []
    
    sed_command = "sed -e \'1d\' -e \'s/ *<[a-z]* [a-z]*=\"//g\' -e \'s/\".*//g\' %s > file.tmp" % (result_file)
    os.system(sed_command)

    mv_command = "mv file.tmp %s" % (result_file)
    os.system(mv_command)

    if options.verbose:
    	print("3.",  sed_command, "\n4.", mv_command)
    
    with open(result_file, "r") as file:
        for line in file:
            ACTION_SUCCEDED.append(line[:-1])    
    print("\n" + "#" * 20)
    print("Action succeded on", ACTION_SUCCEDED)
    for item in array_config:
        if item not in ACTION_SUCCEDED:
            ACTION_FAILED.append(item)  
    print("Action failed on", ACTION_FAILED)
    print("#" * 20)
    
    os.system("rm -f " + result_file)


if options.decoders:
    process_item(WAZUH_DECODERS, "decoder")

if options.rules:
    process_item(WAZUH_RULES, "rule")


