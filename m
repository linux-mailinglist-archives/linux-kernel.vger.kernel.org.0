Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB9F0142FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgATQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 11:29:08 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:10975 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgATQ3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579537746; x=1611073746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=VWI3iKWCGFxKCrPhXElhJRjHWg68meG4dSAmn+17eBI=;
  b=u9ndmuBziFcCx01mgnzZs/wpcJLiCE6Cle9rK6G1ojXLqNH7pM0b8Vor
   WipuO/gyhkvdcfcV3RebEH596yPQpgJV+UhpDm702KMeJEopqVuHyXyuj
   YlGGvWeuDAWHJk5i6UVSFsfHo+w+LcNjTgVnf3n++VMYGH5fey55U/FTs
   0=;
IronPort-SDR: +ddrrpCzZaIVycq8yz72hIlt2gHwluQ8c9DkRoLclXVXB0JLP46i3BI7GY8pjQwgAbrN4A4p73
 rVTzUB8a0qpA==
X-IronPort-AV: E=Sophos;i="5.70,342,1574121600"; 
   d="scan'208";a="19801579"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 20 Jan 2020 16:28:46 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id DFD04A1EB6;
        Mon, 20 Jan 2020 16:28:41 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Mon, 20 Jan 2020 16:28:41 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.253) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 Jan 2020 16:28:35 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <acme@kernel.org>,
        <brendan.d.gregg@gmail.com>, <corbet@lwn.net>, <mgorman@suse.de>,
        <dwmw@amazon.com>, <amit@kernel.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/8] mm: Introduce Data Access MONitor (DAMON)
Date:   Mon, 20 Jan 2020 17:27:50 +0100
Message-ID: <20200120162757.32375-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200120162757.32375-1-sjpark@amazon.com>
References: <20200120162757.32375-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D14UWC002.ant.amazon.com (10.43.162.214) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit introduces a new kernel module named DAMON.  Note that this
commit is implementing only the stub for the module load/unload, basic
data structures, and simple manipulation functions of the structures to
keep the size of commit small.  The core mechanisms of DAMON will be
implemented one by one by following commits.

Brief Introduction
==================

DAMON is a kernel module that would allow users to monitor the actual
memory access pattern of specific user-space processes.  It aims to be
1) accurate enough to be useful for performance-centric domains, and 2)
sufficiently light-weight so that it can be applied online.

For the goals, DAMON will utilize its two core mechanisms, called
region-based sampling and adaptive regions adjustment.  The region-based
sampling allows users to make their own trade-off between the quality
and the overhead of the monitoring and set the upperbound of the
monitoring overhead.  Further, the adaptive regions adjustment mechanism
makes DAMON to maximize the quality and minimize the overhead with its
best efforts while preserving the users configured trade-off.

Please note that the term 'memory' in this context means 'main memory'.
It also assumes that it would usually utilizes the middle level speed
memory devices such as DRAMs or NVRAMs.  CPU caches or storage devices
are not DAMON's concern, as those are too fast or too slow to be in
DAMON's scope.

Expected Use-cases
==================

A straightforward usecase of DAMON would be the program behavior
analysis.  With the DAMON output, users can confirm whether the program
is running as intended or not.  This will be useful for debuggings and
tests of design points.

The monitored results can also be useful for counting the dynamic
working set size of workloads.  For the administration of memory
overcommitted systems or selection of the environments (e.g., containers
providing different amount of memory) for your workloads, this will be
useful.

If you are a programmer, you can optimize your program by managing the
memory based on the actual data access pattern.  For example, you can
identify the dynamic hotness of your data using DAMON and call
``mlock()`` to keep your hot data in DRAM, or call ``madvise()`` with
``MADV_PAGEOUT`` to proactively reclaim cold data.  Even though your
program is guaranteed to not encounter memory pressure, you can still
improve the performance by applying the DAMON outputs for call of
``MADV_HUGEPAGE`` and ``MADV_NOHUGEPAGE``.  More creative optimizations
would be possible.  Our evaluations of DAMON includes a straightforward
optimization using the ``mlock()``.  Please refer to the below
Evaluation section for more detail.

As DAMON incurs very low overhead, such optimizations can be applied not
only offline, but also online.  Also, there is no reason to limit such
optimizations to the user space.  Several parts of the kernel's memory
management mechanisms could be also optimized using DAMON. The
reclamation, the THP (de)promotion decisions, and the compaction would
be such a candidates.  Nevertheless, current version of DAMON is not
highly optimized for the online/in-kernel uses.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 MAINTAINERS |   6 ++
 mm/Kconfig  |  12 +++
 mm/Makefile |   1 +
 mm/damon.c  | 223 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+)
 create mode 100644 mm/damon.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 97e3ce930083..c8db500a182f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4583,6 +4583,12 @@ F:	net/ax25/ax25_out.c
 F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
+DATA ACCESS MONITOR
+M:	SeongJae Park <sjpark@amazon.de>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	mm/damon.c
+
 DAVICOM FAST ETHERNET (DMFE) NETWORK DRIVER
 L:	netdev@vger.kernel.org
 S:	Orphan
diff --git a/mm/Kconfig b/mm/Kconfig
index a5dae9a7eb51..35813e0d0e28 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -736,4 +736,16 @@ config ARCH_HAS_PTE_SPECIAL
 config ARCH_HAS_HUGEPD
 	bool
 
+config DAMON
+	tristate "Data Access Monitor"
+	depends on MMU
+	default y
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
index d996846697ef..6c3c7c364015 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -107,3 +107,4 @@ obj-$(CONFIG_PERCPU_STATS) += percpu-stats.o
 obj-$(CONFIG_ZONE_DEVICE) += memremap.o
 obj-$(CONFIG_HMM_MIRROR) += hmm.o
 obj-$(CONFIG_MEMFD_CREATE) += memfd.o
+obj-$(CONFIG_DAMON) += damon.o
diff --git a/mm/damon.c b/mm/damon.c
new file mode 100644
index 000000000000..064ec1f6ded9
--- /dev/null
+++ b/mm/damon.c
@@ -0,0 +1,223 @@
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
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/random.h>
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
+#define damon_for_each_task(t) \
+	list_for_each_entry(t, &damon_tasks_list, list)
+
+#define damon_for_each_task_safe(t, next) \
+	list_for_each_entry_safe(t, next, &damon_tasks_list, list)
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
+/* List of damon_task objects */
+static LIST_HEAD(damon_tasks_list);
+
+static struct rnd_state rndseed;
+/* Get a random number in [l, r) */
+#define damon_rand(l, r) (l + prandom_u32_state(&rndseed) % (r - l))
+
+/*
+ * Construct a damon_region struct
+ *
+ * Returns the pointer to the new struct if success, or NULL otherwise
+ */
+static struct damon_region *damon_new_region(unsigned long vm_start,
+					unsigned long vm_end)
+{
+	struct damon_region *ret;
+
+	ret = kmalloc(sizeof(struct damon_region), GFP_KERNEL);
+	if (!ret)
+		return NULL;
+	ret->vm_start = vm_start;
+	ret->vm_end = vm_end;
+	ret->nr_accesses = 0;
+	ret->sampling_addr = damon_rand(vm_start, vm_end);
+	INIT_LIST_HEAD(&ret->list);
+
+	return ret;
+}
+
+/*
+ * Add a region between two other regions
+ */
+static inline void damon_add_region(struct damon_region *r,
+		struct damon_region *prev, struct damon_region *next)
+{
+	__list_add(&r->list, &prev->list, &next->list);
+}
+
+/*
+ * Append a region to a task's list of regions
+ */
+static void damon_add_region_tail(struct damon_region *r, struct damon_task *t)
+{
+	list_add_tail(&r->list, &t->regions_list);
+}
+
+/*
+ * Delete a region from its list
+ */
+static void damon_del_region(struct damon_region *r)
+{
+	list_del(&r->list);
+}
+
+/*
+ * De-allocate a region
+ */
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
+	t = kmalloc(sizeof(struct damon_task), GFP_KERNEL);
+	if (!t)
+		return NULL;
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
+	unsigned int i;
+
+	i = 0;
+	damon_for_each_region(r, t) {
+		if (i++ == n)
+			return r;
+	}
+	return NULL;
+}
+
+static void damon_add_task_tail(struct damon_task *t)
+{
+	list_add_tail(&t->list, &damon_tasks_list);
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
+/*
+ * Returns number of monitoring target tasks
+ */
+static unsigned int nr_damon_tasks(void)
+{
+	struct damon_task *t;
+	unsigned int ret = 0;
+
+	damon_for_each_task(t)
+		ret++;
+	return ret;
+}
+
+/*
+ * Returns the number of target regions for a given target task
+ */
+static unsigned int nr_damon_regions(struct damon_task *t)
+{
+	struct damon_region *r;
+	unsigned int ret = 0;
+
+	damon_for_each_region(r, t)
+		ret++;
+	return ret;
+}
+
+static int __init damon_init(void)
+{
+	pr_info("init\n");
+
+	prandom_seed_state(&rndseed, 42);
+	return 0;
+}
+
+static void __exit damon_exit(void)
+{
+	pr_info("exit\n");
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

