Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1AE11CA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2019 11:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfLLKNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Dec 2019 05:13:45 -0500
Received: from foss.arm.com ([217.140.110.172]:41010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfLLKNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:13:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CCA2328;
        Thu, 12 Dec 2019 02:13:44 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 03A913F6CF;
        Thu, 12 Dec 2019 02:13:39 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: [PATCH] arm64: Introduce ISAR6 CPU ID register
Date:   Thu, 12 Dec 2019 15:44:23 +0530
Message-Id: <1576145663-9909-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds basic building blocks required for ISAR6 CPU ID register which
identifies support for various instruction implementation on AArch32 state.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: kvmarm@lists.cs.columbia.edu
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/cpu.h    | 1 +
 arch/arm64/include/asm/sysreg.h | 9 +++++++++
 arch/arm64/kernel/cpufeature.c  | 7 ++++++-
 arch/arm64/kernel/cpuinfo.c     | 1 +
 arch/arm64/kvm/sys_regs.c       | 2 +-
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index d72d995..b4a4053 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -39,6 +39,7 @@ struct cpuinfo_arm64 {
 	u32		reg_id_isar3;
 	u32		reg_id_isar4;
 	u32		reg_id_isar5;
+	u32		reg_id_isar6;
 	u32		reg_id_mmfr0;
 	u32		reg_id_mmfr1;
 	u32		reg_id_mmfr2;
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 6db3a9b..4fd3327 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -146,6 +146,7 @@
 #define SYS_ID_ISAR4_EL1		sys_reg(3, 0, 0, 2, 4)
 #define SYS_ID_ISAR5_EL1		sys_reg(3, 0, 0, 2, 5)
 #define SYS_ID_MMFR4_EL1		sys_reg(3, 0, 0, 2, 6)
+#define SYS_ID_ISAR6_EL1		sys_reg(3, 0, 0, 2, 7)
 
 #define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
 #define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
@@ -683,6 +684,14 @@
 #define ID_ISAR5_AES_SHIFT		4
 #define ID_ISAR5_SEVL_SHIFT		0
 
+#define ID_ISAR6_JSCVT_SHIFT		0
+#define ID_ISAR6_DP_SHIFT		4
+#define ID_ISAR6_FHM_SHIFT		8
+#define ID_ISAR6_SB_SHIFT		12
+#define ID_ISAR6_SPECRES_SHIFT		16
+#define ID_ISAR6_BF16_SHIFT		20
+#define ID_ISAR6_I8MM_SHIFT		24
+
 #define MVFR0_FPROUND_SHIFT		28
 #define MVFR0_FPSHVEC_SHIFT		24
 #define MVFR0_FPSQRT_SHIFT		20
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f344cea..3b9ac8b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -346,7 +346,7 @@ static const struct arm64_ftr_bits ftr_zcr[] = {
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
  * 0. Covers the following 32bit registers:
- * id_isar[0-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
+ * id_isar[0-4, 6], id_mmfr[1-3], id_pfr1, mvfr[0-1]
  */
 static const struct arm64_ftr_bits ftr_generic_32bits[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
@@ -399,6 +399,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_ISAR4_EL1, ftr_generic_32bits),
 	ARM64_FTR_REG(SYS_ID_ISAR5_EL1, ftr_id_isar5),
 	ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),
+	ARM64_FTR_REG(SYS_ID_ISAR6_EL1, ftr_generic_32bits),
 
 	/* Op1 = 0, CRn = 0, CRm = 3 */
 	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_generic_32bits),
@@ -603,6 +604,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
 		init_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
 		init_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
+		init_cpu_ftr_reg(SYS_ID_ISAR6_EL1, info->reg_id_isar6);
 		init_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
 		init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
 		init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
@@ -756,6 +758,8 @@ void update_cpu_features(int cpu,
 					info->reg_id_isar4, boot->reg_id_isar4);
 		taint |= check_update_ftr_reg(SYS_ID_ISAR5_EL1, cpu,
 					info->reg_id_isar5, boot->reg_id_isar5);
+		taint |= check_update_ftr_reg(SYS_ID_ISAR6_EL1, cpu,
+					info->reg_id_isar6, boot->reg_id_isar6);
 
 		/*
 		 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
@@ -834,6 +838,7 @@ static u64 __read_sysreg_by_encoding(u32 sys_id)
 	read_sysreg_case(SYS_ID_ISAR3_EL1);
 	read_sysreg_case(SYS_ID_ISAR4_EL1);
 	read_sysreg_case(SYS_ID_ISAR5_EL1);
+	read_sysreg_case(SYS_ID_ISAR6_EL1);
 	read_sysreg_case(SYS_MVFR0_EL1);
 	read_sysreg_case(SYS_MVFR1_EL1);
 	read_sysreg_case(SYS_MVFR2_EL1);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 10121f5..6005d38 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -362,6 +362,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 		info->reg_id_isar3 = read_cpuid(ID_ISAR3_EL1);
 		info->reg_id_isar4 = read_cpuid(ID_ISAR4_EL1);
 		info->reg_id_isar5 = read_cpuid(ID_ISAR5_EL1);
+		info->reg_id_isar6 = read_cpuid(ID_ISAR6_EL1);
 		info->reg_id_mmfr0 = read_cpuid(ID_MMFR0_EL1);
 		info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
 		info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7dadd24..a6b8ca1 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1424,7 +1424,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	ID_SANITISED(ID_ISAR4_EL1),
 	ID_SANITISED(ID_ISAR5_EL1),
 	ID_SANITISED(ID_MMFR4_EL1),
-	ID_UNALLOCATED(2,7),
+	ID_SANITISED(ID_ISAR6_EL1),
 
 	/* CRm=3 */
 	ID_SANITISED(MVFR0_EL1),
-- 
2.7.4

