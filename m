Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0AED9FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2019 08:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfKDHjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Nov 2019 02:39:08 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:35022 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:39:08 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id Mjet2100D5USYZQ01jetgN; Mon, 04 Nov 2019 08:38:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iRWwv-0000ze-SU
        for linux-kernel@vger.kernel.org; Mon, 04 Nov 2019 08:38:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iRWwv-0004uJ-PT
        for linux-kernel@vger.kernel.org; Mon, 04 Nov 2019 08:38:53 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.4-rc6
Date:   Mon,  4 Nov 2019 08:38:53 +0100
Message-Id: <20191104073853.18820-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.4-rc6[1] compared to v5.3[2].

Summarized:
  - build errors: +9/-3
  - build warnings: +148/-138

JFYI, when comparing v5.4-rc6[1] to v5.4-rc5[3], the summaries are:
  - build errors: +0/-2
  - build warnings: +74/-94

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a99d8080aaf358d5d23581244e5da23b35e340b9/ (232 out of 242 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4d856f72c10ecb060868ed10ff1b1453943fc6c8/ (all 242 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d6d5df1db6e9d7f8f76d2911707f7d5877251b02/ (232 out of 242 configs)


*** ERRORS ***

9 error regressions:
  + /kisskb/src/drivers/staging/octeon/ethernet-defines.h: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function):  => 30:38
  + /kisskb/src/drivers/staging/octeon/ethernet-defines.h: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function); did you mean 'CONFIG_MDIO_OCTEON_MODULE'?:  => 30:38
  + /kisskb/src/drivers/staging/octeon/ethernet-rx.c: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function):  => 190:6
  + /kisskb/src/drivers/staging/octeon/ethernet-rx.c: error: 'OCTEON_IRQ_WORKQ0' undeclared (first use in this function):  => 472:25
  + /kisskb/src/drivers/staging/octeon/ethernet-rx.c: error: 'OCTEON_IRQ_WORKQ0' undeclared (first use in this function); did you mean 'OCTEON_IS_MODEL'?:  => 472:25
  + error: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!:  => N/A
  + error: c2p_iplan2.c: undefined reference to `c2p_unsupported':  => .text+0x150), .text+0xc4)
  + error: c2p_planar.c: undefined reference to `c2p_unsupported':  => .text+0xd6), .text+0x1dc)
  + error: page_alloc.c: undefined reference to `node_reclaim_distance':  => .text+0x3180), .text+0x3148)

3 error improvements:
  - /kisskb/src/mm/hmm.c: error: implicit declaration of function 'pud_pfn' [-Werror=implicit-function-declaration]: 753:3, 753:9 => 
  - /kisskb/src/mm/hmm.c: error: implicit declaration of function 'pud_pfn'; did you mean 'pte_pfn'? [-Werror=implicit-function-declaration]: 753:9 => 
  - error: "can_do_mlock" [drivers/infiniband/sw/siw/siw.ko] undefined!: N/A => 


*** WARNINGS ***

148 warning regressions:
  + /kisskb/src/arch/mips/include/asm/octeon/cvmx.h: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 282:17, 299:23
  + /kisskb/src/drivers/android/binderfs.c: warning: (near initialization for 'device_info.name') [-Wmissing-braces]:  => 657:9
  + /kisskb/src/drivers/android/binderfs.c: warning: missing braces around initializer [-Wmissing-braces]:  => 657:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/renoir_ppt.c: warning: (near initialization for 'metrics.ClockFrequency') [-Wmissing-braces]:  => 186:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../powerplay/renoir_ppt.c: warning: missing braces around initializer [-Wmissing-braces]:  => 186:2
  + /kisskb/src/drivers/md/dm-writecache.c: warning: 'g' may be used uninitialized in this function [-Wuninitialized]:  => 1613:18
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 302:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1232 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 302:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1416 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 302:1
  + /kisskb/src/drivers/net/phy/mdio-cavium.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 47:2, 21:16, 131:2, 86:2, 39:2, 138:16, 54:16, 24:2, 125:2, 93:16
  + /kisskb/src/drivers/net/phy/mdio-cavium.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 113:48, 114:37
  + /kisskb/src/drivers/net/phy/mdio-octeon.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 48:3
  + /kisskb/src/drivers/net/phy/mdio-octeon.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 56:2, 91:2, 77:2
  + /kisskb/src/drivers/parisc/dino.c: warning: 'pci_dev_is_behind_card_dino' defined but not used [-Wunused-function]:  => 160:12
  + /kisskb/src/drivers/staging/octeon/ethernet-mem.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 123:18
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.35' uses dynamic stack allocation [enabled by default]:  => 498:1
  + /kisskb/src/drivers/usb/usbip/stub_rx.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 573:5
  + /kisskb/src/drivers/video/fbdev/sa1100fb.c: warning: 'sa1100fb_min_dma_period' defined but not used [-Wunused-function]:  => 975:21
  + /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1180 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 410:1
  + /kisskb/src/fs/splice.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]:  => 1394:8, 1368:8
  + /kisskb/src/kernel/kexec_file.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 1324:19, 1307:19
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U   0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 500>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 640>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2280>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U36e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4960>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U60a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U86e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U93c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua820>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uab40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubf00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud960>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uee60>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf6e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/lib/rhashtable.c: warning: 'next' may be used uninitialized in this function [-Wuninitialized]:  => 259:20
  + /kisskb/src/mm/memcontrol.c: warning: 'mem_cgroup_id_get_many' defined but not used [-Wunused-function]:  => 4929:13
  + /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]: 2189:42 => 1616:17, 2189:42
  + /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1480 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2905:1
  + /kisskb/src/net/sunrpc/xprtsock.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 2610:16
  + /kisskb/src/net/wireless/nl80211.c: warning: 'rdev' may be used uninitialized in this function [-Wuninitialized]:  => 13108:21
  + /kisskb/src/net/wireless/nl80211.c: warning: 'wdev' may be used uninitialized in this function [-Wuninitialized]:  => 13138:33
  + /kisskb/src/sound/soc/fsl/fsl_ssi.c: warning: 'baudrate' may be used uninitialized in this function [-Wuninitialized]:  => 769:7
  + /kisskb/src/sound/soc/soc-pcm.c: warning: unused variable 'name' [-Wunused-variable]:  => 1149:8
  + warning: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL:  => N/A
  + warning: 12 bad relocations:  => N/A
  + warning: 140 bad relocations:  => N/A
  + warning: You need at least binutils >= 2.19 to build a CONFIG_RELOCATABLE kernel:  => N/A
  + warning: arch/powerpc/oprofile/oprofile.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.:  => N/A
  + warning: vmlinux.o(.text+0x2e1c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x2fc8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x31d4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x31dc): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x31e4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x33c8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x3774): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x39c8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x6ee98): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x114): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_printf():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x160): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_printf():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x180): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.call_prom():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x1b0): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_getprop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x1c8): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_panic():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2aec): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2af0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2cf4): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2cf8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2d18): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2f20): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3cdc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3cec): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3cf0): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3d00): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3d08): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3d1c): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3f8c): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3f9c): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3fb8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x538): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x590): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x5f0): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x610): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x6dc): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x6e4): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x720): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x75c): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x77c): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7ac): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7b8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7bc): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7c0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x7c4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x804): Section mismatch in reference from the function mmp2_add_sdhost() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x810): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh0:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x814): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x818): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x81c): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x864): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x870): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x874): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x878): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x87c): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8c4): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8d0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8d4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8d8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x8dc): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x984): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A

138 warning improvements:
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined: 261:0, 261 => 261
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined: 262, 262:0 => 262
  - /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]: 182:1 => 
  - /kisskb/src/arch/s390/include/asm/uaccess.h: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]: 143:2, 113:2 => 
  - /kisskb/src/drivers/crypto/ccree/cc_cipher.c: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 465:1 => 
  - /kisskb/src/drivers/crypto/talitos.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 3142:4 => 
  - /kisskb/src/drivers/dma/imx-dma.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 542:6 => 
  - /kisskb/src/drivers/gpu/drm/arm/malidp_hw.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 387:8, 1311:4 => 
  - /kisskb/src/drivers/media/usb/dvb-usb/pctv452e.c: warning: value computed is not used [-Wunused-value]: 918:2 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1288 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 127:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 127:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1312 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 127:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 294:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 294:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1368 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 294:1 => 
  - /kisskb/src/drivers/pinctrl/pinctrl-rockchip.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 2783:3 => 
  - /kisskb/src/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 815:20, 820:20 => 
  - /kisskb/src/drivers/pwm/pwm-atmel-hlcdc.c: warning: 'clk_period_ns' may be used uninitialized in this function [-Wuninitialized]: 67:56 => 
  - /kisskb/src/drivers/scsi/cxlflash/main.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 2347:6, 754:6, 759:3, 978:3, 975:3, 757:3, 3018:6, 983:3, 980:3 => 
  - /kisskb/src/drivers/scsi/ibmvscsi/ibmvfc.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 1838:11, 4022:3, 1830:11 => 
  - /kisskb/src/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 2494:16, 2496:16, 1582:6 => 
  - /kisskb/src/drivers/scsi/ncr53c8xx.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 6713:6, 3908:7, 3914:7, 3917:18 => 
  - /kisskb/src/drivers/scsi/wd33c93.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 1856:11 => 
  - /kisskb/src/drivers/soundwire/slave.c: warning: 'sdw_slave_add' defined but not used [-Wunused-function]: 16:12 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.34' uses dynamic stack allocation [enabled by default]: 498:1 => 
  - /kisskb/src/drivers/video/fbdev/sh_mobile_lcdcfb.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 1596:22, 2086:22 => 
  - /kisskb/src/fs/btrfs/ref-verify.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 545:2, 492:2 => 492:2
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 295:1 => 
  - /kisskb/src/fs/ubifs/orphan.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t' [-Wformat]: 132:3, 140:3 => 
  - /kisskb/src/include/linux/unaligned/le_byteshift.h: warning: array subscript is above array bounds [-Warray-bounds]: 26:7 => 
  - /kisskb/src/kernel/fork.c: warning: 'task_struct_whitelist' defined but not used [-Wunused-function]: 771:13 => 
  - /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]: 1676:17 => 
  - /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wuninitialized]: 1676:3, 1686:3 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 8c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U be0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U dc0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U16e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U25a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U28c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U35a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U43c0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4dc0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U50a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5a00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U61e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U63c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U68c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U78c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8960>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8be0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8e60>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U98c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9f00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaaa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub140>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub280>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub3c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub5a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub6e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub8c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubbe0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubd20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubdc0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue5a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf5a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufb40>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufbe0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_ip_fixup' uses dynamic stack allocation [enabled by default]: 249:1 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation [enabled by default]: 300:1 => 
  - /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation [enabled by default]: 316:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]: 269:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation [enabled by default]: 268:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation [enabled by default]: 275:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation [enabled by default]: 272:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation [enabled by default]: 271:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation [enabled by default]: 266:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation [enabled by default]: 265:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation [enabled by default]: 263:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]: 269:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation [enabled by default]: 268:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation [enabled by default]: 275:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation [enabled by default]: 272:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation [enabled by default]: 271:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation [enabled by default]: 266:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation [enabled by default]: 265:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation [enabled by default]: 263:1 => 
  - /kisskb/src/mm/percpu.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 2189:32, 1616:17 => 2189:32
  - /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation [enabled by default]: 229:1 => 
  - /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation [enabled by default]: 1854:1 => 
  - /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1512 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2905:1 => 
  - /kisskb/src/net/sunrpc/stats.c: warning: 'rpc_clnt_show_stats' uses dynamic stack allocation [enabled by default]: 276:1 => 
  - /kisskb/src/net/sunrpc/xprtsock.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]: 2605:16 => 
  - /kisskb/src/net/xfrm/xfrm_policy.c: warning: array subscript is above array bounds [-Warray-bounds]: 3496:15 => 
  - /kisskb/src/sound/aoa/codecs/onyx.c: warning: 'c' may be used uninitialized in this function [-Wmaybe-uninitialized]: 377:37 => 
  - warning: same module names found:: N/A => 
  - warning: vmlinux.o(.text+0x2e0c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x2fd0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x31f4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x31fac): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x31fc): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3204): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x33d0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x37154): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3794): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x39d0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x36c4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x38c4): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x38f0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3af0): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48a4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48b4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48bc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48cc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48d0): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x48e8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4b58): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4b68): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4b84): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
