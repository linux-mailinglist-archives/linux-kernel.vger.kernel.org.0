Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31670189AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Mar 2020 12:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgCRLbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Mar 2020 07:31:25 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:23024 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgCRLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584531084; x=1616067084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Gz1TacAIoe7eEilKrgWA9QhMe33T33CzRWdxDRA3U50=;
  b=JGNpe8pUg3ezj0h5CJsQi8f51WqH4Tf+JzrbuudjEBS8D/mdtzGRrijw
   +H5x0Pa7UeIPSqT1KtSBvX58KClGGc7Qspcahvgzvv1JT8f994ZnYyROG
   00kCB0mAjXR/OKgyLpliT9WczHVPuyv7NwIpbbJa+qCPgE9jA1knDe56M
   g=;
IronPort-SDR: s/i5SgHJv+MZoUH8Bxx5k4MF3WW0QocPzQAs0cJ79QDOq8+JW6UambIaoUQDmZo0kexIA2gVkP
 105ZvVy9yzdg==
X-IronPort-AV: E=Sophos;i="5.70,567,1574121600"; 
   d="scan'208";a="23517497"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Mar 2020 11:31:21 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 11C07A2BC2;
        Wed, 18 Mar 2020 11:31:10 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Mar 2020 11:31:10 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.235) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Mar 2020 11:30:51 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 03/15] mm: Introduce Data Access MONitor (DAMON)
Date:   Wed, 18 Mar 2020 12:27:10 +0100
Message-ID: <20200318112722.30143-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318112722.30143-1-sjpark@amazon.com>
References: <20200318112722.30143-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.235]
X-ClientProxiedBy: EX13D28UWC001.ant.amazon.com (10.43.162.166) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit introduces a kernel module named DAMON.  Note that this
commit is implementing only the stub for the module load/unload, basic
data structures, and simple manipulation functions of the structures to
keep the size of commit small.  The core mechanisms of DAMON will be
implemented one by one by following commits.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 include/linux/damon.h |  38 +++++++++
 mm/Kconfig            |  11 +++
 mm/Makefile           |   1 +
 mm/damon.c            | 189 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 239 insertions(+)
 create mode 100644 include/linux/damon.h
 create mode 100644 mm/damon.c

diff --git a/include/linux/damon.h b/include/linux/damon.h
new file mode 100644
index 000000000000..7117bb7e7544
--- /dev/null
+++ b/include/linux/damon.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DAMON api
+ *
+ * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#ifndef _DAMON_H_
+#define _DAMON_H_
+
+#include <linux/random.h>
+#include <linux/types.h>
+
+/* Represents a monitoring target region on the virtual address space */
+struct damon_region {
+	unsigned long vm_start;
+	unsigned long vm_end;
+	unsigned long sampling_addr;
+	unsigned int nr_accesses;
+	struct list_head list;
+};
+
+/* Represents a monitoring target task */
+struct damon_task {
+	unsigned long pid;
+	struct list_head regions_list;
+	struct list_head list;
+};
+
+struct damon_ctx {
+	struct rnd_state rndseed;
+
+	struct list_head tasks_list;	/* 'damon_task' objects */
+};
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..79da00d15604 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -739,4 +739,15 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config DAMON
+	tristate "Data Access Monitor"
+	depends on MMU
+	help
+	  Provides data access monitoring.
+
+	  DAMON is a kernel module that allows users to monitor the actual
+	  memory access pattern of specific user-space processes.  It aims to
+	  be 1) accurate enough to be useful for performance-centric domains,
+	  and 2) sufficiently light-weight so that it can be applied online.
+
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 1937cc251883..2911b3832c90 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
 obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
+obj-$(CONFIG_DAMON) += damon.o
diff --git a/mm/damon.c b/mm/damon.c
new file mode 100644
index 000000000000..d7e6226ab7f1
--- /dev/null
+++ b/mm/damon.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Access Monitor
+ *
+ * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#define pr_fmt(fmt) "damon: " fmt
+
+#include <linux/damon.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#define damon_get_task_struct(t) \
+	(get_pid_task(find_vpid(t->pid), PIDTYPE_PID))
+
+#define damon_next_region(r) \
+	(container_of(r->list.next, struct damon_region, list))
+
+#define damon_prev_region(r) \
+	(container_of(r->list.prev, struct damon_region, list))
+
+#define damon_for_each_region(r, t) \
+	list_for_each_entry(r, &t->regions_list, list)
+
+#define damon_for_each_region_safe(r, next, t) \
+	list_for_each_entry_safe(r, next, &t->regions_list, list)
+
+#define damon_for_each_task(ctx, t) \
+	list_for_each_entry(t, &(ctx)->tasks_list, list)
+
+#define damon_for_each_task_safe(ctx, t, next) \
+	list_for_each_entry_safe(t, next, &(ctx)->tasks_list, list)
+
+/* Get a random number in [l, r) */
+#define damon_rand(ctx, l, r) (l + prandom_u32_state(&ctx->rndseed) % (r - l))
+
+/*
+ * Construct a damon_region struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+static struct damon_region *damon_new_region(struct damon_ctx *ctx,
+				unsigned long vm_start, unsigned long vm_end)
+{
+	struct damon_region *region;
+
+	region = kmalloc(sizeof(*region), GFP_KERNEL);
+	if (!region)
+		return NULL;
+
+	region->vm_start = vm_start;
+	region->vm_end = vm_end;
+	region->nr_accesses = 0;
+	region->sampling_addr = damon_rand(ctx, vm_start, vm_end);
+	INIT_LIST_HEAD(&region->list);
+
+	return region;
+}
+
+/*
+ * Add a region between two other regions
+ */
+static inline void damon_insert_region(struct damon_region *r,
+		struct damon_region *prev, struct damon_region *next)
+{
+	__list_add(&r->list, &prev->list, &next->list);
+}
+
+static void damon_add_region(struct damon_region *r, struct damon_task *t)
+{
+	list_add_tail(&r->list, &t->regions_list);
+}
+
+static void damon_del_region(struct damon_region *r)
+{
+	list_del(&r->list);
+}
+
+static void damon_free_region(struct damon_region *r)
+{
+	kfree(r);
+}
+
+static void damon_destroy_region(struct damon_region *r)
+{
+	damon_del_region(r);
+	damon_free_region(r);
+}
+
+/*
+ * Construct a damon_task struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+static struct damon_task *damon_new_task(unsigned long pid)
+{
+	struct damon_task *t;
+
+	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+
+	t->pid = pid;
+	INIT_LIST_HEAD(&t->regions_list);
+
+	return t;
+}
+
+/* Returns n-th damon_region of the given task */
+struct damon_region *damon_nth_region_of(struct damon_task *t, unsigned int n)
+{
+	struct damon_region *r;
+	unsigned int i = 0;
+
+	damon_for_each_region(r, t) {
+		if (i++ == n)
+			return r;
+	}
+
+	return NULL;
+}
+
+static void damon_add_task(struct damon_ctx *ctx, struct damon_task *t)
+{
+	list_add_tail(&t->list, &ctx->tasks_list);
+}
+
+static void damon_del_task(struct damon_task *t)
+{
+	list_del(&t->list);
+}
+
+static void damon_free_task(struct damon_task *t)
+{
+	struct damon_region *r, *next;
+
+	damon_for_each_region_safe(r, next, t)
+		damon_free_region(r);
+	kfree(t);
+}
+
+static void damon_destroy_task(struct damon_task *t)
+{
+	damon_del_task(t);
+	damon_free_task(t);
+}
+
+static unsigned int nr_damon_tasks(struct damon_ctx *ctx)
+{
+	struct damon_task *t;
+	unsigned int nr_tasks = 0;
+
+	damon_for_each_task(ctx, t)
+		nr_tasks++;
+
+	return nr_tasks;
+}
+
+static unsigned int nr_damon_regions(struct damon_task *t)
+{
+	struct damon_region *r;
+	unsigned int nr_regions = 0;
+
+	damon_for_each_region(r, t)
+		nr_regions++;
+
+	return nr_regions;
+}
+
+static int __init damon_init(void)
+{
+	return 0;
+}
+
+static void __exit damon_exit(void)
+{
+	return;
+}
+
+module_init(damon_init);
+module_exit(damon_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("SeongJae Park <sjpark@amazon.de>");
+MODULE_DESCRIPTION("DAMON: Data Access MONitor");
-- 
2.17.1

