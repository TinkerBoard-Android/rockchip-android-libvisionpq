#pragma once
#ifndef __RKHWPQ_UTILS_VDPP_CFG_API_H_
#define __RKHWPQ_UTILS_VDPP_CFG_API_H_

#ifdef __cplusplus
extern "C"
{
#endif
/* Run Mode */
#define RK_HWPQ_UTILS_RUN_MODE_VDPP_CFG     0x40

/* Process Command */
typedef enum{
    RK_HWPQ_UTILS_VDPP_CFG_MIN = 0x100, 
    RK_HWPQ_UTILS_VDPP_CFG_RUN,
    RK_HWPQ_UTILS_VDPP_CFG_MAX, 
} RK_HWPQ_UTILS_VDPP_CFG_CMD;

/* Vdpp Config Define */
typedef struct {
    // dmsr config
    unsigned int dmsr_en;
    unsigned int str_pri_y;
    unsigned int str_sec_y;
    unsigned int dumping_y;
    unsigned int reserve_dmsr[4];

    // es config
    unsigned int es_en;
    unsigned int es_iWgtGain;
    unsigned int reserve_es[4];

    // zme config
    unsigned int zme_dering_en;
    unsigned int reserve_zme[4];

    // hist_cnt config
    unsigned int hist_cnt_en;
    unsigned int hist_csc_range;
    unsigned int reserve_hist_cnt[4];

    // sharp config
    unsigned int shp_en;
    unsigned int peaking_gain;
    unsigned int shp_shoot_ctrl_en;
    unsigned int shp_shoot_ctrl_over;
    unsigned int shp_shoot_ctrl_under;
    unsigned int reserve_shp[4];
} RkHwpqVdppParams;

/* Hwpq base config structure */
typedef struct RkHwpqVdppCfg_t {
    const char* p_vdpp_cfg_file; 
    RkHwpqVdppParams vdpp_params; 
    int reserve0[16];
} RkHwpqVdppCfg;


#ifdef __cplusplus
}
#endif
#endif //__RKHWPQ_UTILS_VDPP_CFG_API_H_