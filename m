Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97787E6AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 03:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbfJ1CPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 22:15:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:5377 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfJ1CPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:15:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 19:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="189497390"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2019 19:15:37 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, walken@google.com,
        richardw.yang@linux.intel.com, dbueso@suse.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [Patch v2 1/2] lib/rbtree: set successor's parent unconditionally
Date:   Mon, 28 Oct 2019 10:14:41 +0800
Message-Id: <20191028021442.5450-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both in Case 2 and 3, we exchange n and s. This mean no matter whether
child2 is NULL or not, successor's parent should be assigned to node's.

This patch takes this step out to make it explicit and reduce the
ambiguity.

Besides, this step reduces some symbol size like rb_erase().

   KERN_CONFIG       upstream       patched
   OPT_FOR_PERF      877            870
   OPT_FOR_SIZE      635            621

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 include/linux/rbtree_augmented.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index fdd421b8d9ae..99c42e1a74b8 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -283,14 +283,13 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 		__rb_change_child(node, successor, tmp, root);
 
 		if (child2) {
-			successor->__rb_parent_color = pc;
 			rb_set_parent_color(child2, parent, RB_BLACK);
 			rebalance = NULL;
 		} else {
 			unsigned long pc2 = successor->__rb_parent_color;
-			successor->__rb_parent_color = pc;
 			rebalance = __rb_is_black(pc2) ? parent : NULL;
 		}
+		successor->__rb_parent_color = pc;
 		tmp = successor;
 	}
 
-- 
2.17.1

