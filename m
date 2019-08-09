Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B210986EBD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 02:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404969AbfHIATy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 20:19:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:58703 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404850AbfHIATx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 20:19:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 17:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="scan'208";a="169158764"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 08 Aug 2019 17:19:51 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v2] mm/mmap.c: refine find_vma_prev with rb_last
Date:   Fri,  9 Aug 2019 08:19:28 +0800
Message-Id: <20190809001928.4950-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When addr is out of the range of the whole rb_tree, pprev will points to
the right-most node. rb_tree facility already provides a helper
function, rb_last, to do this task. We can leverage this instead of
re-implement it.

This patch refines find_vma_prev with rb_last to make it a little nicer
to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
v2: leverage rb_last
---
 mm/mmap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..f7ed0afb994c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2270,12 +2270,9 @@ find_vma_prev(struct mm_struct *mm, unsigned long addr,
 	if (vma) {
 		*pprev = vma->vm_prev;
 	} else {
-		struct rb_node *rb_node = mm->mm_rb.rb_node;
-		*pprev = NULL;
-		while (rb_node) {
-			*pprev = rb_entry(rb_node, struct vm_area_struct, vm_rb);
-			rb_node = rb_node->rb_right;
-		}
+		struct rb_node *rb_node = rb_last(&mm->mm_rb);
+		*pprev = !rb_node ? NULL :
+			 rb_entry(rb_node, struct vm_area_struct, vm_rb);
 	}
 	return vma;
 }
-- 
2.17.1

