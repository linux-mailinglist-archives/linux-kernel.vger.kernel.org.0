Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1611149A15
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jan 2020 11:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgAZK1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jan 2020 05:27:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:33300 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgAZK1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 05:27:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 02:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,365,1574150400"; 
   d="scan'208";a="223002739"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2020 02:27:19 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, yang.shi@linux.alibaba.com, rientjes@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v3 2/4] mm/migrate.c: wrap do_move_pages_to_node() and store_status()
Date:   Sun, 26 Jan 2020 18:26:21 +0800
Message-Id: <20200126102623.9616-3-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200126102623.9616-1-richardw.yang@linux.intel.com>
References: <20200126102623.9616-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usually do_move_pages_to_node() and store_status() is a pair. There are
three places call this pair of functions with almost the same form.

This patch just wrap it to make it friendly to audience and also
consolidate the move and store action into one place.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/migrate.c | 61 ++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ae3db45c6a42..e816c8990296 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1583,6 +1583,29 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
 	return err;
 }
 
+static int move_pages_and_store_status(struct mm_struct *mm, int node,
+		struct list_head *pagelist, int __user *status,
+		unsigned long nr_pages, int start, int i)
+{
+	int err;
+
+	err = do_move_pages_to_node(mm, pagelist, node);
+	if (err) {
+		/*
+		 * Positive err means the number of failed
+		 * pages to migrate.  Since we are going to
+		 * abort and return the number of non-migrated
+		 * pages, so need incude the rest of the
+		 * nr_pages that have not attempted as well.
+		 */
+		if (err > 0)
+			err += nr_pages - i - 1;
+		return err;
+	}
+	err = store_status(status, start, node, i - start);
+	return err;
+}
+
 /*
  * Migrate an array of page address onto an array of nodes and fill
  * the corresponding array of status.
@@ -1626,20 +1649,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			current_node = node;
 			start = i;
 		} else if (node != current_node) {
-			err = do_move_pages_to_node(mm, &pagelist, current_node);
-			if (err) {
-				/*
-				 * Positive err means the number of failed
-				 * pages to migrate.  Since we are going to
-				 * abort and return the number of non-migrated
-				 * pages, so need incude the rest of the
-				 * nr_pages that have not attempted as well.
-				 */
-				if (err > 0)
-					err += nr_pages - i - 1;
-				goto out;
-			}
-			err = store_status(status, start, current_node, i - start);
+			err = move_pages_and_store_status(mm, current_node,
+					&pagelist, status, nr_pages,
+					start, i);
 			if (err)
 				goto out;
 			start = i;
@@ -1668,13 +1680,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (err)
 			goto out_flush;
 
-		err = do_move_pages_to_node(mm, &pagelist, current_node);
-		if (err) {
-			if (err > 0)
-				err += nr_pages - i - 1;
-			goto out;
-		}
-		err = store_status(status, start, current_node, i - start);
+		err = move_pages_and_store_status(mm, current_node, &pagelist,
+				status, nr_pages, start, i);
 		if (err)
 			goto out;
 		current_node = NUMA_NO_NODE;
@@ -1684,16 +1691,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		return err;
 
 	/* Make sure we do not overwrite the existing error */
-	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
-	/*
-	 * Don't have to report non-attempted pages here since:
-	 *     - If the above loop is done gracefully there is not non-attempted
-	 *       page.
-	 *     - If the above loop is aborted to it means more fatal error
-	 *       happened, should return err.
-	 */
-	if (!err1)
-		err1 = store_status(status, start, current_node, i - start);
+	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
+			status, nr_pages, start, i);
 	if (err >= 0)
 		err = err1;
 out:
-- 
2.17.1

