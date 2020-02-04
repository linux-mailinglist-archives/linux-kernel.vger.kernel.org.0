Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFC615176E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Feb 2020 10:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBDJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Feb 2020 04:11:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbgBDJLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:11:46 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DF0E8B0DC8B86BF720F0;
        Tue,  4 Feb 2020 17:11:43 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 17:11:35 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 1/5] irqchip/gic-v4.1: Fix programming of GICR_VPROPBASER_4_1_SIZE
Date:   Tue, 4 Feb 2020 17:09:36 +0800
Message-ID: <20200204090940.1225-2-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20200204090940.1225-1-yuzenghui@huawei.com>
References: <20200204090940.1225-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Size field of GICv4.1 VPROPBASER register indicates number of
pages minus one and together Page_Size and Size control the vPEID
width. Let's respect this requirement of the architecture.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e5a25d97f8db..992bc72cab6f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2531,7 +2531,7 @@ static int allocate_vpe_l1_table(void)
 		npg = 1;
 	}
 
-	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg);
+	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg - 1);
 
 	/* Right, that's the number of CPU pages we need for L1 */
 	np = DIV_ROUND_UP(npg * psz, PAGE_SIZE);
-- 
2.19.1


