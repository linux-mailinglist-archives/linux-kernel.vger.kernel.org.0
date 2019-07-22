Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254FC6FC42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbfGVJeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 05:34:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44347 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfGVJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:34:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M9Y8FH3763174
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 02:34:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M9Y8FH3763174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563788049;
        bh=Www9SEyDdvGoBNkVTU+1M7Jek4aOoOdaCF+bB4dpfQk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qb9swNKaPMROy+30INCjtz+3Na1VjrPxN09lVtcPVm7YbE1fSoldmLbqMUME/Tuxn
         hrMYaPSA3M3f4laawTu+v3Wmnl3MUnJJU5qMB86+7QI7izlTiNYMO91WOEgUt/uooM
         s5GZVYlSS7TO14gy0n9f1n5Qqi8m/CZeN14yz8VM9GYawn9mfBh+RkjH4Nh1utYmhu
         wcj23U8mHV7dIAs+y4/6vw89GHLLfYCNVFaZx7reRRzEZ92aGHk7wxbF1Eab39vIka
         NepKpBG+Vch6+7o7U8DEx4pk8TRHXoKnWJEoLb1OMMp2VoWWpHiWnsDllel3/LWFOQ
         NiubwdevcZRnw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M9Y7c33763171;
        Mon, 22 Jul 2019 02:34:07 -0700
Date:   Mon, 22 Jul 2019 02:34:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pingfan Liu <tipbot@zytor.com>
Message-ID: <tip-69732102426b1c55a257386841fb80ec1f425d32@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        kernelfans@gmail.com, hpa@zytor.com
Reply-To: mingo@kernel.org, hpa@zytor.com, kernelfans@gmail.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1563266424-3472-1-git-send-email-kernelfans@gmail.com>
References: <1563266424-3472-1-git-send-email-kernelfans@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/realmode: Remove trampoline_status
Git-Commit-ID: 69732102426b1c55a257386841fb80ec1f425d32
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=1.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  69732102426b1c55a257386841fb80ec1f425d32
Gitweb:     https://git.kernel.org/tip/69732102426b1c55a257386841fb80ec1f425d32
Author:     Pingfan Liu <kernelfans@gmail.com>
AuthorDate: Tue, 16 Jul 2019 16:40:24 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 11:30:18 +0200

x86/realmode: Remove trampoline_status

There is no reader of trampoline_status, it's only written.

It turns out that after commit ce4b1b16502b ("x86/smpboot: Initialize
secondary CPU only if master CPU will wait for it"), trampoline_status is
not needed any more.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1563266424-3472-1-git-send-email-kernelfans@gmail.com
---
 arch/x86/include/asm/realmode.h          | 1 -
 arch/x86/kernel/smpboot.c                | 5 -----
 arch/x86/realmode/rm/header.S            | 1 -
 arch/x86/realmode/rm/trampoline_32.S     | 3 ---
 arch/x86/realmode/rm/trampoline_64.S     | 3 ---
 arch/x86/realmode/rm/trampoline_common.S | 4 ----
 6 files changed, 17 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index c53682303c9c..09ecc32f6524 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -20,7 +20,6 @@ struct real_mode_header {
 	u32	ro_end;
 	/* SMP trampoline */
 	u32	trampoline_start;
-	u32	trampoline_status;
 	u32	trampoline_header;
 #ifdef CONFIG_X86_64
 	u32	trampoline_pgd;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fdbd47ceb84d..497e9b7077c1 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1023,8 +1023,6 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		       int *cpu0_nmi_registered)
 {
-	volatile u32 *trampoline_status =
-		(volatile u32 *) __va(real_mode_header->trampoline_status);
 	/* start_ip had better be page-aligned! */
 	unsigned long start_ip = real_mode_header->trampoline_start;
 
@@ -1116,9 +1114,6 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
 		}
 	}
 
-	/* mark "stuck" area as not stuck */
-	*trampoline_status = 0;
-
 	if (x86_platform.legacy.warm_reset) {
 		/*
 		 * Cleanup possible dangling ends...
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 30b0d30d861a..6363761cc74c 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -19,7 +19,6 @@ GLOBAL(real_mode_header)
 	.long	pa_ro_end
 	/* SMP trampoline */
 	.long	pa_trampoline_start
-	.long	pa_trampoline_status
 	.long	pa_trampoline_header
 #ifdef CONFIG_X86_64
 	.long	pa_trampoline_pgd;
diff --git a/arch/x86/realmode/rm/trampoline_32.S b/arch/x86/realmode/rm/trampoline_32.S
index 2dd866c9e21e..1868b158480d 100644
--- a/arch/x86/realmode/rm/trampoline_32.S
+++ b/arch/x86/realmode/rm/trampoline_32.S
@@ -41,9 +41,6 @@ ENTRY(trampoline_start)
 
 	movl	tr_start, %eax	# where we need to go
 
-	movl	$0xA5A5A5A5, trampoline_status
-				# write marker for master knows we're running
-
 	/*
 	 * GDT tables in non default location kernel can be beyond 16MB and
 	 * lgdt will not be able to load the address as in real mode default
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 24bb7598774e..aee2b45d83b8 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -49,9 +49,6 @@ ENTRY(trampoline_start)
 	mov	%ax, %es
 	mov	%ax, %ss
 
-	movl	$0xA5A5A5A5, trampoline_status
-	# write marker for master knows we're running
-
 	# Setup stack
 	movl	$rm_stack_end, %esp
 
diff --git a/arch/x86/realmode/rm/trampoline_common.S b/arch/x86/realmode/rm/trampoline_common.S
index 7c706772ab59..8d8208dcca24 100644
--- a/arch/x86/realmode/rm/trampoline_common.S
+++ b/arch/x86/realmode/rm/trampoline_common.S
@@ -2,7 +2,3 @@
 	.section ".rodata","a"
 	.balign	16
 tr_idt: .fill 1, 6, 0
-
-	.bss
-	.balign	4
-GLOBAL(trampoline_status)	.space	4
