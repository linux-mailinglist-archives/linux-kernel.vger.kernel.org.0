Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61088FC960
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 16:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKNPAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 10:00:11 -0500
Received: from foss.arm.com ([217.140.110.172]:44650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbfKNPAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:00:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84A00328;
        Thu, 14 Nov 2019 07:00:04 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 663033F52E;
        Thu, 14 Nov 2019 07:00:03 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, james.morse@arm.com, will@kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH 5/5] KVM: arm/arm64: Don't invoke defacto-CnP on first run
Date:   Thu, 14 Nov 2019 14:59:18 +0000
Message-Id: <20191114145918.235339-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191114145918.235339-1-suzuki.poulose@arm.com>
References: <20191114145918.235339-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

When KVM finds itself switching between two vCPUs of the same VM
on one physical CPU it has to invalidate the TLB for this VMID
to avoid unintended sharing of TLB entries between vCPU.

This is done by tracking the 'last_vcpu_ran' as a percpu variable
for each vm.

kvm_arch_init_vm() is careful to initialise these to an impossible
vcpu id, but we never check for this. The first time
vm_arch_vcpu_load() is called on a new physical CPU, we will fail
the last_ran check and invalidate the TLB.

Now that we have an errata workaround in this path, it means we
trigger the workaround whenever a guest is migrated to a new CPU.

Check for the impossible vcpu id, and skip defacto-CnP.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 virt/kvm/arm/arm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index ac9e017df7c9..6f729739cf6f 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -366,7 +366,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	 * We might get preempted before the vCPU actually runs, but
 	 * over-invalidation doesn't affect correctness.
 	 */
-	if (*last_ran != vcpu->vcpu_id) {
+	if (*last_ran != -1 && *last_ran != vcpu->vcpu_id) {
 		kvm_call_hyp(__kvm_tlb_flush_local_vmid, vcpu);
 
 		/*
@@ -374,9 +374,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		 *  conditions for Cortex-A77 erratum 1542418.
 		 */
 		kvm_workaround_1542418_vmid_rollover();
-
-		*last_ran = vcpu->vcpu_id;
 	}
+	*last_ran = vcpu->vcpu_id;
 
 	vcpu->cpu = cpu;
 	vcpu->arch.host_cpu_context = &cpu_data->host_ctxt;
-- 
2.23.0

