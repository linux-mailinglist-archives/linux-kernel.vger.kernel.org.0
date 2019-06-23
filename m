Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9542A4FE74
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 03:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfFXBmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jun 2019 21:42:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfFXBk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5NNndhx2859114
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 16:49:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5NNndhx2859114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561333780;
        bh=mFKcQ1+D55JQfF+eRIrzjmc6S00ykEXF+NZqkSbdho0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=H3BOPDyF/mKzbsoDbqSgWVAtGco6/i3WnYSKPsgQsd4dYDMHPb0FGaN73kHgu0qTk
         dQJML9WvRHzrSE3/bH5oYS2IXfb1cfc4Lw6Ur6r2uXIpqp9SV6mhjilg1t6M4B1w30
         MlDVNE1MWftps6tP4FKMhFQKOlE+CInhp6GS7D2TEfgTCqtZHHoko7jsM+UPkS1CIO
         NZOGJ7Qz+LWvV86m2zVBRoWpCfc1GOHSPX5FGpv+Gmu/mU7BznNwxbkSEhbg2aeH6A
         yDzizJLArGKPkQDOunzEChMmKbLx1QD1JNN/58x2HgCJdYqJsNVLdPMpDYmoTfVpYS
         rmjk3YUij4gbA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5NNndJm2859111;
        Sun, 23 Jun 2019 16:49:39 -0700
Date:   Sun, 23 Jun 2019 16:49:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincenzo Frascino <tipbot@zytor.com>
Message-ID: <tip-206c0dfa3c55bf31f9d78da3d7384b9343745153@git.kernel.org>
Cc:     shuah@kernel.org, pcc@google.com, paul.burton@mips.com,
        0x7f454c46@gmail.com, catalin.marinas@arm.com,
        sthotton@marvell.com, salyzyn@android.com, huw@codeweavers.com,
        tglx@linutronix.de, ralf@linux-mips.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, andre.przywara@arm.com,
        mingo@kernel.org, linux@rasmusvillemoes.dk,
        vincenzo.frascino@arm.com, arnd@arndb.de, hpa@zytor.com,
        will.deacon@arm.com, daniel.lezcano@linaro.org
Reply-To: ralf@linux-mips.org, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, andre.przywara@arm.com,
          linux@armlinux.org.uk, linux@rasmusvillemoes.dk,
          vincenzo.frascino@arm.com, arnd@arndb.de,
          daniel.lezcano@linaro.org, will.deacon@arm.com, hpa@zytor.com,
          pcc@google.com, shuah@kernel.org, paul.burton@mips.com,
          0x7f454c46@gmail.com, catalin.marinas@arm.com,
          sthotton@marvell.com, huw@codeweavers.com, salyzyn@android.com
In-Reply-To: <20190621095252.32307-8-vincenzo.frascino@arm.com>
References: <20190621095252.32307-8-vincenzo.frascino@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/vdso] arm64: compat: Expose signal related structures
Git-Commit-ID: 206c0dfa3c55bf31f9d78da3d7384b9343745153
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

Commit-ID:  206c0dfa3c55bf31f9d78da3d7384b9343745153
Gitweb:     https://git.kernel.org/tip/206c0dfa3c55bf31f9d78da3d7384b9343745153
Author:     Vincenzo Frascino <vincenzo.frascino@arm.com>
AuthorDate: Fri, 21 Jun 2019 10:52:34 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 21:21:07 +0200

arm64: compat: Expose signal related structures

The compat signal data structures are required as part of the compat
vDSO implementation in order to provide the unwinding information for
the sigreturn trampolines.

Expose these data structures as part of signal32.h.

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
Link: https://lkml.kernel.org/r/20190621095252.32307-8-vincenzo.frascino@arm.com

---
 arch/arm64/include/asm/signal32.h | 46 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal32.c      | 46 ---------------------------------------
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 0418c67f2b8b..bd43d1cf724b 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -9,6 +9,52 @@
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
+struct compat_sigcontext {
+	/* We always set these two fields to 0 */
+	compat_ulong_t			trap_no;
+	compat_ulong_t			error_code;
+
+	compat_ulong_t			oldmask;
+	compat_ulong_t			arm_r0;
+	compat_ulong_t			arm_r1;
+	compat_ulong_t			arm_r2;
+	compat_ulong_t			arm_r3;
+	compat_ulong_t			arm_r4;
+	compat_ulong_t			arm_r5;
+	compat_ulong_t			arm_r6;
+	compat_ulong_t			arm_r7;
+	compat_ulong_t			arm_r8;
+	compat_ulong_t			arm_r9;
+	compat_ulong_t			arm_r10;
+	compat_ulong_t			arm_fp;
+	compat_ulong_t			arm_ip;
+	compat_ulong_t			arm_sp;
+	compat_ulong_t			arm_lr;
+	compat_ulong_t			arm_pc;
+	compat_ulong_t			arm_cpsr;
+	compat_ulong_t			fault_address;
+};
+
+struct compat_ucontext {
+	compat_ulong_t			uc_flags;
+	compat_uptr_t			uc_link;
+	compat_stack_t			uc_stack;
+	struct compat_sigcontext	uc_mcontext;
+	compat_sigset_t			uc_sigmask;
+	int 				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
+	compat_ulong_t			uc_regspace[128] __attribute__((__aligned__(8)));
+};
+
+struct compat_sigframe {
+	struct compat_ucontext	uc;
+	compat_ulong_t		retcode[2];
+};
+
+struct compat_rt_sigframe {
+	struct compat_siginfo info;
+	struct compat_sigframe sig;
+};
+
 int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		       struct pt_regs *regs);
 int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 331d1e5acad4..8a9a5ceb63b7 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -19,42 +19,6 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
-struct compat_sigcontext {
-	/* We always set these two fields to 0 */
-	compat_ulong_t			trap_no;
-	compat_ulong_t			error_code;
-
-	compat_ulong_t			oldmask;
-	compat_ulong_t			arm_r0;
-	compat_ulong_t			arm_r1;
-	compat_ulong_t			arm_r2;
-	compat_ulong_t			arm_r3;
-	compat_ulong_t			arm_r4;
-	compat_ulong_t			arm_r5;
-	compat_ulong_t			arm_r6;
-	compat_ulong_t			arm_r7;
-	compat_ulong_t			arm_r8;
-	compat_ulong_t			arm_r9;
-	compat_ulong_t			arm_r10;
-	compat_ulong_t			arm_fp;
-	compat_ulong_t			arm_ip;
-	compat_ulong_t			arm_sp;
-	compat_ulong_t			arm_lr;
-	compat_ulong_t			arm_pc;
-	compat_ulong_t			arm_cpsr;
-	compat_ulong_t			fault_address;
-};
-
-struct compat_ucontext {
-	compat_ulong_t			uc_flags;
-	compat_uptr_t			uc_link;
-	compat_stack_t			uc_stack;
-	struct compat_sigcontext	uc_mcontext;
-	compat_sigset_t			uc_sigmask;
-	int		__unused[32 - (sizeof (compat_sigset_t) / sizeof (int))];
-	compat_ulong_t	uc_regspace[128] __attribute__((__aligned__(8)));
-};
-
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
 	compat_ulong_t	size;
@@ -81,16 +45,6 @@ struct compat_aux_sigframe {
 	unsigned long			end_magic;
 } __attribute__((__aligned__(8)));
 
-struct compat_sigframe {
-	struct compat_ucontext	uc;
-	compat_ulong_t		retcode[2];
-};
-
-struct compat_rt_sigframe {
-	struct compat_siginfo info;
-	struct compat_sigframe sig;
-};
-
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
 static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
