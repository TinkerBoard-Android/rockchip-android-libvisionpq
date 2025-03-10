#
# Copyright (C) 2018 Fuzhou Rockchip Electronics Co.Ltd.
#
# Modification based on code covered by the Apache License, Version 2.0 (the "License").
# You may not use this software except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS TO YOU ON AN "AS IS" BASIS
# AND ANY AND ALL WARRANTIES AND REPRESENTATIONS WITH RESPECT TO SUCH SOFTWARE, WHETHER EXPRESS,
# IMPLIED, STATUTORY OR OTHERWISE, INCLUDING WITHOUT LIMITATION, ANY IMPLIED WARRANTIES OF TITLE,
# NON-INFRINGEMENT, MERCHANTABILITY, SATISFACTROY QUALITY, ACCURACY OR FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.
#
# IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
# GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Copyright (C) 2015 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
LOCAL_PATH := $(call my-dir)

# ifeq ($(strip $(BOARD_USES_LIBPQ)),true)

## RK3588
ifneq ($(filter rk3588, $(strip $(TARGET_BOARD_PLATFORM))), )
    TARGET_SOC_PLATFORM := rk3588
    USE_LIBSWPQ := true
    USE_LIBHWPQ := false
endif

## RK3576
ifneq ($(filter rk3576, $(strip $(TARGET_BOARD_PLATFORM))), )
    TARGET_SOC_PLATFORM := rk3576
    USE_LIBSWPQ := true
    USE_LIBHWPQ := true
endif

## TODO: RK356X


## define target lib path according to TARGET_SOC_PLATFORM
TARGET_PQ_LIB_PATH := lib/Android/$(TARGET_SOC_PLATFORM)/


## SWPQ lib
ifeq ($(strip $(USE_LIBSWPQ)), true)
    include $(CLEAR_VARS)
    LOCAL_MODULE := librkswpq
    LOCAL_MODULE_CLASS := SHARED_LIBRARIES
    LOCAL_MODULE_SUFFIX := .so

    LOCAL_SHARED_LIBRARIES += \
        librknnrt

    ifneq ($(strip $(TARGET_2ND_ARCH)), )
        LOCAL_MULTILIB := both
        LOCAL_SRC_FILES_$(TARGET_ARCH) := $(TARGET_PQ_LIB_PATH)/$(TARGET_CPU_ABI)/librkswpq.so
        LOCAL_SRC_FILES_$(TARGET_2ND_ARCH) := $(TARGET_PQ_LIB_PATH)/$(TARGET_2ND_CPU_ABI)/librkswpq.so
    else
        LOCAL_SRC_FILES_$(TARGET_ARCH) := $(TARGET_PQ_LIB_PATH)/$(TARGET_CPU_ABI)/librkswpq.so
    endif

    LOCAL_CHECK_ELF_FILES := false
    LOCAL_VENDOR_MODULE := true
    LOCAL_MODULE_SUFFIX := .so
    LOCAL_REQUIRED_MODULES := rkaipq_mssr_model0_EbookSR480to960_rknn162_rk3576.bin
    include $(BUILD_PREBUILT)
endif

## HWPQ lib
ifeq ($(strip $(USE_LIBHWPQ)), true)
    include $(CLEAR_VARS)
    LOCAL_MODULE := librkhwpq
    LOCAL_MODULE_CLASS := SHARED_LIBRARIES
    LOCAL_MODULE_SUFFIX := .so

    ifneq ($(strip $(TARGET_2ND_ARCH)), )
        LOCAL_MULTILIB := both
        LOCAL_SRC_FILES_$(TARGET_ARCH) := $(TARGET_PQ_LIB_PATH)/$(TARGET_CPU_ABI)/librkhwpq.so
        LOCAL_SRC_FILES_$(TARGET_2ND_ARCH) := $(TARGET_PQ_LIB_PATH)/$(TARGET_2ND_CPU_ABI)/librkhwpq.so
    else
        LOCAL_SRC_FILES_$(TARGET_ARCH) := $(TARGET_PQ_LIB_PATH)/$(TARGET_CPU_ABI)/librkhwpq.so
    endif

    LOCAL_CHECK_ELF_FILES := false
    LOCAL_VENDOR_MODULE := true
    LOCAL_MODULE_SUFFIX := .so
    include $(BUILD_PREBUILT)
endif

## RKNN models for AI sub-modules
SOURCE_RKNN_MODEL_PATH := $(LOCAL_PATH)/models/$(TARGET_SOC_PLATFORM)/
TARGET_RKNN_MODEL_PATH := $(TARGET_OUT_VENDOR)/etc/

# BOARD_ENABLE_AIPQ_DFC := true
ifeq ($(BOARD_ENABLE_AIPQ_DFC), true)
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_dfc_*.bin $(TARGET_RKNN_MODEL_PATH))
endif
# BOARD_ENABLE_AIPQ_DM := true
ifeq ($(BOARD_ENABLE_AIPQ_DM), true)
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_dm_*.bin $(TARGET_RKNN_MODEL_PATH))
endif
# BOARD_ENABLE_AIPQ_SDSR := true
ifeq ($(BOARD_ENABLE_AIPQ_SDSR), true)
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_sd_*.bin $(TARGET_RKNN_MODEL_PATH))
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_sr_*.bin $(TARGET_RKNN_MODEL_PATH))
endif
# BOARD_ENABLE_AIPQ_DDDE := true
ifeq ($(BOARD_ENABLE_AIPQ_DDDE), true)
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_dd_*.bin $(TARGET_RKNN_MODEL_PATH))
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_de_*.bin $(TARGET_RKNN_MODEL_PATH))
endif
# BOARD_ENABLE_AIPQ_EBOOK_PRODUCT := true
ifeq ($(BOARD_ENABLE_AIPQ_EBOOK_PRODUCT), true)
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_mssr_model0_EbookSR*.bin $(TARGET_RKNN_MODEL_PATH))
endif
# BOARD_ENABLE_AIPQ_PROJECTOR_PRODUCT := true
ifeq ($(BOARD_ENABLE_AIPQ_PROJECTOR_PRODUCT), true)
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_mssr_model*_IFBlockX*.bin $(TARGET_RKNN_MODEL_PATH))
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_mssr_model*_NaturalSR*.bin $(TARGET_RKNN_MODEL_PATH))
    # $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_mssr_model*_rd*.bin $(TARGET_RKNN_MODEL_PATH))
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_mssr_model*_sd*.bin $(TARGET_RKNN_MODEL_PATH))
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_mssr_model*_std*.bin $(TARGET_RKNN_MODEL_PATH))
    $(shell cp -f $(SOURCE_RKNN_MODEL_PATH)/rkaipq_mssr_model*_f*.bin $(TARGET_RKNN_MODEL_PATH))
endif

# endif
