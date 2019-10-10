TOP=../..

include $(TOP)/configure/CONFIG

# IOC
USR_SYS_LIBS += xml2
#DBDINC += xxxRecord
# Install devXxxSoft.dbd into <top>/dbd
#DBD += xxxSupport.dbd

DBD += scantest.dbd
scantest_DBD += base.dbd ecAsyn.dbd asSupport.dbd calcSupport.dbd
PROD_IOC = scantest
scantest_SRCS += scantest_registerRecordDeviceDriver.cpp

# These two lines are needed for non-vxWorks builds, such as Linux
scantest_SRCS_DEFAULT += scantestMain.cpp
scantest_SRCS_vxWorks += -nil-

# Add locally compiled object code
# scantest_SRCS +=

# The following adds object code from base/src/vxWorks
scantest_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

scantest_LIBS += ecAsyn asyn autosave scannerlib rtutils calc


	snlStepperMotorSequencer_SNCFLAGS += +r
    scantest_DBD += snlStepperMotorSequencer.dbd
    scantest_SRCS += snlStepperMotorSequencer.stt
    #scantest_LIBS += seq pv 
    scantest_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += snlStepperMotorSequencerProgram
    snlStepperMotorSequencerProgram_SNCFLAGS += +m
    snlStepperMotorSequencerProgram_SRCS += snlStepperMotorSequencerProgram.st
    snlStepperMotorSequencerProgram_LIBS += seq pv
    snlStepperMotorSequencerProgram_LIBS += $(EPICS_BASE_HOST_LIBS)

scantest_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
