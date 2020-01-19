Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9F141D11
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 10:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgASJG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jan 2020 04:06:58 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38442 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbgASJG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 04:06:58 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0ECFB4E55211167F5BDE;
        Sun, 19 Jan 2020 17:06:55 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sun, 19 Jan 2020 17:06:45 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        "Haibin Wang" <wanghaibin.wang@huawei.com>
Subject: [PATCH] KVM: arm/arm64: vgic: Drop the kvm_vgic_register_mmio_region()
Date:   Sun, 19 Jan 2020 17:06:04 +0800
Message-ID: <20200119090604.398-1-yuzenghui@huawei.com>
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

kvm_vgic_register_mmio_region() was introduced in commit 4493b1c4866a
("KVM: arm/arm64: vgic-new: Add MMIO handling framework") but never
used, and even never implemented. Remove it to avoid confusing readers.

Reported-by: Haibin Wang <wanghaibin.wang@huawei.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 virt/kvm/arm/vgic/vgic-mmio.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.h b/virt/kvm/arm/vgic/vgic-mmio.h
index 836f418f1ee8..5af2aefad435 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.h
+++ b/virt/kvm/arm/vgic/vgic-mmio.h
@@ -98,11 +98,6 @@ extern struct kvm_io_device_ops kvm_io_gic_ops;
 		.uaccess_write = uwr,					\
 	}
 
-int kvm_vgic_register_mmio_region(struct kvm *kvm, struct kvm_vcpu *vcpu,
-				  struct vgic_register_region *reg_desc,
-				  struct vgic_io_device *region,
-				  int nr_irqs, bool offset_private);
-
 unsigned long vgic_data_mmio_bus_to_host(const void *val, unsigned int len);
 
 void vgic_data_host_to_mmio_bus(void *buf, unsigned int len,
-- 
2.19.1


