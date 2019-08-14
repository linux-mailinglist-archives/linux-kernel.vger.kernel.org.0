Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0017E8C6C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 04:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfHNCSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 22:18:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:4431 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbfHNCSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:18:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 19:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="181365545"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 13 Aug 2019 19:18:21 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 2/3] mm/mmap.c: __vma_unlink_prev is not necessary now
Date:   Wed, 14 Aug 2019 10:17:54 +0800
Message-Id: <20190814021755.1977-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814021755.1977-1-richardw.yang@linux.intel.com>
References: <20190814021755.1977-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The third parameter of __vma_unlink_common could differentiate these two
types. __vma_unlink_prev is not necessary now.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/mmap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3d56340fea36..3fde0ec18554 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -693,13 +693,6 @@ static __always_inline void __vma_unlink_common(struct mm_struct *mm,
 	vmacache_invalidate(mm);
 }
 
-static inline void __vma_unlink_prev(struct mm_struct *mm,
-				     struct vm_area_struct *vma,
-				     struct vm_area_struct *prev)
-{
-	__vma_unlink_common(mm, vma, vma);
-}
-
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -874,7 +867,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		 * us to remove next before dropping the locks.
 		 */
 		if (remove_next != 3)
-			__vma_unlink_prev(mm, next, vma);
+			__vma_unlink_common(mm, next, next);
 		else
 			/*
 			 * vma is not before next if they've been
-- 
2.17.1

