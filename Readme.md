
# 目录
[toc]

**修订记录**

| **日期**   | **版本** | **作者** | **修改说明** |
| ---        | ----     | -------- | ----------- |
| 20230326 | 0.0.1    | sinwel   | 初始版本  |
| 20240411 | 0.0.2    | vance.wu | 修改目录结构等信息  |
| 20240422 | 0.0.3    | vance.wu | 增加有关RKNN模型文件拷贝相关说明  |

---
# 1. 工程介绍
- rockchip vision pq lib 是 rockchip 公司自研的图像处理库，包含了图像处理算法、图像格式转换、图像增强、图像处理框架等功能。
- 算法库支持功能与开发文档见`doc/Rockchip_Developer_Guide_SWPQ_cn.md`

---
# 2. 目录结构
```shell
.
├── Android.mk
├── Readme.md
├── demo                                    ## 集成示例
│   ├── rkpq_demo.cpp                       # 多个独立模块的使用集成示例
│   ├── rkpq_demo_common_pipeline.cpp       # 通用pipeline集成示例
│   └── rkpq_demo_mssr.cpp                  # MSSR 模块使用的集成示例
├── doc                                     ## 文档目录
│   ├── RKSWPQ_SDK_Release_Note_cn.md       # 发布日志
│   └── Rockchip_Developer_Guide_SWPQ_cn.md # 内部开发指南（请勿外传）
├── lib
│   ├── Android
│   │   ├── rk3576                          ## RK3576 Android 平台下的 librkswpq.so 和 librkhwpq.so 库
│   │   │   ├── arm64-v8a
│   │   │   │   ├── librkhwpq.so
│   │   │   │   └── librkswpq.so
│   │   │   ├── armeabi-v7a
│   │   │   │   ├── librkhwpq.so
│   │   │   │   └── librkswpq.so
│   │   │   └── include
│   │   │       ├── rkhwpq_api.h
│   │   │       └── rkpq_api.h
│   │   └── rk3588                          ## RK3588 Android 平台下的 librkswpq.so
│   │       ├── arm64-v8a
│   │       │   └── librkswpq.so
│   │       ├── armeabi-v7a
│   │       │   └── librkswpq.so
│   │       └── include
│   │           └── rkpq_api.h
│   └── Linux                               ## Linux 平台下的库
└── models
    ├── rk3576                              ## RK3576 使用的 RKNN 模型
    └── rk3588                              ## RK3588 使用的 RKNN 模型
```

- lib/Android
  - Android平台下的工程路径对应librkswpq.so/librkhwpq.so库文件
  - `rkpq_api.h`头文件位于该路径下对应rk平台子目录下
- lib/Linux
  - Linux平台下的工程路径对应librkswpq.so/librkhwpq.so库文件
  - `rkpq_api.h`头文件位于该路径下对应rk平台子目录下
- doc
  - 文档路径
- demo
  - 集成示例
- models
  - RKNN模型存放路径，AI相关的模型需要将其对应的模型文件推到默认路径`/vendor/etc/`下
---

# 3. 编译说明

## 有关RKNN 模型文件的拷贝操作
算法库内的 AI 模块的使用需要保证其对应的 RKNN 模型文件存在于`/vendor/etc/`下，编译脚本内内置了多个编译宏开关用于在编译时执行对模型文件的拷贝操作。
上层应用应根据具体需求开启对应的 AI 模块。 本库预设的编译宏开关如下：

| 可供上层开启的宏 | 对应模块 | 对应平台与模型数量 <br> RK3588 - RK3576 - RK356X |
|:--------------- | -------- | ----------------- |
| BOARD_ENABLE_AIPQ_DFC  | DFC | 1 - 0 - 0 |
| BOARD_ENABLE_AIPQ_DM   | DM  | 0 - 0 - 1 |
| BOARD_ENABLE_AIPQ_SDSR | SD+SR | 3 - 0 - 1 |
| BOARD_ENABLE_AIPQ_DDDE | DD+DE | 3 - 3 - 0 |
| BOARD_ENABLE_AIPQ_EBOOK_PRODUCT     | MSSR (电子书产品) | 0 - 2 - 0 |
| BOARD_ENABLE_AIPQ_PROJECTOR_PRODUCT | MSSR (投影产品) | 0 - 12 - 0 |