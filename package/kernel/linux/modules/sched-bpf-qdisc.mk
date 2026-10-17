#
# Copyright (C) 2026 flacon1984
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

define KernelPackage/sched-bpf-qdisc
  SUBMENU:=$(NETWORK_SUPPORT_MENU)
  TITLE:=BPF queuing discipline (sch_bpf / NET_SCH_BPF)
  DEPENDS:=+kmod-sched-core
  KCONFIG:=CONFIG_NET_SCH_BPF
  FILES:=$(LINUX_DIR)/net/sched/sch_bpf.ko
  AUTOLOAD:=$(call AutoProbe,sch_bpf)
endef

define KernelPackage/sched-bpf-qdisc/description
  BPF based queuing discipline (CONFIG_NET_SCH_BPF). Provides sch_bpf.ko.
endef

$(eval $(call KernelPackage,sched-bpf-qdisc))
