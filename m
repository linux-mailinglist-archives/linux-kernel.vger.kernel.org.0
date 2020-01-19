Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D65141B5F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jan 2020 04:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgASDHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jan 2020 22:07:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:14153 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbgASDHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 22:07:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 19:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="258308768"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2020 19:07:18 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH 1/8] mm/migrate.c: skip node check if done in last round
Date:   Sun, 19 Jan 2020 11:06:29 +0800
Message-Id: <20200119030636.11899-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119030636.11899-1-richardw.yang@linux.intel.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before move page to target node, we would check if the node id is valid.
In case we would try to move pages to the same target node, it is not
necessary to do the check each time.

This patch tries to skip the check if the node has been checked.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/migrate.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 430fdccc733e..ba7cf4fa43a0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1612,15 +1612,18 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			goto out_flush;
 		addr = (unsigned long)untagged_addr(p);
 
-		err = -ENODEV;
-		if (node < 0 || node >= MAX_NUMNODES)
-			goto out_flush;
-		if (!node_state(node, N_MEMORY))
-			goto out_flush;
+		/* Check node if it is not checked. */
+		if (current_node == NUMA_NO_NODE || node != current_node) {
+			err = -ENODEV;
+			if (node < 0 || node >= MAX_NUMNODES)
+				goto out_flush;
+			if (!node_state(node, N_MEMORY))
+				goto out_flush;
 
-		err = -EACCES;
-		if (!node_isset(node, task_nodes))
-			goto out_flush;
+			err = -EACCES;
+			if (!node_isset(node, task_nodes))
+				goto out_flush;
+		}
 
 		if (current_node == NUMA_NO_NODE) {
 			current_node = node;
-- 
2.17.1

