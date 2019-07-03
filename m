Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 260605DDD2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 07:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGCFxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 01:53:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8130 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbfGCFxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 01:53:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 60FD3EDEC9C4AF337995;
        Wed,  3 Jul 2019 13:53:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Wed, 3 Jul 2019 13:53:10 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Guan Xuetao <gxt@pku.edu.cn>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        GuanXuetao <gxt@mprc.pku.edu.cn>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH] unicore32: dma: fix to pass correct device identity to free_irq()
Date:   Wed, 3 Jul 2019 05:59:43 +0000
Message-ID: <20190703055943.141542-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_irq() expects the same device identity that was passed to
corresponding request_irq(), otherwise the IRQ is not freed.

Fixes: 10c9c10c3151 ("unicore32 core architecture: mm related: consistent device DMA handling")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/unicore32/kernel/dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/unicore32/kernel/dma.c b/arch/unicore32/kernel/dma.c
index 7a0e2d4d6077..2b8666f8a37d 100644
--- a/arch/unicore32/kernel/dma.c
+++ b/arch/unicore32/kernel/dma.c
@@ -169,7 +169,7 @@ int __init puv3_init_dma(void)
 	ret = request_irq(IRQ_DMAERR, dma_err_handler, 0, "DMAERR", NULL);
 	if (ret) {
 		printk(KERN_CRIT "Can't register IRQ for DMAERR\n");
-		free_irq(IRQ_DMA, "DMA");
+		free_irq(IRQ_DMA, NULL);
 		return ret;
 	}



