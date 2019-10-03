Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE151C9A6C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2019 11:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfJCJJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Oct 2019 05:09:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:52698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727382AbfJCJJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:09:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BECD7B14B;
        Thu,  3 Oct 2019 09:09:24 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect ne_fit_preload_node
Date:   Thu,  3 Oct 2019 11:09:06 +0200
Message-Id: <20191003090906.1261-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace preempt_enable() and preempt_disable() with the vmap_area_lock
spin_lock instead. Calling spin_lock() with preempt disabled is
illegal for -rt. Furthermore, enabling preemption inside the
spin_lock() doesn't really make sense.

Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for
split purpose")
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 mm/vmalloc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 08c134aa7ff3..0d1175673583 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1091,11 +1091,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * Even if it fails we do not really care about that. Just proceed
 	 * as it is. "overflow" path will refill the cache we allocate from.
 	 */
-	preempt_disable();
+	spin_lock(&vmap_area_lock);
 	if (!__this_cpu_read(ne_fit_preload_node)) {
-		preempt_enable();
+		spin_unlock(&vmap_area_lock);
 		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
-		preempt_disable();
+		spin_lock(&vmap_area_lock);
 
 		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
 			if (pva)
@@ -1103,9 +1103,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		}
 	}
 
-	spin_lock(&vmap_area_lock);
-	preempt_enable();
-
 	/*
 	 * If an allocation fails, the "vend" address is
 	 * returned. Therefore trigger the overflow path.
-- 
2.16.4

