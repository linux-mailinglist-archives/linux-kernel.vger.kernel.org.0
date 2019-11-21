Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D9010553F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 16:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKUPUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 10:20:35 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:45711 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUPUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:20:35 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 02CAE1C001E;
        Thu, 21 Nov 2019 15:20:26 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 06/19] mm, vmscan: use for_each_node in do_try_to_free_pages()
Date:   Thu, 21 Nov 2019 23:17:58 +0800
Message-Id: <20191121151811.49742-7-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In do_try_to_free_pages(), we want to traverse node instead of zone,
so use for_each_node instead of for_each_zone.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/vmscan.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a3ad433c8ff4..159a2aaa8db1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3033,9 +3033,9 @@ static unsigned long do_try_to_free_pages(struct nodelist *nodelist,
 					  struct scan_control *sc)
 {
 	int initial_priority = sc->priority;
-	pg_data_t *last_pgdat;
+	pg_data_t *pgdat;
 	struct nlist_traverser t;
-	struct zone *zone;
+	int node;
 retry:
 	delayacct_freepages_start();
 
@@ -3062,20 +3062,17 @@ static unsigned long do_try_to_free_pages(struct nodelist *nodelist,
 			sc->may_writepage = 1;
 	} while (--sc->priority >= 0);
 
-	last_pgdat = NULL;
-	for_each_zone_nlist_nodemask(zone, &t, nodelist, sc->reclaim_idx,
-					sc->nodemask) {
-		if (zone->zone_pgdat == last_pgdat)
-			continue;
-		last_pgdat = zone->zone_pgdat;
+	for_each_node_nlist_nodemask(node, &t, nodelist,
+					sc->reclaim_idx, sc->nodemask) {
+		pgdat = NODE_DATA(node);
 
-		snapshot_refaults(sc->target_mem_cgroup, zone->zone_pgdat);
+		snapshot_refaults(sc->target_mem_cgroup, pgdat);
 
 		if (cgroup_reclaim(sc)) {
 			struct lruvec *lruvec;
 
 			lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup,
-						   zone->zone_pgdat);
+						   pgdat);
 			clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
 		}
 	}
-- 
2.23.0

