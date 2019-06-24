Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC34550144
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 07:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfFXFnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 01:43:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFXFnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZFBwbC42pF4/ydEOSJ4y75ZnrJb+ZBbMm/qFm7Ht5k0=; b=X6al4PUPrJG3GXXDCc+GVTzTlg
        2TSkJtcBJThDHIeyPeJiS8/uksAhamtWEZqHOR7790Zoc05bZD4vgnQfeFrUhpgVmS6Wtj34h+Zp8
        LauTUq5EVZOKR9tSXliqJAsyWJ+cFEkaJ7oZfe4j7mDAwtXbxzD6go0vThELFfQTkD5IxmXoNvw0o
        L0gFZrRUmOexC+mmTGo11vv5/KRkjFhwZXlKYQGHpUZD90U1hUU3pTX0qmaYFxdQRVfkjVqmPirtZ
        pukuQReHO+bDQdEoXqU6Ycu/nnJkbAVTVnG3qUyQ0Az1wVOLQPr8aw2Y0GyezJJ14dT8hSXtMfQ9y
        0CzY8sZA==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfHl8-00064U-KY; Mon, 24 Jun 2019 05:43:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 01/17] mm: provide a print_vma_addr stub for !CONFIG_MMU
Date:   Mon, 24 Jun 2019 07:42:55 +0200
Message-Id: <20190624054311.30256-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624054311.30256-1-hch@lst.de>
References: <20190624054311.30256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 include/linux/mm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd0b5f4e1e45..69843ee0c5f8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2756,7 +2756,13 @@ extern int randomize_va_space;
 #endif
 
 const char * arch_vma_name(struct vm_area_struct *vma);
+#ifdef CONFIG_MMU
 void print_vma_addr(char *prefix, unsigned long rip);
+#else
+static inline void print_vma_addr(char *prefix, unsigned long rip)
+{
+}
+#endif
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page *sparse_mem_map_populate(unsigned long pnum, int nid,
-- 
2.20.1

