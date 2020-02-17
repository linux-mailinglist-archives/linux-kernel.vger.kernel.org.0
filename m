Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30E74160FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2020 11:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgBQK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Feb 2020 05:27:45 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4803 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbgBQK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581935264; x=1613471264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=oZnJcj23ZgAKIikbswlN6tGEpYxRqIysLxZZhWCaknk=;
  b=DFxW2z4UvYyK2WYwGvW+zWqTMYbzdf1HWrdTkyaYRMgNkLCSFNwFfz97
   IKBy1/xw0QAJwykpLCg49LZ1hz7wQeYGXnx9zw4cktCMAh3RBXAnFlcwu
   GYfhMq1kFLYodtcgYZF/3If04JXXYNCWHB9tpJpyDIIRm23Qch7rF05kW
   M=;
IronPort-SDR: GazxHAAmHUukeku1pj7SYzlT6iaU8QitX8fXT+jZrrLOabChlTSrfYQ19t85UQf3YqkvjujREx
 2c/TMU8m8D9w==
X-IronPort-AV: E=Sophos;i="5.70,452,1574121600"; 
   d="scan'208";a="18057870"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 17 Feb 2020 10:27:28 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id C7E50A2E1B;
        Mon, 17 Feb 2020 10:27:25 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 17 Feb 2020 10:27:25 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 17 Feb 2020 10:27:15 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 06/14] mm/damon: Implement access pattern recording
Date:   Mon, 17 Feb 2020 11:25:36 +0100
Message-ID: <20200217102544.29012-7-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217102544.29012-1-sjpark@amazon.com>
References: <20200217102544.29012-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D30UWB004.ant.amazon.com (10.43.161.51) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements the recording feature of DAMON. If this feature
is enabled, DAMON writes the monitored access patterns in its binary
format into a file which specified by the user. This is already able to
be implemented by each user using the callbacks.  However, as the
recording is expected to be used widely, this commit implements the
feature in the DAMON, for more convenience and efficiency.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/damon.c | 124 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 3 deletions(-)

diff --git a/mm/damon.c b/mm/damon.c
index 90f61e378a61..3d46bf5e353a 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -76,6 +76,11 @@ struct damon_ctx {
 	struct timespec64 last_aggregation;
 	struct timespec64 last_regions_update;
 
+	unsigned char *rbuf;
+	unsigned int rbuf_len;
+	unsigned int rbuf_offset;
+	char *rfile_path;
+
 	struct task_struct *kdamond;
 	bool kdamond_stop;
 	spinlock_t kdamond_lock;
@@ -89,6 +94,8 @@ struct damon_ctx {
 	void (*aggregate_cb)(struct damon_ctx *context);
 };
 
+#define MAX_RFILE_PATH_LEN	256
+
 /* Get a random number in [l, r) */
 #define damon_rand(ctx, l, r) (l + prandom_u32_state(&ctx->rndseed) % (r - l))
 
@@ -550,16 +557,81 @@ static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
 }
 
 /*
- * Reset the aggregated monitoring results
+ * Flush the content in the result buffer to the result file
+ */
+static void damon_flush_rbuffer(struct damon_ctx *ctx)
+{
+	ssize_t sz;
+	loff_t pos;
+	struct file *rfile;
+
+	while (ctx->rbuf_offset) {
+		pos = 0;
+		rfile = filp_open(ctx->rfile_path, O_CREAT | O_RDWR | O_APPEND,
+				0644);
+		if (IS_ERR(rfile)) {
+			pr_err("Cannot open the result file %s\n",
+					ctx->rfile_path);
+			return;
+		}
+
+		sz = kernel_write(rfile, ctx->rbuf, ctx->rbuf_offset, &pos);
+		filp_close(rfile, NULL);
+
+		ctx->rbuf_offset -= sz;
+	}
+}
+
+/*
+ * Write a data into the result buffer
+ */
+static void damon_write_rbuf(struct damon_ctx *ctx, void *data, ssize_t size)
+{
+	if (!ctx->rbuf_len || !ctx->rbuf)
+		return;
+	if (ctx->rbuf_offset + size > ctx->rbuf_len)
+		damon_flush_rbuffer(ctx);
+
+	memcpy(&ctx->rbuf[ctx->rbuf_offset], data, size);
+	ctx->rbuf_offset += size;
+}
+
+/*
+ * Flush the aggregated monitoring results to the result buffer
+ *
+ * Stores current tracking results to the result buffer and reset 'nr_accesses'
+ * of each regions.  The format for the result buffer is as below:
+ *
+ *   <time> <number of tasks> <array of task infos>
+ *
+ *   task info: <pid> <number of regions> <array of region infos>
+ *   region info: <start address> <end address> <nr_accesses>
  */
 static void kdamond_flush_aggregated(struct damon_ctx *c)
 {
 	struct damon_task *t;
-	struct damon_region *r;
+	struct timespec64 now;
+	unsigned int nr;
+
+	ktime_get_coarse_ts64(&now);
+
+	damon_write_rbuf(c, &now, sizeof(struct timespec64));
+	nr = nr_damon_tasks(c);
+	damon_write_rbuf(c, &nr, sizeof(nr));
 
 	damon_for_each_task(c, t) {
-		damon_for_each_region(r, t)
+		struct damon_region *r;
+
+		damon_write_rbuf(c, &t->pid, sizeof(t->pid));
+		nr = nr_damon_regions(t);
+		damon_write_rbuf(c, &nr, sizeof(nr));
+		damon_for_each_region(r, t) {
+			damon_write_rbuf(c, &r->vm_start, sizeof(r->vm_start));
+			damon_write_rbuf(c, &r->vm_end, sizeof(r->vm_end));
+			damon_write_rbuf(c, &r->nr_accesses,
+					sizeof(r->nr_accesses));
 			r->nr_accesses = 0;
+		}
 	}
 }
 
@@ -834,6 +906,7 @@ static int kdamond_fn(void *data)
 
 		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
 	}
+	damon_flush_rbuffer(ctx);
 	damon_for_each_task(ctx, t) {
 		damon_for_each_region_safe(r, next, t)
 			damon_destroy_region(r);
@@ -912,6 +985,51 @@ static int damon_set_pids(struct damon_ctx *ctx,
 	return 0;
 }
 
+/*
+ * Set attributes for the recording
+ *
+ * ctx		target kdamond context
+ * rbuf_len	length of the result buffer
+ * rfile_path	path to the monitor result files
+ *
+ * Setting 'rbuf_len' 0 disables recording.
+ *
+ * This function should not be called while the kdamond is running.
+ *
+ * Returns 0 on success, negative error code otherwise.
+ */
+static int damon_set_recording(struct damon_ctx *ctx,
+				unsigned int rbuf_len, char *rfile_path)
+{
+	size_t rfile_path_len;
+
+	if (rbuf_len > 4 * 1024 * 1024) {
+		pr_err("too long (>%d) result buffer length\n",
+				4 * 1024 * 1024);
+		return -EINVAL;
+	}
+	rfile_path_len = strnlen(rfile_path, MAX_RFILE_PATH_LEN);
+	if (rfile_path_len >= MAX_RFILE_PATH_LEN) {
+		pr_err("too long (>%d) result file path %s\n",
+				MAX_RFILE_PATH_LEN, rfile_path);
+		return -EINVAL;
+	}
+	ctx->rbuf_len = rbuf_len;
+	kfree(ctx->rbuf);
+	kfree(ctx->rfile_path);
+	if (!rbuf_len)
+		return 0;
+
+	ctx->rbuf = kvmalloc(rbuf_len, GFP_KERNEL);
+	if (!ctx->rbuf)
+		return -ENOMEM;
+	ctx->rfile_path = kmalloc(rfile_path_len + 1, GFP_KERNEL);
+	if (!ctx->rfile_path)
+		return -ENOMEM;
+	strncpy(ctx->rfile_path, rfile_path, rfile_path_len + 1);
+	return 0;
+}
+
 /*
  * Set attributes for the monitoring
  *
-- 
2.17.1

