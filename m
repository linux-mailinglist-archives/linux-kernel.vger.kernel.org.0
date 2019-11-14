Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1756FC513
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 12:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKNLHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 06:07:34 -0500
Received: from foss.arm.com ([217.140.110.172]:40710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbfKNLHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:07:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB4E6328;
        Thu, 14 Nov 2019 03:07:30 -0800 (PST)
Received: from e112269-lin.cambridge.arm.com (e112269-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84F063F6C4;
        Thu, 14 Nov 2019 03:07:29 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v4 3/3] arm64: Workaround for Cortex-A55 erratum 1530923
Date:   Thu, 14 Nov 2019 11:06:58 +0000
Message-Id: <20191114110658.20560-4-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191114110658.20560-1-steven.price@arm.com>
References: <20191114110658.20560-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cortex-A55 erratum 1530923 allows TLB entries to be allocated as a
result of a speculative AT instruction. This may happen in the middle of
a guest world switch while the relevant VMSA configuration is in an
inconsistent state, leading to erroneous content being allocated into
TLBs.

The same workaround as is used for Cortex-A76 erratum 1165522
(WORKAROUND_SPECULATIVE_AT_VHE) can be used here. Note that this
mandates the use of VHE on affected parts.

Signed-off-by: Steven Price <steven.price@arm.com>
---
 Documentation/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                     | 13 +++++++++++++
 arch/arm64/include/asm/kvm_hyp.h       |  4 ++--
 arch/arm64/kernel/cpu_errata.c         |  6 +++++-
 arch/arm64/kvm/hyp/switch.c            |  4 ++--
 arch/arm64/kvm/hyp/tlb.c               |  4 ++--
 6 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 899a72570282..b40cb3e0634e 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -88,6 +88,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A55      | #1530923        | ARM64_ERRATUM_1530923       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index defb68e45387..aa9b8a9a6910 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -532,6 +532,19 @@ config ARM64_ERRATUM_1165522
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_1530923
+	bool "Cortex-A55: Speculative AT instruction using out-of-context translation regime could cause subsequent request to generate an incorrect translation"
+	default y
+	select ARM64_WORKAROUND_SPECULATIVE_AT_VHE
+	help
+	  This option adds a workaround for ARM Cortex-A55 erratum 1530923.
+
+	  Affected Cortex-A55 cores (r0p0, r0p1, r1p0, r2p0) could end-up with
+	  corrupted TLBs by speculating an AT instruction during a guest
+	  context switch.
+
+	  If unsure, say Y.
+
 config ARM64_ERRATUM_1286807
 	bool "Cortex-A76: Modification of the translation table for a virtual address might lead to read-after-read ordering violation"
 	default y
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 167a161dd596..a3a6a2ba9a63 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -91,8 +91,8 @@ static __always_inline void __hyp_text __load_guest_stage2(struct kvm *kvm)
 	write_sysreg(kvm_get_vttbr(kvm), vttbr_el2);
 
 	/*
-	 * ARM erratum 1165522 requires the actual execution of the above
-	 * before we can switch to the EL1/EL0 translation regime used by
+	 * ARM errata 1165522 and 1530923 require the actual execution of the
+	 * above before we can switch to the EL1/EL0 translation regime used by
 	 * the guest.
 	 */
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT_VHE));
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index c7f1f5398a44..c01e20317394 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -749,6 +749,10 @@ static const struct midr_range erratum_speculative_at_vhe_list[] = {
 #ifdef CONFIG_ARM64_ERRATUM_1165522
 	/* Cortex A76 r0p0 to r2p0 */
 	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_1530923
+	/* Cortex A55 r0p0 to r2p0 */
+	MIDR_RANGE(MIDR_CORTEX_A55, 0, 0, 2, 0),
 #endif
 	{},
 };
@@ -880,7 +884,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT_VHE
 	{
-		.desc = "ARM erratum 1165522",
+		.desc = "ARM errata 1165522, 1530923",
 		.capability = ARM64_WORKAROUND_SPECULATIVE_AT_VHE,
 		ERRATA_MIDR_RANGE_LIST(erratum_speculative_at_vhe_list),
 	},
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 0fc824bdf258..eae08ba82e95 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -158,8 +158,8 @@ static void deactivate_traps_vhe(void)
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
 
 	/*
-	 * ARM erratum 1165522 requires the actual execution of the above
-	 * before we can switch to the EL2/EL0 translation regime used by
+	 * ARM errata 1165522 and 1530923 require the actual execution of the
+	 * above before we can switch to the EL2/EL0 translation regime used by
 	 * the host.
 	 */
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT_VHE));
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index ff4e73c9bafc..92f560e3e1aa 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -25,8 +25,8 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 
 	if (cpus_have_const_cap(ARM64_WORKAROUND_SPECULATIVE_AT_VHE)) {
 		/*
-		 * For CPUs that are affected by ARM erratum 1165522, we
-		 * cannot trust stage-1 to be in a correct state at that
+		 * For CPUs that are affected by ARM errata 1165522 or 1530923,
+		 * we cannot trust stage-1 to be in a correct state at that
 		 * point. Since we do not want to force a full load of the
 		 * vcpu state, we prevent the EL1 page-table walker to
 		 * allocate new TLBs. This is done by setting the EPD bits
-- 
2.20.1

