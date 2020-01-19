Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA83141B62
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 04:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgASDH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 22:07:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:14153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729050AbgASDH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:07:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 19:07:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="258308787"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2020 19:07:25 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 5/8] mm/migrate.c: check pagelist in move_pages_and_store_status()
Date:   Sun, 19 Jan 2020 11:06:33 +0800
Message-Id: <20200119030636.11899-6-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119030636.11899-1-richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pagelist is empty, it is not necessary to do the move and store.
Also it consolidate the empty list check in one place.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/migrate.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index dec147d3a4dd..46a5697b7fc6 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1499,9 +1499,6 @@ static int do_move_pages_to_node(struct mm_struct *mm,
 {
 	int err;
 
-	if (list_empty(pagelist))
-		return 0;
-
 	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
 			MIGRATE_SYNC, MR_SYSCALL);
 	if (err)
@@ -1589,6 +1586,9 @@ static int move_pages_and_store_status(struct mm_struct *mm, int node,
 {
 	int err;
 
+	if (list_empty(pagelist))
+		return 0;
+
 	err = do_move_pages_to_node(mm, pagelist, node);
 	if (err)
 		return err;
@@ -1679,9 +1679,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		current_node = NUMA_NO_NODE;
 	}
 out_flush:
-	if (list_empty(&pagelist))
-		return err;
-
 	/* Make sure we do not overwrite the existing error */
 	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
 				status, start, i - start);
-- 
2.17.1

