Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38D2144948
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jan 2020 02:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAVBRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 20:17:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:24737 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgAVBRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:17:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 17:17:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; 
   d="scan'208";a="244885539"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2020 17:17:14 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 4/4] mm/migrate.c: handle same node and add failure in the same way
Date:   Wed, 22 Jan 2020 09:16:47 +0800
Message-Id: <20200122011647.13636-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122011647.13636-1-richardw.yang@linux.intel.com>
References: <20200122011647.13636-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page is not queued for migration, there are two possible cases:

  * page already on the target node
  * failed to add to migration queue

Current code handle them differently, this leads to a behavior
inconsistency.

Usually for each page's status, we just do store for once. While for the
page already on the target node, we might store the node information for
twice:

  * once when we found the page is on the target node
  * second when moving the pages to target node successfully after above
    action

The reason is even we don't add the page to pagelist, but store_status()
does store in a range which still contains the page.

This patch handles these two cases in the same way to reduce this
inconsistency and also make the code a little easier to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/migrate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 80d2bba57265..591f2e5caed6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1654,18 +1654,18 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
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
+		 * Two possible cases for err here:
+		 * == 0: page is already on the target node, then store
+		 *       current_node to status
+		 * <  0: failed to add page to list, then store err to status
+		 */
+		err = store_status(status, i, err ? : current_node, 1);
 		if (err)
 			goto out_flush;
 
-- 
2.17.1

