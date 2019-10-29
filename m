Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50BACE8201
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 08:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfJ2HU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 03:20:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727927AbfJ2HUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:20:25 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3C181374D1B2EC7E14A6;
        Tue, 29 Oct 2019 15:20:22 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Tue, 29 Oct 2019 15:20:16 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>, <eric.auger@redhat.com>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 2/3] KVM: arm/arm64: vgic: Fix some comments typo
Date:   Tue, 29 Oct 2019 15:19:18 +0800
Message-ID: <20191029071919.177-3-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20191029071919.177-1-yuzenghui@huawei.com>
References: <20191029071919.177-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/vgic_its_save_pending_tables/vgic_v3_save_pending_tables/
s/then/the/

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 include/kvm/arm_vgic.h      | 2 +-
 virt/kvm/arm/vgic/vgic-v3.c | 2 +-
 virt/kvm/arm/vgic/vgic-v4.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 0fb240ec0a2a..01f8b3739a09 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -240,7 +240,7 @@ struct vgic_dist {
 	 * Contains the attributes and gpa of the LPI configuration table.
 	 * Since we report GICR_TYPER.CommonLPIAff as 0b00, we can share
 	 * one address across all redistributors.
-	 * GICv3 spec: 6.1.2 "LPI Configuration tables"
+	 * GICv3 spec "LPI Configuration tables"
 	 */
 	u64			propbaser;
 
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 8d69f007dd0c..5ef93e5041e1 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -357,7 +357,7 @@ int vgic_v3_lpi_sync_pending_status(struct kvm *kvm, struct vgic_irq *irq)
 }
 
 /**
- * vgic_its_save_pending_tables - Save the pending tables into guest RAM
+ * vgic_v3_save_pending_tables - Save the pending tables into guest RAM
  * kvm lock and all vcpu lock must be held
  */
 int vgic_v3_save_pending_tables(struct kvm *kvm)
diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index 477af6aebb97..d864cf8dd212 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -266,7 +266,7 @@ int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
 
 	mutex_lock(&its->its_lock);
 
-	/* Perform then actual DevID/EventID -> LPI translation. */
+	/* Perform the actual DevID/EventID -> LPI translation. */
 	ret = vgic_its_resolve_lpi(kvm, its, irq_entry->msi.devid,
 				   irq_entry->msi.data, &irq);
 	if (ret)
-- 
2.19.1


