Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68A01139D53
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jan 2020 00:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgAMXbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jan 2020 18:31:25 -0500
Received: from foss.arm.com ([217.140.110.172]:45686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbgAMXbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 18:31:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 601111424;
        Mon, 13 Jan 2020 15:31:24 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 462193F68E;
        Mon, 13 Jan 2020 15:31:23 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, maz@kernel.org,
        catalin.marinas@arm.com, ard.biesheuvel@linaro.org,
        mark.rutland@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v3 4/7] arm64: cpufeature: Set the FP/SIMD compat HWCAP bits properly
Date:   Mon, 13 Jan 2020 23:30:20 +0000
Message-Id: <20200113233023.928028-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200113233023.928028-1-suzuki.poulose@arm.com>
References: <20200113233023.928028-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We set the compat_elf_hwcap bits unconditionally on arm64 to
include the VFP and NEON support. However, the FP/SIMD unit
is optional on Arm v8 and thus could be missing. We already
handle this properly in the kernel, but still advertise to
the COMPAT applications that the VFP is available. Fix this
to make sure we only advertise when we really have them.

Fixes: 82e0191a1aa11abf ("arm64: Support systems without FP/ASIMD")
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 37 +++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7c373722f692..f0eb0f57ca8d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -32,9 +32,7 @@ static unsigned long elf_hwcap __read_mostly;
 #define COMPAT_ELF_HWCAP_DEFAULT	\
 				(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
 				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
-				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
-				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
-				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV|\
+				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_IDIV|\
 				 COMPAT_HWCAP_LPAE)
 unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
 unsigned int compat_elf_hwcap2 __read_mostly;
@@ -1669,6 +1667,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.match_list = list,						\
 	}
 
+#define HWCAP_CAP_MATCH(match, cap_type, cap)					\
+	{									\
+		__HWCAP_CAP(#cap, cap_type, cap)				\
+		.matches = match,						\
+	}
+
 #ifdef CONFIG_ARM64_PTR_AUTH
 static const struct arm64_cpu_capabilities ptr_auth_hwcap_addr_matches[] = {
 	{
@@ -1742,8 +1746,35 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	{},
 };
 
+#ifdef CONFIG_COMPAT
+static bool compat_has_neon(const struct arm64_cpu_capabilities *cap, int scope)
+{
+	/*
+	 * Check that all of MVFR1_EL1.{SIMDSP, SIMDInt, SIMDLS} are available,
+	 * in line with that of arm32 as in vfp_init(). We make sure that the
+	 * check is future proof, by making sure value is non-zero.
+	 */
+	u32 mvfr1;
+
+	WARN_ON(scope == SCOPE_LOCAL_CPU && preemptible());
+	if (scope == SCOPE_SYSTEM)
+		mvfr1 = read_sanitised_ftr_reg(SYS_MVFR1_EL1);
+	else
+		mvfr1 = read_sysreg_s(SYS_MVFR1_EL1);
+
+	return cpuid_feature_extract_unsigned_field(mvfr1, MVFR1_SIMDSP_SHIFT) &&
+		cpuid_feature_extract_unsigned_field(mvfr1, MVFR1_SIMDINT_SHIFT) &&
+		cpuid_feature_extract_unsigned_field(mvfr1, MVFR1_SIMDLS_SHIFT);
+}
+#endif
+
 static const struct arm64_cpu_capabilities compat_elf_hwcaps[] = {
 #ifdef CONFIG_COMPAT
+	HWCAP_CAP_MATCH(compat_has_neon, CAP_COMPAT_HWCAP, COMPAT_HWCAP_NEON),
+	HWCAP_CAP(SYS_MVFR1_EL1, MVFR1_SIMDFMAC_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFPv4),
+	/* Arm v8 mandates MVFR0.FPDP == {0, 2}. So, piggy back on this for the presence of VFP support */
+	HWCAP_CAP(SYS_MVFR0_EL1, MVFR0_FPDP_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFP),
+	HWCAP_CAP(SYS_MVFR0_EL1, MVFR0_FPDP_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP, COMPAT_HWCAP_VFPv3),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 2, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_PMULL),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_AES_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_AES),
 	HWCAP_CAP(SYS_ID_ISAR5_EL1, ID_ISAR5_SHA1_SHIFT, FTR_UNSIGNED, 1, CAP_COMPAT_HWCAP2, COMPAT_HWCAP2_SHA1),
-- 
2.24.1

