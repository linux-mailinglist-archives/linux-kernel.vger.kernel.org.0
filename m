Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16533BF47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 00:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390165AbfFJWQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 18:16:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389989AbfFJWQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uHFTnl4vUjrNVYTFv2dDUy+7np+VKavI9He7Ga2MW2s=; b=WoT5qfZOaCdlI5cjodJO96MTUa
        0x0FTUYOBpRsHYygY/XLRcYru1xwfiTUOH/aiIMRbNiEB0rWP1GO4Xk2gH/26HqDQe+j2Ybm6u/Rv
        hupkRFH69Ysbq0FC3igQAwsbpJU618sqwSYdNRkyNM58whYGLdOuZJih7LYrSSzsRQCkMlyedKmp1
        ApZeHTypJnTEPZDUphxKWpF2bD7O6bBM0bMcDdsTblUbbiQq7uHikPzv7wXg0izoJxUurD2y92zv1
        LM0WfD9mxU80dyyv93OBxyEnVWpfoleq8QXyRkJoWLd4bGvAAP2qR00MhSEMk9xXdbgybODC2RYFM
        ypkZtJVA==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1haSaa-0002mM-Ql; Mon, 10 Jun 2019 22:16:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, uclinux-dev@uclinux.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] mm: stub out all of swapops.h for !CONFIG_MMU
Date:   Tue, 11 Jun 2019 00:16:06 +0200
Message-Id: <20190610221621.10938-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610221621.10938-1-hch@lst.de>
References: <20190610221621.10938-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole header file deals with swap entries and PTEs, none of which
can exist for nommu builds.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swapops.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 4d961668e5fc..b02922556846 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -6,6 +6,8 @@
 #include <linux/bug.h>
 #include <linux/mm_types.h>
 
+#ifdef CONFIG_MMU
+
 /*
  * swapcache pages are stored in the swapper_space radix tree.  We want to
  * get good packing density in that tree, so the index should be dense in
@@ -50,13 +52,11 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-#ifdef CONFIG_MMU
 /* check whether a pte points to a swap entry */
 static inline int is_swap_pte(pte_t pte)
 {
 	return !pte_none(pte) && !pte_present(pte);
 }
-#endif
 
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
@@ -375,4 +375,5 @@ static inline int non_swap_entry(swp_entry_t entry)
 }
 #endif
 
+#endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
-- 
2.20.1

