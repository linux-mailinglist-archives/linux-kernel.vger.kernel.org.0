Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F5153F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 08:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgBFH6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 02:58:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728129AbgBFH6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:58:40 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EA65DF750A52A2234C2B;
        Thu,  6 Feb 2020 15:58:37 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 6 Feb 2020 15:58:27 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 6/6] irqchip/gic-v3-its: Rename VPENDBASER/VPROPBASER accessors
Date:   Thu, 6 Feb 2020 15:57:11 +0800
Message-ID: <20200206075711.1275-7-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200206075711.1275-1-yuzenghui@huawei.com>
References: <20200206075711.1275-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V{PEND,PROP}BASER registers are actually located in VLPI_base frame
of the *redistributor*. Rename their accessors to reflect this fact.

No functional changes.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 arch/arm/include/asm/arch_gicv3.h   | 12 ++++++------
 arch/arm64/include/asm/arch_gicv3.h |  8 ++++----
 drivers/irqchip/irq-gic-v3-its.c    | 28 ++++++++++++++--------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/include/asm/arch_gicv3.h b/arch/arm/include/asm/arch_gicv3.h
index b5752f0e8936..c815477b4303 100644
--- a/arch/arm/include/asm/arch_gicv3.h
+++ b/arch/arm/include/asm/arch_gicv3.h
@@ -326,16 +326,16 @@ static inline u64 __gic_readq_nonatomic(const volatile void __iomem *addr)
 #define gits_write_cwriter(v, c)	__gic_writeq_nonatomic(v, c)
 
 /*
- * GITS_VPROPBASER - hi and lo bits may be accessed independently.
+ * GICR_VPROPBASER - hi and lo bits may be accessed independently.
  */
-#define gits_read_vpropbaser(c)		__gic_readq_nonatomic(c)
-#define gits_write_vpropbaser(v, c)	__gic_writeq_nonatomic(v, c)
+#define gicr_read_vpropbaser(c)		__gic_readq_nonatomic(c)
+#define gicr_write_vpropbaser(v, c)	__gic_writeq_nonatomic(v, c)
 
 /*
- * GITS_VPENDBASER - the Valid bit must be cleared before changing
+ * GICR_VPENDBASER - the Valid bit must be cleared before changing
  * anything else.
  */
-static inline void gits_write_vpendbaser(u64 val, void __iomem *addr)
+static inline void gicr_write_vpendbaser(u64 val, void __iomem *addr)
 {
 	u32 tmp;
 
@@ -352,7 +352,7 @@ static inline void gits_write_vpendbaser(u64 val, void __iomem *addr)
 	__gic_writeq_nonatomic(val, addr);
 }
 
-#define gits_read_vpendbaser(c)		__gic_readq_nonatomic(c)
+#define gicr_read_vpendbaser(c)		__gic_readq_nonatomic(c)
 
 static inline bool gic_prio_masking_enabled(void)
 {
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 4750fc8030c3..25fec4bde43a 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -140,11 +140,11 @@ static inline u32 gic_read_rpr(void)
 #define gicr_write_pendbaser(v, c)	writeq_relaxed(v, c)
 #define gicr_read_pendbaser(c)		readq_relaxed(c)
 
-#define gits_write_vpropbaser(v, c)	writeq_relaxed(v, c)
-#define gits_read_vpropbaser(c)		readq_relaxed(c)
+#define gicr_write_vpropbaser(v, c)	writeq_relaxed(v, c)
+#define gicr_read_vpropbaser(c)		readq_relaxed(c)
 
-#define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
-#define gits_read_vpendbaser(c)		readq_relaxed(c)
+#define gicr_write_vpendbaser(v, c)	writeq_relaxed(v, c)
+#define gicr_read_vpendbaser(c)		readq_relaxed(c)
 
 static inline bool gic_prio_masking_enabled(void)
 {
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 811875bf3abb..1ee95f546cb0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2429,7 +2429,7 @@ static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
 		 * ours wrt CommonLPIAff. Let's use its own VPROPBASER.
 		 * Make sure we don't write the Z bit in that case.
 		 */
-		val = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
+		val = gicr_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
 		val &= ~GICR_VPROPBASER_4_1_Z;
 
 		gic_data_rdist()->vpe_l1_base = gic_data_rdist_cpu(cpu)->vpe_l1_base;
@@ -2452,7 +2452,7 @@ static bool allocate_vpe_l2_table(int cpu, u32 id)
 	if (!gic_rdists->has_rvpeid)
 		return true;
 
-	val  = gits_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
+	val  = gicr_read_vpropbaser(base + SZ_128K + GICR_VPROPBASER);
 
 	esz  = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val) + 1;
 	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
@@ -2524,8 +2524,8 @@ static int allocate_vpe_l1_table(void)
 	 * effect of making sure no doorbell will be generated and we can
 	 * then safely clear VPROPBASER.Valid.
 	 */
-	if (gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER) & GICR_VPENDBASER_Valid)
-		gits_write_vpendbaser(GICR_VPENDBASER_PendingLast,
+	if (gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER) & GICR_VPENDBASER_Valid)
+		gicr_write_vpendbaser(GICR_VPENDBASER_PendingLast,
 				      vlpi_base + GICR_VPENDBASER);
 
 	/*
@@ -2548,8 +2548,8 @@ static int allocate_vpe_l1_table(void)
 
 	/* First probe the page size */
 	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
-	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
-	val = gits_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
+	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	val = gicr_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
 	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
 	esz = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val);
 
@@ -2620,7 +2620,7 @@ static int allocate_vpe_l1_table(void)
 	val |= GICR_VPROPBASER_4_1_VALID;
 
 out:
-	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 	cpumask_set_cpu(smp_processor_id(), gic_data_rdist()->vpe_table_mask);
 
 	pr_debug("CPU%d: VPROPBASER = %llx %*pbl\n",
@@ -2727,14 +2727,14 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
 	bool clean;
 	u64 val;
 
-	val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+	val = gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 	val &= ~GICR_VPENDBASER_Valid;
 	val &= ~clr;
 	val |= set;
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 
 	do {
-		val = gits_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
+		val = gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 		clean = !(val & GICR_VPENDBASER_Dirty);
 		if (!clean) {
 			count--;
@@ -2849,7 +2849,7 @@ static void its_cpu_init_lpis(void)
 		val = (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
 		pr_debug("GICv4: CPU%d: Init IDbits to 0x%llx for GICR_VPROPBASER\n",
 			smp_processor_id(), val);
-		gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+		gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 
 		/*
 		 * Also clear Valid bit of GICR_VPENDBASER, in case some
@@ -3523,7 +3523,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val |= (LPI_NRBITS - 1) & GICR_VPROPBASER_IDBITS_MASK;
 	val |= GICR_VPROPBASER_RaWb;
 	val |= GICR_VPROPBASER_InnerShareable;
-	gits_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
+	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 
 	val  = virt_to_phys(page_address(vpe->vpt_page)) &
 		GENMASK_ULL(51, 16);
@@ -3541,7 +3541,7 @@ static void its_vpe_schedule(struct its_vpe *vpe)
 	val |= GICR_VPENDBASER_PendingLast;
 	val |= vpe->idai ? GICR_VPENDBASER_IDAI : 0;
 	val |= GICR_VPENDBASER_Valid;
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 }
 
 static void its_vpe_deschedule(struct its_vpe *vpe)
@@ -3741,7 +3741,7 @@ static void its_vpe_4_1_schedule(struct its_vpe *vpe,
 	val |= info->g1en ? GICR_VPENDBASER_4_1_VGRP1EN : 0;
 	val |= FIELD_PREP(GICR_VPENDBASER_4_1_VPEID, vpe->vpe_id);
 
-	gits_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
 }
 
 static void its_vpe_4_1_deschedule(struct its_vpe *vpe,
-- 
2.19.1


