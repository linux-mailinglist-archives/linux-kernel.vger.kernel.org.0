Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC64CE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 15:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbfFTNHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 09:07:16 -0400
Received: from foss.arm.com ([217.140.110.172]:36756 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731975AbfFTNG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:06:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 317B7C0A;
        Thu, 20 Jun 2019 06:06:29 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D122C3F718;
        Thu, 20 Jun 2019 06:06:27 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [RFC v2 04/14] arm64/mm: Move the variable lock and tlb_flush_pending to asid_info
Date:   Thu, 20 Jun 2019 14:05:58 +0100
Message-Id: <20190620130608.17230-5-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190620130608.17230-1-julien.grall@arm.com>
References: <20190620130608.17230-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variables lock and tlb_flush_pending holds information for a given
ASID allocator. So move them to the asid_info structure.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 7883347ece52..6457a9310fe4 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -27,8 +27,6 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
-static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
-
 static struct asid_info
 {
 	atomic64_t	generation;
@@ -36,6 +34,9 @@ static struct asid_info
 	atomic64_t __percpu	*active;
 	u64 __percpu		*reserved;
 	u32			bits;
+	raw_spinlock_t		lock;
+	/* Which CPU requires context flush on next call */
+	cpumask_t		flush_pending;
 } asid_info;
 
 #define active_asid(info, cpu)	*per_cpu_ptr((info)->active, cpu)
@@ -44,8 +45,6 @@ static struct asid_info
 static DEFINE_PER_CPU(atomic64_t, active_asids);
 static DEFINE_PER_CPU(u64, reserved_asids);
 
-static cpumask_t tlb_flush_pending;
-
 #define ASID_MASK(info)			(~GENMASK((info)->bits - 1, 0))
 #define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))
 
@@ -124,7 +123,7 @@ static void flush_context(struct asid_info *info)
 	 * Queue a TLB invalidation for each CPU to perform on next
 	 * context-switch
 	 */
-	cpumask_setall(&tlb_flush_pending);
+	cpumask_setall(&info->flush_pending);
 }
 
 static bool check_update_reserved_asid(struct asid_info *info, u64 asid,
@@ -233,7 +232,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 				     old_active_asid, asid))
 		goto switch_mm_fastpath;
 
-	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+	raw_spin_lock_irqsave(&info->lock, flags);
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
 	if ((asid ^ atomic64_read(&info->generation)) >> info->bits) {
@@ -241,11 +240,11 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 		atomic64_set(&mm->context.id, asid);
 	}
 
-	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+	if (cpumask_test_and_clear_cpu(cpu, &info->flush_pending))
 		local_flush_tlb_all();
 
 	atomic64_set(&active_asid(info, cpu), asid);
-	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+	raw_spin_unlock_irqrestore(&info->lock, flags);
 
 switch_mm_fastpath:
 
@@ -288,6 +287,8 @@ static int asids_init(void)
 	info->active = &active_asids;
 	info->reserved = &reserved_asids;
 
+	raw_spin_lock_init(&info->lock);
+
 	pr_info("ASID allocator initialised with %lu entries\n",
 		NUM_USER_ASIDS(info));
 	return 0;
-- 
2.11.0

