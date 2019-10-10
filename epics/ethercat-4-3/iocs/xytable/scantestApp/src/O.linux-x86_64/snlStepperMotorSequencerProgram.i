# 1 "../snlStepperMotorSequencerProgram.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../snlStepperMotorSequencerProgram.st"
# 1 "./../snlStepperMotorSequencer.stt" 1

program snlStepperMotorSequencer
%{#include <time.h>}%
%{#include <string.h>}%
%{#include <math.h>}%
%{#include<stdio.h>}%
%{#include<stdlib.h>}%



double setCounterValue;
assign setCounterValue to "{MotorDrive}:ENCCONTROLCOMPACT:SETCOUNTERVALUE";
monitor setCounterValue;

double setCounterControl;
assign setCounterControl to "{MotorDrive}:ENCCONTROLCOMPACT:CONTROL__SETCOUNTER";
monitor setCounterControl;

double driveVelocity;
assign driveVelocity to "{MotorDrive}:STMVELOCITY:VELOCITY";
monitor driveVelocity;



double snlState;
assign snlState to "{IOC}:{DEVICE}:snlState";
monitor snlState;

double encCalc;
assign encCalc to "{IOC}:{DEVICE}:encCalc";
monitor encCalc;

double encCalc_ENG;
assign encCalc_ENG to "{IOC}:{DEVICE}:encCalc_ENG";
monitor encCalc_ENG;

double potChVal;
assign potChVal to "{IOC}:{DEVICE}:potChVal";
monitor potChVal;

double potChVal_ENG;
assign potChVal_ENG to "{IOC}:{DEVICE}:potChVal_ENG";
monitor potChVal_ENG;

double internalCounterVal;
assign internalCounterVal to "{IOC}:{DEVICE}:internalCounterVal";
monitor internalCounterVal;

double internalCounterVal_ENG;
assign internalCounterVal_ENG to "{IOC}:{DEVICE}:internalCounterVal_ENG";
monitor internalCounterVal_ENG;

double OUFlowCount;
assign OUFlowCount to "{IOC}:{DEVICE}:OUFlowCount";
monitor OUFlowCount;

double snlCLFeedback;
assign snlCLFeedback to "{IOC}:{DEVICE}:snlCLFeedback";
monitor snlCLFeedback;

double dist_Encoder;
assign dist_Encoder to "{IOC}:{DEVICE}:dist_Encoder";
monitor dist_Encoder;

double dist_Counter;
assign dist_Counter to "{IOC}:{DEVICE}:dist_Counter";
monitor dist_Counter;

double dist_Pot;
assign dist_Pot to "{IOC}:{DEVICE}:dist_Pot";
monitor dist_Pot;

double snlFailSafe;
assign snlFailSafe to "{IOC}:{DEVICE}:snlFailSafe";
monitor snlFailSafe;

double lowerLim;
assign lowerLim to "{IOC}:{DEVICE}:lowerLim";
monitor lowerLim;

double isCalibrated;
assign isCalibrated to "{IOC}:{DEVICE}:isCalibrated";
monitor isCalibrated;

double offset_Encoder;
assign offset_Encoder to "{IOC}:{DEVICE}:offset_Encoder";
monitor offset_Encoder;

double offset_Pot;
assign offset_Pot to "{IOC}:{DEVICE}:offset_Pot";
monitor offset_Pot;

double enable_automode;
assign enable_automode to "{IOC}:{DEVICE}:enable_automode";
monitor enable_automode;

double setpoint;
assign setpoint to "{IOC}:{DEVICE}:setpoint";
monitor setpoint;

double CL_deadband;
assign CL_deadband to "{IOC}:{DEVICE}:CL_deadband";
monitor CL_deadband;

double readback;
assign readback to "{IOC}:{DEVICE}:readback";
monitor readback;

double driveEnable;
assign driveEnable to "{IOC}:{DEVICE}:driveEnable";
monitor driveEnable;

double state_automode;
assign state_automode to "{IOC}:{DEVICE}:state_automode";
monitor state_automode;

double CL_enable;
assign CL_enable to "{IOC}:{DEVICE}:CL_enable";

double jog_enable;
assign jog_enable to "{IOC}:{DEVICE}:jog_enable";

double fanout_snlState_val;
assign fanout_snlState_val to "{IOC}:{DEVICE}:fanout_snlState_val";

double fanout_snlCLFeedback_val;
assign fanout_snlCLFeedback_val to "{IOC}:{DEVICE}:fanout_snlCLFeedback_val";

string CL_FBSensor;
assign CL_FBSensor to "{IOC}:{DEVICE}:CL_FBSensor";

string CL_FSSensor;
assign CL_FSSensor to "{IOC}:{DEVICE}:CL_FSSensor";

double FSErrorLim_val;
assign FSErrorLim_val to "{IOC}:{DEVICE}:FSErrorLim_val";


double pre_CL_setpoint_dist;
double auto_transition;

double MS_MULT = 1000000;
struct timespec sleep;

ss ss1 {
    state PowerOnReset_delay_state {
  when(delay(0.5)){
  } state PowerOnReset_state
 }
 state PowerOnReset_state {
  option +e;
  entry {
   printf("Entry PowerOnReset_state\n\r");

   state_automode = 0;
   pvPut(state_automode,SYNC);
   snlState = 0;
   pvPut(snlState,SYNC);
   CL_enable = 0;
   pvPut(CL_enable,SYNC);
   jog_enable = 0;
   pvPut(jog_enable,SYNC);
   fanout_snlState_val = 1;
   pvPut(fanout_snlState_val,SYNC);
   setCounterControl = 0;
   pvPut(setCounterControl,SYNC);
   set_CL_setpoint_dist();

   if (isCalibrated==0){

    sleep.tv_nsec = (int)(500*MS_MULT);
    nanosleep(&sleep, NULL);
    calibrate();
   }
   printf("CL DISABLED | JOG DISABLED | FANOUT 1\n\r");
  }
  when (snlState==1) {
   printf("##Requested CL_state\n\r");
   isCalibrated = 0;
   pvPut(isCalibrated,SYNC);
   calibrate();

   pre_CL_setpoint_dist = setpoint;
   auto_transition = 0;
  } state CL_delay_state
  when (snlState==2) {
   printf("##Requested OL_state\n\r");
   isCalibrated = 0;
   pvPut(isCalibrated,SYNC);
   calibrate();
  } state OL_delay_state
  when ((enable_automode==1) && (fabs(setpoint-readback)>CL_deadband)) {
   printf("##AUTO Requested CL_state\n\r");

   pre_CL_setpoint_dist = setpoint;
   auto_transition = 1;

   snlState = 1;
   pvPut(snlState,SYNC);
   isCalibrated = 0;
   pvPut(isCalibrated,SYNC);
   calibrate();
  } state CL_delay_state
    }
 state CL_delay_state {
  when(delay(0.5)){
  } state CL_state
 }
 state CL_state {
  option +e;
  entry {
   printf("Entry CL_state\n\r");

   state_automode = 1;
   pvPut(state_automode,SYNC);
   snlState = 1;
   pvPut(snlState,SYNC);
   CL_enable = 1;
   pvPut(CL_enable,SYNC);
   jog_enable = 0;
   pvPut(jog_enable,SYNC);
   fanout_snlState_val = 2;
   pvPut(fanout_snlState_val,SYNC);
   setCounterControl = 0;
   pvPut(setCounterControl,SYNC);
   printf("CL ENABLED | JOG DISABLED | FANOUT 2\n\r");
   if(enable_automode==1){

      setpoint = pre_CL_setpoint_dist;
      pvPut(setpoint,SYNC);
      if(fabs(setpoint-readback)>CL_deadband){
    driveEnable = 1;
    pvPut(driveEnable,SYNC);
      }
   }
  }
  when (snlState==0) {
   printf("##Requested PowerOnReset_state\n\r");
   CL_enable = 0;
   pvPut(CL_enable,SYNC);
  } state PowerOnReset_delay_state
  when (snlState==2) {
   printf("##Requested OL_state\n\r");
   CL_enable = 0;
   pvPut(CL_enable,SYNC);
  } state OL_delay_state
  when (enable_automode==1 && auto_transition==1 && driveEnable==0) {
   printf("##AUTO Requested PowerOnReset_state\n\r");

   snlState = 0;
   CL_enable = 0;
   pvPut(CL_enable,SYNC);
  } state PowerOnReset_delay_state
    }
 state OL_delay_state {
  when(delay(0.5)){
  } state OL_state
 }
 state OL_state {
  option +e;
  entry {
     printf("Entry OL_state\n\r");
     snlState = 2;
     pvPut(snlState,SYNC);
     CL_enable = 0;
     pvPut(CL_enable,SYNC);
     jog_enable = 1;
     pvPut(jog_enable,SYNC);
     fanout_snlState_val = 3;
     pvPut(fanout_snlState_val,SYNC);
     setCounterControl = 0;
     pvPut(setCounterControl,SYNC);
     printf("CL DISABLED | JOG ENABLED | FANOUT 3\n\r");
  }
  when (snlState==0) {
   printf("##Requested PowerOnReset_state\n\r");
   jog_enable = 0;
   pvPut(jog_enable,SYNC);
  } state PowerOnReset_delay_state
  when (snlState==1) {
   printf("##Requested CL_state\n\r");
   jog_enable = 0;
   pvPut(jog_enable,SYNC);

   set_CL_setpoint_dist();

   pre_CL_setpoint_dist = setpoint;
   auto_transition = 0;
  } state CL_delay_state
    }
}

void calibrate()
{
   if(snlCLFeedback==0){
  if(snlFailSafe==0)
  {
   calCounterMechEnc();
   strcpy(CL_FSSensor, "MECHANICAL ENCODER");
   pvPut(CL_FSSensor,SYNC);
   FSErrorLim_val = 1;
   pvPut(FSErrorLim_val,SYNC);
  }
  else if(snlFailSafe==1)
  {
   calCounterPot();
   strcpy(CL_FSSensor, "POTENTIOMETER");
   pvPut(CL_FSSensor,SYNC);
   FSErrorLim_val = 2;
   pvPut(FSErrorLim_val,SYNC);
  }
  else if(snlFailSafe==2)
  {
   calCounterMechEnc();
   strcpy(CL_FSSensor, "INTERNAL COUNTER");
   pvPut(CL_FSSensor,SYNC);
   FSErrorLim_val = 3;
   pvPut(FSErrorLim_val,SYNC);
  }
  else
  {

  }

  setpoint = encCalc_ENG;
  pvPut(setpoint, SYNC);

  fanout_snlCLFeedback_val = 1;
  pvPut(fanout_snlCLFeedback_val, SYNC);

  strcpy(CL_FBSensor, "MECHANICAL ENCODER");
  pvPut(CL_FBSensor,SYNC);
 }
 if(snlCLFeedback==1){
  if(snlFailSafe==0)
  {
   calCounterMechEnc();
   strcpy(CL_FSSensor, "MECHANICAL ENCODER");
   pvPut(CL_FSSensor,SYNC);
   FSErrorLim_val = 2;
   pvPut(FSErrorLim_val,SYNC);
  }
  else if(snlFailSafe==1)
  {
   calCounterPot();
   strcpy(CL_FSSensor, "POTENTIOMETER");
   pvPut(CL_FSSensor,SYNC);
   FSErrorLim_val = 1;
   pvPut(FSErrorLim_val,SYNC);
  }
  else if(snlFailSafe==2)
  {
   calCounterPot();
   strcpy(CL_FSSensor, "INTERNAL COUNTER");
   pvPut(CL_FSSensor,SYNC);
   FSErrorLim_val = 4;
   pvPut(FSErrorLim_val,SYNC);
  }
  else
  {

  }

  setpoint = potChVal_ENG;
  pvPut(setpoint, SYNC);

  fanout_snlCLFeedback_val = 2;
  pvPut(fanout_snlCLFeedback_val, SYNC);

  strcpy(CL_FBSensor, "POTENTIOMETER");
  pvPut(CL_FBSensor,SYNC);
 }
 if(snlCLFeedback==2){
  if(snlFailSafe==0)
  {
   FSErrorLim_val = 3;
   pvPut(FSErrorLim_val,SYNC);
   calCounterMechEnc();

   setpoint = encCalc_ENG;
   pvPut(setpoint, SYNC);
   strcpy(CL_FSSensor, "MECHANICAL ENCODER");
   pvPut(CL_FSSensor,SYNC);
  }
  else if(snlFailSafe==1)
  {
   FSErrorLim_val = 4;
   pvPut(FSErrorLim_val,SYNC);
   calCounterPot();

   setpoint = potChVal_ENG;
   pvPut(setpoint, SYNC);
   strcpy(CL_FSSensor, "POTENTIOMETER");
   pvPut(CL_FSSensor,SYNC);
  }
  else if(snlFailSafe==2)
  {
   FSErrorLim_val = 1;
   pvPut(FSErrorLim_val,SYNC);
   calCounterSelf();

   setpoint = lowerLim;
   pvPut(setpoint, SYNC);
   strcpy(CL_FSSensor, "INTERNAL COUNTER");
   pvPut(CL_FSSensor,SYNC);
  }
  else
  {

  }

  fanout_snlCLFeedback_val = 3;
  pvPut(fanout_snlCLFeedback_val, SYNC);

  strcpy(CL_FBSensor, "INTERNAL COUNTER");
  pvPut(CL_FBSensor,SYNC);
 }
 isCalibrated = 1;
 pvPut(isCalibrated, SYNC);
}

void calCounterMechEnc()
{

 setCounterValue = 0;
 pvPut(setCounterValue,SYNC);
 setCounterControl = 1;
 pvPut(setCounterControl,SYNC);
 OUFlowCount = (offset_Encoder+encCalc/dist_Encoder)*dist_Counter;
 pvPut(OUFlowCount, SYNC);
}

void calCounterPot()
{

 setCounterValue = 0;
 pvPut(setCounterValue,SYNC);
 setCounterControl = 1;
 pvPut(setCounterControl,SYNC);
 OUFlowCount = (offset_Pot+potChVal/dist_Pot)*dist_Counter;
 pvPut(OUFlowCount, SYNC);
}

void calCounterSelf()
{

 setCounterValue = 0;
 pvPut(setCounterValue,SYNC);
 setCounterControl = 1;
 pvPut(setCounterControl,SYNC);
 OUFlowCount = lowerLim*dist_Counter;
 pvPut(OUFlowCount, SYNC);
}

void set_CL_setpoint_dist(){
 if(snlCLFeedback==0){
  setpoint = encCalc_ENG;
  pvPut(setpoint, SYNC);
 }
 else if(snlCLFeedback==1){
  setpoint = potChVal_ENG;
  pvPut(setpoint, SYNC);
 }
 else if(snlCLFeedback==2){
  setpoint = internalCounterVal_ENG;
  pvPut(setpoint, SYNC);
 }
}
# 1 "../snlStepperMotorSequencerProgram.st" 2
