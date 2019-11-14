Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7083EFA96C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 06:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfKMFSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 00:18:44 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48217 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726074AbfKMFSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 00:18:43 -0500
X-IronPort-AV: E=Sophos;i="5.68,299,1569254400"; 
   d="scan'208";a="78394566"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Nov 2019 13:18:42 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 5986D4CE1A05;
        Wed, 13 Nov 2019 13:10:27 +0800 (CST)
Received: from localhost.localdomain (10.167.225.140) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 13 Nov 2019 13:18:50 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <rppt@linux.ibm.com>, <akpm@linux-foundation.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: [PATCH] mm/memblock: Correct doc for function
Date:   Wed, 13 Nov 2019 13:18:22 +0800
Message-ID: <20191113051822.3296-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 5986D4CE1A05.A498C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cao jin <caoj.fnst@cn.fujitsu.com>

Change "max_addr" to "end" for less confusion
in memblock_alloc_range_nid comments.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Suppose this still goes to Andrew's -mm.

diff --git a/mm/memblock.c b/mm/memblock.c
index ceb6761f526d..203ed317551b 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1321,7 +1321,7 @@ __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  *
  * The allocation is performed from memory region limited by
- * memblock.current_limit if @max_addr == %MEMBLOCK_ALLOC_ACCESSIBLE.
+ * memblock.current_limit if @end == %MEMBLOCK_ALLOC_ACCESSIBLE.
  *
  * If the specified node can not hold the requested memory the
  * allocation falls back to any node in the system
-- 
2.21.0



