Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93F6FD76
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbfGVKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 06:13:19 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:49862 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfGVKNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:13:19 -0400
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1hpVJg-00073S-I5; Mon, 22 Jul 2019 12:13:12 +0200
Date:   Mon, 22 Jul 2019 12:13:12 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Jessica Yu <jeyu@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: next-20190722, imx25: Oops when loading a module
Message-ID: <20190722101312.2nakxrfy7yn4a4ro@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

I run next-20190722 on an arm imx25 system and came across an issue that might
be worth reporting. I am no sure to whom, though. Please let me know if I got
that wrong.

Loading a module, no matter which one, causes a segfault and a dump such as

[root@host ]# insmod /mnt/kernel/iio/potentiometer/max5432.ko
[   63.043683] Internal error: Oops - undefined instruction: 0 [#1] ARM
[   63.050123] Modules linked in:
[   63.053266] CPU: 0 PID: 170 Comm: insmod Tainted: G        W         5.3.0-rc1-next-20190722+ #3104
[   63.062344] Hardware name: Freescale i.MX25 (Device Tree Support)
[   63.068529] PC is at frob_text.constprop.15+0x2c/0x40
[   63.073639] LR is at load_module+0x10dc/0x125c
[   63.078115] pc : [<c0072ffc>]    lr : [<c0071f8c>]    psr: 00000013
[   63.084407] sp : d3303e30  ip : d3303e40  fp : d3303e3c
[   63.089654] r10: 00000000  r9 : d3303e98  r8 : 00000018
[   63.094903] r7 : 00000001  r6 : bf0006cc  r5 : d3303f20  r4 : bf0006c0
[   63.101454] r3 : bf000000  r2 : 18000000  r1 : 00000180  r0 : bf0007a0
[   63.108013] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   63.115176] Control: 0005317f  Table: 93330000  DAC: 00000051
[   63.120961] Process insmod (pid: 170, stack limit = 0x90da5324)
[   63.126917] Stack: (0xd3303e30 to 0xd3304000)
[   63.131318] 3e20:                                     d3303f0c d3303e40 c0071f8c c0072fe0
[   63.139546] 3e40: bf0006c0 d3309920 00002cc0 ffffffff 00000002 00000002 d3309900 00000000
[   63.147776] 3e60: 001a77e2 bf00289b bf0008a0 c067c9c8 0000025f c07df990 d3303ecc d3303e88
[   63.155999] 3e80: c00d7688 c00d689c 00000000 00000000 00000000 00000000 00000000 00000000
[   63.164225] 3ea0: 6e72656b 00006c65 00000000 00000000 00000000 00000000 00000000 00000000
[   63.172453] 3ec0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 ba520d2b
[   63.180681] 3ee0: c00721a8 00001aed 0120abad 00000000 c0883028 d4c17aed 001a77e2 d3302000
[   63.188912] 3f00: d3303fa4 d3303f10 c0072270 c0070ec0 c0034324 c0677478 d32f1640 00000051
[   63.197142] 3f20: d4c16788 d4c16a80 d4c16000 00001aed d4c16dd8 d4c16cd5 d4c177f0 000008a0
[   63.205368] 3f40: 00000950 00000850 000009b4 00000000 00000000 00000000 00000840 0000001b
[   63.213590] 3f60: 0000001c 00000011 0000000d 00000009 00000000 ba520d2b c01030f4 00000000
[   63.221819] 3f80: 00000000 00001aed 00000080 c00091e4 d3302000 00000000 00000000 d3303fa8
[   63.230046] 3fa0: c0009000 c007211c 00000000 00000000 012090c0 00001aed 001a77e2 00000000
[   63.238273] 3fc0: 00000000 00000000 00001aed 00000080 00000001 be90de0c 001a77e2 00000000
[   63.246499] 3fe0: be90dac0 be90dab0 0001ec34 00009b30 60000010 012090c0 00000000 00000000
[   63.254694] Backtrace:
[   63.257232] [<c0072fd0>] (frob_text.constprop.15) from [<c0071f8c>] (load_module+0x10dc/0x125c)
[   63.265999] [<c0070eb0>] (load_module) from [<c0072270>] (sys_init_module+0x164/0x194)
[   63.273970]  r10:d3302000 r9:001a77e2 r8:d4c17aed r7:c0883028 r6:00000000 r5:0120abad
[   63.281823]  r4:00001aed
[   63.284410] [<c007210c>] (sys_init_module) from [<c0009000>] (ret_fast_syscall+0x0/0x50)
[   63.292529] Exception stack(0xd3303fa8 to 0xd3303ff0)
[   63.297624] 3fa0:                   00000000 00000000 012090c0 00001aed 001a77e2 00000000
[   63.305851] 3fc0: 00000000 00000000 00001aed 00000080 00000001 be90de0c 001a77e2 00000000
[   63.314067] 3fe0: be90dac0 be90dab0 0001ec34 00009b30
[   63.319170]  r10:00000000 r9:d3302000 r8:c00091e4 r7:00000080 r6:00001aed r5:00000000
[   63.327021]  r4:00000000
[   63.329603] Code: 1a000002 e5901008 e1b02a01 0a000000 (e7f001f2)
[   63.335742] ---[ end trace c38bbcd6af0938a2 ]---
Segmentation fault
[root@host ]#

It seems that this is realated to strict module rwx.
The config below crashes:

CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
# CONFIG_STRICT_MODULE_RWX is not set

If I enable CONFIG_STRICT_MODULE_RWX, modules can be loaded and unloaded without problems.

Best regards,

   Martin
