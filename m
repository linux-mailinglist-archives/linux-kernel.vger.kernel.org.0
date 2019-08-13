Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5BC8BD83
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfHMPrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 11:47:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbfHMPry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vOVF1bL6OtEC3ny1W9eKFWhCTN+KLHMSW/CBbgd+PKs=; b=at/oFKaXhxx9WSbNQk/O9DhxVQ
        c0vXeVBysRRgl8deLC6F3KmHtIi+3CuLDzd3ddBlwUnyelHMAmMo3TZcOizl/OooXaeqQHVmG0MoM
        A33wD+ojWw2HTjHPHZWuYHshbrmabSBX0X2K6Os40efCJae2ySrBCz75oemVg97UY+cLe1AxjwJyE
        hZll8Shf35U6G8aeAA5KDGI8J9htH1SO7LkiPrnKcOyKO0GJ3naZHJfUiwYMnXf7qbXBMVVrf6X9n
        9lC9J21T60NIUfpFiiXyfCt1HjsN25kBZIUE/YE4eVOPBz+fcvn/E/XIe/bv/bCMD6LAPD/GO0PGg
        kIa8OWqg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxZ1c-0004i8-3Q; Tue, 13 Aug 2019 15:47:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] irqchip/sifive-plic: set max threshold for ignored handlers
Date:   Tue, 13 Aug 2019 17:47:33 +0200
Message-Id: <20190813154747.24256-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813154747.24256-1-hch@lst.de>
References: <20190813154747.24256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running in M-mode we still the S-mode plic handlers in the DT.
Ignore them by setting the maximum threshold.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/irqchip/irq-sifive-plic.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index cf755964f2f8..c72c036aea76 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -244,6 +244,7 @@ static int __init plic_init(struct device_node *node,
 		struct plic_handler *handler;
 		irq_hw_number_t hwirq;
 		int cpu, hartid;
+		u32 threshold = 0;
 
 		if (of_irq_parse_one(node, i, &parent)) {
 			pr_err("failed to parse parent for context %d.\n", i);
@@ -266,10 +267,16 @@ static int __init plic_init(struct device_node *node,
 			continue;
 		}
 
+		/*
+		 * When running in M-mode we need to ignore the S-mode handler.
+		 * Here we assume it always comes later, but that might be a
+		 * little fragile.
+		 */
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
 			pr_warn("handler already present for context %d.\n", i);
-			continue;
+			threshold = 0xffffffff;
+			goto done;
 		}
 
 		handler->present = true;
@@ -279,8 +286,9 @@ static int __init plic_init(struct device_node *node,
 		handler->enable_base =
 			plic_regs + ENABLE_BASE + i * ENABLE_PER_HART;
 
+done:
 		/* priority must be > threshold to trigger an interrupt */
-		writel(0, handler->hart_base + CONTEXT_THRESHOLD);
+		writel(threshold, handler->hart_base + CONTEXT_THRESHOLD);
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
 			plic_toggle(handler, hwirq, 0);
 		nr_handlers++;
-- 
2.20.1

