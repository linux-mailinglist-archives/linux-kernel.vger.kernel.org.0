Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E8CBC62A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 13:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504534AbfIXLFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Sep 2019 07:05:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:46564 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504522AbfIXLFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:05:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 04:05:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="190989099"
Received: from pktinlab.iind.intel.com ([10.66.253.121])
  by orsmga003.jf.intel.com with ESMTP; 24 Sep 2019 04:04:59 -0700
From:   Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
To:     pankaj.bharadiya@gmail.com, andriy.shevchenko@linux.intel.com,
        kernel-hardening@lists.openwall.com, keescook@chromium.org,
        akpm@linux-foundation.org, mayhs11saini@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     pankaj.laxminarayan.bharadiya@intel.com
Subject: [PATCH 0/5] Add and use sizeof_member macro to bring uniformity
Date:   Tue, 24 Sep 2019 16:28:34 +0530
Message-Id: <20190924105839.110713-1-pankaj.laxminarayan.bharadiya@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This topic has been discussed on the kernel hardening mailing list [1]
few months back. Thanks to Shyam for initiating work on this.

Its been concluded on how the patch series should be but there was
no further progress and this work is still pending (Pardon me if I 
missed something here).

At present, we have 3 different macros which serve the same purpose
of finding the size of a member of a structure:
  - SIZEOF_FIELD
  - FIELD_SIZEOF
  - sizeof_field

To bring uniformity in entire kernel source tree, this patch series -
  - adds the new sizeof_member macro
  - does scripted replacement of above 3 macros where used with newly
    introduced sizeof_member macro
  - removes definitions of SIZEOF_FIELD, FIELD_SIZEOF, sizeof_field

This series aims to fix the issue based on given comments in [1].

[1] Link: https://www.openwall.com/lists/kernel-hardening/2019/07/02/2

Pankaj Bharadiya (5):
  linux/kernel.h: Add sizeof_member macro
  treewide: Use sizeof_member macro
  MIPS: OCTEON: use sizeof_member macro instead of SIZEOF_FIELD
  linux/kernel.h: Remove FIELD_SIZEOF macro
  stddef.h: Remove sizeof_field macro

 Documentation/process/coding-style.rst        |   2 +-
 .../it_IT/process/coding-style.rst            |   2 +-
 .../zh_CN/process/coding-style.rst            |   2 +-
 arch/arc/kernel/unwind.c                      |   6 +-
 arch/arm64/include/asm/processor.h            |  10 +-
 .../cavium-octeon/executive/cvmx-bootmem.c    |   9 +-
 arch/powerpc/net/bpf_jit32.h                  |   4 +-
 arch/powerpc/net/bpf_jit_comp.c               |  16 +-
 arch/sparc/net/bpf_jit_comp_32.c              |   8 +-
 arch/x86/kernel/fpu/xstate.c                  |   2 +-
 block/blk-core.c                              |   4 +-
 crypto/adiantum.c                             |   4 +-
 drivers/firmware/efi/efi.c                    |   2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c          |   2 +-
 drivers/infiniband/hw/hfi1/sdma.c             |   2 +-
 drivers/infiniband/hw/hfi1/verbs.h            |   4 +-
 .../ulp/opa_vnic/opa_vnic_ethtool.c           |   2 +-
 drivers/input/keyboard/applespi.c             |   2 +-
 drivers/md/raid5-ppl.c                        |   2 +-
 drivers/media/platform/omap3isp/isppreview.c  |  24 +--
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   4 +-
 .../ethernet/cavium/liquidio/octeon_console.c |  16 +-
 .../net/ethernet/emulex/benet/be_ethtool.c    |   2 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c |   2 +-
 .../net/ethernet/huawei/hinic/hinic_ethtool.c |   8 +-
 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  |   2 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   2 +-
 .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |   2 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  10 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |   4 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |   4 +-
 .../net/ethernet/intel/ixgb/ixgb_ethtool.c    |   4 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   4 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c    |   4 +-
 .../net/ethernet/mellanox/mlx4/en_ethtool.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/fpga/ipsec.c  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   4 +-
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    |   4 +-
 .../ethernet/mellanox/mlxsw/spectrum_ptp.c    |   2 +-
 drivers/net/ethernet/netronome/nfp/bpf/jit.c  |  10 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c |   2 +-
 .../net/ethernet/netronome/nfp/bpf/offload.c  |   2 +-
 .../net/ethernet/netronome/nfp/flower/main.h  |   2 +-
 .../oki-semi/pch_gbe/pch_gbe_ethtool.c        |   2 +-
 drivers/net/ethernet/qlogic/qede/qede.h       |   2 +-
 .../ethernet/qlogic/qlcnic/qlcnic_ethtool.c   |   2 +-
 .../net/ethernet/qlogic/qlge/qlge_ethtool.c   |   2 +-
 .../ethernet/samsung/sxgbe/sxgbe_ethtool.c    |   2 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |   4 +-
 drivers/net/ethernet/ti/cpsw_ethtool.c        |   6 +-
 drivers/net/ethernet/ti/netcp_ethss.c         |  32 ++--
 drivers/net/fjes/fjes_ethtool.c               |   2 +-
 drivers/net/geneve.c                          |   2 +-
 drivers/net/hyperv/netvsc_drv.c               |   2 +-
 drivers/net/usb/sierra_net.c                  |   2 +-
 drivers/net/usb/usbnet.c                      |   2 +-
 drivers/net/vxlan.c                           |   4 +-
 .../net/wireless/marvell/libertas/debugfs.c   |   2 +-
 drivers/net/wireless/marvell/mwifiex/util.h   |   4 +-
 drivers/s390/net/qeth_core_mpc.h              |  10 +-
 drivers/scsi/aacraid/aachba.c                 |   4 +-
 drivers/scsi/be2iscsi/be_cmds.h               |   2 +-
 drivers/scsi/cxgbi/libcxgbi.c                 |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c         |   6 +-
 .../staging/media/davinci_vpfe/dm365_ipipe.c  |  36 ++---
 drivers/target/iscsi/cxgbit/cxgbit_main.c     |   2 +-
 drivers/usb/atm/usbatm.c                      |   2 +-
 drivers/usb/gadget/function/f_fs.c            |   2 +-
 fs/befs/linuxvfs.c                            |   2 +-
 fs/ext2/super.c                               |   2 +-
 fs/ext4/super.c                               |   2 +-
 fs/freevxfs/vxfs_super.c                      |   2 +-
 fs/orangefs/super.c                           |   2 +-
 fs/ufs/super.c                                |   2 +-
 include/linux/filter.h                        |  12 +-
 include/linux/kernel.h                        |  12 +-
 include/linux/kvm_host.h                      |   2 +-
 include/linux/phy_led_triggers.h              |   2 +-
 include/linux/slab.h                          |   2 +-
 include/linux/stddef.h                        |  10 +-
 include/net/garp.h                            |   2 +-
 include/net/ip_tunnels.h                      |   6 +-
 include/net/mrp.h                             |   2 +-
 include/net/netfilter/nf_conntrack_helper.h   |   2 +-
 include/net/netfilter/nf_tables_core.h        |   2 +-
 include/net/sock.h                            |   2 +-
 ipc/util.c                                    |   2 +-
 kernel/bpf/cgroup.c                           |   2 +-
 kernel/bpf/local_storage.c                    |   4 +-
 kernel/fork.c                                 |   2 +-
 kernel/signal.c                               |  12 +-
 kernel/utsname.c                              |   2 +-
 net/802/mrp.c                                 |   6 +-
 net/batman-adv/main.c                         |   2 +-
 net/bpf/test_run.c                            |   4 +-
 net/bridge/br.c                               |   2 +-
 net/caif/caif_socket.c                        |   2 +-
 net/core/dev.c                                |   2 +-
 net/core/filter.c                             | 140 +++++++++---------
 net/core/flow_dissector.c                     |  10 +-
 net/core/skbuff.c                             |   2 +-
 net/core/xdp.c                                |   4 +-
 net/dccp/proto.c                              |   2 +-
 net/ipv4/ip_gre.c                             |   4 +-
 net/ipv4/ip_vti.c                             |   4 +-
 net/ipv4/raw.c                                |   2 +-
 net/ipv4/tcp.c                                |   2 +-
 net/ipv6/ip6_gre.c                            |   4 +-
 net/ipv6/raw.c                                |   2 +-
 net/iucv/af_iucv.c                            |   2 +-
 net/netfilter/nf_tables_api.c                 |   4 +-
 net/netfilter/nfnetlink_cthelper.c            |   2 +-
 net/netfilter/nft_ct.c                        |  12 +-
 net/netfilter/nft_masq.c                      |   2 +-
 net/netfilter/nft_nat.c                       |   6 +-
 net/netfilter/nft_redir.c                     |   2 +-
 net/netfilter/nft_tproxy.c                    |   4 +-
 net/netfilter/xt_RATEEST.c                    |   2 +-
 net/netlink/af_netlink.c                      |   2 +-
 net/openvswitch/datapath.c                    |   2 +-
 net/openvswitch/flow.h                        |   4 +-
 net/rxrpc/af_rxrpc.c                          |   2 +-
 net/sched/act_ct.c                            |   4 +-
 net/sched/cls_flower.c                        |   2 +-
 net/sctp/socket.c                             |   4 +-
 net/unix/af_unix.c                            |   2 +-
 security/integrity/ima/ima_policy.c           |   4 +-
 sound/soc/codecs/hdmi-codec.c                 |   2 +-
 virt/kvm/kvm_main.c                           |   2 +-
 131 files changed, 345 insertions(+), 360 deletions(-)

-- 
2.17.1

