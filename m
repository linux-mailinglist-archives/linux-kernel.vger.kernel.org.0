Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3C733B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 18:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbfGXQZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 12:25:53 -0400
Received: from foss.arm.com ([217.140.110.172]:43354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbfGXQZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:25:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4C3A15A2;
        Wed, 24 Jul 2019 09:25:51 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815423F71F;
        Wed, 24 Jul 2019 09:25:50 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     james.morse@arm.com, marc.zyngier@arm.com, julien.thierry@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, Julien Grall <julien.grall@arm.com>
Subject: [PATCH v3 03/15] arm64/mm: Move bits to asid_info
Date:   Wed, 24 Jul 2019 17:25:22 +0100
Message-Id: <20190724162534.7390-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190724162534.7390-1-julien.grall@arm.com>
References: <20190724162534.7390-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable bits hold information for a given ASID allocator. So move
it to the asid_info structure.

Because most of the macros were relying on bits, they are now taking an
extra parameter that is a pointer to the asid_info structure.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 arch/arm64/mm/context.c | 59 +++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 3de028803284..49fff350e12f 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -16,7 +16,6 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
-static u32 asid_bits;
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
 
 static struct asid_info
@@ -25,6 +24,7 @@ static struct asid_info
 	unsigned long	*map;
 	atomic64_t __percpu	*active;
 	u64 __percpu		*reserved;
+	u32			bits;
 } asid_info;
 
 #define active_asid(info, cpu)	*per_cpu_ptr((info)->active, cpu)
@@ -35,17 +35,17 @@ static DEFINE_PER_CPU(u64, reserved_asids);
 
 static cpumask_t tlb_flush_pending;
 
-#define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
-#define ASID_FIRST_VERSION	(1UL << asid_bits)
+#define ASID_MASK(info)			(~GENMASK((info)->bits - 1, 0))
+#define ASID_FIRST_VERSION(info)	(1UL << ((info)->bits))
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-#define NUM_USER_ASIDS		(ASID_FIRST_VERSION >> 1)
-#define asid2idx(asid)		(((asid) & ~ASID_MASK) >> 1)
-#define idx2asid(idx)		(((idx) << 1) & ~ASID_MASK)
+#define NUM_USER_ASIDS(info)		(ASID_FIRST_VERSION(info) >> 1)
+#define asid2idx(info, asid)		(((asid) & ~ASID_MASK(info)) >> 1)
+#define idx2asid(info, idx)		(((idx) << 1) & ~ASID_MASK(info))
 #else
-#define NUM_USER_ASIDS		(ASID_FIRST_VERSION)
-#define asid2idx(asid)		((asid) & ~ASID_MASK)
-#define idx2asid(idx)		asid2idx(idx)
+#define NUM_USER_ASIDS(info)		(ASID_FIRST_VERSION(info))
+#define asid2idx(info, asid)		((asid) & ~ASID_MASK(info))
+#define idx2asid(info, idx)		asid2idx(info, idx)
 #endif
 
 /* Get the ASIDBits supported by the current CPU */
@@ -75,13 +75,13 @@ void verify_cpu_asid_bits(void)
 {
 	u32 asid = get_cpu_asid_bits();
 
-	if (asid < asid_bits) {
+	if (asid < asid_info.bits) {
 		/*
 		 * We cannot decrease the ASID size at runtime, so panic if we support
 		 * fewer ASID bits than the boot CPU.
 		 */
 		pr_crit("CPU%d: smaller ASID size(%u) than boot CPU (%u)\n",
-				smp_processor_id(), asid, asid_bits);
+				smp_processor_id(), asid, asid_info.bits);
 		cpu_panic_kernel();
 	}
 }
@@ -92,7 +92,7 @@ static void flush_context(struct asid_info *info)
 	u64 asid;
 
 	/* Update the list of reserved ASIDs and the ASID bitmap. */
-	bitmap_clear(info->map, 0, NUM_USER_ASIDS);
+	bitmap_clear(info->map, 0, NUM_USER_ASIDS(info));
 
 	for_each_possible_cpu(i) {
 		asid = atomic64_xchg_relaxed(&active_asid(info, i), 0);
@@ -105,7 +105,7 @@ static void flush_context(struct asid_info *info)
 		 */
 		if (asid == 0)
 			asid = reserved_asid(info, i);
-		__set_bit(asid2idx(asid), info->map);
+		__set_bit(asid2idx(info, asid), info->map);
 		reserved_asid(info, i) = asid;
 	}
 
@@ -148,7 +148,7 @@ static u64 new_context(struct asid_info *info, struct mm_struct *mm)
 	u64 generation = atomic64_read(&info->generation);
 
 	if (asid != 0) {
-		u64 newasid = generation | (asid & ~ASID_MASK);
+		u64 newasid = generation | (asid & ~ASID_MASK(info));
 
 		/*
 		 * If our current ASID was active during a rollover, we
@@ -161,7 +161,7 @@ static u64 new_context(struct asid_info *info, struct mm_struct *mm)
 		 * We had a valid ASID in a previous life, so try to re-use
 		 * it if possible.
 		 */
-		if (!__test_and_set_bit(asid2idx(asid), info->map))
+		if (!__test_and_set_bit(asid2idx(info, asid), info->map))
 			return newasid;
 	}
 
@@ -172,22 +172,22 @@ static u64 new_context(struct asid_info *info, struct mm_struct *mm)
 	 * a reserved TTBR0 for the init_mm and we allocate ASIDs in even/odd
 	 * pairs.
 	 */
-	asid = find_next_zero_bit(info->map, NUM_USER_ASIDS, cur_idx);
-	if (asid != NUM_USER_ASIDS)
+	asid = find_next_zero_bit(info->map, NUM_USER_ASIDS(info), cur_idx);
+	if (asid != NUM_USER_ASIDS(info))
 		goto set_asid;
 
 	/* We're out of ASIDs, so increment the global generation count */
-	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION,
+	generation = atomic64_add_return_relaxed(ASID_FIRST_VERSION(info),
 						 &info->generation);
 	flush_context(info);
 
 	/* We have more ASIDs than CPUs, so this will always succeed */
-	asid = find_next_zero_bit(info->map, NUM_USER_ASIDS, 1);
+	asid = find_next_zero_bit(info->map, NUM_USER_ASIDS(info), 1);
 
 set_asid:
 	__set_bit(asid, info->map);
 	cur_idx = asid;
-	return idx2asid(asid) | generation;
+	return idx2asid(info, asid) | generation;
 }
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
@@ -217,7 +217,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	 */
 	old_active_asid = atomic64_read(&active_asid(info, cpu));
 	if (old_active_asid &&
-	    !((asid ^ atomic64_read(&info->generation)) >> asid_bits) &&
+	    !((asid ^ atomic64_read(&info->generation)) >> info->bits) &&
 	    atomic64_cmpxchg_relaxed(&active_asid(info, cpu),
 				     old_active_asid, asid))
 		goto switch_mm_fastpath;
@@ -225,7 +225,7 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	raw_spin_lock_irqsave(&cpu_asid_lock, flags);
 	/* Check that our ASID belongs to the current generation. */
 	asid = atomic64_read(&mm->context.id);
-	if ((asid ^ atomic64_read(&info->generation)) >> asid_bits) {
+	if ((asid ^ atomic64_read(&info->generation)) >> info->bits) {
 		asid = new_context(info, mm);
 		atomic64_set(&mm->context.id, asid);
 	}
@@ -261,23 +261,24 @@ static int asids_init(void)
 {
 	struct asid_info *info = &asid_info;
 
-	asid_bits = get_cpu_asid_bits();
+	info->bits = get_cpu_asid_bits();
 	/*
 	 * Expect allocation after rollover to fail if we don't have at least
 	 * one more ASID than CPUs. ASID #0 is reserved for init_mm.
 	 */
-	WARN_ON(NUM_USER_ASIDS - 1 <= num_possible_cpus());
-	atomic64_set(&info->generation, ASID_FIRST_VERSION);
-	info->map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS), sizeof(*info->map),
-			    GFP_KERNEL);
+	WARN_ON(NUM_USER_ASIDS(info) - 1 <= num_possible_cpus());
+	atomic64_set(&info->generation, ASID_FIRST_VERSION(info));
+	info->map = kcalloc(BITS_TO_LONGS(NUM_USER_ASIDS(info)),
+			    sizeof(*info->map), GFP_KERNEL);
 	if (!info->map)
 		panic("Failed to allocate bitmap for %lu ASIDs\n",
-		      NUM_USER_ASIDS);
+		      NUM_USER_ASIDS(info));
 
 	info->active = &active_asids;
 	info->reserved = &reserved_asids;
 
-	pr_info("ASID allocator initialised with %lu entries\n", NUM_USER_ASIDS);
+	pr_info("ASID allocator initialised with %lu entries\n",
+		NUM_USER_ASIDS(info));
 	return 0;
 }
 early_initcall(asids_init);
-- 
2.11.0

