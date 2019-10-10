#!bin/linux-x86_64/scantest
dbLoadDatabase("dbd/scantest.dbd")
scantest_registerRecordDeviceDriver(pdbbase)

ecAsynInit("/tmp/scan1", 1000000)

dbLoadRecords("../../db/MASTER.template", "DEVICE=XYTABLE:0,PORT=MASTER0,SCAN=I/O Intr")

# Load all Beckhoff Modules with correct PV names
dbLoadTemplate "db/mapBeckhoffModules.substitutions"

# Load all Beckhoff Modules with correct PV names
dbLoadTemplate "db/mapMotionControl.substitutions"

set_savefile_path("save/")
set_pass0_restoreFile("info_positions.sav")
set_pass1_restoreFile("info_positions.sav")

iocInit()

makeAutosaveFiles()
create_monitor_set("info_positions.req", 1)

##### STEPPER MOTOR SEQUENCER #################
seq snlStepperMotorSequencer "IOC=XYTIOC, DEVICE=X, MotorDrive=XYTABLE:2"
seq snlStepperMotorSequencer "IOC=XYTIOC, DEVICE=Y, MotorDrive=XYTABLE:3"


dbcar * 1
seqcar 1


