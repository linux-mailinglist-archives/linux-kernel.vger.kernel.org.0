Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA12139D50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 00:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgAMXbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 18:31:13 -0500
Received: from foss.arm.com ([217.140.110.172]:45652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbgAMXbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:31:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D953F11B3;
        Mon, 13 Jan 2020 15:31:12 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BFBF73F68E;
        Mon, 13 Jan 2020 15:31:11 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        mark.rutland@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 2/7] arm64: fpsimd: Make sure SVE setup is complete before SIMD is used
Date:   Mon, 13 Jan 2020 23:30:18 +0000
Message-Id: <20200113233023.928028-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113233023.928028-1-suzuki.poulose@arm.com>
References: <20200113233023.928028-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-kernel users of NEON rely on may_use_simd() to check if the SIMD
can be used. However, we must initialize the SVE before SIMD can
be used. Add a sanity check to make sure that we have completed the
SVE setup before anyone uses the SIMD.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v2:
  - Add WARN_ON() in may_use_simd() if invoked before caps
    are finalized()
---
 arch/arm64/include/asm/simd.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
index 7434844036d3..89cba2622b79 100644
--- a/arch/arm64/include/asm/simd.h
+++ b/arch/arm64/include/asm/simd.h
@@ -26,6 +26,8 @@ DECLARE_PER_CPU(bool, fpsimd_context_busy);
 static __must_check inline bool may_use_simd(void)
 {
 	/*
+	 * We must make sure that the SVE has been initialized properly
+	 * before using the SIMD in kernel.
 	 * fpsimd_context_busy is only set while preemption is disabled,
 	 * and is clear whenever preemption is enabled. Since
 	 * this_cpu_read() is atomic w.r.t. preemption, fpsimd_context_busy
@@ -33,8 +35,10 @@ static __must_check inline bool may_use_simd(void)
 	 * migrated, and if it's clear we cannot be migrated to a CPU
 	 * where it is set.
 	 */
-	return !in_irq() && !irqs_disabled() && !in_nmi() &&
-		!this_cpu_read(fpsimd_context_busy);
+	return !WARN_ON(!system_capabilities_finalized()) &&
+	       system_supports_fpsimd() &&
+	       !in_irq() && !irqs_disabled() && !in_nmi() &&
+	       !this_cpu_read(fpsimd_context_busy);
 }
 
 #else /* ! CONFIG_KERNEL_MODE_NEON */
-- 
2.24.1

