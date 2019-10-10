# 1 "../xpsSlave.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../xpsSlave.st"
program xpsSlave("name=xpsSlave,P=xxx:,R=xps:slave,IP=192.168.1.11,M=GROUP1.POSITIONER,S=GROUP2")


option +d;

option +r;



# 1 "../seqPVmacros.h" 1
# 11 "../xpsSlave.st" 2
%%#include "XPS_C8_drivers.h"




char* SNLtaskName;
char* ip;
char* master;
char* slave;
%%int xps_socket;
int val;
char* masterRdbk;
double ratioRdbk;



int debug_flag; assign debug_flag to "{P}{R}:debug.VAL" ; monitor debug_flag;

int ok_pv; assign ok_pv to "{P}{R}:ok.VAL" ;
int on_pv; assign on_pv to "{P}{R}:on.VAL" ; monitor on_pv; evflag on_pv_mon; sync on_pv on_pv_mon;
int init_pv; assign init_pv to "{P}{R}:init.VAL" ; monitor init_pv; evflag init_pv_mon; sync init_pv init_pv_mon;
double ratio_pv; assign ratio_pv to "{P}{R}:ratio.VAL" ; monitor ratio_pv;
double ratioRdbk_pv; assign ratioRdbk_pv to "{P}{R}:ratioRdbk.VAL" ;

ss slave_main
{
  state init
  {
    when ()
    {

      ip = macValueGet("IP");
      master = macValueGet("M");
      slave = macValueGet("S");
      SNLtaskName = macValueGet("name");


      %%xps_socket = TCP_ConnectToServer(pVar->ip, 5001, 100.0);

      if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 50, SNLtaskName, 2); printf("init -> update",0,0,0,0); printf("\n"); };

      efClear(init_pv_mon);
      efClear(on_pv_mon);

    } state update
  }

  state update
  {
    when ()
    {

      %%pVar->val = SingleAxisSlaveParametersGet(xps_socket, pVar->slave, pVar->masterRdbk, &pVar->ratioRdbk);
      if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 64, SNLtaskName, 2); printf("update(): val = %i, masterRdbk = %s, ratioRdbk = %f",val,masterRdbk,ratioRdbk,0); printf("\n"); };


      if (val == 0)
      {
        { ok_pv = ( 1 ); pvPut(ok_pv); };
      }
      else
      {
        { ok_pv = ( 0 ); pvPut(ok_pv); };
      }



      { ratioRdbk_pv = ( ratioRdbk ); pvPut(ratioRdbk_pv); };

      if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 80, SNLtaskName, 2); printf("update -> idle",0,0,0,0); printf("\n"); };

    } state idle

  }

  state modeChange
  {
    when ()
    {
      if (on_pv == 1)
      {
        %%pVar->val = SingleAxisSlaveModeEnable(xps_socket, pVar->slave);
        if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 93, SNLtaskName, 2); printf("on_pv == 1",0,0,0,0); printf("\n"); };
      }
      else
      {
        %%pVar->val = SingleAxisSlaveModeDisable(xps_socket, pVar->slave);
        if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 98, SNLtaskName, 2); printf("on_pv != 1",0,0,0,0); printf("\n"); };
      }
      if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 100, SNLtaskName, 2); printf("modeChange -> idle",0,0,0,0); printf("\n"); };
   } state idle

  }


  state reinit
  {
    when ()
    {
      %%pVar->val = SingleAxisSlaveParametersSet(xps_socket, pVar->slave, pVar->master, pVar->ratio_pv);
      if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 111, SNLtaskName, 2); printf("reinit(): val = %i",val,0,0,0); printf("\n"); };


      { init_pv = ( 0 ); pvPut(init_pv); };
      efClear(init_pv_mon);
      if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 116, SNLtaskName, 2); printf("reinit -> update",0,0,0,0); printf("\n"); };

    } state update
  }

  state idle
  {
    when ( efTestAndClear(on_pv_mon) && ok_pv == 1 )
    {

      if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 126, SNLtaskName, 2); printf("idle -> modeChange",0,0,0,0); printf("\n"); };
    } state modeChange

    when ( efTest(init_pv_mon) )
    {

      if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../xpsSlave.st", 132, SNLtaskName, 2); printf("idle -> reinit",0,0,0,0); printf("\n"); };
    } state reinit

  }
}
