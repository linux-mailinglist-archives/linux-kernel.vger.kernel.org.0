Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE112312A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 17:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfLQQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 11:10:35 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:36309 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfLQQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576599034; x=1608135034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X93izDi+OFRUN5FGBE4eNUsCd4hh4S1nRuspQbSs7oM=;
  b=SE9hhwD39rxL/tVLBUWI2n6JVW5x96ji4yVNO90n6+M7/oRegzOxzJPO
   ZngD9nzW23XCaj5UfrePbH3vYflY+kXOymWCFDn3KeOlpgRui1eCS38wq
   eYCb6LHQkT1Q5bV3zTwH7miHhamiriqQKn1y5wKKnoMqGJKcNPlsfWfK7
   Q=;
IronPort-SDR: 70ddUbeW6owvy2EsZEB5V7klIKYTlDr9YFdJgX2Vus9Ax3jr06+HmRW82KbVIgZc2xnkseooqS
 yAEfbOh9IRNg==
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="8883589"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 17 Dec 2019 16:10:33 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id BBB14A1D78;
        Tue, 17 Dec 2019 16:10:31 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 17 Dec 2019 16:10:31 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.179) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:10:26 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 5/6] xen/blkback: Remove unnecessary static variable name prefixes
Date:   Tue, 17 Dec 2019 17:10:07 +0100
Message-ID: <20191217161007.1102-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217160748.693-1-sjpark@amazon.com>
References: <20191217160748.693-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.179]
X-ClientProxiedBy: EX13D16UWC002.ant.amazon.com (10.43.162.161) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

A few of static variables in blkback have 'xen_blkif_' prefix, though it
is unnecessary for static variables.  This commit removes such prefixes.

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 drivers/block/xen-blkback/blkback.c | 37 +++++++++++++----------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 79f677aeb5cc..fbd67f8e4e4e 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -62,8 +62,8 @@
  * IO workloads.
  */
 
-static int xen_blkif_max_buffer_pages = 1024;
-module_param_named(max_buffer_pages, xen_blkif_max_buffer_pages, int, 0644);
+static int max_buffer_pages = 1024;
+module_param_named(max_buffer_pages, max_buffer_pages, int, 0644);
 MODULE_PARM_DESC(max_buffer_pages,
 "Maximum number of free pages to keep in each block backend buffer");
 
@@ -78,8 +78,8 @@ MODULE_PARM_DESC(max_buffer_pages,
  * algorithm.
  */
 
-static int xen_blkif_max_pgrants = 1056;
-module_param_named(max_persistent_grants, xen_blkif_max_pgrants, int, 0644);
+static int max_pgrants = 1056;
+module_param_named(max_persistent_grants, max_pgrants, int, 0644);
 MODULE_PARM_DESC(max_persistent_grants,
                  "Maximum number of grants to map persistently");
 
@@ -88,8 +88,8 @@ MODULE_PARM_DESC(max_persistent_grants,
  * use. The time is in seconds, 0 means indefinitely long.
  */
 
-static unsigned int xen_blkif_pgrant_timeout = 60;
-module_param_named(persistent_grant_unused_seconds, xen_blkif_pgrant_timeout,
+static unsigned int pgrant_timeout = 60;
+module_param_named(persistent_grant_unused_seconds, pgrant_timeout,
 		   uint, 0644);
 MODULE_PARM_DESC(persistent_grant_unused_seconds,
 		 "Time in seconds an unused persistent grant is allowed to "
@@ -137,9 +137,8 @@ module_param(log_stats, int, 0644);
 
 static inline bool persistent_gnt_timeout(struct persistent_gnt *persistent_gnt)
 {
-	return xen_blkif_pgrant_timeout &&
-	       (jiffies - persistent_gnt->last_used >=
-		HZ * xen_blkif_pgrant_timeout);
+	return pgrant_timeout && (jiffies - persistent_gnt->last_used >=
+			HZ * pgrant_timeout);
 }
 
 static inline int get_free_page(struct xen_blkif_ring *ring, struct page **page)
@@ -234,7 +233,7 @@ static int add_persistent_gnt(struct xen_blkif_ring *ring,
 	struct persistent_gnt *this;
 	struct xen_blkif *blkif = ring->blkif;
 
-	if (ring->persistent_gnt_c >= xen_blkif_max_pgrants) {
+	if (ring->persistent_gnt_c >= max_pgrants) {
 		if (!blkif->vbd.overflow_max_grants)
 			blkif->vbd.overflow_max_grants = 1;
 		return -EBUSY;
@@ -397,14 +396,13 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
 		goto out;
 	}
 
-	if (ring->persistent_gnt_c < xen_blkif_max_pgrants ||
-	    (ring->persistent_gnt_c == xen_blkif_max_pgrants &&
+	if (ring->persistent_gnt_c < max_pgrants ||
+	    (ring->persistent_gnt_c == max_pgrants &&
 	    !ring->blkif->vbd.overflow_max_grants)) {
 		num_clean = 0;
 	} else {
-		num_clean = (xen_blkif_max_pgrants / 100) * LRU_PERCENT_CLEAN;
-		num_clean = ring->persistent_gnt_c - xen_blkif_max_pgrants +
-			    num_clean;
+		num_clean = (max_pgrants / 100) * LRU_PERCENT_CLEAN;
+		num_clean = ring->persistent_gnt_c - max_pgrants + num_clean;
 		num_clean = min(ring->persistent_gnt_c, num_clean);
 		pr_debug("Going to purge at least %u persistent grants\n",
 			 num_clean);
@@ -599,8 +597,7 @@ static void print_stats(struct xen_blkif_ring *ring)
 		 current->comm, ring->st_oo_req,
 		 ring->st_rd_req, ring->st_wr_req,
 		 ring->st_f_req, ring->st_ds_req,
-		 ring->persistent_gnt_c,
-		 xen_blkif_max_pgrants);
+		 ring->persistent_gnt_c, max_pgrants);
 	ring->st_print = jiffies + msecs_to_jiffies(10 * 1000);
 	ring->st_rd_req = 0;
 	ring->st_wr_req = 0;
@@ -660,7 +657,7 @@ int xen_blkif_schedule(void *arg)
 		if (time_before(jiffies, blkif->buffer_squeeze_end))
 			shrink_free_pagepool(ring, 0);
 		else
-			shrink_free_pagepool(ring, xen_blkif_max_buffer_pages);
+			shrink_free_pagepool(ring, max_buffer_pages);
 
 		if (log_stats && time_after(jiffies, ring->st_print))
 			print_stats(ring);
@@ -887,7 +884,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 			continue;
 		}
 		if (use_persistent_gnts &&
-		    ring->persistent_gnt_c < xen_blkif_max_pgrants) {
+		    ring->persistent_gnt_c < max_pgrants) {
 			/*
 			 * We are using persistent grants, the grant is
 			 * not mapped but we might have room for it.
@@ -914,7 +911,7 @@ static int xen_blkbk_map(struct xen_blkif_ring *ring,
 			pages[seg_idx]->persistent_gnt = persistent_gnt;
 			pr_debug("grant %u added to the tree of persistent grants, using %u/%u\n",
 				 persistent_gnt->gnt, ring->persistent_gnt_c,
-				 xen_blkif_max_pgrants);
+				 max_pgrants);
 			goto next;
 		}
 		if (use_persistent_gnts && !blkif->vbd.overflow_max_grants) {
-- 
2.17.1

