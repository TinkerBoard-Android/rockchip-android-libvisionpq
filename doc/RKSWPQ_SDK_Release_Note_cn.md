# RKSWPQ SDK Release Note

<!-- ## coming next version -->

## v0.5.5.3507 Release Note | 2024.06.19
  - [MSSR] 修复FE通路下人脸边界跳变明显问题
  - [MSSR] 修正FE通路帧序跳变时跑挂问题
  - [MSSR] 修复部分变量未初始化问题

## v0.5.4.3493 Release Note | 2024.06.17
  - [MSSR] 修正RK3576人脸增强处理的bug

## v0.5.3.3490 Release Note | 2024.06.17
  - [MSSR] 修改演示水印：显示输入输出的分辨率、帧率，各种开关状态

## v0.5.2.3476 Release Note | 2024.06.11
  - [MSSR] SR模型修改，默认用USM效果，修复文字边缘瑕疵
  - [MSSR] 新加支持1080pNV12输入输出的SR通路
  - [MSSR] 人脸增强通路改为异步，默认走384x384通路

## v0.5.1.3453 Release Note | 2024.06.05
  - [MSSR] Linux平台人脸增强通路集成跑通
  - [MSSR] ProjectorSR通路颜色拖影问题修正

## v0.5.0.3445 Release Note | 2024.06.03
  - [MSSR] MEMC性能优化
  - [MSSR] 增加支持人脸增强通路，接口增加`bEnableFE`参数控制是否打开人脸增强功能

## v0.4.0.3437 Release Note | 2024.05.30
  - [MSSR] 关闭MEMC的SR通路输出场景检测结果数据。
  - [MSSR] 优化720pSR的效果
  - [MSSR] 接口增加MEMC强度参数`nMEMCStrength`

## v0.3.0.3378 Release Note | 2024.05.17
  - [MSSR] 增加支持三套ME金字塔分辨率方案，由api新增参数`nSchemeIdx`指定并传入相应数据
  - [MSSR] 优化540p和720p的SR处理性能，满足30fps输入的SR+MEMC性能要求

## v0.2.1.3349 Release Note | 2024.05.11
  - [MSSR] 输出场景检测结果
  - [MSSR] 优化720pSR性能

## v0.2.0.3333 Release Note | 2024.05.09
  - [ALL] 增加新的接口`rkpq_clear_caches()`，用于清除旧的输入输出缓存buffer
  - [MSSR] 重新打开授权功能
  - [MSSR] 支持前后两帧输入不同的分辨率

## v0.1.2.3280 Release Note | 2024.04.24
  - [ALL] 取消对 vendor_storage 端口的写权限要求，改为只读权限;
  - [ALL] RKNN模型和授权文件的默认读取路径在Android下统一设为: `/vendor/etc/`, 在Linux下统一设为`/etc/`
  - [MSSR] 性能优化; RKNN模型升级到2.0.0b

## v0.1.1.3264 Release Note | 2024.04.22
  - [ALL] 授权功能增加 vendor_storage 验证，授权验证全面开启
  - [ALL] pipeline实时开关模块的功能支持，通过api_config的`bEnableXXX`参数可控制子模块实时开关
  - [ACM] 修正ACM子模块的api_config参数传递不生效问题

## v0.1.0.3210 Release Note | 2024.04.11
  - [DD] 文档检测子模块完成fp16零拷贝适配，性能优化至35fps(on RK3588)
  - [ALL] OpenCL缓存加入版本信息，防止Mali库版本变化后缓存失效造成程序无法正常运行
  - [ALL] **（重要）API大调整，**
    - **增加新的模块，`rkpq_module`枚举名称和对应数值调整**，并划分为3个子类别，每个类别对应的模块如下：
      1. 通用的非AI模块: CVT(暂不支持)/CSC/DCI/ACM/ZME/SHP/MLC(新增，暂不支持)
      2. 通用的AI模块: AI_SR/AI_SD/AI_DM/AI_DFC(新增)/AI_DD(新增)/AI_DE(新增)
      3. 特定优化的混合模块: SHP_ACM/FE(新增)/MSSR(新增)
    - **增加新的图像格式**
      1. 单通道格式: `Y8`；
      2. 双通道格式: `UV88`,`VU88`(暂不支持)；
      3. 三通道紧凑RGB格式`RGB565`/`BGR565`(MSB顺序，即对于`RGB565`来说，高5位为R，低5位为B)
    - **接口调整**
      1. 增加`rkpq_set_inputs()`,`rkpq_set_outputs()`接口，用于支持多输入多输出的模块(MSSR)
      2. 增加`rkpq_set_cache_path()`接口，用于用户自定义缓存路径，具体包含3种：OpenCL缓存文件路径、RKNN模型文件路径、许可文件路径
      3. 增加`rkpq_set_target_platform()`接口(暂不支持)

## v0.0.8.3074_alpha Release Note | 2024.03.04
  - [DD] 增加文档检测(DocDetection, DD)子模块

## v0.0.7.3057 Release Note | 2024.02.28
  - [CSC] CSC子模块增加 R2R 通路，并支持色温调节功能

## v0.0.6.3040 Release Note | 2024.02.23
  - [ALL] 增加非对齐数据导致零拷贝失效情况下的程序鲁棒性
  - [ALL] 增加对不同平台不同版本的OpenCL对齐条件不一致的适配
  - [SR] AISR子模块文字模型效果修正

## v0.0.5.3012 Release Note | 2024.02.04
  - 修正Linux系统下零拷贝功能不支持的问题
  - 增加Linux系统环境变量的读取功能以修改日志等级等一系列属性

## v0.0.4.2986 Release Note | 2024.01.17
  - `rkpq_set_loglevel()`日志等级设置可以不用指定特定的`pq_context`, 支持在调用`pq_init()`之前设置

## v0.0.3.2865 Release Note | 2023.12.01
  - 增加非零拷贝即不带 fd buffer 的支持

## v0.0.2.2829 Release Note | 2023.11.16
  - 恢复 DCI/ACM/DM 模块的支持
  - SR/DM 模块增加了对 ROI 支持
  - ZME 模块增加了对 RGBA 格式图像的缩放支持
  - SR 模块增加了在 RK356X 平台上分辨率从 960x540 -> 1920x1080 的通路支持
  - RKNN 依赖版本提升到 v1.5.2

## v0.0.0.2534 Release Note | 2023.07.21
  - 新的处理框架，支持用户自定义的 pipeline 形式
  - 支持模块: CSC/SD/SR/DM/ZME/SHP
