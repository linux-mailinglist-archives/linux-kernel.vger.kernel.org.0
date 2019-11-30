Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6BD10DC3A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2019 04:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfK3DP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Nov 2019 22:15:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfK3DP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 22:15:58 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4D0FFA083DCA239A0AD2;
        Sat, 30 Nov 2019 11:15:57 +0800 (CST)
Received: from linux-XCyijm.huawei.com (10.175.104.212) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 30 Nov 2019 11:15:49 +0800
From:   Heyi Guo <guoheyi@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>, Heyi Guo <guoheyi@huawei.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] kvm/arm64: change gicv3_cpuif to static likely branch
Date:   Sat, 30 Nov 2019 11:14:43 +0800
Message-ID: <20191130031443.41696-1-guoheyi@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platforms running hypervisor nowadays are normally powerful servers
which at least support GICv3, so it should be better to switch
kvm_vgic_global_state.gicv3_cpuif to static likely branch, which can
reduce two "b" instructions to a single "nop" for GICv3 branches.

We don't update arm32 specific code for they may still only have
GICv2.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/switch.c   | 4 ++--
 include/kvm/arm_vgic.h        | 2 +-
 virt/kvm/arm/vgic/vgic-init.c | 9 +++++----
 virt/kvm/arm/vgic/vgic.c      | 9 +++++----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 799e84a40335..57e7d314211a 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -219,7 +219,7 @@ static void __hyp_text __deactivate_vm(struct kvm_vcpu *vcpu)
 /* Save VGICv3 state on non-VHE systems */
 static void __hyp_text __hyp_vgic_save_state(struct kvm_vcpu *vcpu)
 {
-	if (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif)) {
+	if (static_branch_likely(&kvm_vgic_global_state.gicv3_cpuif)) {
 		__vgic_v3_save_state(vcpu);
 		__vgic_v3_deactivate_traps(vcpu);
 	}
@@ -228,7 +228,7 @@ static void __hyp_text __hyp_vgic_save_state(struct kvm_vcpu *vcpu)
 /* Restore VGICv3 state on non_VEH systems */
 static void __hyp_text __hyp_vgic_restore_state(struct kvm_vcpu *vcpu)
 {
-	if (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif)) {
+	if (static_branch_likely(&kvm_vgic_global_state.gicv3_cpuif)) {
 		__vgic_v3_activate_traps(vcpu);
 		__vgic_v3_restore_state(vcpu);
 	}
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index af4f09c02bf1..474e73dd3112 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -72,7 +72,7 @@ struct vgic_global {
 	bool			has_gicv4;
 
 	/* GIC system register CPU interface */
-	struct static_key_false gicv3_cpuif;
+	struct static_key_true gicv3_cpuif;
 
 	u32			ich_vtr_el2;
 };
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 6f50c429196d..b03e5c8e1731 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -509,13 +509,14 @@ int kvm_vgic_hyp_init(void)
 	switch (gic_kvm_info->type) {
 	case GIC_V2:
 		ret = vgic_v2_probe(gic_kvm_info);
+		if (!ret) {
+			static_branch_disable(
+				&kvm_vgic_global_state.gicv3_cpuif);
+			kvm_info("GIC system register CPU interface disabled\n");
+		}
 		break;
 	case GIC_V3:
 		ret = vgic_v3_probe(gic_kvm_info);
-		if (!ret) {
-			static_branch_enable(&kvm_vgic_global_state.gicv3_cpuif);
-			kvm_info("GIC system register CPU interface enabled\n");
-		}
 		break;
 	default:
 		ret = -ENODEV;
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index 45a870cb63f5..9dafeeb1457b 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -18,7 +18,7 @@
 #include "trace.h"
 
 struct vgic_global kvm_vgic_global_state __ro_after_init = {
-	.gicv3_cpuif = STATIC_KEY_FALSE_INIT,
+	.gicv3_cpuif = STATIC_KEY_TRUE_INIT,
 };
 
 /*
@@ -841,12 +841,13 @@ static inline bool can_access_vgic_from_kernel(void)
 	 * memory-mapped, and VHE systems can access GICv3 EL2 system
 	 * registers.
 	 */
-	return !static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif) || has_vhe();
+	return !static_branch_likely(&kvm_vgic_global_state.gicv3_cpuif) ||
+	       has_vhe();
 }
 
 static inline void vgic_save_state(struct kvm_vcpu *vcpu)
 {
-	if (!static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
+	if (!static_branch_likely(&kvm_vgic_global_state.gicv3_cpuif))
 		vgic_v2_save_state(vcpu);
 	else
 		__vgic_v3_save_state(vcpu);
@@ -873,7 +874,7 @@ void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
 
 static inline void vgic_restore_state(struct kvm_vcpu *vcpu)
 {
-	if (!static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif))
+	if (!static_branch_likely(&kvm_vgic_global_state.gicv3_cpuif))
 		vgic_v2_restore_state(vcpu);
 	else
 		__vgic_v3_restore_state(vcpu);
-- 
2.19.1

