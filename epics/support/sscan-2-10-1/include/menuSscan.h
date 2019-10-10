#ifndef INCsscanPAUSH
#define INCsscanPAUSH
typedef enum {
	sscanPAUS_Go,
	sscanPAUS_Pause
}sscanPAUS;
#endif /*INCsscanPAUSH*/
#ifndef INCsscanPASMH
#define INCsscanPASMH
typedef enum {
	sscanPASM_Stay,
	sscanPASM_Start_Pos,
	sscanPASM_Prior_Pos,
	sscanPASM_Peak_Pos,
	sscanPASM_Valley_Pos,
	sscanPASM_RisingEdge_Pos,
	sscanPASM_FallingEdge_Pos,
	sscanPASM_COM
}sscanPASM;
#endif /*INCsscanPASMH*/
#ifndef INCsscanP1SMH
#define INCsscanP1SMH
typedef enum {
	sscanP1SM_Linear,
	sscanP1SM_Table,
	sscanP1SM_On_The_Fly
}sscanP1SM;
#endif /*INCsscanP1SMH*/
#ifndef INCsscanP1NVH
#define INCsscanP1NVH
typedef enum {
	sscanP1NV_PV_OK,
	sscanP1NV_No_PV,
	sscanP1NV_PV_NoRead,
	sscanP1NV_PV_xxx,
	sscanP1NV_PV_NoWrite,
	sscanP1NV_PV_yyy,
	sscanP1NV_PV_NC
}sscanP1NV;
#endif /*INCsscanP1NVH*/
#ifndef INCsscanP1ARH
#define INCsscanP1ARH
typedef enum {
	sscanP1AR_Absolute,
	sscanP1AR_Relative
}sscanP1AR;
#endif /*INCsscanP1ARH*/
#ifndef INCsscanNOYESH
#define INCsscanNOYESH
typedef enum {
	sscanNOYES_NO,
	sscanNOYES_YES
}sscanNOYES;
#endif /*INCsscanNOYESH*/
#ifndef INCsscanLINKWAITH
#define INCsscanLINKWAITH
typedef enum {
	sscanLINKWAIT_YES,
	sscanLINKWAIT_NO
}sscanLINKWAIT;
#endif /*INCsscanLINKWAITH*/
#ifndef INCsscanFPTSH
#define INCsscanFPTSH
typedef enum {
	sscanFPTS_No,
	sscanFPTS_Freeze
}sscanFPTS;
#endif /*INCsscanFPTSH*/
#ifndef INCsscanFFOH
#define INCsscanFFOH
typedef enum {
	sscanFFO_Use_F_Flags,
	sscanFFO_Override
}sscanFFO;
#endif /*INCsscanFFOH*/
#ifndef INCsscanFAZEH
#define INCsscanFAZEH
typedef enum {
	sscanFAZE_IDLE,
	sscanFAZE_INIT_SCAN,
	sscanFAZE_BEFORE_SCAN,
	sscanFAZE_BEFORE_SCAN_WAIT,
	sscanFAZE_MOVE_MOTORS,
	sscanFAZE_CHECK_MOTORS,
	sscanFAZE_TRIG_DETCTRS,
	sscanFAZE_READ_DETCTRS,
	sscanFAZE_RETRACE_MOVE,
	sscanFAZE_RETRACE_WAIT,
	sscanFAZE_AFTER_SCAN_DO,
	sscanFAZE_AFTER_SCAN_WAIT,
	sscanFAZE_SCAN_DONE,
	sscanFAZE_SCAN_PENDING,
	sscanFAZE_PREVIEW,
	sscanFAZE_RECORD_SCALAR_DATA
}sscanFAZE;
#endif /*INCsscanFAZEH*/
#ifndef INCsscanDSTATEH
#define INCsscanDSTATEH
typedef enum {
	sscanDSTATE_UNPACKED,
	sscanDSTATE_TRIG_ARRAY_READ,
	sscanDSTATE_ARRAY_READ_WAIT,
	sscanDSTATE_ARRAY_GET_CALLBACK_WAIT,
	sscanDSTATE_RECORD_ARRAY_DATA,
	sscanDSTATE_SAVE_DATA_WAIT,
	sscanDSTATE_PACKED,
	sscanDSTATE_POSTED
}sscanDSTATE;
#endif /*INCsscanDSTATEH*/
#ifndef INCsscanCMNDH
#define INCsscanCMNDH
typedef enum {
	sscanCMND_CLEAR_MSG,
	sscanCMND_CHECK_LIMITS,
	sscanCMND_PREVIEW_SCAN,
	sscanCMND_CLEAR_ALL_PVS,
	sscanCMND_CLEAR_POS_PVS_ETC,
	sscanCMND_CLEAR_POS_PVS,
	sscanCMND_CLEAR_POS_RDBK_PVS_ETC,
	sscanCMND_CLEAR_POS_RDBK_PVS
}sscanCMND;
#endif /*INCsscanCMNDH*/
#ifndef INCsscanACQTH
#define INCsscanACQTH
typedef enum {
	sscanACQT_SCALAR,
	sscanACQT_1D_ARRAY
}sscanACQT;
#endif /*INCsscanACQTH*/
#ifndef INCsscanACQMH
#define INCsscanACQMH
typedef enum {
	sscanACQM_NORMAL,
	sscanACQM_ACC,
	sscanACQM_ADD
}sscanACQM;
#endif /*INCsscanACQMH*/
