Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5EE105546
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 16:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfKUPVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 10:21:25 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53999 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:21:24 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id CFACD1C0014;
        Thu, 21 Nov 2019 15:21:15 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 11/19] mm, mempolicy: use first_node in mempolicy_slab_node()
Date:   Thu, 21 Nov 2019 23:18:03 +0800
Message-Id: <20191121151811.49742-12-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mempolicy_slab_node(), we want to access first node instead of
first zone, so use first_node_nlist instead of first_zone_nlist.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/mempolicy.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b1df19d42047..66184add1627 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1855,8 +1855,10 @@ static unsigned interleave_nodes(struct mempolicy *policy)
  */
 unsigned int mempolicy_slab_node(void)
 {
-	struct mempolicy *policy;
 	int node = numa_mem_id();
+	struct mempolicy *policy;
+	struct nodelist *nodelist;
+	int first_node;
 
 	if (in_interrupt())
 		return node;
@@ -1876,18 +1878,16 @@ unsigned int mempolicy_slab_node(void)
 		return interleave_nodes(policy);
 
 	case MPOL_BIND: {
-		struct zone *zone;
-
 		/*
 		 * Follow bind policy behavior and start allocation at the
 		 * first node.
 		 */
-		struct nodelist *nodelist;
-		enum zone_type highest_zoneidx = gfp_zone(GFP_KERNEL);
-		nodelist = &NODE_DATA(node)->node_nodelists[NODELIST_FALLBACK];
-		zone = first_zone_nlist_nodemask(nodelist, highest_zoneidx,
-							&policy->v.nodes);
-		return zone ? zone_to_nid(zone) : node;
+		nodelist = node_nodelist(node, GFP_KERNEL);
+
+		first_node = first_node_nlist_nodemask(nodelist,
+					gfp_zone(GFP_KERNEL), &policy->v.nodes);
+
+		return (first_node != NUMA_NO_NODE) ? first_node : node;
 	}
 
 	default:
-- 
2.23.0

