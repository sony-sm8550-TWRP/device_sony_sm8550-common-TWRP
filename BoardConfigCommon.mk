#
# Copyright 2017 The Android Open Source Project
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
#

# This contains the module build definitions for the hardware-specific
# components for this device.
#
# As much as possible, those components should be built unconditionally,
# with device-specific names to avoid collisions, to avoid device-specific
# bitrot and build breakages. Building a component unconditionally does
# *not* include it on all devices, so it is safe even with hardware-specific
# components.

# SDK
BOARD_SYSTEMSDK_VERSIONS := 31

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a-branchprot
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo385

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a75

# Bootloader
TARGET_NO_BOOTLOADER := false
TARGET_USES_UEFI := true
TARGET_USES_REMOTEPROC := true

# Kernel/Ramdisk
BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS := --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true
BOARD_KERNEL_IMAGE_NAME := kernel
BOARD_RAMDISK_USE_LZ4 := true
TARGET_PREBUILT_KERNEL := $(COMMON_PATH)/prebuilt/$(BOARD_KERNEL_IMAGE_NAME)

# Partition Info
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

TARGET_COPY_OUT_ODM := odm
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_VENDOR_DLKMIMAGE := true
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_BOOTIMAGE_PARTITION_SIZE := 201326592
BOARD_KERNEL-GKI_BOOTIMAGE_PARTITION_SIZE := $(BOARD_BOOTIMAGE_PARTITION_SIZE)
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 201326592
BOARD_USERDATAIMAGE_PARTITION_SIZE := 233871900672
BOARD_PERSISTIMAGE_PARTITION_SIZE := 67108864
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_METADATAIMAGE_PARTITION_SIZE := 16777216
BOARD_DTBOIMG_PARTITION_SIZE := 25165824
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)

# Dynamic/Logical Partitions
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 16936005632 # BOARD_SUPER_PARTITION_SIZE - 4MB
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor vendor_dlkm odm

BOARD_RECOVERYIMAGE_PARTITION_SIZE := 104857600

# Workaround for error copying vendor files to recovery ramdisk
TARGET_COPY_OUT_VENDOR := vendor

# Rules
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_NINJA_USES_ENV_VARS += RTIC_MPGEN

# KEYSTONE(If43215c7f384f24e7adeeabdbbb1790f174b2ec1,b/147756744)
BUILD_BROKEN_NINJA_USES_ENV_VARS += SDCLANG_AE_CONFIG SDCLANG_CONFIG SDCLANG_SA_ENABLE

BUILD_BROKEN_USES_BUILD_HOST_SHARED_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_STATIC_LIBRARY := true
BUILD_BROKEN_USES_BUILD_HOST_EXECUTABLE := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

# Recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hidl.allocator@1.0 \
    android.hidl.memory@1.0 \
    android.hidl.memory.token@1.0 \
    libdmabufheap \
    libhidlmemory \
    libion \
    libnetutils \
    vendor.display.config@1.0 \
    vendor.display.config@2.0 \
    libdebuggerd_client
TARGET_RECOVERY_FSTAB := $(COMMON_PATH)/recovery.fstab

# Use mke2fs to create ext4 images
TARGET_USES_MKE2FS := true

# AVB
BOARD_AVB_ENABLE := true
BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA4096
BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1

# Encryption
BOARD_USES_METADATA_PARTITION := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Extras
TARGET_SYSTEM_PROP += $(COMMON_PATH)/system.prop
TARGET_VENDOR_PROP += $(COMMON_PATH)/vendor.prop

# TWRP specific build flags
TARGET_RECOVERY_QCOM_RTC_FIX := true
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TW_THEME := portrait_hdpi
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone35/temp"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS := 2047
TW_EXCLUDE_APEX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_CRYPTO := true
TW_NO_EXFAT_FUSE := true
TW_INCLUDE_RESETPROP := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true
TW_OVERRIDE_SYSTEM_PROPS := \
    "ro.build.product;ro.build.fingerprint=ro.vendor.build.fingerprint;ro.build.version.incremental"
TW_OVERRIDE_PROPS_ADDITIONAL_PARTITIONS := vendor
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.allocator@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.memory@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hidl.memory.token@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libdmabufheap.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libhidlmemory.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libnetutils.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libdebuggerd_client.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so
TW_LOAD_VENDOR_MODULES := "qcom_wdt_core.ko gh_virt_wdt.ko qcom_cpu_vendor_hooks.ko clk-rpmh.ko gcc-kalama.ko icc-rpmh.ko camcc-kalama.ko qcom_ipcc.ko qcom-pdc.ko thermal_minidump.ko qcom_tsens.ko rpmh-regulator.ko bwmon.ko qcom-cpufreq-hw.ko sched-walt.ko thermal_pause.ko cpu_hotplug.ko clk-dummy.ko clk-qcom.ko cmd-db.ko cqhci.ko crypto-qti-common.ko crypto-qti-hwkm.ko dcc_v2.ko dcvs_fp.ko dispcc-kalama.ko tcsrcc-kalama.ko videocc-kalama.ko gdsc-regulator.ko gh_arm_drv.ko gh_ctrl.ko gh_dbl.ko gh_msgq.ko gh_rm_drv.ko gunyah.ko mdt_loader.ko hwkm.ko icc-bcm-voter.ko iommu-logger.ko llcc-qcom.ko mem-hooks.ko mem_buf_dev.ko mem_buf_msgq.ko mem_buf.ko memory_dump_v2.ko minidump.ko msm_dma_iommu_mapping.ko pinctrl-kalama.ko qnoc-kalama.ko nvmem_qcom-spmi-sdam.ko phy-qcom-ufs.ko phy-qcom-ufs-qmp-v4-kalama.ko phy-qcom-ufs-qrbtc-sdm845.ko pinctrl-msm.ko pinctrl-somc.ko proxy-consumer.ko qcom-dcvs.ko qcom-dload-mode.ko qcom_dma_heaps.ko qcom_hwspinlock.ko debug_symbol.ko qcom_logbuf_vh.ko qcom_iommu_util.ko qcom_llcc_pmu.ko qcom-pmu-lib.ko pmu_vendor.ko pmu_scmi.ko qcom-spmi-pmic.ko spmi-pmic-arb.ko qcom-reboot-reason.ko qcom_rpmh.ko qcom-scm.ko qnoc-qos.ko qrtr.ko regmap-spmi.ko rtc-pm8xxx.ko secure_buffer.ko smem.ko socinfo.ko stub-regulator.ko qcom_aoss.ko msm_qmp.ko tmecom-intf.ko ufs_qcom.ko ufshcd-crypto-qti.ko arm_smmu.ko sdhci-msm.ko qcom_rimps.ko c1dcvs_vendor.ko c1dcvs_scmi.ko bcl_pmic5.ko nvme-core.ko nvme.ko wakeup_irq_debug.ko msm_sysstats.ko msm_show_resume_irq.ko mhi.ko mhi_cntrl_qcom.ko mhi_dev_uci.ko mhi_dev_netdev.ko mhi_dev_dtr.ko mhi_dev_satellite.ko phy-qcom-ufs-qmp-v4-waipio.ko phy-qcom-ufs-qmp-v4.ko phy-qcom-ufs-qmp-v4-khaje.ko pinctrl-spmi-gpio.ko pinctrl-spmi-mpp.ko pinctrl-somc-pmic.ko pwm-qti-lpg.ko pci-msm-drv.ko debugcc-kalama.ko gpucc-kalama.ko bam_dma.ko msm_gpi.ko pdr_interface.ko qmi_helpers.ko heap_mem_ext_v01.ko msm_memshare.ko smp2p.ko smp2p_sleepstate.ko qsee_ipc_irq_bridge.ko glink_probe.ko glink_pkt.ko pmic_glink.ko altmode-glink.ko soc_sleep_stats.ko cdsprm.ko sysmon_subsystem_stats.ko subsystem_sleep_stats.ko adsp_sleepmon.ko eud.ko microdump_collector.ko llcc_perfmon.ko cdsp-loader.ko pmic-pon-log.ko boot_stats.ko rq_stats.ko core_hang_detect.ko usb_bam.ko memlat.ko memlat_scmi.ko qcom_ramdump.ko panel_event_notifier.ko dmesg_dumper.ko sys_pm_vx.ko qdss_bridge.ko fsa4480-i2c.ko msm_show_epoch.ko gh_tlmm_vm_mem_access.ko sps_drv.ko spss_utils.ko spcom.ko msm_performance.ko qcom_va_minidump.ko qbt_handler.ko hung_task_enh.ko qti-fixed-regulator.ko qti-ocp-notifier.ko hvc_gunyah.ko msm_geni_serial.ko frpc-adsprpc.ko rdbg.ko lt9611uxc.ko qseecom_proxy.ko sg.ko spi-msm-geni.ko smsc.ko smsc75xx.ko smsc95xx.ko msm_sharedmem.ko phy-generic.ko phy-qcom-emu.ko phy-msm-ssusb-qmp.ko phy-msm-snps-eusb2.ko phy-msm-m31-eusb2.ko dwc3-msm.ko ehset.ko usb_f_cdev.ko usb_f_ccid.ko usb_f_qdss.ko usb_f_gsi.ko usb_f_diag.ko ucsi_glink.ko usbmon.ko repeater.ko repeater-qti-pmic-eusb2.ko repeater-i2c-eusb2.ko redriver.ko pm8941-pwrkey.ko i2c-msm-geni.ko i3c-master-msm-geni.ko qcom_ipc_lite.ko synx-driver.ko qcom-pon.ko reboot-mode.ko qti_battery_charger.ko qcom-spmi-temp-alarm.ko bcl_soc.ko cpu_voltage_cooling.ko ddr_cdev.ko max31760_fan.ko msm_lmh_dcvs.ko policy_engine.ko qti_qmi_cdev.ko qti_qmi_sensor_v2.ko qti_cpufreq_cdev.ko qti_devfreq_cdev.ko qti_userspace_cdev.ko sdpm_clk.ko qcom_edac.ko qcom_lpm.ko mmc_log_probes.ko leds-qti-flash.ko leds-qti-tri-led.ko memlat_vendor.ko ipa_fmwk.ko qcom_pil_info.ko rproc_qcom_common.ko qcom_q6v5.ko qcom_q6v5_pas.ko qcom_spss.ko qcom_esoc.ko qcom_sysmon.ko qcom_glink.ko qcom_glink_smem.ko qcom_glink_spss.ko qcom_smd.ko gh_irq_lend.ko gh_mem_notifier.ko qcom-spmi-adc5-gen3.ko qcom-vadc-common.ko nvmem_qfprom.ko slimbus.ko slim-qcom-ngd-ctrl.ko stm_core.ko stm_p_basic.ko stm_p_ost.ko stm_console.ko stm_ftrace.ko snd-usb-audio-qmi.ko snd-soc-hdmi-codec.ko cfg80211.ko mac80211.ko qrtr-smd.ko qrtr-mhi.ko qrtr-gunyah.ko qca_cld3_kiwi_v2.ko cnss2.ko cnss_plat_ipc_qmi_svc.ko wlan_firmware_service.ko cnss_nl.ko cnss_prealloc.ko cnss_utils.ko q6_notifier_dlkm.ko spf_core_dlkm.ko audpkt_ion_dlkm.ko gpr_dlkm.ko audio_pkt_dlkm.ko q6_dlkm.ko adsp_loader_dlkm.ko audio_prm_dlkm.ko q6_pdr_dlkm.ko pinctrl_lpi_dlkm.ko swr_dlkm.ko swr_ctrl_dlkm.ko snd_event_dlkm.ko wcd_core_dlkm.ko mbhc_dlkm.ko wcd9xxx_dlkm.ko stub_dlkm.ko machine_dlkm.ko swr_dmic_dlkm.ko swr_haptics_dlkm.ko hdmi_dlkm.ko lpass_cdc_wsa2_macro_dlkm.ko lpass_cdc_wsa_macro_dlkm.ko lpass_cdc_va_macro_dlkm.ko lpass_cdc_rx_macro_dlkm.ko lpass_cdc_tx_macro_dlkm.ko lpass_cdc_dlkm.ko wsa884x_dlkm.ko wsa883x_dlkm.ko wcd938x_dlkm.ko wcd938x_slave_dlkm.ko tz_log_dlkm.ko qcedev-mod_dlkm.ko qcrypto-msm_dlkm.ko qce50_dlkm.ko hdcp_qseecom_dlkm.ko qrng_dlkm.ko smcinvoke_dlkm.ko cirrus_wm_adsp.ko cirrus_cs35l45.ko somc_battchg_ext.ko et603-int.ko cirrus_cs40l2x.ko cirrus_cs40l2x_codec.ko lxs_touchscreen.ko btpower.ko bt_fm_slim.ko radio-i2c-rtc6226-qca.ko gsim.ko ipam.ko ipanetm.ko rndisipam.ko ipa_clientsm.ko rmnet_core.ko rmnet_ctl.ko rmnet_offload.ko rmnet_perf_tether.ko rmnet_perf.ko rmnet_shs.ko rmnet_aps.ko rmnet_sch.ko rmnet_wlan.ko msm_drm.ko msm-eva.ko msm_ext_display.ko sync_fence.ko msm_hw_fence.ko msm-mmrm.ko nxp-nci.ko msm_video.ko slg51000-regulator.ko msm_kgsl.ko"
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI := true

# TWRP Debug Flags
#TWRP_EVENT_LOGGING := true
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true
TARGET_RECOVERY_DEVICE_MODULES += debuggerd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/debuggerd
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/strace
#TARGET_RECOVERY_DEVICE_MODULES += twrpdec
#RECOVERY_BINARY_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/twrpdec

#
# For local builds only
#
# TWRP zip installer
ifneq ($(wildcard bootable/recovery/installer/.),)
    USE_RECOVERY_INSTALLER := true
    RECOVERY_INSTALLER_PATH := bootable/recovery/installer
endif
# end local build flags
#
