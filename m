Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4321F10554E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 16:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfKUPVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 10:21:48 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40151 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUPVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:21:48 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9F5D81C0006;
        Thu, 21 Nov 2019 15:21:34 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 13/19] mm, page_alloc: use first_node in local_memory_node()
Date:   Thu, 21 Nov 2019 23:18:05 +0800
Message-Id: <20191121151811.49742-14-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In local_memory_node(), we want to access first node instead of
first zone, so use first_node_nlist instead of first_zone_nlist.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/page_alloc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aa5c2ef4f8ec..5c96d1ecd643 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5673,12 +5673,8 @@ static void build_zonelists(pg_data_t *pgdat)
  */
 int local_memory_node(int node)
 {
-	struct zone *zone;
-
-	zone = first_zone_nlist_nodemask(node_nodelist(node, GFP_KERNEL),
-				   gfp_zone(GFP_KERNEL),
-				   NULL);
-	return zone_to_nid(zone);
+	return first_node_nlist_nodemask(node_nodelist(node, GFP_KERNEL),
+						gfp_zone(GFP_KERNEL), NULL);
 }
 #endif
 
-- 
2.23.0

