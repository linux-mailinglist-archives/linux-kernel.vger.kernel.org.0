Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95EC69C136
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2019 03:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfHYBKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Aug 2019 21:10:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:4487 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbfHYBKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 21:10:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Aug 2019 18:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,427,1559545200"; 
   d="scan'208";a="204158112"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2019 18:10:35 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        dbueso@suse.de, linux-kernel@vger.kernel.org
Cc:     Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] lib/rbtree: set successor's parent unconditionally
Date:   Sun, 25 Aug 2019 09:10:10 +0800
Message-Id: <20190825011010.31072-1-richardw.yang@linux.intel.com>
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
index 179faab29f52..8fcddfef7876 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -237,14 +237,13 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
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

