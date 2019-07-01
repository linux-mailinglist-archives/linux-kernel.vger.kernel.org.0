Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27FFF21E53
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 21:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfEQTcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 15:32:32 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:34286 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729078AbfEQTc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:32:29 -0400
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BDFBEC0089;
        Fri, 17 May 2019 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1558121554; bh=xwShkLhGy3zJDGrFbam8j04SOieQnSppOd9GEqzu0dE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dK3t8gO76eLp1t9s1rlBpvAcnbu8QC6djE43BZymiAt8v/TRI1I3ZGT9aiuees+CE
         Rc/5n1X6KjNqLVX6KqB9hVJf96O7RV60dMm8oqeGWVGELG0XPpt4ERdx3z+KJ4n3qX
         jvGpY5bMvjG+MayTFhY+lMRcMObhSf74GdgMEgjvILmhk2afbpe59RHzF81HLuGlcV
         eMSznEcMGXeGRB98HEq+9iG02PuZmLl6isA3NkSW5FkF5J+gQni8rcCpodxB6ykJ76
         L720fYiXKswUWfayqv2+IARTxK78iA3GmkHpa91H3EyLIJVllM6PnkfvxoEalDqHke
         ZaOUyfvMhrvvw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8F9C1A009E;
        Fri, 17 May 2019 19:32:26 +0000 (UTC)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 17 May 2019 12:32:26 -0700
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:36 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.89) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 18 May 2019 01:02:23 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 1/5] ARCv2: entry: comments about hardware auto-save on taken interrupts
Date:   Fri, 17 May 2019 12:32:04 -0700
Message-ID: <1558121528-30184-2-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558121528-30184-1-git-send-email-vgupta@synopsys.com>
References: <1558121528-30184-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.89]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/include/asm/entry-arcv2.h | 78 ++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/arch/arc/include/asm/entry-arcv2.h b/arch/arc/include/asm/entry-arcv2.h
index 225e7df2d8ed..1c3520d1fa42 100644
--- a/arch/arc/include/asm/entry-arcv2.h
+++ b/arch/arc/include/asm/entry-arcv2.h
@@ -7,15 +7,54 @@
 #include <asm/irqflags-arcv2.h>
 #include <asm/thread_info.h>	/* For THREAD_SIZE */
 
+/*
+ * Interrupt/Exception stack layout (pt_regs) for ARCv2
+ *   (End of struct aligned to end of page [unless nested])
+ *
+ *  INTERRUPT                          EXCEPTION
+ *
+ *    manual    ---------------------  manual
+ *              |      orig_r0      |
+ *              |      event/ECR    |
+ *              |      bta          |
+ *              |      user_r25     |
+ *              |      gp           |
+ *              |      fp           |
+ *              |      sp           |
+ *              |      r12          |
+ *              |      r30          |
+ *              |      r58          |
+ *              |      r59          |
+ *  hw autosave ---------------------
+ *    optional  |      r0           |
+ *              |      r1           |
+ *              ~                   ~
+ *              |      r9           |
+ *              |      r10          |
+ *              |      r11          |
+ *              |      blink        |
+ *              |      lpe          |
+ *              |      lps          |
+ *              |      lpc          |
+ *              |      ei base      |
+ *              |      ldi base     |
+ *              |      jli base     |
+ *              ---------------------
+ *  hw autosave |       pc / eret   |
+ *   mandatory  | stat32 / erstatus |
+ *              ---------------------
+ */
+
 /*------------------------------------------------------------------------*/
 .macro INTERRUPT_PROLOGUE	called_from
-
-	; Before jumping to Interrupt Vector, hardware micro-ops did following:
+	; (A) Before jumping to Interrupt Vector, hardware micro-ops did following:
 	;   1. SP auto-switched to kernel mode stack
-	;   2. STATUS32.Z flag set to U mode at time of interrupt (U:1, K:0)
-	;   3. Auto saved: r0-r11, blink, LPE,LPS,LPC, JLI,LDI,EI, PC, STAT32
+	;   2. STATUS32.Z flag set if in U mode at time of interrupt (U:1,K:0)
+	;   3. Auto save: (mandatory) Push PC and STAT32 on stack
+	;                 hardware does even if CONFIG_ARC_IRQ_NO_AUTOSAVE
+	;   4. Auto save: (optional) r0-r11, blink, LPE,LPS,LPC, JLI,LDI,EI
 	;
-	; Now manually save: r12, sp, fp, gp, r25
+	; (B) Manually saved some regs: r12,r25,r30, sp,fp,gp, ACCL pair
 
 #ifdef CONFIG_ARC_IRQ_NO_AUTOSAVE
 .ifnc \called_from, exception
@@ -57,14 +96,17 @@
 	;  - U mode: retrieve it from AUX_USER_SP
 	;  - K mode: add the offset from current SP where H/w starts auto push
 	;
-	; Utilize the fact that Z bit is set if Intr taken in U mode
+	; 1. Utilize the fact that Z bit is set if Intr taken in U mode
+	; 2. Upon entry SP is always saved (for any inspection, unwinding etc),
+	;    but on return, restored only if U mode
+
 	mov.nz	r9, sp
-	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4
+	add.nz	r9, r9, SZ_PT_REGS - PT_sp - 4		; K mode SP
 	bnz	1f
 
-	lr	r9, [AUX_USER_SP]
+	lr	r9, [AUX_USER_SP]			; U mode SP
 1:
-	PUSH	r9	; SP
+	PUSH	r9					; SP (pt_regs->sp)
 
 	PUSH	fp
 	PUSH	gp
@@ -85,6 +127,8 @@
 /*------------------------------------------------------------------------*/
 .macro INTERRUPT_EPILOGUE	called_from
 
+	; INPUT: r0 has STAT32 of calling context
+	; INPUT: Z flag set if returning to K mode
 .ifnc \called_from, exception
 	add	sp, sp, 12	; skip BTA/ECR/orig_r0 placeholderss
 .endif
@@ -98,9 +142,10 @@
 	POP	gp
 	POP	fp
 
-	; Don't touch AUX_USER_SP if returning to K mode (Z bit set)
-	; (Z bit set on K mode is inverse of INTERRUPT_PROLOGUE)
-	add.z	sp, sp, 4
+	; Restore SP (into AUX_USER_SP) only if returning to U mode
+	;  - for K mode, it will be implicitly restored as stack is unwound
+	;  - Z flag set on K is inverse of what hardware does on interrupt entry
+	;    but that doesn't really matter
 	bz	1f
 
 	POPAX	AUX_USER_SP
@@ -145,11 +190,11 @@
 /*------------------------------------------------------------------------*/
 .macro EXCEPTION_PROLOGUE
 
-	; Before jumping to Exception Vector, hardware micro-ops did following:
+	; (A) Before jumping to Exception Vector, hardware micro-ops did following:
 	;   1. SP auto-switched to kernel mode stack
-	;   2. STATUS32.Z flag set to U mode at time of interrupt (U:1,K:0)
+	;   2. STATUS32.Z flag set if in U mode at time of exception (U:1,K:0)
 	;
-	; Now manually save the complete reg file
+	; (B) Manually save the complete reg file below
 
 	PUSH	r9		; freeup a register: slot of erstatus
 
@@ -195,12 +240,13 @@
 	PUSHAX	ecr		; r9 contains ECR, expected by EV_Trap
 
 	PUSH	r0		; orig_r0
+	; OUTPUT: r9 has ECR
 .endm
 
 /*------------------------------------------------------------------------*/
 .macro EXCEPTION_EPILOGUE
 
-	; Assumes r0 has PT_status32
+	; INPUT: r0 has STAT32 of calling context
 	btst   r0, STATUS_U_BIT	; Z flag set if K, used in INTERRUPT_EPILOGUE
 
 	add	sp, sp, 8	; orig_r0/ECR don't need restoring
-- 
2.7.4

