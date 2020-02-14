Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C5315CF08
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgBNAaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 19:30:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:25633 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbgBNAaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:30:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 16:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,438,1574150400"; 
   d="scan'208";a="227246085"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga007.fm.intel.com with ESMTP; 13 Feb 2020 16:30:20 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com, david@redhat.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v5 4/4] mm/migrate.c: unify "not queued for migration" handling in do_pages_move()
Date:   Fri, 14 Feb 2020 08:30:17 +0800
Message-Id: <20200214003017.25558-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214003017.25558-1-richardw.yang@linux.intel.com>
References: <20200214003017.25558-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can currently happen that we store the status of a page twice:
* Once we detect that it is already on the target node
* Once we moved a bunch of pages, and a page that's already on the
  target node is contained in the current interval.

Let's simplify the code and always call do_move_pages_to_node() in
case we did not queue a page for migration. Note that pages that are
already on the target node are not added to the pagelist and are,
therefore, ignored by do_move_pages_to_node() - there is no functional
change.

The status of such a page is now only stored once.

[david@redhat.com rephrase changelog]

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/migrate.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index fe62b96852a3..4a8902a443fd 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1664,18 +1664,16 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		err = add_page_for_migration(mm, addr, current_node,
 				&pagelist, flags & MPOL_MF_MOVE_ALL);
 
-		if (!err) {
-			/* The page is already on the target node */
-			err = store_status(status, i, current_node, 1);
-			if (err)
-				goto out_flush;
-			continue;
-		} else if (err > 0) {
+		if (err > 0) {
 			/* The page is successfully queued for migration */
 			continue;
 		}
 
-		err = store_status(status, i, err, 1);
+		/*
+		 * If the page is already on the target node (!err), store the
+		 * node, otherwise, store the err.
+		 */
+		err = store_status(status, i, err ? : current_node, 1);
 		if (err)
 			goto out_flush;
 
-- 
2.17.1

