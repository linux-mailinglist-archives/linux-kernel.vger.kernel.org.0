Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B008198A66
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Mar 2020 05:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgCaDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 23:13:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51152 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727614AbgCaDND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 23:13:03 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D69B58F96A35E84F5A46;
        Tue, 31 Mar 2020 11:12:59 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 31 Mar 2020 11:12:52 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvmarm@lists.cs.columbia.edu>
CC:     <maz@kernel.org>, <eric.auger@redhat.com>,
        <andre.przywara@arm.com>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm64: vgic-v3: Clear pending bit in guest memory after synchronization
Date:   Tue, 31 Mar 2020 11:12:45 +0800
Message-ID: <20200331031245.1562-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When LPI support is enabled at redistributor level, VGIC will potentially
load the correspond LPI penging table and sync it into the pending_latch.
To avoid keeping the 'consumed' pending bits lying around in guest memory
(though they're not used), let's clear them after synchronization.

The similar work had been done in vgic_v3_lpi_sync_pending_status().

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/vgic/vgic-its.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index d53d34a33e35..905760bfa404 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -435,6 +435,7 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 
 	for (i = 0; i < nr_irqs; i++) {
 		int byte_offset, bit_nr;
+		bool status;
 
 		byte_offset = intids[i] / BITS_PER_BYTE;
 		bit_nr = intids[i] % BITS_PER_BYTE;
@@ -447,22 +448,32 @@ static int its_sync_lpi_pending_table(struct kvm_vcpu *vcpu)
 			ret = kvm_read_guest_lock(vcpu->kvm,
 						  pendbase + byte_offset,
 						  &pendmask, 1);
-			if (ret) {
-				kfree(intids);
-				return ret;
-			}
+			if (ret)
+				goto out;
 			last_byte_offset = byte_offset;
 		}
 
+		status = pendmask & (1 << bit_nr);
+
 		irq = vgic_get_irq(vcpu->kvm, NULL, intids[i]);
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
-		irq->pending_latch = pendmask & (1U << bit_nr);
+		irq->pending_latch = status;
 		vgic_queue_irq_unlock(vcpu->kvm, irq, flags);
 		vgic_put_irq(vcpu->kvm, irq);
+
+		if (status) {
+			/* clear consumed data */
+			pendmask &= ~(1 << bit_nr);
+			ret = kvm_write_guest_lock(vcpu->kvm,
+						   pendbase + byte_offset,
+						   &pendmask, 1);
+			if (ret)
+				goto out;
+		}
 	}
 
+out:
 	kfree(intids);
-
 	return ret;
 }
 
-- 
2.19.1


