Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D900015DADE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgBNP03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 10:26:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgBNP02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:26:28 -0500
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9862424649;
        Fri, 14 Feb 2020 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581693987;
        bh=SgTjIAaM95kqOXyHnwAO1PZvRTAkVYcps3rUAVhvSpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCaZTu7t+6nbZXtdlBvEI+Mmk2X6Wzh+0HOePLY2omun/hUDKwkNEg3WOzQqUbDF3
         euM1mnfagGzxyj5OORC6d+HMh1a1Rt12fU7db+T4eFNGBvM+Dg9Z+26I/ujWAkRent
         lC57Mda11FDzvfU9IJKxA5TeDOSMe4Pp5Z+SFcV4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 1/5] x86/entry: Remove _TIF_NOHZ from _TIF_WORK_SYSCALL_ENTRY
Date:   Fri, 14 Feb 2020 16:26:11 +0100
Message-Id: <20200214152615.25447-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214152615.25447-1-frederic@kernel.org>
References: <20200214152615.25447-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Evaluating _TIF_NOHZ to decide whether to use the slow syscall entry path
is not only pointless, it's actually counterproductive:

 1) Context tracking code is invoked unconditionally before that flag is
    evaluated.

 2) If the flag is set the slow path is invoked for nothing due to #1

Remove it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/include/asm/thread_info.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index cf4327986e98..6cb9d1b0d1e6 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -133,14 +133,10 @@ struct thread_info {
 #define _TIF_X32		(1 << TIF_X32)
 #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
 
-/*
- * work to do in syscall_trace_enter().  Also includes TIF_NOHZ for
- * enter_from_user_mode()
- */
+/* Work to do before invoking the actual syscall. */
 #define _TIF_WORK_SYSCALL_ENTRY	\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
-	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT |	\
-	 _TIF_NOHZ)
+	 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\
-- 
2.25.0

