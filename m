Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D6F47AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFQHTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 03:19:50 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:49718 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfFQHTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:19:49 -0400
Received: from ramsan ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id RjKd2000A3XaVaC01jKd7h; Mon, 17 Jun 2019 09:19:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hclvV-0000Kw-Ay
        for linux-kernel@vger.kernel.org; Mon, 17 Jun 2019 09:19:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hclvV-0005x9-9y
        for linux-kernel@vger.kernel.org; Mon, 17 Jun 2019 09:19:37 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.2-rc5
Date:   Mon, 17 Jun 2019 09:19:37 +0200
Message-Id: <20190617071937.22838-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.2-rc5[1] compared to v5.1[2].

Summarized:
  - build errors: +1/-0
  - build warnings: +150/-117

JFYI, when comparing v5.2-rc5[1] to v5.2-rc4[3], the summaries are:
  - build errors: +0/-0
  - build warnings: +53/-56

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9e0babf2c06c73cda2c0cd37a1653d823adb40ec/ (all 242 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd/ (236 out of 242 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d1fdb6d8f6a4109a4263176c84b899076a5f8008/ (all 242 configs)


*** ERRORS ***

1 error regressions:
  + error: "devm_ioremap" [drivers/counter/ftm-quaddec.ko] undefined!:  => N/A


*** WARNINGS ***

150 warning regressions:
  + /kisskb/src/arch/s390/include/asm/uaccess.h: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]:  => 113:2, 143:2
  + /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2960 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 93:1, 51:1
  + /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 93:1
  + /kisskb/src/arch/um/os-Linux/signal.c: warning: the frame size of 2976 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 51:1
  + /kisskb/src/crypto/sha512_generic.c: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 149:1
  + /kisskb/src/crypto/sha512_generic.c: warning: the frame size of 1188 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 149:1
  + /kisskb/src/drivers/crypto/ccree/cc_cipher.c: warning: the frame size of 1136 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 465:1
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.27' uses dynamic stack allocation [enabled by default]:  => 406:1
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/bus/hwsq.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]:  => 162:16
  + /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]:  => 154:40
  + /kisskb/src/drivers/hwmon/f71805f.c: warning: 'address' may be used uninitialized in this function [-Wuninitialized]:  => 1626:26
  + /kisskb/src/drivers/hwmon/w83627hf.c: warning: 'address' may be used uninitialized in this function [-Wuninitialized]:  => 1980:27
  + /kisskb/src/drivers/hwtracing/intel_th/msu.c: warning: unused variable 'i' [-Wunused-variable]:  => 783:21, 863:6
  + /kisskb/src/drivers/iommu/fsl_pamu_domain.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 90:9
  + /kisskb/src/drivers/lightnvm/core.c: warning: 't' may be used uninitialized in this function [-Wuninitialized]:  => 496:5
  + /kisskb/src/drivers/misc/habanalabs/habanalabs_ioctl.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 143:23
  + /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined [enabled by default]:  => 92:0
  + /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined:  => 92
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2.h: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073709551584' to '-32' [-Woverflow]:  => 614:2
  + /kisskb/src/drivers/net/wireless/realtek/rtw88/phy.c: warning: array subscript is above array bounds [-Warray-bounds]:  => 430:26
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/core.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]:  => 149:36
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/core.c: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat]:  => 149:9
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 75:1
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 75:1
  + /kisskb/src/drivers/staging/kpc2000/kpc2000/fileops.c: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 75:1
  + /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t {aka unsigned int}' [-Wformat=]:  => 58:35
  + /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t' [-Wformat]:  => 58:2
  + /kisskb/src/drivers/staging/kpc2000/kpc_dma/fileops.c: warning: format '%ld' expects argument of type 'long int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]:  => 58:35
  + /kisskb/src/fs/btrfs/props.c: warning: 'num_bytes' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 389:4
  + /kisskb/src/fs/cifs/smb2pdu.c: warning: 'in_data_buf' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 2581:19
  + /kisskb/src/fs/cifs/smb2pdu.c: warning: 'in_data_buf' may be used uninitialized in this function [-Wuninitialized]:  => 2581:19
  + /kisskb/src/include/linux/list.h: warning: 'head' may be used uninitialized in this function [-Wuninitialized]:  => 93:12
  + /kisskb/src/include/linux/rhashtable.h: warning: 'next' may be used uninitialized in this function [-Wuninitialized]:  => 110:10
  + /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1645:17
  + /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wuninitialized]:  => 1655:3, 1645:3
  + /kisskb/src/kernel/locking/lockdep.c: warning: 'print_lock_trace' defined but not used [-Wunused-function]:  => 2821:13
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U   0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1000>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U10a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32, 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U11e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1280>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U18c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3500>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3640>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U43c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32, 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5780>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5a00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5b40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5c80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6280>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U63c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7140>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U76e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7f00>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8500>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U85a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8640>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9140>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9280>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9320>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U95a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9e60>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua140>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uab40>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uac80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ube60>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucaa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ucbe0>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud000>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud5a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue320>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uec80>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uee60>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf1e0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf460>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf820>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34
  + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufc80>]' may be used uninitialized in this function [-Wuninitialized]:  => 140:32
  + /kisskb/src/lib/test_kasan.c: warning: 'kasan_alloca_oob_left' uses dynamic stack allocation:  => 491:1
  + /kisskb/src/lib/test_kasan.c: warning: 'kasan_alloca_oob_right' uses dynamic stack allocation:  => 501:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.47' uses dynamic stack allocation [enabled by default]:  => 2177:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.49' uses dynamic stack allocation [enabled by default]:  => 1884:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.48' uses dynamic stack allocation [enabled by default]:  => 2245:1
  + /kisskb/src/mm/vmalloc.c: warning: 'lva' may be used uninitialized in this function [-Wuninitialized]:  => 976:28
  + /kisskb/src/net/core/devlink.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 4304:6 => 4321:6, 4390:6
  + /kisskb/src/net/ipv4/fib_semantics.c: warning: 'err' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1023:12
  + /kisskb/src/net/ipv4/fib_semantics.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 1023:12
  + /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1504 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2905:1
  + /kisskb/src/net/xfrm/xfrm_policy.c: warning: array subscript is above array bounds [-Warray-bounds]:  => 3495:15
  + /kisskb/src/sound/soc/fsl/imx-audmix.c: warning: 'capture_dai_name' may be used uninitialized in this function [-Wuninitialized]:  => 277:45
  + warning: "copy_page" [drivers/md/dm-integrity.ko] has no CRC!:  => N/A
  + warning: 140 bad relocations:  => N/A
  + warning: 141 bad relocations:  => N/A
  + warning: You need at least binutils >= 2.19 to build a CONFIG_RELOCATABLE kernel:  => N/A
  + warning: arch/powerpc/oprofile/oprofile.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.:  => N/A
  + warning: same module names found::  => N/A
  + warning: vmlinux.o(.text+0x2f2a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x2f3c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x302a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x30ba): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3128): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x312a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3164): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x322a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x325ec): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x340c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3474): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3484): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x352a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3628): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x362a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3664): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x3734): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3770): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x37794): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text+0x3a14): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init():  => N/A
  + warning: vmlinux.o(.text+0x3c34): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup():  => N/A
  + warning: vmlinux.o(.text+0x3c70): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel():  => N/A
  + warning: vmlinux.o(.text+0x3dc6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x40e): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x42c6): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x51a): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:.early_setup():  => N/A
  + warning: vmlinux.o(.text+0x5f878): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x24c64): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x308): Section mismatch in reference from the function populate_initrd_image() to the function .init.text:set_reset_devices():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x30c): Section mismatch in reference from the function populate_initrd_image() to the variable .init.ramfs.info:__initramfs_size:  => N/A
  + warning: vmlinux.o(.text.unlikely+0x32c): Section mismatch in reference from the function populate_initrd_image() to the function .init.text:set_reset_devices():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x36cc): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x36e4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x38cc): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3914): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3928): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3b58): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0xe6e4): Section mismatch in reference from the function __integrity_init_keyring() to the function .init.text:set_platform_trusted_keys():  => N/A

117 warning improvements:
  - /kisskb/src/arch/arc/include/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]: 95:29 => 
  - /kisskb/src/arch/arc/mm/tlb.c: warning: ISO C90 forbids variable length array 'pd0' [-Wvla]: 914:2 => 
  - /kisskb/src/arch/arc/mm/tlb.c: warning: variable length array 'pd0' is used [-Wvla]: 914:2 => 
  - /kisskb/src/arch/s390/mm/pgtable.c: warning: 'pmd_alloc_map' defined but not used [-Wunused-function]: 413:15 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: left shift count >= width of type [enabled by default]: 310:1 => 
  - /kisskb/src/arch/sh/math-emu/math.c: warning: right shift count >= width of type [enabled by default]: 296:3, 294:3 => 
  - /kisskb/src/arch/um/kernel/skas/uaccess.c: warning: unused variable 'buf' [-Wunused-variable]: 62:10 => 
  - /kisskb/src/arch/um/os-Linux/umid.c: warning: ISO C90 forbids variable length array 'dir' [-Wvla]: 388:2 => 
  - /kisskb/src/arch/um/os-Linux/umid.c: warning: ISO C90 forbids variable length array 'file' [-Wvla]: 213:2, 138:2 => 
  - /kisskb/src/drivers/atm/ambassador.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]: 1762:3 => 
  - /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.23' uses dynamic stack allocation [enabled by default]: 406:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: (near initialization for 'stream_update.src') [-Wmissing-braces]: 5861:10 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: missing braces around initializer [-Wmissing-braces]: 5861:10 => 
  - /kisskb/src/drivers/gpu/drm/arm/display/komeda/komeda_dev.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 145:5 => 
  - /kisskb/src/drivers/mtd/ubi/wl.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 1520:19 => 
  - /kisskb/src/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c: warning: 'rc' may be used uninitialized in this function [-Wuninitialized]: 2962:6 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 845:5 => 
  - /kisskb/src/drivers/net/wan/lmc/lmc_main.c: warning: passing argument 1 of 'virt_to_bus' discards 'volatile' qualifier from pointer target type [enabled by default]: 1860:9, 1862:5, 1873:9, 1876:5, 1875:5, 1851:9 => 
  - /kisskb/src/drivers/scsi/myrs.c: warning: 'sshdr.sense_key' may be used uninitialized in this function [-Wmaybe-uninitialized]: 821:24 => 
  - /kisskb/src/fs/btrfs/qgroup.c: warning: array subscript is below array bounds [-Warray-bounds]: 1721:17, 1720:18 => 
  - /kisskb/src/fs/reiserfs/stree.c: warning: the frame size of 1052 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 812:1 => 
  - /kisskb/src/include/linux/skbuff.h: warning: 'extra_uref' may be used uninitialized in this function [-Wuninitialized]: 1397:6 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U  a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 960>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U be0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1640>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U16e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1be0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U1c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2000>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U20a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U2aa0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3000>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U30a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U35a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U36e0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3c80>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U3d20>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4320>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U45a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U4a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U5f00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U66e0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U68c0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U6960>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7000>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U7b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8000>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8140>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8a00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8b40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U8c80>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9460>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U9820>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua000>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ua320>]' may be used uninitialized in this function [-Wuninitialized]: 121:34, 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uadc0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub0a0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ub460>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uc500>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uca00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ud960>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Udf00>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue140>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ue5a0>]' may be used uninitialized in this function [-Wuninitialized]: 140:32 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ueb40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uebe0>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf780>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Uf960>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufa00>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<Ufb40>]' may be used uninitialized in this function [-Wuninitialized]: 121:34 => 
  - /kisskb/src/kernel/trace/trace_hwlat.c: warning: the frame size of 1696 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 341:1 => 
  - /kisskb/src/lib/rhashtable.c: warning: 'next' may be used uninitialized in this function [-Wuninitialized]: 264:2 => 
  - /kisskb/src/mm/mprotect.c: warning: unused variable 'mm' [-Wunused-variable]: 42:20 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.50' uses dynamic stack allocation [enabled by default]: 2185:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.52' uses dynamic stack allocation [enabled by default]: 1892:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.51' uses dynamic stack allocation [enabled by default]: 2253:1 => 
  - /kisskb/src/net/ncsi/ncsi-manage.c: warning: 'vid' may be used uninitialized in this function [-Wuninitialized]: 676:19, 661:5 => 672:19
  - /kisskb/src/net/netfilter/nf_nat_masquerade.c: warning: 'masq_refcnt6' defined but not used [-Wunused-variable]: 15:21 => 
  - /kisskb/src/net/sched/sch_cake.c: warning: the frame size of 1480 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2904:1 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for FS_ENCRYPTION: 534 => 
  - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for NET_DEVLINK: 333 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for FS_ENCRYPTION: 423 => 
  - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for NET_DEVLINK: 306 => 
  - warning: vmlinux.o(.text+0x2b3c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x2d28): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x2d5c): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x2fac): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3074): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3084): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x3228): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x325c): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x3334): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3368): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x339c8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x35a4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x37c04): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3834): Section mismatch in reference from the variable start_here_multiplatform to the function .init.text:early_setup(): N/A => 
  - warning: vmlinux.o(.text+0x3868): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x3d9430): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3d9a98): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3e0c10): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x3e1278): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text+0x458810): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory(): N/A => 
  - warning: vmlinux.o(.text+0x458e78): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2e18): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2e84): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2f90): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x30a8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
