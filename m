Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6772105547
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 16:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfKUPVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Nov 2019 10:21:35 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35779 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUPVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:21:35 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 5E3151C0003;
        Thu, 21 Nov 2019 15:21:24 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 12/19] mm, mempolicy: use first_node in mpol_misplaced()
Date:   Thu, 21 Nov 2019 23:18:04 +0800
Message-Id: <20191121151811.49742-13-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mpol_misplaced(), we want to access first node instead of
first zone, so use first_node_nlist instead of first_zone_nlist.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/mempolicy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 66184add1627..8fd962762e46 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2404,7 +2404,6 @@ static void sp_free(struct sp_node *n)
 int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long addr)
 {
 	struct mempolicy *pol;
-	struct zone *zone;
 	int curnid = page_to_nid(page);
 	unsigned long pgoff;
 	int thiscpu = raw_smp_processor_id();
@@ -2440,11 +2439,10 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 		 */
 		if (node_isset(curnid, pol->v.nodes))
 			goto out;
-		zone = first_zone_nlist_nodemask(
+		polnid = first_node_nlist_nodemask(
 				node_nodelist(numa_node_id(), GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
 				&pol->v.nodes);
-		polnid = zone_to_nid(zone);
 		break;
 
 	default:
-- 
2.23.0

