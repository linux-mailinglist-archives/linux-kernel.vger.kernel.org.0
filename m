Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C85FEADC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 06:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKPFyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 00:54:38 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52926 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfKPFyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 00:54:37 -0500
Received: by mail-wm1-f47.google.com with SMTP id l1so11680403wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 21:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=mRqW6zthPLcHBh4LlAfUIeqD/Iv45YY4zHt9yE8+dGA=;
        b=bsyQAeTffxoDun/10FTAUhud1UqsgNjhx62iY/d+Dqq4drawJ7t6Wqwu4FYJerEt/m
         2ZsEOWAF+LXvYJYeyDA9u0CNEiuaSmxaVa0myZEPJAjwr4sm/2HfddFBFCd2zJ4eusiy
         BjrBcuA+GdFJUxZQvIZw4MtYYufzCwypL7xwBS6JUYs6ayvea1fjtRU30TzUxcCWppr/
         0FpPFk6kYTW3LA//8BmkMn+hePaaZRd/TlBKpwi+yqAVY+JA7I/A/VS9KWQC3q+NV8mS
         vch4LTKZ3nZ1b6EfNIlw3IillZBkFXh7OLRs62xBdsvwCTMs34HoHgta5g4uC7aEHLus
         fUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=mRqW6zthPLcHBh4LlAfUIeqD/Iv45YY4zHt9yE8+dGA=;
        b=TJJ+Lp5Zm/4jrriFHHL7IJJegPV3vtsi+RrxC6E7xAmPtThP1XXaaMJGkXSs3ILwy2
         YDxtWuhua+wSFNwCrwFQAz4jqfJDB1G9dQSyJVEvrWyptCYc6xH+EKqXwQx2Lm5Bzw87
         fTqZVbD6Gc9H0YHSPwd4MbnC05LlysuG3KtV5gGM7yjzWFLuOf3dKyqtLnAiDtIw/usz
         eFMnv1057GWmtXkLDV55SjdWWv2h/mNlARnFhx1K62W2HJ/BxAdIJDWT3CaWmnfX75Nr
         4dDGC/hFuDbGYgfB9IBxC2qQan7tJNGabSmq6O4cT/RO71blrJymdR8+3KJws3RpkjUQ
         kEAA==
X-Gm-Message-State: APjAAAWHRl7JR3ZntokeSDYyB4snoLexeW7C9riqNhm6vJq4U2Gd6TXm
        bpw9OIoX850b5HRdiXSfVyK3Zg==
X-Google-Smtp-Source: APXvYqyIYg+CVgR8kiSO/8JtF/TM61sgmJn2Q6X/fXpS7x59JGY945o7u28IgweCmdMRjNu8aCsZhQ==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr16802598wmc.148.1573883674570;
        Fri, 15 Nov 2019 21:54:34 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id n13sm12042360wmi.25.2019.11.15.21.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 21:54:33 -0800 (PST)
Message-ID: <5dcf8f19.1c69fb81.c02f3.91f2@mx.google.com>
Date:   Fri, 15 Nov 2019 21:54:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Branch: for-next
X-Kernelci-Tree: rmk
X-Kernelci-Report-Type: bisect
X-Kernelci-Kernel: v5.4-rc5-26-gb6c3c42cfda0
Subject: rmk/for-next bisection: boot on ox820-cloudengines-pogoplug-series-3
To:     Ard Biesheuvel <ardb@kernel.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Russell King <rmk+kernel@armlinux.org.uk>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <maz@kernel.org>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

rmk/for-next bisection: boot on ox820-cloudengines-pogoplug-series-3

Summary:
  Start:      b6c3c42cfda0 ARM: 8938/1: kernel: initialize broadcast hrtime=
r based clock event device
  Details:    https://kernelci.org/boot/id/5dcf3f0359b514dc84cf54c8
  Plain log:  https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c=
42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-p=
ogoplug-series-3.txt
  HTML log:   https://storage.kernelci.org//rmk/for-next/v5.4-rc5-26-gb6c3c=
42cfda0/arm/oxnas_v6_defconfig/gcc-8/lab-baylibre/boot-ox820-cloudengines-p=
ogoplug-series-3.html
  Result:     ea70bf6e92c5 ARM: 8935/1: decompressor: avoid CP15 barrier in=
structions in v7 cache setup code

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       rmk
  URL:        git://git.armlinux.org.uk/~rmk/linux-arm.git
  Branch:     for-next
  Target:     ox820-cloudengines-pogoplug-series-3
  CPU arch:   arm
  Lab:        lab-baylibre
  Compiler:   gcc-8
  Config:     oxnas_v6_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit ea70bf6e92c5d8cf38c8a077e0eded091c275899
Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri Nov 8 13:46:50 2019 +0100

    ARM: 8935/1: decompressor: avoid CP15 barrier instructions in v7 cache =
setup code
    =

    Commit e17b1af96b2afc38e684aa2f1033387e2ed10029
    =

      "ARM: 8857/1: efi: enable CP15 DMB instructions before cleaning the c=
ache"
    =

    added some explicit handling of the CP15BEN bit in the SCTLR system
    register, to ensure that CP15 barrier instructions are enabled, even
    if we enter the decompressor via the EFI stub.
    =

    However, as it turns out, there are other ways in which we may end up
    using CP15 barrier instructions without them being enabled. I.e., when
    the decompressor startup code skips the cache_on() initially, we end
    up calling cache_clean_flush() with the caches and MMU off, in which
    case the CP15BEN bit in SCTLR may not be programmed either. And in
    fact, cache_on() itself issues CP15 barrier instructions before actually
    enabling them by programming the new SCTLR value (and issuing an ISB)
    =

    Since all these routines are specific to v7, let's clean this up by
    using the ordinary v7 barrier instructions in the v7 specific cache
    handling routines, so that we never rely on the CP15 ones. This also
    avoids the issue where a barrier is required between programming SCTLR
    and using the CP15 barrier instructions, which would result in two
    different kinds of barriers being used in the same function.
    =

    Acked-by: Marc Zyngier <maz@kernel.org>
    Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
    Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/hea=
d.S
index 95238146b7f2..fe279816b298 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -656,6 +656,21 @@ params:		ldr	r0, =3D0x10000100		@ params_phys for RPC
 		.align
 #endif
 =

+		.macro	v7dsb
+ ARM(		.inst	0xf57ff04f		@ v7+ dsb	)
+ THUMB(		dsb						)
+		.endm
+
+		.macro	v7dmb
+ ARM(		.inst	0xf57ff05f		@ v7+ dmb	)
+ THUMB(		dmb						)
+		.endm
+
+		.macro	v7isb
+ ARM(		.inst	0xf57ff06f		@ v7+ isb	)
+ THUMB(		isb						)
+		.endm
+
 /*
  * Turn on the cache.  We need to setup some page tables so that we
  * can have both the I and D caches on.
@@ -827,7 +842,7 @@ __armv7_mmu_cache_on:
 		movne	r6, #CB_BITS | 0x02	@ !XN
 		blne	__setup_mmu
 		mov	r0, #0
-		mcr	p15, 0, r0, c7, c10, 4	@ drain write buffer
+		v7dsb				@ drain write buffer
 		tst	r11, #0xf		@ VMSA
 		mcrne	p15, 0, r0, c8, c7, 0	@ flush I,D TLBs
 #endif
@@ -849,11 +864,11 @@ __armv7_mmu_cache_on:
 		mcrne	p15, 0, r1, c3, c0, 0	@ load domain access control
 		mcrne   p15, 0, r6, c2, c0, 2   @ load ttb control
 #endif
-		mcr	p15, 0, r0, c7, c5, 4	@ ISB
+		v7isb
 		mcr	p15, 0, r0, c1, c0, 0	@ load control register
 		mrc	p15, 0, r0, c1, c0, 0	@ and read it back
 		mov	r0, #0
-		mcr	p15, 0, r0, c7, c5, 4	@ ISB
+		v7isb
 		mov	pc, r12
 =

 __fa526_cache_on:
@@ -1154,8 +1169,8 @@ __armv7_mmu_cache_off:
 		mcr	p15, 0, r0, c8, c7, 0	@ invalidate whole TLB
 #endif
 		mcr	p15, 0, r0, c7, c5, 6	@ invalidate BTC
-		mcr	p15, 0, r0, c7, c10, 4	@ DSB
-		mcr	p15, 0, r0, c7, c5, 4	@ ISB
+		v7dsb
+		v7isb
 		mov	pc, r12
 =

 /*
@@ -1218,7 +1233,7 @@ __armv7_mmu_cache_flush:
 		mcr	p15, 0, r10, c7, c14, 0	@ clean+invalidate D
 		b	iflush
 hierarchical:
-		mcr	p15, 0, r10, c7, c10, 5	@ DMB
+		v7dmb
 		stmfd	sp!, {r0-r7, r9-r11}
 		mrc	p15, 1, r0, c0, c0, 1	@ read clidr
 		ands	r3, r0, #0x7000000	@ extract loc from clidr
@@ -1232,7 +1247,7 @@ loop1:
 		cmp	r1, #2			@ see what cache we have at this level
 		blt	skip			@ skip if no cache, or just i-cache
 		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in cssr
-		mcr	p15, 0, r10, c7, c5, 4	@ isb to sych the new cssr&csidr
+		v7isb				@ isb to sych the new cssr&csidr
 		mrc	p15, 1, r1, c0, c0, 0	@ read the new csidr
 		and	r2, r1, #7		@ extract the length of the cache lines
 		add	r2, r2, #4		@ add 4 (line length offset)
@@ -1264,10 +1279,10 @@ finished:
 		mov	r10, #0			@ switch back to cache level 0
 		mcr	p15, 2, r10, c0, c0, 0	@ select current cache level in cssr
 iflush:
-		mcr	p15, 0, r10, c7, c10, 4	@ DSB
+		v7dsb
 		mcr	p15, 0, r10, c7, c5, 0	@ invalidate I+BTB
-		mcr	p15, 0, r10, c7, c10, 4	@ DSB
-		mcr	p15, 0, r10, c7, c5, 4	@ ISB
+		v7dsb
+		v7isb
 		mov	pc, lr
 =

 __armv5tej_mmu_cache_flush:
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [cb73737ea1d27181f5c4bfb1288e97f3e8a4abc7] ARM: 8928/1: ARM_ERRATA_=
775420: Spelling s/date/data/
git bisect good cb73737ea1d27181f5c4bfb1288e97f3e8a4abc7
# bad: [b6c3c42cfda04b0119a0ac46c2a06006f38522d7] ARM: 8938/1: kernel: init=
ialize broadcast hrtimer based clock event device
git bisect bad b6c3c42cfda04b0119a0ac46c2a06006f38522d7
# good: [052e76a31b4a64d7678e270d498e1bc36c342f88] ARM: 8931/1: Add clock_g=
etres entry point
git bisect good 052e76a31b4a64d7678e270d498e1bc36c342f88
# good: [44700c1ea9afeb9c5093dba7794117fda7c5c955] ARM: 8934/1: Revert "efi=
: enable CP15 DMB instructions before cleaning the cache"
git bisect good 44700c1ea9afeb9c5093dba7794117fda7c5c955
# bad: [7f586a0a683ec37ac25bee24381e24c66dfe32b8] ARM: 8937/1: spectre-v2: =
remove Brahma-B53 from hardening
git bisect bad 7f586a0a683ec37ac25bee24381e24c66dfe32b8
# bad: [ea70bf6e92c5d8cf38c8a077e0eded091c275899] ARM: 8935/1: decompressor=
: avoid CP15 barrier instructions in v7 cache setup code
git bisect bad ea70bf6e92c5d8cf38c8a077e0eded091c275899
# first bad commit: [ea70bf6e92c5d8cf38c8a077e0eded091c275899] ARM: 8935/1:=
 decompressor: avoid CP15 barrier instructions in v7 cache setup code
---------------------------------------------------------------------------=
----
