Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDA41B4F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 15:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfIQNnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 09:43:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfIQNnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:43:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3346628;
        Tue, 17 Sep 2019 06:43:31 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D1A1D3F575;
        Tue, 17 Sep 2019 06:43:29 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>
Subject: [PATCH 2/4] arm64: trap to EL1 accesses to AMU counters from EL0
Date:   Tue, 17 Sep 2019 14:42:26 +0100
Message-Id: <20190917134228.5369-3-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190917134228.5369-1-ionela.voinescu@arm.com>
References: <20190917134228.5369-1-ionela.voinescu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The activity monitors extension is an optional extension introduced
by the ARMv8.4 CPU architecture. In order to access the activity
monitors counters safely, if desired, the kernel should detect the
presence of the extension through the feature register, and mediate
the access.

Therefore, disable direct accesses to activity monitors counters
from EL0 (userspace) and trap them to EL1 (kernel).

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/assembler.h | 10 ++++++++++
 arch/arm64/mm/proc.S               |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index b8cf7c85ffa2..894fc8bf8102 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -443,6 +443,16 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 9000:
 	.endm
 
+/*
+ * reset_amuserenr_el0 - reset AMUSERENR_EL0 if AMUv1 present
+ */
+	.macro	reset_amuserenr_el0, tmpreg
+	mrs	\tmpreg, id_aa64pfr0_el1	// Check ID_AA64PFR0_EL1
+	ubfx	\tmpreg, \tmpreg, #ID_AA64PFR0_AMU_SHIFT, #4
+	cbz	\tmpreg, 9000f			// Skip if no AMU present
+	msr_s	SYS_AMUSERENR_EL0, xzr		// Disable AMU access from EL0
+9000:
+	.endm
 /*
  * copy_page - copy src to dest using temp registers t1-t8
  */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index a1e0592d1fbc..d8aae1152c08 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -124,6 +124,7 @@ alternative_endif
 	ubfx	x11, x11, #1, #1
 	msr	oslar_el1, x11
 	reset_pmuserenr_el0 x0			// Disable PMU access from EL0
+	reset_amuserenr_el0 x0			// Disable AMU access from EL0
 
 alternative_if ARM64_HAS_RAS_EXTN
 	msr_s	SYS_DISR_EL1, xzr
@@ -415,6 +416,8 @@ ENTRY(__cpu_setup)
 	isb					// Unmask debug exceptions now,
 	enable_dbg				// since this is per-cpu
 	reset_pmuserenr_el0 x0			// Disable PMU access from EL0
+	reset_amuserenr_el0 x0			// Disable AMU access from EL0
+
 	/*
 	 * Memory region attributes for LPAE:
 	 *
-- 
2.17.1

