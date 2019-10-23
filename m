Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98213E1CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405993AbfJWNln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 09:41:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391642AbfJWNlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 09:41:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 68646F7628D9BF9903EC;
        Wed, 23 Oct 2019 21:41:40 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 23 Oct 2019 21:41:31 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <osalvador@suse.de>, <mgorman@techsingularity.net>,
        <rppt@linux.ibm.com>, <dan.j.williams@intel.com>,
        <alexander.h.duyck@linux.intel.com>, <anshuman.khandual@arm.com>,
        <pavel.tatashin@microsoft.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] mm/page_alloc: fix gcc compile warning
Date:   Wed, 23 Oct 2019 21:48:28 +0800
Message-ID: <1571838508-117928-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chenwandun <chenwandun@huawei.com>

mm/page_alloc.o: In function `page_alloc_init_late':
mm/page_alloc.c:1956: undefined reference to `zone_pcp_update'
mm/page_alloc.o:(.debug_addr+0x8350): undefined reference to `zone_pcp_update'
make: *** [vmlinux] Error 1

zone_pcp_update is defined in CONFIG_MEMORY_HOTPLUG,
so add ifdef when calling zone_pcp_update.

Signed-off-by: Chenwandun <chenwandun@huawei.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f9488ef..8513150 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1952,8 +1952,10 @@ void __init page_alloc_init_late(void)
 	 * so the pcpu batch and high limits needs to be updated or the limits
 	 * will be artificially small.
 	 */
+#ifdef CONFIG_MEMORY_HOTPLUG
 	for_each_populated_zone(zone)
 		zone_pcp_update(zone);
+#endif
 
 	/*
 	 * We initialized the rest of the deferred pages.  Permanently disable
-- 
2.7.4

