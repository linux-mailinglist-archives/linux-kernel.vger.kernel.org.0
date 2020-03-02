Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD13F1756E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgCBJWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 04:22:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727383AbgCBJWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:22:22 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 542D2877FE3F9071A0B5;
        Mon,  2 Mar 2020 17:22:18 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Mar 2020 17:22:11 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v4.1: Wait for completion of redistributor's INVALL operation
Date:   Mon, 2 Mar 2020 17:21:45 +0800
Message-ID: <20200302092145.899-1-yuzenghui@huawei.com>
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

In GICv4.1, we emulate a guest-issued INVALL command by a direct write
to GICR_INVALLR.  Before we finish the emulation and go back to guest,
let's make sure the physical invalidate operation is actually completed
and no stale data will be left in redistributor. Per the specification,
this can be achieved by polling the GICR_SYNCR.Busy bit (to zero).

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 83b1186ffcad..fc8c2970cee4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3784,6 +3784,8 @@ static void its_vpe_4_1_invall(struct its_vpe *vpe)
 	/* Target the redistributor this vPE is currently known on */
 	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
 	gic_write_lpir(val, rdbase + GICR_INVALLR);
+
+	wait_for_syncr(rdbase);
 }
 
 static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
-- 
2.19.1


