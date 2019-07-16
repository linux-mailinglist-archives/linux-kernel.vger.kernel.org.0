Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C576ADF1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2019 19:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388331AbfGPRum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jul 2019 13:50:42 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:43797 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbfGPRum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:50:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TX46pWJ_1563299431;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX46pWJ_1563299431)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Jul 2019 01:50:39 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     catalin.marinas@arm.com, mhocko@suse.com, dvyukov@google.com,
        rientjes@google.com, willy@infradead.org, cai@lca.pw,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "kmemleak: allow to coexist with fault injection"
Date:   Wed, 17 Jul 2019 01:50:31 +0800
Message-Id: <1563299431-111710-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running ltp's oom test with kmemleak enabled, the below warning was
triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
passed in:

WARNING: CPU: 105 PID: 2138 at mm/page_alloc.c:4608 __alloc_pages_nodemask+0x1c31/0x1d50
Modules linked in: loop dax_pmem dax_pmem_core ip_tables x_tables xfs virtio_net net_failover virtio_blk failover ata_generic virtio_pci virtio_ring virtio libata
CPU: 105 PID: 2138 Comm: oom01 Not tainted 5.2.0-next-20190710+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
RIP: 0010:__alloc_pages_nodemask+0x1c31/0x1d50
...
 kmemleak_alloc+0x4e/0xb0
 kmem_cache_alloc+0x2a7/0x3e0
 ? __kmalloc+0x1d6/0x470
 ? ___might_sleep+0x9c/0x170
 ? mempool_alloc+0x2b0/0x2b0
 mempool_alloc_slab+0x2d/0x40
 mempool_alloc+0x118/0x2b0
 ? __kasan_check_read+0x11/0x20
 ? mempool_resize+0x390/0x390
 ? lock_downgrade+0x3c0/0x3c0
 bio_alloc_bioset+0x19d/0x350
 ? __swap_duplicate+0x161/0x240
 ? bvec_alloc+0x1b0/0x1b0
 ? do_raw_spin_unlock+0xa8/0x140
 ? _raw_spin_unlock+0x27/0x40
 get_swap_bio+0x80/0x230
 ? __x64_sys_madvise+0x50/0x50
 ? end_swap_bio_read+0x310/0x310
 ? __kasan_check_read+0x11/0x20
 ? check_chain_key+0x24e/0x300
 ? bdev_write_page+0x55/0x130
 __swap_writepage+0x5ff/0xb20

The mempool_alloc_slab() clears __GFP_DIRECT_RECLAIM, however kmemleak has
__GFP_NOFAIL set all the time due to commit
d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist
with fault injection").  But, it doesn't make any sense to have
__GFP_NOFAIL and ~__GFP_DIRECT_RECLAIM specified at the same time.

According to the discussion on the mailing list, the commit should be
reverted for short term solution.  Catalin Marinas would follow up with a better
solution for longer term.

The failure rate of kmemleak metadata allocation may increase in some
circumstances, but this should be expected side effect.

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 9dd581d..884a5e3 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -114,7 +114,7 @@
 /* GFP bitmask for kmemleak internal allocations */
 #define gfp_kmemleak_mask(gfp)	(((gfp) & (GFP_KERNEL | GFP_ATOMIC)) | \
 				 __GFP_NORETRY | __GFP_NOMEMALLOC | \
-				 __GFP_NOWARN | __GFP_NOFAIL)
+				 __GFP_NOWARN)
 
 /* scanning area inside a memory block */
 struct kmemleak_scan_area {
-- 
1.8.3.1

