Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF2B141B67
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 04:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgASDHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 22:07:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:14153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgASDHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:07:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 19:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="258308782"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2020 19:07:24 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 4/8] mm/migrate.c: wrap do_move_pages_to_node() and store_status()
Date:   Sun, 19 Jan 2020 11:06:32 +0800
Message-Id: <20200119030636.11899-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119030636.11899-1-richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually do_move_pages_to_node() and store_status() is a pair. There are
three places call this pair of functions with almost the same form.

This patch just wrap it to make it friendly to audience and also
consolidate the move and store action into one place. Also mentioned by
Yang Shi, the handling of do_move_pages_to_node()'s return value is not
proper. Now we can fix it in one place.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/migrate.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4a63fb8fbb6d..dec147d3a4dd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1583,6 +1583,19 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 	return err;
 }
 
+static int move_pages_and_store_status(struct mm_struct *mm, int node,
+		struct list_head *pagelist, int __user *status,
+		int start, int nr)
+{
+	int err;
+
+	err = do_move_pages_to_node(mm, pagelist, node);
+	if (err)
+		return err;
+	err = store_status(status, start, node, nr);
+	return err;
+}
+
 /*
  * Migrate an array of page address onto an array of nodes and fill
  * the corresponding array of status.
@@ -1629,10 +1642,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			current_node = node;
 			start = i;
 		} else if (node != current_node) {
-			err = do_move_pages_to_node(mm, &pagelist, current_node);
-			if (err)
-				goto out;
-			err = store_status(status, start, current_node, i - start);
+			err = move_pages_and_store_status(mm, current_node,
+					&pagelist, status, start, i - start);
 			if (err)
 				goto out;
 			start = i;
@@ -1661,10 +1672,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (err)
 			goto out_flush;
 
-		err = do_move_pages_to_node(mm, &pagelist, current_node);
-		if (err)
-			goto out;
-		err = store_status(status, start, current_node, i - start);
+		err = move_pages_and_store_status(mm, current_node, &pagelist,
+				status, start, i - start);
 		if (err)
 			goto out;
 		current_node = NUMA_NO_NODE;
@@ -1674,13 +1683,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		return err;
 
 	/* Make sure we do not overwrite the existing error */
-	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
-	if (err1) {
-		if (err >= 0)
-			err = err1;
-		goto out;
-	}
-	err1 = store_status(status, start, current_node, i - start);
+	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
+				status, start, i - start);
 	if (err >= 0)
 		err = err1;
 out:
-- 
2.17.1

