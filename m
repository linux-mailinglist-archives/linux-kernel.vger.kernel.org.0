Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3445D14B131
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jan 2020 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgA1I6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jan 2020 03:58:43 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:14373 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgA1I6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1580201923; x=1611737923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HXOa5YmT7KvbHXfClLkAOk34a6rpgiRM2RdRi6O/cH0=;
  b=fGXz7An43ypJmUPeeR1KcgdhzYNH7MsMYZ5f0EiHOJYmG9kgU8nfOe6L
   8yW8F7GhSbD5xCl0xd/a2jO2lhJjWskSXLi5kQZBPiZeqzRriUlqCAqZK
   2T8OXcIYFXLB5lY0kNWjB+uY40NpZ0nmEm6cg2SxJpzRmv+Smux8Ud09/
   Y=;
IronPort-SDR: bohypZ/U3bEKHHNAZ9R74dfCWn7bpC3oXer40opHYXN06AW5hHcgZPOEaRYHgEwC0Xnph9Xznv
 CcsEJS2+I3bQ==
X-IronPort-AV: E=Sophos;i="5.70,373,1574121600"; 
   d="scan'208";a="15066512"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 28 Jan 2020 08:58:40 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id AD9D9224452;
        Tue, 28 Jan 2020 08:58:38 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 28 Jan 2020 08:58:38 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.29) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 28 Jan 2020 08:58:30 +0000
From:   <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <sj38.park@gmail.com>,
        <acme@kernel.org>, <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <corbet@lwn.net>, <dwmw@amazon.com>, <mgorman@suse.de>,
        <rostedt@goodmis.org>, <kirill@shutemov.name>,
        <brendanhiggins@google.com>, <colin.king@canonical.com>,
        <minchan@kernel.org>, <vdavydov.dev@gmail.com>,
        <vdavydov@parallels.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/9] mm/damon: Adaptively adjust regions
Date:   Tue, 28 Jan 2020 09:57:36 +0100
Message-ID: <20200128085742.14566-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128085742.14566-1-sjpark@amazon.com>
References: <20200128085742.14566-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.29]
X-ClientProxiedBy: EX13D21UWA001.ant.amazon.com (10.43.160.154) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

At the beginning of the monitoring, DAMON constructs the initial regions
by evenly splitting the memory mapped address space of the process into
the user-specified minimal number of regions.  In this initial state,
the assumption of the regions (pages in same region have similar access
frequencies) is normally not kept and thus the monitoring quality could
be low.  To keep the assumption as much as possible, DAMON adaptively
merges and splits each region.

For each ``aggregation interval``, it compares the access frequencies of
adjacent regions and merges those if the frequency difference is small.
Then, after it reports and clears the aggregated access frequency of
each region, it splits each region into two regions if the total number
of regions is smaller than the half of the user-specified maximum number
of regions.

In this way, DAMON provides its best-effort quality and minimal overhead
while keeping the bounds users set for their trade-off.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 5 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 4144e9da9282..124f12d4be40 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -73,6 +73,7 @@ static unsigned long aggr_interval = 100 * 1000;
 static struct timespec64 last_aggregate_time;
 
 static unsigned long min_nr_regions = 10;
+static unsigned long max_nr_regions = 1000;
 
 /* result buffer */
 #define DAMON_LEN_RBUF	(1024 * 1024 * 4)
@@ -398,7 +399,12 @@ static int damon_three_regions_of(struct damon_task *t,
  * regions is wasteful.  That said, because we can deal with small noises,
  * tracking every mapping is not strictly required but could even incur a high
  * overhead if the mapping frequently changes or the number of mappings is
- * high.
+ * high.  The adaptive regions adjustment mechanism will further help to deal
+ * with the noises by simply identifying the unmapped areas as a region that
+ * has no access.  Moreover, applying the real mappings that would have many
+ * unmapped areas inside will make the adaptive mechanism quite complex.  That
+ * said, too huge unmapped areas inside the monitoring target should be removed
+ * to not take the time for the adaptive mechanism.
  *
  * For the reason, we convert the complex mappings to three distinct regions
  * that cover every mapped areas of the address space.  Also the two gaps
@@ -618,6 +624,122 @@ static void kdamond_flush_aggregated(void)
 	}
 }
 
+#define sz_damon_region(r) (r->vm_end - r->vm_start)
+
+/*
+ * Merge two adjacent regions into one region
+ */
+static void damon_merge_two_regions(struct damon_region *l,
+				struct damon_region *r)
+{
+	l->nr_accesses = (l->nr_accesses * sz_damon_region(l) +
+			r->nr_accesses * sz_damon_region(r)) /
+			(sz_damon_region(l) + sz_damon_region(r));
+	l->vm_end = r->vm_end;
+	damon_destroy_region(r);
+}
+
+#define diff_of(a, b) (a > b ? a - b : b - a)
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * t		task that merge operation will make change
+ * thres	merge regions having '->nr_accesses' diff smaller than this
+ */
+static void damon_merge_regions_of(struct damon_task *t, unsigned int thres)
+{
+	struct damon_region *r, *prev = NULL, *next;
+
+	damon_for_each_region_safe(r, next, t) {
+		if (!prev || prev->vm_end != r->vm_start)
+			goto next;
+		if (diff_of(prev->nr_accesses, r->nr_accesses) > thres)
+			goto next;
+		damon_merge_two_regions(prev, r);
+		continue;
+next:
+		prev = r;
+	}
+}
+
+/*
+ * Merge adjacent regions having similar access frequencies
+ *
+ * threshold	merge regions havind nr_accesses diff larger than this
+ *
+ * This function merges monitoring target regions which are adjacent and their
+ * access frequencies are similar.  This is for minimizing the monitoring
+ * overhead under the dynamically changeable access pattern.  If a merge was
+ * unnecessarily made, later 'kdamond_split_regions()' will revert it.
+ */
+static void kdamond_merge_regions(unsigned int threshold)
+{
+	struct damon_task *t;
+
+	damon_for_each_task(t)
+		damon_merge_regions_of(t, threshold);
+}
+
+/*
+ * Split a region into two small regions
+ *
+ * r		the region to be split
+ * sz_r		size of the first sub-region that will be made
+ */
+static void damon_split_region_at(struct damon_region *r, unsigned long sz_r)
+{
+	struct damon_region *new;
+
+	new = damon_new_region(r->vm_start + sz_r, r->vm_end);
+	r->vm_end = new->vm_start;
+
+	damon_add_region(new, r, damon_next_region(r));
+}
+
+static void damon_split_regions_of(struct damon_task *t)
+{
+	struct damon_region *r, *next;
+	unsigned long sz_left_region;
+
+	damon_for_each_region_safe(r, next, t) {
+		/*
+		 * Randomly select size of left sub-region to be at least
+		 * 10 percent and at most 90% of original region
+		 */
+		sz_left_region = (prandom_u32_state(&rndseed) % 9 + 1) *
+			(r->vm_end - r->vm_start) / 10;
+		/* Do not allow blank region */
+		if (sz_left_region == 0)
+			continue;
+		damon_split_region_at(r, sz_left_region);
+	}
+}
+
+/*
+ * splits every target regions into two randomly-sized regions
+ *
+ * This function splits every target regions into two random-sized regions if
+ * current total number of the regions is smaller than the half of the
+ * user-specified maximum number of regions.  This is for maximizing the
+ * monitoring accuracy under the dynamically changeable access patterns.  If a
+ * split was unnecessarily made, later 'kdamond_merge_regions()' will revert
+ * it.
+ */
+static void kdamond_split_regions(void)
+{
+	struct damon_task *t;
+	unsigned int nr_regions = 0;
+
+	damon_for_each_task(t)
+		nr_regions += nr_damon_regions(t);
+	if (nr_regions > max_nr_regions / 2)
+		return;
+
+	damon_for_each_task(t)
+		damon_split_regions_of(t);
+}
+
 /*
  * Check whether current monitoring should be stopped
  *
@@ -657,21 +779,29 @@ static int kdamond_fn(void *data)
 	struct damon_task *t;
 	struct damon_region *r, *next;
 	struct mm_struct *mm;
+	unsigned long max_nr_accesses;
 
 	pr_info("kdamond (%d) starts\n", kdamond->pid);
 	kdamond_init_regions();
 	while (!kdamond_need_stop()) {
+		max_nr_accesses = 0;
 		damon_for_each_task(t) {
 			mm = damon_get_mm(t);
 			if (!mm)
 				continue;
-			damon_for_each_region(r, t)
+			damon_for_each_region(r, t) {
 				kdamond_check_access(mm, r);
+				if (r->nr_accesses > max_nr_accesses)
+					max_nr_accesses = r->nr_accesses;
+			}
 			mmput(mm);
 		}
 
-		if (kdamond_aggregate_interval_passed())
+		if (kdamond_aggregate_interval_passed()) {
+			kdamond_merge_regions(max_nr_accesses / 10);
 			kdamond_flush_aggregated();
+			kdamond_split_regions();
+		}
 
 		usleep_range(sample_interval, sample_interval + 1);
 	}
@@ -780,6 +910,7 @@ static long damon_set_pids(unsigned long *pids, ssize_t nr_pids)
  * sample_int		time interval between samplings
  * aggr_int		time interval between aggregations
  * min_nr_reg		minimal number of regions
+ * max_nr_reg		maximum number of regions
  * path_to_rfile	path to the monitor result files
  *
  * This function should not be called while the kdamond is running.
@@ -787,8 +918,10 @@ static long damon_set_pids(unsigned long *pids, ssize_t nr_pids)
  *
  * Returns 0 on success, negative error code otherwise.
  */
-static long damon_set_attrs(unsigned long sample_int, unsigned long aggr_int,
-		unsigned long min_nr_reg, char *path_to_rfile)
+static long damon_set_attrs(unsigned long sample_int,
+		unsigned long aggr_int,
+		unsigned long min_nr_reg, unsigned long max_nr_reg,
+		char *path_to_rfile)
 {
 	if (strnlen(path_to_rfile, LEN_RES_FILE_PATH) >= LEN_RES_FILE_PATH) {
 		pr_err("too long (>%d) result file path %s\n",
@@ -800,10 +933,16 @@ static long damon_set_attrs(unsigned long sample_int, unsigned long aggr_int,
 				min_nr_reg);
 		return -EINVAL;
 	}
+	if (min_nr_reg >= max_nr_regions) {
+		pr_err("invalid nr_regions.  min (%lu) >= max (%lu)\n",
+				min_nr_reg, max_nr_reg);
+		return -EINVAL;
+	}
 
 	sample_interval = sample_int;
 	aggr_interval = aggr_int;
 	min_nr_regions = min_nr_reg;
+	max_nr_regions = max_nr_reg;
 	strncpy(rfile_path, path_to_rfile, LEN_RES_FILE_PATH);
 	return 0;
 }
-- 
2.17.1

