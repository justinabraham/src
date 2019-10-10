# 1 "../MAX_trajectoryScan.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../MAX_trajectoryScan.st"
program MAX_trajectoryScan("P=13IDC:,R=traj1,M1=M1,M2=M2,M3=M3,M4=M4,M5=M5,M6=M6,M7=M7,M8=M8,PORT=serial1")
# 19 "../MAX_trajectoryScan.st"
%% #include <stdlib.h>
%% #include <string.h>
%% #include <ctype.h>
%% #include <stdio.h>
%% #include <math.h>
%% #include <time.h>
%% #include <epicsString.h>
%% #include <epicsStdio.h>
%% #include <asynOctetSyncIO.h>

# 1 "/epics/support/seq-2-2-1/include/seq_release.h" 1
# 30 "../MAX_trajectoryScan.st" 2
# 38 "../MAX_trajectoryScan.st"
option +r;
# 59 "../MAX_trajectoryScan.st"
# 1 "../MAX_trajectoryScan.h" 1
# 41 "../MAX_trajectoryScan.h"
int debugLevel; assign debugLevel to "{P}{R}DebugLevel.VAL";
monitor debugLevel;
int numAxes; assign numAxes to "{P}{R}NumAxes.VAL";
monitor numAxes;
int nelements; assign nelements to "{P}{R}Nelements.VAL";
monitor nelements;
int npulses; assign npulses to "{P}{R}Npulses.VAL";
monitor npulses;
int startPulses; assign startPulses to "{P}{R}StartPulses.VAL";
monitor startPulses;
int endPulses; assign endPulses to "{P}{R}EndPulses.VAL";
monitor endPulses;
int nactual; assign nactual to "{P}{R}Nactual.VAL";
int moveMode; assign moveMode to "{P}{R}MoveMode.VAL";
monitor moveMode;
double time_PV; assign time_PV to "{P}{R}Time.VAL";
monitor time_PV;
double timeScale; assign timeScale to "{P}{R}TimeScale.VAL";
monitor timeScale;
int timeMode; assign timeMode to "{P}{R}TimeMode.VAL";
monitor timeMode;
double accel; assign accel to "{P}{R}Accel.VAL";
monitor accel;
int build; assign build to "{P}{R}Build.VAL";
monitor build;
int buildState; assign buildState to "{P}{R}BuildState.VAL";
int buildStatus; assign buildStatus to "{P}{R}BuildStatus.VAL";
string buildMessage;assign buildMessage to "{P}{R}BuildMessage.VAL";
int simMode; assign simMode to "{P}{R}SimMode.VAL";
monitor simMode;
int execute; assign execute to "{P}{R}Execute.VAL";
monitor execute;
int execState; assign execState to "{P}{R}ExecState.VAL";
monitor execState;
int execStatus; assign execStatus to "{P}{R}ExecStatus.VAL";
string execMessage; assign execMessage to "{P}{R}ExecMessage.VAL";
int abort; assign abort to "{P}{R}Abort.VAL";
monitor abort;
int readback; assign readback to "{P}{R}Readback.VAL";
monitor readback;
int readState; assign readState to "{P}{R}ReadState.VAL";
int readStatus; assign readStatus to "{P}{R}ReadStatus.VAL";
string readMessage; assign readMessage to "{P}{R}ReadMessage.VAL";
double timeTrajectory[1000];
assign timeTrajectory to "{P}{R}TimeTraj.VAL";
monitor timeTrajectory;
string trajectoryFile; assign trajectoryFile to "{P}{R}TrajectoryFile.VAL";
monitor trajectoryFile;




double elapsedTime; assign elapsedTime to "{P}{R}ElapsedTime.VAL";


int outBitNum; assign outBitNum to "{P}{R}OutBitNum.VAL";
monitor outBitNum;


int inBitNum; assign inBitNum to "{P}{R}InBitNum.VAL";
monitor inBitNum;


double overrideFactor; assign overrideFactor to "{P}{R}OverrideFactor";
monitor overrideFactor;


int updateFreq; assign updateFreq to "{P}{R}UpdateFreq.RVAL";
monitor updateFreq;


double realTimeTrajectory[1000];
assign realTimeTrajectory to "{P}{R}realTimeTrajectory.VAL";


int motorCurrentRaw[8];
int motorCurrentVRaw[8];
int motorCurrentARaw[8];


double epicsMotorMres[8];
assign epicsMotorMres to {"","","","","","","",""};
monitor epicsMotorMres;


int epicsMotorCard[8];
assign epicsMotorCard to {"","","","","","","",""};
monitor epicsMotorCard;


double epicsMotorHLM[8];
assign epicsMotorHLM to {"","","","","","","",""};
monitor epicsMotorHLM;
double epicsMotorLLM[8];
assign epicsMotorLLM to {"","","","","","","",""};
monitor epicsMotorLLM;

double motorMinSpeed[8];
assign motorMinSpeed to
        {"{P}{R}M1MinSpeed.VAL",
         "{P}{R}M2MinSpeed.VAL",
         "{P}{R}M3MinSpeed.VAL",
         "{P}{R}M4MinSpeed.VAL",
         "{P}{R}M5MinSpeed.VAL",
         "{P}{R}M6MinSpeed.VAL",
         "{P}{R}M7MinSpeed.VAL",
         "{P}{R}M8MinSpeed.VAL"};

double motorMaxSpeed[8];
assign motorMaxSpeed to
        {"{P}{R}M1MaxSpeed.VAL",
         "{P}{R}M2MaxSpeed.VAL",
         "{P}{R}M3MaxSpeed.VAL",
         "{P}{R}M4MaxSpeed.VAL",
         "{P}{R}M5MaxSpeed.VAL",
         "{P}{R}M6MaxSpeed.VAL",
         "{P}{R}M7MaxSpeed.VAL",
         "{P}{R}M8MaxSpeed.VAL"};

double motorStart[8];
assign motorStart to
        {"{P}{R}M1Start.VAL",
         "{P}{R}M2Start.VAL",
         "{P}{R}M3Start.VAL",
         "{P}{R}M4Start.VAL",
         "{P}{R}M5Start.VAL",
         "{P}{R}M6Start.VAL",
         "{P}{R}M7Start.VAL",
         "{P}{R}M8Start.VAL"};

int addAccelDecel; assign addAccelDecel to "{P}{R}AddAccelDecel.VAL";
monitor addAccelDecel;
evflag moveModeMon; sync moveMode moveModeMon;
int moveModePrev;



int moveAxis[8];
assign moveAxis to
        {"{P}{R}M1Move.VAL",
         "{P}{R}M2Move.VAL",
         "{P}{R}M3Move.VAL",
         "{P}{R}M4Move.VAL",
         "{P}{R}M5Move.VAL",
         "{P}{R}M6Move.VAL",
         "{P}{R}M7Move.VAL",
         "{P}{R}M8Move.VAL"};
monitor moveAxis;

double motorTrajectory[8][1000];
assign motorTrajectory to
        {"{P}{R}M1Traj.VAL",
         "{P}{R}M2Traj.VAL",
         "{P}{R}M3Traj.VAL",
         "{P}{R}M4Traj.VAL",
         "{P}{R}M5Traj.VAL",
         "{P}{R}M6Traj.VAL",
         "{P}{R}M7Traj.VAL",
         "{P}{R}M8Traj.VAL"};
monitor motorTrajectory;

double motorReadbacks[8][1000];
assign motorReadbacks to
        {"{P}{R}M1Actual.VAL",
         "{P}{R}M2Actual.VAL",
         "{P}{R}M3Actual.VAL",
         "{P}{R}M4Actual.VAL",
         "{P}{R}M5Actual.VAL",
         "{P}{R}M6Actual.VAL",
         "{P}{R}M7Actual.VAL",
         "{P}{R}M8Actual.VAL"};

double motorError[8][1000];
assign motorError to
        {"{P}{R}M1Error.VAL",
         "{P}{R}M2Error.VAL",
         "{P}{R}M3Error.VAL",
         "{P}{R}M4Error.VAL",
         "{P}{R}M5Error.VAL",
         "{P}{R}M6Error.VAL",
         "{P}{R}M7Error.VAL",
         "{P}{R}M8Error.VAL"};

double motorCurrent[8];
assign motorCurrent to
        {"{P}{R}M1Current.VAL",
         "{P}{R}M2Current.VAL",
         "{P}{R}M3Current.VAL",
         "{P}{R}M4Current.VAL",
         "{P}{R}M5Current.VAL",
         "{P}{R}M6Current.VAL",
         "{P}{R}M7Current.VAL",
         "{P}{R}M8Current.VAL"};

double motorMDVS[8];
assign motorMDVS to
        {"{P}{R}M1MDVS.VAL",
         "{P}{R}M2MDVS.VAL",
         "{P}{R}M3MDVS.VAL",
         "{P}{R}M4MDVS.VAL",
         "{P}{R}M5MDVS.VAL",
         "{P}{R}M6MDVS.VAL",
         "{P}{R}M7MDVS.VAL",
         "{P}{R}M8MDVS.VAL"};
monitor motorMDVS;

double motorMDVA[8];
assign motorMDVA to
        {"{P}{R}M1MDVA.VAL",
         "{P}{R}M2MDVA.VAL",
         "{P}{R}M3MDVA.VAL",
         "{P}{R}M4MDVA.VAL",
         "{P}{R}M5MDVA.VAL",
         "{P}{R}M6MDVA.VAL",
         "{P}{R}M7MDVA.VAL",
         "{P}{R}M8MDVA.VAL"};

int motorMDVE[8];
assign motorMDVE to
        {"{P}{R}M1MDVE.VAL",
         "{P}{R}M2MDVE.VAL",
         "{P}{R}M3MDVE.VAL",
         "{P}{R}M4MDVE.VAL",
         "{P}{R}M5MDVE.VAL",
         "{P}{R}M6MDVE.VAL",
         "{P}{R}M7MDVE.VAL",
         "{P}{R}M8MDVE.VAL"};

double motorMVA[8];
assign motorMVA to
        {"{P}{R}M1MVA.VAL",
         "{P}{R}M2MVA.VAL",
         "{P}{R}M3MVA.VAL",
         "{P}{R}M4MVA.VAL",
         "{P}{R}M5MVA.VAL",
         "{P}{R}M6MVA.VAL",
         "{P}{R}M7MVA.VAL",
         "{P}{R}M8MVA.VAL"};

int motorMVE[8];
assign motorMVE to
        {"{P}{R}M1MVE.VAL",
         "{P}{R}M2MVE.VAL",
         "{P}{R}M3MVE.VAL",
         "{P}{R}M4MVE.VAL",
         "{P}{R}M5MVE.VAL",
         "{P}{R}M6MVE.VAL",
         "{P}{R}M7MVE.VAL",
         "{P}{R}M8MVE.VAL"};

double motorMAA[8];
assign motorMAA to
        {"{P}{R}M1MAA.VAL",
         "{P}{R}M2MAA.VAL",
         "{P}{R}M3MAA.VAL",
         "{P}{R}M4MAA.VAL",
         "{P}{R}M5MAA.VAL",
         "{P}{R}M6MAA.VAL",
         "{P}{R}M7MAA.VAL",
         "{P}{R}M8MAA.VAL"};

int motorMAE[8];
assign motorMAE to
        {"{P}{R}M1MAE.VAL",
         "{P}{R}M2MAE.VAL",
         "{P}{R}M3MAE.VAL",
         "{P}{R}M4MAE.VAL",
         "{P}{R}M5MAE.VAL",
         "{P}{R}M6MAE.VAL",
         "{P}{R}M7MAE.VAL",
         "{P}{R}M8MAE.VAL"};



double epicsMotorPos[8];
assign epicsMotorPos to {"","","","","","","",""};
monitor epicsMotorPos;

int epicsMotorDir[8];
assign epicsMotorDir to {"","","","","","","",""};
monitor epicsMotorDir;

double epicsMotorOff[8];
assign epicsMotorOff to {"","","","","","","",""};
monitor epicsMotorOff;

double epicsMotorDone[8];
assign epicsMotorDone to {"","","","","","","",""};
monitor epicsMotorDone;

double epicsMotorVELO[8];
assign epicsMotorVELO to {"","","","","","","",""};
monitor epicsMotorVELO;

double epicsMotorVMAX[8];
assign epicsMotorVMAX to {"","","","","","","",""};
monitor epicsMotorVMAX;

double epicsMotorVMIN[8];
assign epicsMotorVMIN to {"","","","","","","",""};
monitor epicsMotorVMIN;

double epicsMotorACCL[8];
assign epicsMotorACCL to {"","","","","","","",""};
monitor epicsMotorACCL;

string epicsMotorOUT[8];
assign epicsMotorOUT to {"","","","","","","",""};


evflag buildMon; sync build buildMon;
evflag executeMon; sync execute executeMon;
evflag execStateMon; sync execState execStateMon;
evflag abortMon; sync abort abortMon;
evflag readbackMon; sync readback readbackMon;
evflag nelementsMon; sync nelements nelementsMon;
evflag motorMDVSMon; sync motorMDVS motorMDVSMon;
# 60 "../MAX_trajectoryScan.st" 2
# 89 "../MAX_trajectoryScan.st"
int cardNumber;






%%extern int MAXV_send_mess(int cardNumber, char const *message, char *name);





%%extern int MAXV_recv_mess(int cardNumber, char *message, int amount);

%%extern int MAXV_send_recv_mess(int cardNumber, char const *command, char *name, char *message, int amount);
%%extern int MAXV_getPositions(int card, epicsInt32 *positions, int nPositions);







%%char axis_name[] = "XYZTUVRS";
char stringOut[100];
char sbuf[100];
char stringIn[100];
char *asynPort;
char *pasynUser;
int status;
int i;
int j;
int k;
int n;
double delay;
int anyMoving;
int ncomplete;
int nextra;
int npoints;
double dtime;
double dpos;
double accelDist[8];
double decelDist[8];
%%double aDist;
%%double dDist;
double posActual;
double posTheory;
double expectedTime;
double initialPos[8];
char macroBuf[100];
char motorName[100];
char *p;
char *tok_save;
int currPulse;
double frac;
double deltaV;
double v;
double vO;
int vOverride;
double lastPollTime;
int lastRealTimePoint;
int doPoll;
int initStatus;
int limitViolation;



int motorCurrentIndex[8];
int epicsMotorDoneIndex[8];



unsigned long startTime;
%%epicsTimeStamp eStartTime;


%% static int writeOnly(SS_ID ssId, struct UserVar *pVar, char *command);
%% static int writeRead(SS_ID ssId, struct UserVar *pVar, char *command, char *reply);
%% static int getMotorPositions(SS_ID ssId, struct UserVar *pVar, double *pos, epicsInt32 *raw, double *dtime);
%% static int getMotorMoving(SS_ID ssId, struct UserVar *pVar, int movingMask);
%% static int getEpicsMotorMoving(SS_ID ssId, struct UserVar *pVar);
%% static int waitEpicsMotors(SS_ID ssId, struct UserVar *pVar);
%% static int buildTrajectory(SS_ID ssId, struct UserVar *pVar, double *realTimeTrajectory,
%% double *motorTrajectory, int epicsMotorDir, int moveMode, int npoints, double motorOffset,
%% double motorResolution, double motorVmin, int *position, int *velocity, int *acceleration,
%% double *accelDist, double *decelDist);
%% static int loadTrajectory(SS_ID ssId, struct UserVar *pVar, int simMode);
%% static int getStarted(SS_ID ssId, struct UserVar *pVar);
%% static int userToRaw(double user, double off, int dir, double res);
%% static double rawToUser(int raw, double off, int dir, double res);

int position[8][1002];
int velocity[8][1002];
int acceleration[8][1002];

double realTimeTrajectoryAccelDecel[1002];
double *rttraj;

int motorStartRaw[8];
double motorEnd[8];
double dbuf[1000];


int movingMask;
int waitingForTrigger;


double vmax;
double amax;

int card;
int signal;

ss maxTrajectoryScan {


 state init {
  when() {
   cardNumber = -2;
   initStatus = 0;

   if (numAxes > 8) numAxes = 8;
   for (i=0; i<numAxes; i++) {
    sprintf(macroBuf, "M%d", i+1);

    sprintf(motorName, "%s%s.VAL", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorPos[i], motorName);
    pvMonitor(epicsMotorPos[i]);

    sprintf(motorName, "%s%s.DIR", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorDir[i], motorName);
    pvMonitor(epicsMotorDir[i]);

    sprintf(motorName, "%s%s.OFF", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorOff[i], motorName);
    pvMonitor(epicsMotorOff[i]);

    sprintf(motorName, "%s%s.DMOV", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorDone[i], motorName);
    pvMonitor(epicsMotorDone[i]);

    sprintf(motorName, "%s%s.MRES", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorMres[i], motorName);
    pvMonitor(epicsMotorMres[i]);

    sprintf(motorName, "%s%s.CARD", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorCard[i], motorName);
    pvMonitor(epicsMotorCard[i]);

    sprintf(motorName, "%s%s.HLM", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorHLM[i], motorName);
    pvMonitor(epicsMotorHLM[i]);

    sprintf(motorName, "%s%s.LLM", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorLLM[i], motorName);
    pvMonitor(epicsMotorLLM[i]);

    sprintf(motorName, "%s%s.VELO", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorVELO[i], motorName);
    pvMonitor(epicsMotorVELO[i]);

    sprintf(motorName, "%s%s.VMAX", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorVMAX[i], motorName);
    pvMonitor(epicsMotorVMAX[i]);

    sprintf(motorName, "%s%s.VBAS", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorVMIN[i], motorName);
    pvMonitor(epicsMotorVMIN[i]);

    sprintf(motorName, "%s%s.ACCL", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorACCL[i], motorName);
    pvMonitor(epicsMotorACCL[i]);

    sprintf(motorName, "%s%s.OUT", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorOUT[i], motorName);
    pvGet(epicsMotorOUT[i]);

    sscanf(epicsMotorOUT[i], "#C%d S%d", &card, &signal);
    if (signal != i) {
     printf("MAX_trajectoryScan: motor %d has signal %d (must be same)\n", i, signal);
     initStatus = 2;
    }

    if (cardNumber == -2) {
     cardNumber = epicsMotorCard[i];
    } else {
     if (cardNumber != epicsMotorCard[i]) {
      printf("MAX_trajectoryScan: motors not on same card: %d %d\n", cardNumber, epicsMotorCard[i]);
      initStatus = 2;
     }
    }
   }
# 290 "../MAX_trajectoryScan.st"
   for (j=0; j<numAxes; j++) {
    motorCurrentIndex[j] = pvIndex(motorCurrent[j]);
    epicsMotorDoneIndex[j] = pvIndex(epicsMotorDone[j]);
   }


   efClear(buildMon);
   efClear(executeMon);
   efClear(abortMon);
   efClear(readbackMon);
   efClear(nelementsMon);
   efClear(motorMDVSMon);
   efClear(moveModeMon);

   moveModePrev = moveMode;
   if (initStatus == 0) initStatus = 1;
  } state monitor_inputs
 }


 state monitor_inputs {
  when(efTestAndClear(buildMon) && (build==1) && (initStatus == 1)) {
  } state build

  when(efTestAndClear(executeMon) && (execute==1) && (buildStatus == 1)) {
  } state execute

  when(efTestAndClear(readbackMon) && (readback==1) ) {
  } state readback

  when(efTestAndClear(nelementsMon) && (nelements>=1)) {



   endPulses = nelements;
   pvPut(endPulses);
  } state monitor_inputs

  when(efTestAndClear(motorMDVSMon)) {

  } state monitor_inputs

  when (efTestAndClear(moveModeMon)) {

   if (moveMode == 2) {
    moveMode = moveModePrev;
    pvPut(moveMode);
   } else {
    moveModePrev = moveMode;
   }
   buildStatus = 0;
   pvPut(buildStatus);
  } state monitor_inputs
 }


 state build {
  when() {

   buildState = 1;
   pvPut(buildState);
   buildStatus=0;
   pvPut(buildStatus);
   epicsSnprintf(buildMessage, 40, "Building...");
   pvPut(buildMessage);


   buildStatus = 1;



   if (timeMode == 0) {
    dtime = time_PV/(nelements-1);
    for (i=0; i<nelements-1; i++) timeTrajectory[i] = dtime;
    for (i=nelements-1; i<1000; i++) timeTrajectory[i] = 0;
    pvPut(timeTrajectory);
   }

   if (moveMode == 0) {
    npoints = nelements;
   } else {
    npoints = nelements;
   }


   realTimeTrajectory[0] = 0.;
   for (i=1; i<npoints; i++) {
    realTimeTrajectory[i] = realTimeTrajectory[i-1] + timeTrajectory[i-1];
   }
   for (i=0; i<npoints; i++) realTimeTrajectory[i] *= timeScale;


   for (; i<1000; i++) realTimeTrajectory[i] = realTimeTrajectory[i-1];
   pvPut(realTimeTrajectory);


   realTimeTrajectoryAccelDecel[0] = 0;
   for (i=1; i<npoints+1; i++) realTimeTrajectoryAccelDecel[i] = realTimeTrajectory[i-1] + accel;
   realTimeTrajectoryAccelDecel[npoints+1] = realTimeTrajectoryAccelDecel[npoints] + accel;


   for (j=0; j<8; j++) {
    if (moveAxis[j]) {
     rttraj = realTimeTrajectoryAccelDecel;
     if (addAccelDecel) rttraj = realTimeTrajectoryAccelDecel;
     %%buildTrajectory(ssId, pVar, pVar->rttraj, pVar->motorTrajectory[pVar->j],
     %% pVar->epicsMotorDir[pVar->j], pVar->moveMode, pVar->npoints,
     %% pVar->epicsMotorOff[pVar->j], pVar->epicsMotorMres[pVar->j], pVar->epicsMotorVMIN[pVar->j],
     %% pVar->position[pVar->j], pVar->velocity[pVar->j], pVar->acceleration[pVar->j],
     %% &aDist, &dDist);
     %%pVar->accelDist[pVar->j] = aDist;
     %%pVar->decelDist[pVar->j] = dDist;
    }
   }


   if (addAccelDecel) {

    expectedTime = realTimeTrajectoryAccelDecel[npoints+1];
   } else {
    expectedTime = realTimeTrajectory[npoints-1];
   }


   limitViolation = 0;
   for (j=0; j<numAxes && !limitViolation; j++) {
    if (moveAxis[j]) {
     vmax = epicsMotorVMAX[j];
     if (fabs(vmax) < .001) vmax = epicsMotorVELO[j];
     amax = vmax/epicsMotorACCL[j];
     motorMVA[j] = 0.;
     motorMAA[j] = 0.;
     motorMVE[j] = 0;
     motorMAE[j] = 0;
     for (k=0; k<npoints && !limitViolation; k++) {
      posActual = motorTrajectory[j][k];
      if (moveMode != 1) posActual += epicsMotorPos[j];
      limitViolation |= (posActual > epicsMotorHLM[j]) || (posActual < epicsMotorLLM[j]);
                  if (limitViolation) {
       epicsSnprintf(buildMessage, 40, "Limit: m%d at pt. %d (%f)", j+1, k+1, posActual);
      }
      if (velocity[j][k]*epicsMotorMres[j] > vmax) {
       limitViolation |= 1;
       epicsSnprintf(buildMessage, 40, "V limit: m%d at pt. %d (%f)", j+1, k+1,
        velocity[j][k]*epicsMotorMres[j]);
      }
      if (fabs(acceleration[j][k]*epicsMotorMres[j]) > amax) {
       limitViolation |= 1;
       epicsSnprintf(buildMessage, 40, "A limit: m%d at pt. %d (%f)", j+1, k+1,
        acceleration[j][k]*epicsMotorMres[j]);
      }
      if (fabs(velocity[j][k]) > motorMVA[j]) {
       motorMVA[j] = velocity[j][k];
       motorMVE[j] = k;
      }
      if (fabs(acceleration[j][k]) > motorMAA[j]) {
       motorMAA[j] = acceleration[j][k];
       motorMAE[j] = k;
      }
     }
     motorMVA[j] *= epicsMotorMres[j];
     motorMAA[j] *= epicsMotorMres[j];
     pvPut(motorMVA[j]);
     pvPut(motorMAA[j]);
     pvPut(motorMVE[j]);
     pvPut(motorMAE[j]);
    }
   }

   if (limitViolation) {
    buildStatus = 2;
   }


   for (j=0; j<numAxes; j++) {
    if (moveAxis[j]) {
     if (moveMode == 1) {
      motorStart[j] = motorTrajectory[j][0];
      motorEnd[j] = motorTrajectory[j][npoints-1];
     } else {
      motorStart[j] = epicsMotorPos[j];
      motorEnd[j] = motorStart[j] + (motorTrajectory[j][npoints-1] - motorTrajectory[j][0]);
     }
     if (addAccelDecel) {
      motorStart[j] -= accelDist[j];
      motorEnd[j] += decelDist[j];
     }
     pvPut(motorStart[j]);
    }
   }


   %%getMotorPositions(ssId, pVar, pVar->motorCurrent, pVar->motorCurrentRaw, &(pVar->dtime));
   for (j=0; j<numAxes; j++) {
    if (moveAxis[j]) {
     pvPut(motorCurrent[j]);
    }
   }
# 499 "../MAX_trajectoryScan.st"
   buildState = 0;
   pvPut(buildState);
   pvPut(buildStatus);
   pvPut(buildMessage);


   build=0;
   pvPut(build);
   if (buildStatus == 1) {
    epicsSnprintf(buildMessage, 40, "Done");
    pvPut(buildMessage);
   }
  } state monitor_inputs
 }


 state execute {
  when () {

   execState = 1;
   pvPut(execState);

   execStatus = 0;
   pvPut(execStatus);

   for (j=0; j<numAxes; j++) {
    for (i=0; i<1000; i++) {
     motorReadbacks[j][i] = 0.;
     motorError[j][i] = 0.;
    }
   }
   currPulse = 0;

   for (j=0; j<numAxes; j++) motorStart[j] = epicsMotorPos[j];


   for (j=0; j<numAxes; j++) {
    if (moveAxis[j]) {
     if (moveMode == 1) {
      motorStart[j] = motorTrajectory[j][0];
      motorEnd[j] = motorTrajectory[j][npoints-1];
     } else {
      motorStart[j] = epicsMotorPos[j];
      motorEnd[j] = motorStart[j] + (motorTrajectory[j][npoints-1] - motorTrajectory[j][0]);
     }
     if (addAccelDecel) {
      motorStart[j] -= accelDist[j];
      motorEnd[j] += decelDist[j];
     }
     pvPut(motorStart[j]);
    }
   }


   if ((moveMode == 1) || addAccelDecel) {
    for (j=0; j<numAxes; j++) {
     if (moveAxis[j]) {
      epicsMotorPos[j] = motorStart[j];
      pvPut(epicsMotorPos[j]);
     }
    }
    %%waitEpicsMotors(ssId, pVar);
   }







   %%loadTrajectory(ssId, pVar, pVar->simMode);


   %%getMotorPositions(ssId, pVar, pVar->motorStart, pVar->motorStartRaw, &(pVar->dtime));
   n = sprintf(stringOut, "AM;");
   for (j=0; j<8; j++) {
    if (moveAxis[j]) {
     n += sprintf(&(stringOut[n]), "VO[%d]=100;", j+1);
    }
   }
   %%writeOnly(ssId, pVar, pVar->stringOut);

   n = sprintf(stringOut, "AM;");
   for (j=0; j<8; j++) {
    if (moveAxis[j]) {
     n += sprintf(&(stringOut[n]), "VG[%d];", j+1);
    }
   }
   %%writeOnly(ssId, pVar, pVar->stringOut);


   elapsedTime = 0.;
   pvPut(elapsedTime);
   startTime = time(0);
   %%epicsTimeGetCurrent(&eStartTime);
   execState = 2;
   pvPut(execState);
   lastPollTime = -(1/5.);
   lastRealTimePoint = 0;
   waitingForTrigger = ((inBitNum >= 0) && (inBitNum <= 15));
   for (j=0, movingMask = 0; j<numAxes; j++) {
    if (moveAxis[j]) movingMask |= (1<<j);
   }
  } state wait_execute
 }


 state wait_execute {

  when (execStatus == 3) {



   if (debugLevel) printf("\nabort\n");
   pvPut(elapsedTime);
   pvPut(execStatus);
   pvPut(execMessage);

   %%getMotorPositions(ssId, pVar, pVar->motorCurrent, pVar->motorCurrentRaw, &(pVar->dtime));
   for (j=0; j<numAxes; j++) {
    if (moveAxis[j]) {
     pvPut(motorCurrent[j]);
     epicsMotorPos[j] = motorCurrent[j];



     pvPut(epicsMotorPos[j]);
    }
   }
   %%waitEpicsMotors(ssId, pVar);
   if (debugLevel) printf("\n...abort done\n");
   execState = 0;
   pvPut(execState);


   execute=0;
   pvPut(execute);
  } state monitor_inputs

  when (execState==2) {

   if (waitingForTrigger) {
    %%getMotorPositions(ssId, pVar, pVar->motorCurrent, pVar->motorCurrentRaw, &(pVar->dtime));
    for (j=0; j<numAxes; j++) {
     if (moveAxis[j] && (motorStartRaw[j] != motorCurrentRaw[j])) waitingForTrigger = 0;
    }
    if (waitingForTrigger) {
     %%pVar->waitingForTrigger = (getStarted(ssId, pVar) ? 0 : 1);
     startTime = time(0);
     %%epicsTimeGetCurrent(&eStartTime);
    }
   }

   if (!waitingForTrigger) {

    %%getMotorPositions(ssId, pVar, pVar->motorCurrent, pVar->motorCurrentRaw, &(pVar->dtime));
    elapsedTime = dtime;

    doPoll = (dtime - lastPollTime) > (1/5.);
    if (doPoll) pvPut(elapsedTime);
    for (j=0; j<numAxes; j++) {
     if (moveAxis[j]) {
      pvPut(motorCurrent[j]);

      if (currPulse < 1000 -1) {
       motorReadbacks[j][currPulse] = motorCurrent[j];
       motorError[j][currPulse] = dtime;
       if (debugLevel >= 10) printf("wait_execute: motor %d: rb=%f, t=%f\n",
        j, motorReadbacks[j][currPulse], motorError[j][currPulse]);
      }


      for (i=lastRealTimePoint; (i<npoints-1) && (dtime>0.) && (dtime > realTimeTrajectoryAccelDecel[i]); i++);
      i--;
      if (i<0) i = 0;
      if (doPoll && (i > 2) && (i < npoints-2) && (overrideFactor >= .01) && (currPulse < 1000 -1)) {
       if (debugLevel >= 10) printf("wait_execute: time=%f, i=%d, realTimeTrajectoryAccelDecel[i]=%f\n",
        dtime, i, realTimeTrajectoryAccelDecel[i]);
       frac = (dtime - realTimeTrajectoryAccelDecel[i]) / (realTimeTrajectoryAccelDecel[i+1] - realTimeTrajectoryAccelDecel[i]);
       posTheory = motorTrajectory[j][i] + frac * (motorTrajectory[j][i+1] - motorTrajectory[j][i]);
       if (moveMode != 1) {
        posTheory += motorStart[j];
       }
       dpos = motorCurrent[j] - posTheory;
       if (debugLevel >= 4) printf("\n   wait_execute: actual=%.2f, ideal=%.2f, err=%.2f\n",
        motorCurrent[j], posTheory, dpos);

       v = (motorReadbacks[j][currPulse] - motorReadbacks[j][currPulse-1]) /
        (motorError[j][currPulse] - motorError[j][currPulse-1]);


       deltaV = dpos / (realTimeTrajectoryAccelDecel[i+1] - realTimeTrajectoryAccelDecel[i]);
       vO = (1-(deltaV/v)*overrideFactor) * 100;
       %%pVar->vOverride = (int)((pVar->vO)>0 ? (pVar->vO)+0.5 : (pVar->vO)-0.5);
       if (vOverride<80) vOverride=80;
       if (vOverride>120) vOverride=120;
       if (debugLevel >= 10) printf("   wait_execute: v=%.2f, dV=%.2f, vOverride=%.2f (%d)\n",
        v, deltaV, vO, vOverride);

       sprintf(stringOut, "AM; VO[%d]=%d;", j+1, vOverride);
       %%writeOnly(ssId, pVar, pVar->stringOut);
       if (debugLevel >= 2) printf(", 'VO[%d]=%3d'", j+1, vOverride);
      }
     }

    }
    ++currPulse;
    lastRealTimePoint = i;
    if (doPoll) {
     lastPollTime = dtime;
     %%pVar->anyMoving = getMotorMoving(ssId, pVar, pVar->movingMask);
     if (anyMoving == 0) {
      execState = 3;
      execStatus = 1;
      strcpy(execMessage, " ");
     }

     if (difftime(time(0), startTime) > expectedTime*2.) {
      execState = 3;
      execStatus = 4;
      strcpy(execMessage, "Timeout");

      for (j=0; j<8; j++) {
       if (moveAxis[j]) {
        sprintf(stringOut, "AM; VH[%d]1;", j+1);
        %%writeOnly(ssId, pVar, pVar->stringOut);
       }
      }


      sprintf(stringOut, "KS");
      for (j=0; j<8; j++) {
       if (moveAxis[j]) strcat(stringOut, "1");
       if (j<(8 -1)) strcat(stringOut, ",");
      }
      strcat(stringOut, ";");
      if (debugLevel) printf("timeout: sending command '%s'\n", stringOut);
      %%writeOnly(ssId, pVar, pVar->stringOut);

      %%waitEpicsMotors(ssId, pVar);
     }
    }

   }
  } state wait_execute

  when (execState==3) {
   if (debugLevel) printf("\nflyback. currPulse=%d\n", currPulse);
   pvPut(elapsedTime);
   pvPut(execState);
   pvPut(execStatus);
   pvPut(execMessage);

   %%getMotorPositions(ssId, pVar, pVar->motorCurrent, pVar->motorCurrentRaw, &(pVar->dtime));
   for (j=0; j<numAxes; j++) {
    if (moveAxis[j]) {
     pvPut(motorCurrent[j]);
     epicsMotorPos[j] = motorCurrent[j];



     pvPut(epicsMotorPos[j]);
    }
   }
   %%waitEpicsMotors(ssId, pVar);
   if (debugLevel) printf("\n...flyback done\n");

   execState = 0;
   pvPut(execState);


   execute=0;
   pvPut(execute);
  } state monitor_inputs
 }


 state readback {
  when() {

   readState = 1;
   pvPut(readState);
   readStatus=0;
   pvPut(readStatus);


            for (j=0; j<8; j++) {
                pvPut(motorReadbacks[j]);
                pvPut(motorError[j]);
            }

   readState = 0;
   pvPut(readState);

   readStatus = 1;
   pvPut(readStatus);
   strcpy(readMessage, " ");
   pvPut(readMessage);


   readback=0;
   pvPut(readback);
  } state monitor_inputs
 }

}





ss trajectoryAbort {
 state monitorAbort {
  when (efTestAndClear(abortMon) && (abort==1)) {
   for (j=0; j<8; j++) {
    if (moveAxis[j]) {
     sprintf(stringOut, "AM; VH[%d]1;", j+1);
     %%writeOnly(ssId, pVar, pVar->stringOut);
    }
   }


   sprintf(stringOut, "KS");
   for (j=0; j<8; j++) {
    if (moveAxis[j]) strcat(stringOut, "1");
    if (j<(8 -1)) strcat(stringOut, ",");
   }
   strcat(stringOut, ";");
   if (debugLevel) printf("abort: sending command '%s'\n", stringOut);
   %%writeOnly(ssId, pVar, pVar->stringOut);

   execStatus = 3;
   pvPut(execStatus);
   strcpy(execMessage, "Motion aborted");
   pvPut(execMessage);
   pvPut(elapsedTime);


   abort=0;
   pvPut(abort);
  } state monitorAbort
 }
}



%{


static int writeOnly(SS_ID ssId, struct UserVar *pVar, char *command)
{
 asynStatus status=0;
 int debug_out=0;
# 864 "../MAX_trajectoryScan.st"
 if (pVar->simMode==0) {
  status = (asynStatus) MAXV_send_mess(pVar->cardNumber, command, (char *) NULL);
 }

 if (pVar->execState==2)
  debug_out = (pVar->debugLevel >= 7);
 else
  debug_out = (pVar->debugLevel >= 2);
 if (debug_out) printf("    writeOnly:command='%s'\n", command);
 return(status);
}





static int writeRead(SS_ID ssId, struct UserVar *pVar, char *command, char *reply)
{
 asynStatus status;
 char buffer[100];





 strncpy(buffer, command, 100 -3);
# 902 "../MAX_trajectoryScan.st"
 status = MAXV_send_recv_mess(pVar->cardNumber, command, (char *) NULL, reply, 1);

 if (pVar->debugLevel >= 2) {
  printf("    writeRead:command='%s', reply='%s'\n", buffer, reply);
 }
 return(status);
}



static int getMotorPositions(SS_ID ssId, struct UserVar *pVar, double *pos, epicsInt32 *rawP, double *dt)
{
    int j;
    int dir;
 epicsTimeStamp currtime;

 MAXV_getPositions(pVar->cardNumber, rawP, pVar->numAxes);

 epicsTimeGetCurrent(&currtime);
 *dt = epicsTimeDiffInSeconds(&currtime, &eStartTime);
    for (j=0; j<pVar->numAxes; j++) {
        if (pVar->epicsMotorDir[j] == 0) dir=1; else dir=-1;
  pos[j] = rawToUser(rawP[j], pVar->epicsMotorOff[j], dir, pVar->epicsMotorMres[j]);
    }

 if (pVar->debugLevel >= 1) {
  printf("\ndt=%6.3f, p=%7d", *dt, rawP[0]);
 }
 epicsThreadSleep((1/60.));
 return(0);
}



static int getMotorMoving(SS_ID ssId, struct UserVar *pVar, int movingMask)
{
 int i, j, mask, moving;

 for (j=0; j<2; j++) {
  mask = 1;
  moving = 0;

  writeRead(ssId, pVar, "QI", pVar->stringIn);






  for (i=1; i<37; i+=5, mask<<=1) {
   if (pVar->stringIn[i] == 'N') moving |= mask;
  }

  pVar->stringIn[40] = '\0';
  if (pVar->debugLevel >= 7) {
   printf("\ngetMotorMoving: reply = '%s', moving = %2x", pVar->stringIn, moving);
  }
  if (moving & movingMask) return(1);
 }
 return(0);
}


static int getStarted(SS_ID ssId, struct UserVar *pVar) {
 int i, bits, mask;
 char c;

 writeRead(ssId, pVar, "BX", pVar->stringIn);
 for (i=0, bits=0; i<4; i++) {
  bits <<= 4;
  c = pVar->stringIn[i];

  if (isdigit((int)c)) {
   c = c - '0';
  } else if (isxdigit((int)c)) {
   if (islower((int)c)) {
    c = (c - 'a') + 10;
   } else {
    c = (c - 'A') + 10;
   }
  }
  bits |= c;
 }
 mask = 1 << (pVar->inBitNum);
 if (pVar->debugLevel >= 5)
  printf("\ngetStarted: reply='%s', bits=0x%x, mask=0x%x", pVar->stringIn, bits, mask);
 return (bits & mask);
}




static int getEpicsMotorMoving(SS_ID ssId, struct UserVar *pVar)
{
 int j;
 int result=0, mask=0x01;

 for (j=0; j<pVar->numAxes; j++) {
  seq_pvGet(ssId, pVar->epicsMotorDoneIndex[j], 0);
  if (pVar->epicsMotorDone[j] == 0) result |= mask;
  mask = mask << 1;
 }
 return(result);
}



static int waitEpicsMotors(SS_ID ssId, struct UserVar *pVar)
{
 int j;



 while (getEpicsMotorMoving(ssId, pVar)) {

  for (j=0; j<pVar->numAxes; j++) {
   pVar->motorCurrent[j] = pVar->epicsMotorPos[j];
   seq_pvPut(ssId, pVar->motorCurrentIndex[j], 0);
  }
  if (pVar->debugLevel >= 1) printf("waitEpicsMotors: m1=%f\n", pVar->epicsMotorPos[0]);
  epicsThreadSleep((1/5.));
 }
 for (j=0; j<pVar->numAxes; j++) {
  pVar->motorCurrent[j] = pVar->epicsMotorPos[j];
  seq_pvPut(ssId, pVar->motorCurrentIndex[j], 0);
 }
 return(0);
}




volatile int MAXv_traj_quantized = 1;
volatile int MAXv_traj_vmin = 0;

double y2[1002], v_out[1002], a_out[1002], calcMotorTrajectory[1002];
static int buildTrajectory(SS_ID ssId, struct UserVar *pVar, double *realTimeTrajectory,
 double *motorTrajectory, int epicsMotorDir, int moveMode, int npoints, double motorOffset,
 double motorResolution, double motorVmin, int *position, int *velocity, int *acceleration,
 double *accelDist, double *decelDist)
{

 double dp, dt, v_ideal, v_lin, accel_p, accel_v, thisTime;
 double x0;
 int i, dir;

 *accelDist = 0;
 *decelDist = 0;

 if (pVar->addAccelDecel) {
  dp = motorTrajectory[1] - motorTrajectory[0];
  dt = realTimeTrajectory[2] - realTimeTrajectory[1];
  *accelDist = (dp/dt * pVar->accel) / 2;

  dp = motorTrajectory[npoints-1] - motorTrajectory[npoints-2];
  dt = realTimeTrajectory[npoints] - realTimeTrajectory[npoints-1];

  *decelDist = (dp/dt * pVar->accel) / 2;



  for (i=npoints; i>0; i--) {
   motorTrajectory[i] = motorTrajectory[i-1];
  }
  motorTrajectory[0] = motorTrajectory[1] - *accelDist;
  motorTrajectory[npoints+1] = motorTrajectory[npoints] + *decelDist;
  npoints += 2;
 }

 calcMotorTrajectory[0] = motorTrajectory[0];
 v_out[0] = 0;
 if (pVar->debugLevel >= 7) {
  printf("\n###:%8s %8s %7s %8s %8s %8s %8s %8s\n",
   "pos", "calcPos", "dp", "t", "v_ideal", "accel_p", "accel_v", "accel_s");
 }
 for (i=1; i<npoints; i++) {

  dp = motorTrajectory[i]-calcMotorTrajectory[i-1];
  dt = realTimeTrajectory[i]-realTimeTrajectory[i-1];

  accel_p = 2*(dp - v_out[i-1]*dt)/(dt*dt);
  if (i < npoints-1) {


   v_lin = (motorTrajectory[i+1]-motorTrajectory[i-1])/(realTimeTrajectory[i+1]-realTimeTrajectory[i-1]);
   v_ideal = v_lin;


   accel_v = (v_ideal - v_out[i-1])/dt;


   a_out[i-1] = (accel_p + accel_v)/2;

  } else {
   v_ideal = 0.;
   accel_v = (v_ideal - v_out[i-1])/dt;
   a_out[i-1] = accel_v;
  }
  if (pVar->debugLevel >= 7) {
   printf("%3d:%8.2f %8.2f %7.2f %8.3f %8.3f %8.3f %8.3f %8.3f\n",
    i, motorTrajectory[i-1], calcMotorTrajectory[i-1], dp, realTimeTrajectory[i-1], v_ideal, accel_p, accel_v, (y2[i-1]+y2[i])/2);
  }
  if (MAXv_traj_quantized) {

   a_out[i-1] = motorResolution * (int)((a_out[i-1]/motorResolution)>0 ? (a_out[i-1]/motorResolution)+0.5 : (a_out[i-1]/motorResolution)-0.5);
  }
  v_out[i] = v_out[i-1] + a_out[i-1]*dt;
  if (MAXv_traj_quantized) {

   v_out[i] = motorResolution * (int)((v_out[i]/motorResolution)>0 ? (v_out[i]/motorResolution)+0.5 : (v_out[i]/motorResolution)-0.5);
  }
  if (MAXv_traj_vmin) {

   if (v_out[i] < motorVmin) {
    double vsav = v_out[i];
    v_out[i] = (v_out[i] < motorVmin/2) ? 0. : motorVmin;
    printf("v < vmin; %f corrected to %f\n", vsav, v_out[i]);
   }
  }
  calcMotorTrajectory[i] = calcMotorTrajectory[i-1] + v_out[i-1]*dt + .5 * a_out[i-1]*dt*dt;
 }
 a_out[npoints-1] = a_out[npoints-2];

 if (pVar->debugLevel >= 7) {
  printf("buildTrajectory:\n");
  printf("%10s %10s %10s %10s %10s\n", "realTime", "motorTraj", "calcTraj", "v_out", "a_out");
  for (i=0; i<npoints; i++) {
   printf("%10.2f %10.5f %10.5f %10.5f %10.5f\n",
    realTimeTrajectory[i], motorTrajectory[i], calcMotorTrajectory[i], v_out[i], a_out[i]);
  }
 }


 dir = (epicsMotorDir == 0) ? 1 : -1;
 v_out[0] = 0;
 if (pVar->debugLevel >= 1) {
  printf("motor resolution %f\n", motorResolution);
  printf("%10s %10s %10s %10s %10s\n", "time", "position", "calcpos", "velocity", "acceleration");
 }
 for (i=0; i<npoints; i++) {
  if (i < npoints-1) {
   thisTime = realTimeTrajectory[i+1];
   dt = realTimeTrajectory[i+1] - realTimeTrajectory[i];
   position[i] = userToRaw(calcMotorTrajectory[i+1], motorOffset, dir, motorResolution);
   velocity[i] = (int)((dir*v_out[i+1]/motorResolution)>0 ? (dir*v_out[i+1]/motorResolution)+0.5 : (dir*v_out[i+1]/motorResolution)-0.5);
   acceleration[i] = (int)((dir*a_out[i]/motorResolution)>0 ? (dir*a_out[i]/motorResolution)+0.5 : (dir*a_out[i]/motorResolution)-0.5);
  } else {
   thisTime = realTimeTrajectory[i];
   dt = realTimeTrajectory[i] - realTimeTrajectory[i-1];
   position[i] = userToRaw(calcMotorTrajectory[i], motorOffset, dir, motorResolution);
   velocity[i] = 0;
   acceleration[i] = (int)((dir*a_out[i]/motorResolution)>0 ? (dir*a_out[i]/motorResolution)+0.5 : (dir*a_out[i]/motorResolution)-0.5);
  }
  if (i>0) {
   x0 = position[i-1] + velocity[i-1]*dt + .5 * acceleration[i]*dt*dt;
  } else {
   x0 = .5 * acceleration[i]*dt*dt;
  }
  if (pVar->debugLevel >= 1) printf("%10.2f %10d %10d %10d %10d\n", thisTime, position[i], (int)((x0)>0 ? (x0)+0.5 : (x0)-0.5), velocity[i], acceleration[i]);
 }

 if (pVar->addAccelDecel) {

  npoints -= 2;
  for (i=0; i<npoints; i++) {
   motorTrajectory[i] = motorTrajectory[i+1];
  }
  motorTrajectory[npoints] = 0;
 }

 return(0);
}

static int userToRaw(double user, double off, int dir, double res) {
 return ((int)(((user-off)*dir/res)>0 ? ((user-off)*dir/res)+0.5 : ((user-off)*dir/res)-0.5));
}

static double rawToUser(int raw, double off, int dir, double res) {

 return (raw*res*dir+off);
}


static int loadTrajectory(SS_ID ssId, struct UserVar *pVar, int simMode) {
 int i, j, k, n, currUpdateRate;
 int onMask=0, offMask=0, outMask=0;
 int segment_accel, segment_decel, segment_v_start, segment_v_end;
 char absRel;
 char stringOut[100];
 int firstTask;
 double addForRelMove;
 int dir;

 int p1=0, v1=0, do_split;
 double p1_double, t_v0;
 int pulsesEnabled = 0;
 int startPulses, endPulses, npoints;

 startPulses = pVar->startPulses;
 endPulses = pVar->endPulses;
 npoints = pVar->npoints;

 if (pVar->addAccelDecel) {


  startPulses++;
  endPulses++;
  npoints+=2;
 }

 sprintf(stringOut, "AM;");
 writeOnly(ssId, pVar, stringOut);


 if ((pVar->outBitNum >= 0) && (pVar->outBitNum <= 15)) {
  onMask = 1 << (pVar->outBitNum);
  offMask = 0;
  outMask = 1 << (pVar->outBitNum);

  sprintf(stringOut, "BD%04x;", outMask);
  writeOnly(ssId, pVar, stringOut);
  sprintf(stringOut, "BL%d;", pVar->outBitNum);
  writeOnly(ssId, pVar, stringOut);
 }

 if ((pVar->inBitNum >= 0) && (pVar->inBitNum <= 15)) {
  sprintf(stringOut, "IO%d,0;", pVar->inBitNum);
  writeOnly(ssId, pVar, stringOut);
 }


 absRel = 'A';



 sprintf(stringOut, "AM; SI");
 for (j=0; j<8; j++) {
  if (pVar->moveAxis[j]) strcat(stringOut, "1");
  if (j<(8 -1)) strcat(stringOut, ",");
 }
 strcat(stringOut, ";");
 writeOnly(ssId, pVar, stringOut);


 sprintf(stringOut, "AX; #UR?;");
 writeRead(ssId, pVar, stringOut, stringOut);
 if (pVar->debugLevel > 0) printf("Update rate ='%s'\n", stringOut);
 currUpdateRate = atol(stringOut);

 epicsTimeGetCurrent(&eStartTime);
 getMotorPositions(ssId, pVar, pVar->motorCurrent, pVar->motorCurrentRaw, &(pVar->dtime));
# 1275 "../MAX_trajectoryScan.st"
 epicsTimeGetCurrent(&eStartTime);
 getMotorPositions(ssId, pVar, pVar->motorCurrent, pVar->motorCurrentRaw, &(pVar->dtime));

 for (j=0, firstTask=1; j<8; j++) {
  if (pVar->moveAxis[j]) {
   if (pVar->epicsMotorDir[j] == 0) dir=1; else dir=-1;

   addForRelMove = pVar->motorCurrent[j]*dir / pVar->epicsMotorMres[j];
   if (pVar->debugLevel > 2) printf("addForRelMove=%f\n", addForRelMove);


   if (firstTask && ((pVar->outBitNum >= 0) && (pVar->outBitNum <= 15))) {

    sprintf(stringOut, "AM; VIO[%d]%04x,%04x,%04x;", j+1, onMask, offMask, outMask);
    writeOnly(ssId, pVar, stringOut);
    pulsesEnabled = 1;
   } else {

    sprintf(stringOut, "AM; VIO[%d]0,0,0;", j+1);
    writeOnly(ssId, pVar, stringOut);
    pulsesEnabled = 0;
   }

   sprintf(stringOut, "AM; VID[%d]1;", j+1);
   writeOnly(ssId, pVar, stringOut);


   sprintf(stringOut, "AM; VH[%d]0;", j+1);
   writeOnly(ssId, pVar, stringOut);




   if ((pVar->inBitNum >= 0) && (pVar->inBitNum <= 15)) {

    sprintf(stringOut, "A%c; SW%d;", axis_name[j], pVar->inBitNum);
    writeOnly(ssId, pVar, stringOut);
   }

   for (i=0; i<npoints; i++) {
    if (pVar->acceleration[j][i] > 0) {
     segment_accel = pVar->acceleration[j][i];
     segment_decel = pVar->acceleration[j][i];
    } else {
     segment_accel = -(pVar->acceleration[j][i]);
     segment_decel = -(pVar->acceleration[j][i]);
    }
    if (segment_accel < 1) segment_accel = 1;
    if (segment_accel > 8000000) segment_accel = 8000000;
    if (segment_decel < 1) segment_decel = 1;
    if (segment_decel > 8000000) segment_decel = 8000000;

    segment_v_start = (i==0) ? pVar->velocity[j][0] : pVar->velocity[j][i-1];
    segment_v_end = pVar->velocity[j][i];


    do_split = (segment_v_start>0) != (segment_v_end>0);
    do_split = do_split && (abs(segment_v_start)>2) && (abs(segment_v_end)>2);
    do_split = do_split && (i>0);
    if (do_split) {

     t_v0 = (double)(-segment_v_start) / pVar->acceleration[j][i];

     if ((t_v0 < .005) || (((pVar->realTimeTrajectoryAccelDecel[i] - pVar->realTimeTrajectoryAccelDecel[i-1]) - t_v0) < .005)) {

      if (pVar->debugLevel > 0) printf("declined to split segment at t=%f\n", t_v0);
      do_split = 0;
     } else {
      v1 = 0;
      p1_double = pVar->position[j][i-1] + segment_v_start*t_v0 +
       0.5 * pVar->acceleration[j][i]*t_v0*t_v0;
      p1 = (int)((p1_double)>0 ? (p1_double)+0.5 : (p1_double)-0.5);
      if (pVar->debugLevel > 0) printf("split segment at t=%f, x=%d\n", t_v0, p1);
     }
    }

    segment_v_start = abs(segment_v_start);
    segment_v_end = abs(segment_v_end);

    if (segment_v_start < 1) segment_v_start = 1;
    if (segment_v_start > 4194303) segment_v_start = 4194303;
    if (segment_v_end < 0) segment_v_end = 0;
    if (segment_v_end > 4194303) segment_v_end = 4194303;

    if (pVar->moveMode != 1) {
     p1_double = pVar->position[j][i];
     pVar->position[j][i] = (int)((p1_double + addForRelMove)>0 ? (p1_double + addForRelMove)+0.5 : (p1_double + addForRelMove)-0.5);
    }

    if (do_split) {
     if (firstTask && ((pVar->outBitNum >= 0) && (pVar->outBitNum <= 15))) {

      if (pulsesEnabled) {
       sprintf(stringOut, "AM; VIO[%d]0,0,0;", j+1);
       writeOnly(ssId, pVar, stringOut);
       pulsesEnabled = 0;
      }
     }

     n = sprintf(stringOut, "AM; VA[%d]%d;", j+1, segment_accel);
     n += sprintf(&stringOut[n], "VV[%d]%d,%d;", j+1, segment_v_start, v1);
     n += sprintf(&stringOut[n], "VP[%d]%c", j+1, absRel);
     for (k=0; k<j; k++) {strcat(stringOut, ","); n++;}
     n += sprintf(&(stringOut[n]), "%d", p1);
     for (k=j+1; k<8; k++) {strcat(stringOut, ","); n++;}
     strcat(stringOut, ";");
     writeOnly(ssId, pVar, stringOut);

     if (firstTask && ((pVar->outBitNum >= 0) && (pVar->outBitNum <= 15))) {

      if (!pulsesEnabled) {
       sprintf(stringOut, "AM; VIO[%d]%04x,%04x,%04x;", j+1, onMask, offMask, outMask);
       writeOnly(ssId, pVar, stringOut);
       pulsesEnabled = 1;
      }
     }
     n = sprintf(stringOut, "AM; VA[%d]%d;", j+1, segment_accel);
     if (i < (pVar->npoints)-1) {
      n += sprintf(&stringOut[n], "VV[%d]%d;", j+1, segment_v_end);
     } else {
      n += sprintf(&stringOut[n], "VV[%d]%d,%d;", j+1, 1, segment_v_end);
     }
     n += sprintf(&stringOut[n], "VP[%d]%c", j+1, absRel);
     for (k=0; k<j; k++) {strcat(stringOut, ","); n++;}
     n += sprintf(&(stringOut[n]), "%d", pVar->position[j][i]);
     for (k=j+1; k<8; k++) {strcat(stringOut, ","); n++;}
     strcat(stringOut, ";");
     writeOnly(ssId, pVar, stringOut);
    } else {

     if (firstTask && ((pVar->outBitNum >= 0) && (pVar->outBitNum <= 15))) {
      if (i >= startPulses && i <= endPulses) {

       if (!pulsesEnabled) {
        sprintf(stringOut, "AM; VIO[%d]%04x,%04x,%04x;", j+1, onMask, offMask, outMask);
        writeOnly(ssId, pVar, stringOut);
        pulsesEnabled = 1;
       }
      } else {
       if (pulsesEnabled) {

        sprintf(stringOut, "AM; VIO[%d]0,0,0;", j+1);
        writeOnly(ssId, pVar, stringOut);
        pulsesEnabled = 0;
       }
      }
     }

     n = sprintf(stringOut, "AM; VA[%d]%d;", j+1, segment_accel);
     if (i < (pVar->npoints)-1) {
      n += sprintf(&stringOut[n], "VV[%d]%d;", j+1, segment_v_end);
     } else {
      n += sprintf(&stringOut[n], "VV[%d]%d,%d;", j+1, segment_v_start, segment_v_end);
     }
     n += sprintf(&stringOut[n], "VP[%d]%c", j+1, absRel);
     for (k=0; k<j; k++) {strcat(stringOut, ","); n++;}
     n += sprintf(&(stringOut[n]), "%d", pVar->position[j][i]);
     for (k=j+1; k<8; k++) {strcat(stringOut, ","); n++;}
     strcat(stringOut, ";");
     writeOnly(ssId, pVar, stringOut);
    }
   }
   sprintf(stringOut, "AM; VE[%d];", j+1);
   writeOnly(ssId, pVar, stringOut);
   firstTask = 0;
  }
 }
 return(0);
}

}%
