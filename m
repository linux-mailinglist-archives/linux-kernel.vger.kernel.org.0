Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039B4DB378
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503120AbfJQRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 13:38:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440755AbfJQRiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LLpec60MoDQbwYXoM+rURRw9OFWVy4VxOZVL1I8YkmU=; b=IvcvFRaURq+9FwFkXZ8l0+3JAp
        LuymAl0gTOchgj5hvCgshO/4OjK9lywhpOjfsgE09RKZJVQ4Z3b9tubPVPSDjwYNp7SrpiZvyZcTq
        TJTn7NJ55k7Pr6+RkkphW/K9xUU7IF9yCWh7FwSqvtfnOzBV8922w5mjfKQbO1QSx9yF+cYiSjROV
        l47EmlACP9tM7+XnKZX8LSbZ96e3FjswUhTimwZpJDfQMEo/EWLTPWkMq2hZNjAN8wn4uDxwXSOX0
        GYs8KMPUX/VYXUdnD1FKfV3/IE8CVppoQiLZ64QVLkNMEcfc7/Fcg2ifei11Uynf7uv920pHcqIVh
        RgRMWb0w==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iL9j3-0007y5-CO; Thu, 17 Oct 2019 17:38:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] riscv: use the correct interrupt levels for M-mode
Date:   Thu, 17 Oct 2019 19:37:39 +0200
Message-Id: <20191017173743.5430-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017173743.5430-1-hch@lst.de>
References: <20191017173743.5430-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numerical levels for External/Timer/Software interrupts differ
between S-mode and M-mode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/kernel/irq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
index 804ff70bb853..dbd1fd7c22e4 100644
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@ -14,9 +14,15 @@
 /*
  * Possible interrupt causes:
  */
-#define INTERRUPT_CAUSE_SOFTWARE	IRQ_S_SOFT
-#define INTERRUPT_CAUSE_TIMER		IRQ_S_TIMER
-#define INTERRUPT_CAUSE_EXTERNAL	IRQ_S_EXT
+#ifdef CONFIG_RISCV_M_MODE
+# define INTERRUPT_CAUSE_SOFTWARE	IRQ_M_SOFT
+# define INTERRUPT_CAUSE_TIMER		IRQ_M_TIMER
+# define INTERRUPT_CAUSE_EXTERNAL	IRQ_M_EXT
+#else
+# define INTERRUPT_CAUSE_SOFTWARE	IRQ_S_SOFT
+# define INTERRUPT_CAUSE_TIMER		IRQ_S_TIMER
+# define INTERRUPT_CAUSE_EXTERNAL	IRQ_S_EXT
+#endif /* CONFIG_RISCV_M_MODE */
 
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
-- 
2.20.1

