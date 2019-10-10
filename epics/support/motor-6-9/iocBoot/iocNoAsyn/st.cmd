#!/home/justin/epicsdev/support/motor-6-9/bin/linux-x86_64/NoAsyn
# This example if for running a motor record that uses the MX device
# driver support on a Unix host.  This example does not require Asyn.

# Start errlog Task before any possible error messsage to prevent
# erroneous "Interrupted system call" message on Linux OS host.

errlogInit(0)

dbLoadDatabase("../../dbd/NoAsyn.dbd",0,0)
NoAsyn_registerRecordDeviceDriver(pdbbase) 
dbLoadTemplate("motor.substitutions")
#dbLoadRecords("../../db/NoAsyn_MX.db","user=rls")
#MXmotorSetup(1, "MXexample.dat", 10)

iocInit()
