Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF5525685
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 19:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfEURV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 13:21:58 -0400
Received: from foss.arm.com ([217.140.101.70]:39108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728127AbfEURV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:21:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEA4115A2;
        Tue, 21 May 2019 10:21:57 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76F4A3F718;
        Tue, 21 May 2019 10:21:55 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        james.morse@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        ard.biesheuvel@linaro.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v5 2/3] arch/arm64: fpsimd: Introduce fpsimd_save_and_flush_cpu_state() and use it
Date:   Tue, 21 May 2019 18:21:38 +0100
Message-Id: <20190521172139.21277-3-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190521172139.21277-1-julien.grall@arm.com>
References: <20190521172139.21277-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only external user of fpsimd_save() and fpsimd_flush_cpu_state() is
the KVM FPSIMD code.

A following patch will introduce a mechanism to acquire owernship of the
FPSIMD/SVE context for performing context management operations. Rather
than having to export the new helpers to get/put the context, we can just
introduce a new function to combine fpsimd_save() and
fpsimd_flush_cpu_state().

This has also the advantage to remove any external call of fpsimd_save()
and fpsimd_flush_cpu_state(), so they can be turned static.

Lastly, the new function can also be used in the PM notifier.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>

---
    kernel_neon_begin() does not use fpsimd_save_and_flush_cpu_state()
    because the next patch will modify the function to also grab the
    FPSIMD/SVE context.

    Changes in v4:
        - Remove newline before the new prototype
        - Add Dave's reviewed-by

    Changes in v3:
        - Rework the commit message
        - Move the prototype of fpsimd_save_and_flush_cpu_state()
        further down in the header
        - Remove comment in kvm_arch_vcpu_put_fp()

    Changes in v2:
        - Patch added
---
 arch/arm64/include/asm/fpsimd.h |  4 +---
 arch/arm64/kernel/fpsimd.c      | 17 +++++++++++++----
 arch/arm64/kvm/fpsimd.c         |  4 +---
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index b73d12fcc7f9..4154851c21ab 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -48,8 +48,6 @@ struct task_struct;
 extern void fpsimd_save_state(struct user_fpsimd_state *state);
 extern void fpsimd_load_state(struct user_fpsimd_state *state);
 
-extern void fpsimd_save(void);
-
 extern void fpsimd_thread_switch(struct task_struct *next);
 extern void fpsimd_flush_thread(void);
 
@@ -63,7 +61,7 @@ extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
 				     void *sve_state, unsigned int sve_vl);
 
 extern void fpsimd_flush_task_state(struct task_struct *target);
-extern void fpsimd_flush_cpu_state(void);
+extern void fpsimd_save_and_flush_cpu_state(void);
 
 /* Maximum VL that SVE VL-agnostic software can transparently support */
 #define SVE_VL_ARCH_MAX 0x100
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index a38bf74bcca8..6448921a2f59 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -246,7 +246,7 @@ static void task_fpsimd_load(void)
  *
  * Softirqs (and preemption) must be disabled.
  */
-void fpsimd_save(void)
+static void fpsimd_save(void)
 {
 	struct fpsimd_last_state_struct const *last =
 		this_cpu_ptr(&fpsimd_last_state);
@@ -1122,12 +1122,22 @@ void fpsimd_flush_task_state(struct task_struct *t)
  * Invalidate any task's FPSIMD state that is present on this cpu.
  * This function must be called with softirqs disabled.
  */
-void fpsimd_flush_cpu_state(void)
+static void fpsimd_flush_cpu_state(void)
 {
 	__this_cpu_write(fpsimd_last_state.st, NULL);
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
+/*
+ * Save the FPSIMD state to memory and invalidate cpu view.
+ * This function must be called with softirqs (and preemption) disabled.
+ */
+void fpsimd_save_and_flush_cpu_state(void)
+{
+	fpsimd_save();
+	fpsimd_flush_cpu_state();
+}
+
 #ifdef CONFIG_KERNEL_MODE_NEON
 
 DEFINE_PER_CPU(bool, kernel_neon_busy);
@@ -1284,8 +1294,7 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 {
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		fpsimd_save();
-		fpsimd_flush_cpu_state();
+		fpsimd_save_and_flush_cpu_state();
 		break;
 	case CPU_PM_EXIT:
 		break;
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index 6e3c9c8b2df9..525010504f9d 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -112,9 +112,7 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.flags & KVM_ARM64_FP_ENABLED) {
 		u64 *guest_zcr = &vcpu->arch.ctxt.sys_regs[ZCR_EL1];
 
-		/* Clean guest FP state to memory and invalidate cpu view */
-		fpsimd_save();
-		fpsimd_flush_cpu_state();
+		fpsimd_save_and_flush_cpu_state();
 
 		if (guest_has_sve)
 			*guest_zcr = read_sysreg_s(SYS_ZCR_EL12);
-- 
2.11.0

