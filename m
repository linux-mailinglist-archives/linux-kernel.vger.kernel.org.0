Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6990160
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 14:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfHPMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 08:25:07 -0400
Received: from foss.arm.com ([217.140.110.172]:55900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbfHPMZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:25:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83655344;
        Fri, 16 Aug 2019 05:25:04 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A1D33F706;
        Fri, 16 Aug 2019 05:25:03 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC v4 17/18] arm64: kernel: Annotate non-standard stack frame functions
Date:   Fri, 16 Aug 2019 13:24:02 +0100
Message-Id: <20190816122403.14994-18-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816122403.14994-1-raphael.gault@arm.com>
References: <20190816122403.14994-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate assembler functions which are callable but do not
setup a correct stack frame.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/kernel/hyp-stub.S | 3 +++
 arch/arm64/kvm/hyp-init.S    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index 73d46070b315..8917d42f38c7 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -6,6 +6,7 @@
  * Author:	Marc Zyngier <marc.zyngier@arm.com>
  */
 
+#include <linux/frame.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/irqchip/arm-gic-v3.h>
@@ -42,6 +43,7 @@ ENTRY(__hyp_stub_vectors)
 	ventry	el1_fiq_invalid			// FIQ 32-bit EL1
 	ventry	el1_error_invalid		// Error 32-bit EL1
 ENDPROC(__hyp_stub_vectors)
+asm_stack_frame_non_standard __hyp_stub_vectors
 
 	.align 11
 
@@ -69,6 +71,7 @@ el1_sync:
 9:	mov	x0, xzr
 	eret
 ENDPROC(el1_sync)
+asm_stack_frame_non_standard el1_sync
 
 .macro invalid_vector	label
 \label:
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 160be2b4696d..63deea39313d 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -12,6 +12,7 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/sysreg.h>
 #include <asm/virt.h>
+#include <linux/frame.h>
 
 	.text
 	.pushsection	.hyp.idmap.text, "ax"
@@ -118,6 +119,7 @@ CPU_BE(	orr	x4, x4, #SCTLR_ELx_EE)
 	/* Hello, World! */
 	eret
 ENDPROC(__kvm_hyp_init)
+asm_stack_frame_non_standard __kvm_hyp_init
 
 ENTRY(__kvm_handle_stub_hvc)
 	cmp	x0, #HVC_SOFT_RESTART
@@ -159,6 +161,7 @@ reset:
 	eret
 
 ENDPROC(__kvm_handle_stub_hvc)
+asm_stack_frame_non_standard __kvm_handle_stub_hvc
 
 	.ltorg
 
-- 
2.17.1

