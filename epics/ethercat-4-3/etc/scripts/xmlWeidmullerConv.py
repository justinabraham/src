#!/usr/bin/python

import xml.etree.ElementTree as ET
import sys, getopt

## xml layout
# outputs before inputs (RxPdo before TxPdo)
# digital and analogue as per TwinCAT slot order
# each output has one module state input

try:
    opts, args = getopt.getopt(sys.argv[1:],"hi:o:",["help","ifile=","ofile="])
except getopt.GetoptError:
    print './xmlWeidmullerConv.py -i <inputfile.xml> -o <outputfile.xml>'
    sys.exit(2)
  
for opt, arg in opts:
    print arg
    if opt == '-h':
      print './xmlWeidmullerConv.py -i <inputfile.xml> -o <outputfile.xml>'
      sys.exit()
    elif opt in ("-i", "--ifile"):
      inputfile = arg
    elif opt in ("-o", "--ofile"):
      outputfile = arg


# Read in xml file
tree = ET.parse(inputfile)
root = tree.getroot()

# Counts to ignore first RxPdo and TxPdo (Coupler)
cRxPdo = 0
cTxPdo = 0

# Handles Outputs
print "#####OUTPUT MODULES#####"
for RxPdo in root.findall("./Descriptions/Devices/Device/RxPdo"):
    # if condition to skip coupler    
    if cRxPdo>0:
        # slot number from last two digits of index number
        snum = str(RxPdo.find('Index').text[-2:])
        # current name
        cName = RxPdo.find('Name').text
        # new name
        nName = "SLOT"+snum+":"+cName
        # assign new name to module
        RxPdo.find('Name').text = nName
        # find all entries
        for Entry in RxPdo.findall('Entry'):
            try:
                print nName+":"+Entry.find('Name').text
            except:
                error=1
    cRxPdo+=1

# Handles Inputs
print "#####INPUT MODULES#####"
for TxPdo in root.findall("./Descriptions/Devices/Device/TxPdo"):
    # if condition to skip coupler    
    if cTxPdo>0:
        # slot number from last two digits of index number
        snum = str(TxPdo.find('Index').text[-2:])
        # current name
        cName = TxPdo.find('Name').text
        # new name
        nName = "SLOT"+snum+":"+cName
        # assign new name to module
        TxPdo.find('Name').text = nName
        # find all entries
        for Entry in TxPdo.findall('Entry'):
            try:
                print nName+":"+Entry.find('Name').text
            except:
                error=1
    cTxPdo+=1


tree.write(outputfile)