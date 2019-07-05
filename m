Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F2C5EFE1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 02:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGDABO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 20:01:14 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:25390 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfGDABO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 20:01:14 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 9FD8FF1803BB8423107B;
        Thu,  4 Jul 2019 08:01:11 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6400j1F043263;
        Thu, 4 Jul 2019 08:00:45 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070408010927-2064645 ;
          Thu, 4 Jul 2019 08:01:09 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     catalin.marinas@arm.com
Cc:     will.deacon@arm.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, f.fainelli@gmail.com, logang@deltatee.com,
        robin.murphy@arm.com, ghackmann@android.com, hannes@cmpxchg.org,
        david@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        Junhua Huang <huang.junhua@zte.com.cn>
Subject: [PATCH] arm64: mm: free the initrd reserved memblock in a aligned manner
Date:   Thu, 4 Jul 2019 07:59:00 +0800
Message-Id: <1562198340-19089-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-04 08:01:09,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-04 08:00:49,
        Serialize complete at 2019-07-04 08:00:49
X-MAIL: mse-fl2.zte.com.cn x6400j1F043263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junhua Huang <huang.junhua@zte.com.cn>

We should free the reserved memblock in an aligned manner 
because the initrd reserves the memblock in an aligned manner 
in arm64_memblock_init(). 
Otherwise there are some fragments in memblock_reserved regions. e.g.:
/sys/kernel/debug/memblock # cat reserved 
   0: 0x0000000080080000..0x00000000817fafff
   1: 0x0000000083400000..0x0000000083ffffff
   2: 0x0000000090000000..0x000000009000407f
   3: 0x00000000b0000000..0x00000000b000003f
   4: 0x00000000b26184ea..0x00000000b2618fff
The fragments like the ranges from b0000000 to b000003f and 
from b26184ea to b2618fff should be freed.

And we can do free_reserved_area() after memblock_free(),
as free_reserved_area() calls __free_pages(), once we've done 
that it could be allocated somewhere else, 
but memblock and iomem still say this is reserved memory.

Signed-off-by: Junhua Huang <huang.junhua@zte.com.cn>
---
 arch/arm64/mm/init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d2adffb81b5d..03774b8bd364 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -580,8 +580,13 @@ void free_initmem(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void __init free_initrd_mem(unsigned long start, unsigned long end)
 {
+	unsigned long aligned_start, aligned_end;
+
+	aligned_start = __virt_to_phys(start) & PAGE_MASK;
+	aligned_end = PAGE_ALIGN(__virt_to_phys(end));
+	memblock_free(aligned_end, aligned_end - aligned_start);
 	free_reserved_area((void *)start, (void *)end, 0, "initrd");
-	memblock_free(__virt_to_phys(start), end - start);
+
 }
 #endif
 
-- 
2.15.2

