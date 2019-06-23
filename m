Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237024FE76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 03:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfFXBmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 21:42:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXBk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNsb192860039
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:54:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNsb192860039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334078;
        bh=Ja9yR0sHJDiTyPiHR4utJUUQzGAEf6ERIZE+8BGYc9E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=i9DYh4Snu1LuwcDgjQTQYuKN+5oM+NyTrNSdsQDx3UnuzuPjH9sxfLjiFLiUrOdWD
         +u+TNUYMEkJ7hH0V6xn/DkrsKIveI9cNdsf3NSfk+YEZOP8P3R0ANd+9cae/pdgrko
         smhTxdr3ZA1QTWrtC3ozxqjwij/9lGMQNgYeRklhIbYAvBqTRJy3Pd0MNhfiIeLaC1
         Wpiwc3qImYlyviPC6BkLyJedAr8pQKVzf94LPlISz2lldozql6ve30P15pLYGrb0X0
         NknkdZ9gH2jodpBWVVVO0UXOgbzEYPmKu7FJqjy0QNZMOGVsyUbMnLq++qzTLtPNHh
         ziM8VrDPWB2bQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNsaFT2860036;
        Sun, 23 Jun 2019 16:54:36 -0700
Date:   Sun, 23 Jun 2019 16:54:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-bfe801ebe84f42b4666d3f0adde90f504d56e35b@git.kernel.org>
Cc:     salyzyn@android.com, paul.burton@mips.com, sthotton@marvell.com,
        arnd@arndb.de, tglx@linutronix.de, mingo@kernel.org,
        daniel.lezcano@linaro.org, hpa@zytor.com, pcc@google.com,
        catalin.marinas@arm.com, huw@codeweavers.com, ralf@linux-mips.org,
        0x7f454c46@gmail.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, vincenzo.frascino@arm.com,
        will.deacon@arm.com, shuah@kernel.org, linux@rasmusvillemoes.dk,
        andre.przywara@arm.com
Reply-To: linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
          vincenzo.frascino@arm.com, will.deacon@arm.com, shuah@kernel.org,
          linux@rasmusvillemoes.dk, andre.przywara@arm.com, pcc@google.com,
          hpa@zytor.com, catalin.marinas@arm.com, huw@codeweavers.com,
          ralf@linux-mips.org, 0x7f454c46@gmail.com, mingo@kernel.org,
          daniel.lezcano@linaro.org, salyzyn@android.com,
          paul.burton@mips.com, sthotton@marvell.com, tglx@linutronix.de,
          arnd@arndb.de
In-Reply-To: <20190621095252.32307-16-vincenzo.frascino@arm.com>
References: <20190621095252.32307-16-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: vdso: Enable vDSO compat support
Git-Commit-ID: bfe801ebe84f42b4666d3f0adde90f504d56e35b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=2.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bfe801ebe84f42b4666d3f0adde90f504d56e35b
Gitweb:     https://git.kernel.org/tip/bfe801ebe84f42b4666d3f0adde90f504d56e35b
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:42 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:09 +0200

arm64: vdso: Enable vDSO compat support

Add vDSO compat support to the arm64 build system.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Huw Davies <huw@codeweavers.com>
Link: https://lkml.kernel.org/r/20190621095252.32307-16-vincenzo.frascino@arm.com

---
 arch/arm64/Kconfig         |  1 +
 arch/arm64/Makefile        | 23 +++++++++++++++++++++--
 arch/arm64/kernel/Makefile |  6 +++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 952c9f8cf3b8..f5eb592b8579 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -108,6 +108,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_COMPAT_VDSO if (!CPU_BIG_ENDIAN && COMPAT)
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_PCI
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index e9d2e578cbe6..e3d3fd0a4268 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -49,10 +49,26 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
+ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
+  CROSS_COMPILE_COMPAT ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
+
+  ifeq ($(CONFIG_CC_IS_CLANG), y)
+    $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
+  else ifeq ($(CROSS_COMPILE_COMPAT),)
+    $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
+  else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
+    $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
+  else
+    export CROSS_COMPILE_COMPAT
+    export CONFIG_COMPAT_VDSO := y
+    compat_vdso := -DCONFIG_COMPAT_VDSO=1
+  endif
+endif
+
+KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(compat_vdso)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
-KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
+KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
@@ -164,6 +180,9 @@ ifeq ($(KBUILD_EXTMOD),)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
+		$(build)=arch/arm64/kernel/vdso32  \
+		include/generated/vdso32-offsets.h)
 endif
 
 define archhelp
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9e7dcb2c31c7..478491f07b4f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,10 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
-					   sigreturn32.o sys_compat.o
+					   sys_compat.o
+ifneq ($(CONFIG_COMPAT_VDSO), y)
+obj-$(CONFIG_COMPAT)			+= sigreturn32.o
+endif
 obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
@@ -62,6 +65,7 @@ obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 
 obj-y					+= vdso/ probes/
+obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
