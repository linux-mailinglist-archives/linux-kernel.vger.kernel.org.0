Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB54E199
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfD2LwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 07:52:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfD2LwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=578nuBYWVCR8FTrZObdunPo+zrBlm6N2+YISyY9w1RI=; b=mqIDviDMtIZ71bunhSiYX9J7P
        Pl90uKoGYrARY+VN/HdnYKVHZeGkgFzVaPmeQtUmX5pI5dUWh4ds+D0ZmC0dteDRAGl4X+7fpjSEq
        egpTwinP1r5ODUHEx/hktTp3u2i/SPsoXATY2qAQcR+H+WHLvLEHhk/ODfguSS7fHy4cq+S/bVb34
        Dy1jkJFNs+WQFKxi/u/zMXSGYKlXIVQrImTGY4GjhRgcxEm4PFp2Jm3dT+KfQyMVc+R8sab6/y1hv
        yyMj7iCRU4AqSJy88y9j2vXksIXF7Sor2vByx+FzTEXkMeBdbqwEd77ZsW5DXNZE4byg5IziYLw+X
        5jz146W4Q==;
Received: from 65-114-90-19.dia.static.qwest.net ([65.114.90.19] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hL4pX-0008C2-Uc; Mon, 29 Apr 2019 11:52:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nds32: don't export low-level cache flushing routines
Date:   Mon, 29 Apr 2019 06:51:43 -0500
Message-Id: <20190429115143.12498-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these is used by modules.  Nor should they as we have better
highlevel primitives.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nds32/kernel/nds32_ksyms.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/nds32/kernel/nds32_ksyms.c b/arch/nds32/kernel/nds32_ksyms.c
index 5ecebd0e60cb..20719e42ae36 100644
--- a/arch/nds32/kernel/nds32_ksyms.c
+++ b/arch/nds32/kernel/nds32_ksyms.c
@@ -23,9 +23,3 @@ EXPORT_SYMBOL(memzero);
 EXPORT_SYMBOL(__arch_copy_from_user);
 EXPORT_SYMBOL(__arch_copy_to_user);
 EXPORT_SYMBOL(__arch_clear_user);
-
-/* cache handling */
-EXPORT_SYMBOL(cpu_icache_inval_all);
-EXPORT_SYMBOL(cpu_dcache_wbinval_all);
-EXPORT_SYMBOL(cpu_dma_inval_range);
-EXPORT_SYMBOL(cpu_dma_wb_range);
-- 
2.20.1

