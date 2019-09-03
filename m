Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4182A624F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 09:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfICHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 03:13:16 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:40964 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfICHNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:13:16 -0400
Received: from ramsan ([84.194.98.4])
        by andre.telenet-ops.be with bizsmtp
        id wvD32000Q05gfCL01vD3gH; Tue, 03 Sep 2019 09:13:04 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i52zv-0000Gp-NF
        for linux-kernel@vger.kernel.org; Tue, 03 Sep 2019 09:13:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i52zv-0000fp-LY
        for linux-kernel@vger.kernel.org; Tue, 03 Sep 2019 09:13:03 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.3-rc7
Date:   Tue,  3 Sep 2019 09:13:03 +0200
Message-Id: <20190903071303.2547-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.3-rc7[1] compared to v5.2[2].

Summarized:
  - build errors: +6/-1
  - build warnings: +121/-134

JFYI, when comparing v5.3-rc7[1] to v5.3-rc6[3], the summaries are:
  - build errors: +0/-0
  - build warnings: +50/-60

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/089cf7f6ecb266b6a4164919a2e69bd2f938374a/ (all 242 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0ecfebd2b52404ae0c54a878c872bb93363ada36/ (all 242 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/a55aa89aab90fae7c815b0551b07be37db359d76/ (all 242 configs)


*** ERRORS ***

6 error regressions:
  + /kisskb/src/drivers/misc/lkdtm/bugs.c: error: 'X86_CR4_SMEP' undeclared (first use in this function):  => 281:13
  + /kisskb/src/drivers/misc/lkdtm/bugs.c: error: implicit declaration of function 'native_read_cr4' [-Werror=implicit-function-declaration]:  => 279:8
  + /kisskb/src/drivers/misc/lkdtm/bugs.c: error: implicit declaration of function 'native_write_cr4' [-Werror=implicit-function-declaration]:  => 288:2
  + /kisskb/src/mm/hmm.c: error: implicit declaration of function 'pud_pfn' [-Werror=implicit-function-declaration]:  => 753:3, 753:9
  + /kisskb/src/mm/hmm.c: error: implicit declaration of function 'pud_pfn'; did you mean 'pte_pfn'? [-Werror=implicit-function-declaration]:  => 753:9
  + error: "can_do_mlock" [drivers/infiniband/sw/siw/siw.ko] undefined!:  => N/A

1 error improvements:
  - error: arch/sh/kernel/cpu/sh2/clock-sh7619.o: undefined reference to `followparent_recalc': .data+0x70) => 


*** WARNINGS ***

121 warning regressions:
  + /kisskb/src/arch/mips/include/asm/page.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 249:53
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.28' uses dynamic stack allocation [enabled by default]:  => 403:1
  + /kisskb/src/drivers/crypto/talitos.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 3142:4
  + /kisskb/src/drivers/dma-buf/dma-buf.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]:  => 402:26
  + /kisskb/src/drivers/dma/imx-dma.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 542:6
  + /kisskb/src/drivers/gpu/drm/arm/malidp_hw.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 387:8, 1311:4
  + /kisskb/src/drivers/infiniband/sw/siw/siw_qp_tx.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 529:23
  + /kisskb/src/drivers/md/raid10.c: warning: 'best_pending_slot' may be used uninitialized in this function [-Wuninitialized]:  => 840:22
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1288 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 127:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 127:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c: warning: the frame size of 1312 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 127:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 294:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 294:1
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1368 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 294:1
  + /kisskb/src/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 1010:12
  + /kisskb/src/drivers/pinctrl/pinctrl-rockchip.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 2783:3
  + /kisskb/src/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 820:20, 815:20
  + /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 280:15
  + /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg.clk_ps' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 82:20
  + /kisskb/src/drivers/pwm/pwm-fsl-ftm.c: warning: 'periodcfg.mod_period' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 278:3, 84:24
  + /kisskb/src/drivers/scsi/cxlflash/main.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 980:3, 754:6, 978:3, 2347:6, 759:3, 983:3, 975:3, 3018:6, 757:3
  + /kisskb/src/drivers/scsi/ibmvscsi/ibmvfc.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1838:11, 4022:3, 1830:11
  + /kisskb/src/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1582:6, 2496:16, 2494:16
  + /kisskb/src/drivers/scsi/ncr53c8xx.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 3914:7, 3908:7, 6713:6, 3917:18
  + /kisskb/src/drivers/scsi/wd33c93.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1856:11
  + /kisskb/src/drivers/soundwire/slave.c: warning: 'sdw_slave_add' defined but not used [-Wunused-function]:  => 16:12
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.34' uses dynamic stack allocation [enabled by default]:  => 498:1
  + /kisskb/src/drivers/usb/core/devio.c: warning: 'errno' may be used uninitialized in this function [-Wuninitialized]:  => 613:23
  + /kisskb/src/drivers/video/fbdev/sh_mobile_lcdcfb.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1596:22, 2086:22
  + /kisskb/src/fs/gfs2/bmap.c: warning: 'lblock' may be used uninitialized in this function [-Wuninitialized]:  => 957:8
  + /kisskb/src/fs/nfs/read.c: warning: value computed is not used [-Wunused-value]:  => 352:2, 196:5
  + /kisskb/src/fs/ubifs/debug.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t' {aka 'unsigned int'} [-Wformat=]:  => 158:11
  + /kisskb/src/fs/ubifs/orphan.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t' [-Wformat]:  => 132:3, 140:3
  + /kisskb/src/include/asm-generic/bitops/non-atomic.h: warning: 'cpu' may be used uninitialized in this function [-Wuninitialized]:  => 106:21
  + /kisskb/src/include/linux/device.h: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1501:2
  + /kisskb/src/include/linux/regmap.h: warning: 'periodcfg.clk_ps' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 75:2
  + /kisskb/src/include/linux/via-core.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 192:2, 206:2, 198:2
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1000>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1280>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3280>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34, 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U46e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U55a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U58c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U68c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U71e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U73c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U75a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U76e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8960>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U93c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9500>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32, 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U95a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9be0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub280>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubdc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uca00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucdc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucf00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud0a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueb40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uebe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufd20>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/sched/core.c: warning: 'cpu' may be used uninitialized in this function [-Wuninitialized]:  => 2529:12
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.52' uses dynamic stack allocation [enabled by default]:  => 2193:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.54' uses dynamic stack allocation [enabled by default]:  => 1900:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.53' uses dynamic stack allocation [enabled by default]:  => 2261:1
  + /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1512 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2905:1
  + /kisskb/src/sound/aoa/codecs/onyx.c: warning: 'c' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 377:37
  + <stdin>: warning: #warning syscall clone3 not implemented [-Wcpp]:  => 1511:2
  + warning: vmlinux.o(.text+0x2e0c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x2fd0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x31f4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x31fac): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x31fc): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3204): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x33d0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x37154): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text+0x3794): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x39d0): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x36c4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x38c4): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x38f0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3af0): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x48a4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x48b4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x48bc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x48cc): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x48d0): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x48e8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x4b58): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x4b68): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x4b84): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A

134 warning improvements:
  - /kisskb/src/arch/arm/mm/init.c: warning: unused variable 'dtcm_end' [-Wunused-variable]: 452:13 => 
  - /kisskb/src/arch/arm/mm/init.c: warning: unused variable 'itcm_end' [-Wunused-variable]: 453:13 => 
  - /kisskb/src/arch/s390/kernel/machine_kexec.c: warning: 'do_start_kdump' defined but not used [-Wunused-function]: 146:22 => 
  - /kisskb/src/arch/sh/kernel/cpu/clock.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 22:6 => 
  - /kisskb/src/arch/xtensa/kernel/pci.c: warning: 'pci_ctrl_tail' defined but not used [-Wunused-variable]: 40:32 => 
  - /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.27' uses dynamic stack allocation [enabled by default]: 403:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 685:6 => 
  - /kisskb/src/drivers/hwtracing/intel_th/msu.c: warning: unused variable 'i' [-Wunused-variable]: 863:6, 783:21 => 
  - /kisskb/src/drivers/lightnvm/core.c: warning: 't' may be used uninitialized in this function [-Wuninitialized]: 496:5 => 
  - /kisskb/src/drivers/mfd/htc-pasic3.c: warning: unused variable 'asic' [-Wunused-variable]: 186:22 => 
  - /kisskb/src/drivers/net/arcnet/arc-rimi.c: warning: unused variable 'lp' [-Wunused-variable]: 346:23 => 
  - /kisskb/src/drivers/net/can/cc770/cc770_platform.c: warning: unused variable 'priv' [-Wunused-variable]: 236:21 => 
  - /kisskb/src/drivers/net/ethernet/8390/ax88796.c: warning: unused variable 'ei_local' [-Wunused-variable]: 808:20 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq" redefined [enabled by default]: 1670:0 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq" redefined: 1670:0, 1670 => 1679
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq_relaxed" redefined [enabled by default]: 1678:0 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq_relaxed" redefined: 1678, 1678:0 => 1687
  - /kisskb/src/drivers/net/ethernet/freescale/fsl_pq_mdio.c: warning: unused variable 'priv' [-Wunused-variable]: 518:27 => 
  - /kisskb/src/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c: warning: 'type' may be used uninitialized in this function [-Wuninitialized]: 1041:16 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc911x.c: warning: unused variable 'lp' [-Wunused-variable]: 2116:24 => 
  - /kisskb/src/drivers/net/ethernet/smsc/smc91c92_cs.c: warning: unused variable 'smc' [-Wunused-variable]: 958:23 => 
  - /kisskb/src/drivers/s390/scsi/zfcp_erp.c: warning: 'erp_action' may be used uninitialized in this function [-Wuninitialized]: 262:2 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/core.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]: 149:36 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/core.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat]: 149:9 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 75:1 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 75:1 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 75:1 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t {aka unsigned int}' [-Wformat=]: 58:35 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t' [-Wformat]: 58:2 => 
  - /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]: 58:35 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.32' uses dynamic stack allocation [enabled by default]: 498:1 => 
  - /kisskb/src/drivers/thermal/broadcom/ns-thermal.c: warning: unused variable 'ns_thermal' [-Wunused-variable]: 78:21 => 
  - /kisskb/src/fs/btrfs/props.c: warning: 'num_bytes' may be used uninitialized in this function [-Wmaybe-uninitialized]: 389:4 => 
  - /kisskb/src/kernel/locking/lockdep.c: warning: 'print_lock_trace' defined but not used [-Wunused-function]: 2821:13 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U   0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 3c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 640>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U13c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U45a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5f00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U65a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U81e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U83c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U90a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U96e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9e60>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua0a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua1e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uae60>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uaf00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub1e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub5a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubaa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubc80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ubf00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32, 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc0a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc3c0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucbe0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uce60>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud140>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue280>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue5a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf5a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf820>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufe60>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.47' uses dynamic stack allocation [enabled by default]: 2177:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.49' uses dynamic stack allocation [enabled by default]: 1884:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.48' uses dynamic stack allocation [enabled by default]: 2245:1 => 
  - /kisskb/src/net/core/devlink.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 4321:6, 4390:6 => 4443:6
  - /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1504 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2905:1 => 
  - warning: "copy_page" [fs/nfs/nfs.ko] has no CRC!: N/A => 
  - warning: 140 bad relocations: N/A => 
  - warning: 141 bad relocations: N/A => 
  - warning: You need at least binutils >= 2.19 to build a CONFIG_RELOCATABLE kernel: N/A => 
  - warning: arch/powerpc/oprofile/oprofile.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.: N/A => 
  - warning: vmlinux.o(.text+0x2f2a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x2f3c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x302a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x30ba): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3128): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x312a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3164): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x322a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3263c): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x340c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3474): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3484): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x352a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3628): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x362a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3664): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x3734): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3770): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x377e4): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3a14): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3c34): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3c70): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x3dc6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x40e): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x42c6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x51a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x5f878): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x24c04): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x36cc): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x36e4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x38cc): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3914): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3928): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3b58): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0xe724): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
