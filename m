Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2AF0AF497
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 05:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfIKDJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 23:09:11 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:40705 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726657AbfIKDJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 23:09:10 -0400
X-IronPort-AV: E=Sophos;i="5.64,491,1559491200"; 
   d="scan'208";a="75262210"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Sep 2019 11:09:09 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 051084CE030A;
        Wed, 11 Sep 2019 11:08:56 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 11 Sep 2019 11:09:11 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <rppt@linux.ibm.com>
Subject: [PATCH] mm/memblock: fix typo in memblock doc
Date:   Wed, 11 Sep 2019 11:08:56 +0800
Message-ID: <20190911030856.18010-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 051084CE030A.A9008
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

elaboarte -> elaborate
architecure -> architecture
compltes -> completes

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 mm/memblock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 7d4f61ae666a..0d0f92003d18 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -83,16 +83,16 @@
  * Note, that both API variants use implict assumptions about allowed
  * memory ranges and the fallback methods. Consult the documentation
  * of :c:func:`memblock_alloc_internal` and
- * :c:func:`memblock_alloc_range_nid` functions for more elaboarte
+ * :c:func:`memblock_alloc_range_nid` functions for more elaborate
  * description.
  *
  * As the system boot progresses, the architecture specific
  * :c:func:`mem_init` function frees all the memory to the buddy page
  * allocator.
  *
- * Unless an architecure enables %CONFIG_ARCH_KEEP_MEMBLOCK, the
+ * Unless an architecture enables %CONFIG_ARCH_KEEP_MEMBLOCK, the
  * memblock data structures will be discarded after the system
- * initialization compltes.
+ * initialization completes.
  */
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-- 
2.21.0



