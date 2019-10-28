Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7264EE6AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 03:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbfJ1CPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Oct 2019 22:15:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:33972 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729899AbfJ1CPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:15:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 19:15:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="193126219"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga008.jf.intel.com with ESMTP; 27 Oct 2019 19:15:39 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, walken@google.com,
        richardw.yang@linux.intel.com, dbueso@suse.de, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [Patch v2 2/2] lib/rbtree: get successor's color directly
Date:   Mon, 28 Oct 2019 10:14:42 +0800
Message-Id: <20191028021442.5450-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028021442.5450-1-richardw.yang@linux.intel.com>
References: <20191028021442.5450-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After move parent assignment out, we can check the color directly.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 include/linux/rbtree_augmented.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index 99c42e1a74b8..724b0d036b57 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -286,8 +286,7 @@ __rb_erase_augmented(struct rb_node *node, struct rb_root *root,
 			rb_set_parent_color(child2, parent, RB_BLACK);
 			rebalance = NULL;
 		} else {
-			unsigned long pc2 = successor->__rb_parent_color;
-			rebalance = __rb_is_black(pc2) ? parent : NULL;
+			rebalance = rb_is_black(successor) ? parent : NULL;
 		}
 		successor->__rb_parent_color = pc;
 		tmp = successor;
-- 
2.17.1

