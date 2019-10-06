Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5083FCCDC1
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2019 03:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfJFBby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Oct 2019 21:31:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:59618 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfJFBbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 21:31:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2019 18:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,261,1566889200"; 
   d="scan'208";a="217534710"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 05 Oct 2019 18:31:51 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, osalvador@suse.de, hch@infradead.org,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 2/3] mm/mmap.c: __vma_unlink_prev is not necessary now
Date:   Sun,  6 Oct 2019 09:26:35 +0800
Message-Id: <20191006012636.31521-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191006012636.31521-1-richardw.yang@linux.intel.com>
References: <20191006012636.31521-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The third parameter of __vma_unlink_common could differentiate these two
types. __vma_unlink_prev is not necessary now.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2: rebase on top of 5.4-rc1
---
 mm/mmap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index c61403f25833..2ca805209c47 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -702,13 +702,6 @@ static __always_inline void __vma_unlink_common(struct mm_struct *mm,
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
@@ -883,7 +876,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
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

