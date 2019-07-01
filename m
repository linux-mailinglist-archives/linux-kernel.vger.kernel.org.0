Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71563F905
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 14:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfD3MjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 08:39:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53756 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727599AbfD3MjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:39:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44th0d5n8nz9vD33;
        Tue, 30 Apr 2019 14:38:57 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=U74z0Sgn; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nlpAqwvcJFv9; Tue, 30 Apr 2019 14:38:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44th0d4Z4Bz9vD30;
        Tue, 30 Apr 2019 14:38:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556627937; bh=wz4z49vveZWek/d8S0CKVkTsdO2dnxqY9DcbscNvV9w=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=U74z0Sgnii6BHskqW3HdjUDm7wVXKS3lJwsnf5lQ9QRfB8AkfPqkyBrHg9+1EnDEj
         761LkboR8HSZMY2VL9bBgGGxGJtm6ukhvoIO5bJqXH0CLFV7Iqz3NUPO2hme/KAQdk
         9FJuQ0f0nkHiO2q2HlfywJf++mywtlj88oas0Ut8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F01CA8B8E1;
        Tue, 30 Apr 2019 14:38:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wo1i9I3DWNeZ; Tue, 30 Apr 2019 14:38:58 +0200 (CEST)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 96B2E8B8E0;
        Tue, 30 Apr 2019 14:38:58 +0200 (CEST)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 68591666F8; Tue, 30 Apr 2019 12:38:58 +0000 (UTC)
Message-Id: <7113d40938c410b55a3d6645d9a07da425c7d42a.1556627571.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1556627571.git.christophe.leroy@c-s.fr>
References: <cover.1556627571.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 09/16] powerpc/32: enter syscall with MSR_EE inconditionaly
 set
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 30 Apr 2019 12:38:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscalls are expected to be entered with MSR_EE set. Lets
make it inconditional by forcing MSR_EE on syscalls.

This patch adds EXC_XFER_SYS for that.

Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[splited out from benh RFC patch]

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.S        | 2 +-
 arch/powerpc/kernel/head_32.h        | 4 ++++
 arch/powerpc/kernel/head_40x.S       | 2 +-
 arch/powerpc/kernel/head_44x.S       | 2 +-
 arch/powerpc/kernel/head_8xx.S       | 2 +-
 arch/powerpc/kernel/head_booke.h     | 4 ++++
 arch/powerpc/kernel/head_fsl_booke.S | 2 +-
 7 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index fbc655aa0acf..6aa8addce296 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -371,7 +371,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_FPU_UNAVAILABLE)
 	DO_KVM  0xc00
 SystemCall:
 	EXCEPTION_PROLOG
-	EXC_XFER_EE_LITE(0xc00, DoSyscall)
+	EXC_XFER_SYS(0xc00, DoSyscall)
 
 /* Single step - not used on 601 */
 	EXCEPTION(0xd00, SingleStep, single_step_exception, EXC_XFER_STD)
diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index aa0131bb09b5..7221418a883f 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -123,6 +123,10 @@
 	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
 
+#define EXC_XFER_SYS(n, hdlr)		\
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL | MSR_EE, NOCOPY, transfer_to_handler, \
+			  ret_from_except)
+
 #define EXC_XFER_EE(n, hdlr)		\
 	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE, transfer_to_handler_full, \
 			  ret_from_except_full)
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index cce9bd33a176..1a80a3e45e44 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -350,7 +350,7 @@ _ENTRY(saved_ksp_limit)
 /* 0x0C00 - System Call Exception */
 	START_EXCEPTION(0x0C00,	SystemCall)
 	EXCEPTION_PROLOG
-	EXC_XFER_EE_LITE(0xc00, DoSyscall)
+	EXC_XFER_SYS(0xc00, DoSyscall)
 
 	EXCEPTION(0x0D00, Trap_0D, unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x0E00, Trap_0E, unknown_exception, EXC_XFER_EE)
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 37117ab11584..9cc01948651f 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -283,7 +283,7 @@ interrupt_base:
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
 	NORMAL_EXCEPTION_PROLOG(BOOKE_INTERRUPT_SYSCALL)
-	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
+	EXC_XFER_SYS(0x0c00, DoSyscall)
 
 	/* Auxiliary Processor Unavailable Interrupt */
 	EXCEPTION(0x2020, BOOKE_INTERRUPT_AP_UNAVAIL, \
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 7b76ad1b9620..19ad6484f198 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -186,7 +186,7 @@ Alignment:
 	. = 0xc00
 SystemCall:
 	EXCEPTION_PROLOG
-	EXC_XFER_EE_LITE(0xc00, DoSyscall)
+	EXC_XFER_SYS(0xc00, DoSyscall)
 
 /* Single step - not used on 601 */
 	EXCEPTION(0xd00, SingleStep, single_step_exception, EXC_XFER_STD)
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 1b22a8dea399..612f54ba1125 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -251,6 +251,10 @@ END_BTB_FLUSH_SECTION
 	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
 			  ret_from_except)
 
+#define EXC_XFER_SYS(n, hdlr)						\
+	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL | MSR_EE, NOCOPY, transfer_to_handler, \
+			  ret_from_except)
+
 #define EXC_XFER_EE(n, hdlr)		\
 	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE, transfer_to_handler_full, \
 			  ret_from_except_full)
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 32332e24e421..e77a2ed94642 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -411,7 +411,7 @@ interrupt_base:
 	/* System Call Interrupt */
 	START_EXCEPTION(SystemCall)
 	NORMAL_EXCEPTION_PROLOG(SYSCALL)
-	EXC_XFER_EE_LITE(0x0c00, DoSyscall)
+	EXC_XFER_SYS(0x0c00, DoSyscall)
 
 	/* Auxiliary Processor Unavailable Interrupt */
 	EXCEPTION(0x2900, AP_UNAVAIL, AuxillaryProcessorUnavailable, \
-- 
2.13.3

