Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D1136DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 14:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgAJNSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jan 2020 08:18:20 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:29957 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgAJNSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 08:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578662297; x=1610198297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=B5diwc3i/K+sWdwNuNXD6p4E8O6N/m5denNj/GUhgrM=;
  b=LEHa2ZS6K7Em8RicjsucRMCuvh30GjML3m5gdAoOBIpkB7/GpXOIxQgV
   77UT5g8IahnYsFC+jOzt4O1un2x1z1jQAok+kyZGR6DTJQHNcz+vFfGBe
   K9WMdKZPBeyYa9zJ7MXqktoDdiO3CLtzZ8nGDf8MAiq5nJNVuwowNm8OO
   E=;
IronPort-SDR: vSd92ypDhQMFCsS8oH5oeSkSa83C3Q9UP8ZRdCC4mWsjuXLKBr4pqssw45rkc2bm8W05EvzLmK
 7j+NpnZH1VkQ==
X-IronPort-AV: E=Sophos;i="5.69,417,1571702400"; 
   d="scan'208";a="10965220"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 10 Jan 2020 13:18:16 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 5FC80A2477;
        Fri, 10 Jan 2020 13:18:13 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Fri, 10 Jan 2020 13:18:12 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.119) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 10 Jan 2020 13:18:07 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>, <mgorman@suse.de>,
        <brendanhiggins@google.com>, <sj38.park@gmail.com>,
        SeongJae Park <sjpark@amazon.de>
Subject: [RFC PATCH 5/5] mm/damon: Add kunit tests
Date:   Fri, 10 Jan 2020 14:17:53 +0100
Message-ID: <20200110131753.30737-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110131522.29964-1-sjpark@amazon.com>
References: <20200110131522.29964-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.119]
X-ClientProxiedBy: EX13D22UWC004.ant.amazon.com (10.43.162.198) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds kunit based unit tests for DAMON.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/Kconfig      |  11 +
 mm/damon-test.h | 571 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/damon.c      |   2 +
 3 files changed, 584 insertions(+)
 create mode 100644 mm/damon-test.h

diff --git a/mm/Kconfig b/mm/Kconfig
index b7af8a1b5cb5..7b023799aa38 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -748,4 +748,15 @@ config DAMON
 	  be 1) accurate enough to be useful for performance-centric domains,
 	  and 2) sufficiently light-weight so that it can be applied online.
 
+config DAMON_TEST
+	bool "Test for damon"
+	depends on DAMON && KUNIT
+	help
+	  This builds the DAMON Kunit test suite.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/mm/damon-test.h b/mm/damon-test.h
new file mode 100644
index 000000000000..0d94910b8fe5
--- /dev/null
+++ b/mm/damon-test.h
@@ -0,0 +1,571 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data Access Monitor Unit Tests
+ *
+ * Copyright 2019 Amazon.com, Inc. or its affiliates.  All rights reserved.
+ *
+ * Author: SeongJae Park <sjpark@amazon.de>
+ */
+
+#ifdef CONFIG_DAMON_TEST
+
+#ifndef _DAMON_TEST_H
+#define _DAMON_TEST_H
+
+#include <kunit/test.h>
+
+static void damon_test_str_to_pids(struct kunit *test)
+{
+	char *question;
+	unsigned long *answers;
+	unsigned long expected[] = {12, 35, 46};
+	ssize_t nr_integers = 0, i;
+
+	question = "123";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, 1l, nr_integers);
+	KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
+	kfree(answers);
+
+	question = "123abc";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, 1l, nr_integers);
+	KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
+	kfree(answers);
+
+	question = "a123";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, 0l, nr_integers);
+	KUNIT_EXPECT_PTR_EQ(test, answers, (unsigned long *)NULL);
+
+	question = "12 35";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, 2l, nr_integers);
+	for (i = 0; i < nr_integers; i++)
+		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
+	kfree(answers);
+
+	question = "12 35 46";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, 3l, nr_integers);
+	for (i = 0; i < nr_integers; i++)
+		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
+	kfree(answers);
+
+	question = "12 35 abc 46";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, 2l, nr_integers);
+	for (i = 0; i < 2; i++)
+		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
+	kfree(answers);
+
+	question = "";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, 0l, nr_integers);
+	KUNIT_EXPECT_PTR_EQ(test, (unsigned long *)NULL, answers);
+	kfree(answers);
+
+	question = "\n";
+	answers = str_to_pids(question, strnlen(question, 128), &nr_integers);
+	KUNIT_EXPECT_EQ(test, 0l, nr_integers);
+	KUNIT_EXPECT_PTR_EQ(test, (unsigned long *)NULL, answers);
+	kfree(answers);
+}
+
+static void damon_test_regions(struct kunit *test)
+{
+	struct damon_region *r;
+	struct damon_task *t;
+
+	r = damon_new_region(1, 2);
+	KUNIT_EXPECT_EQ(test, 1ul, r->vm_start);
+	KUNIT_EXPECT_EQ(test, 2ul, r->vm_end);
+	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
+	KUNIT_EXPECT_TRUE(test, r->sampling_addr >= r->vm_start);
+	KUNIT_EXPECT_TRUE(test, r->sampling_addr < r->vm_end);
+
+	t = damon_new_task(42);
+	KUNIT_EXPECT_EQ(test, 0u, nr_damon_regions(t));
+
+	damon_add_region_tail(r, t);
+	KUNIT_EXPECT_EQ(test, 1u, nr_damon_regions(t));
+
+	damon_del_region(r);
+	KUNIT_EXPECT_EQ(test, 0u, nr_damon_regions(t));
+
+	damon_free_task(t);
+}
+
+static void damon_test_tasks(struct kunit *test)
+{
+	struct damon_task *t;
+
+	t = damon_new_task(42);
+	KUNIT_EXPECT_EQ(test, 42ul, t->pid);
+	KUNIT_EXPECT_EQ(test, 0u, nr_damon_tasks());
+
+	damon_add_task_tail(t);
+	KUNIT_EXPECT_EQ(test, 1u, nr_damon_tasks());
+
+	damon_destroy_task(t);
+	KUNIT_EXPECT_EQ(test, 0u, nr_damon_tasks());
+}
+
+static void damon_test_set_pids(struct kunit *test)
+{
+	unsigned long pids[] = {1, 2, 3};
+	char buf[64];
+
+	damon_set_pids(pids, 3);
+	damon_sprint_pids(buf, 64);
+	pr_info("buf: %s (%zu)\n", buf, strlen(buf));
+	KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "1 2 3\n", 64));
+
+	damon_set_pids(NULL, 0);
+	damon_sprint_pids(buf, 64);
+	KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "\n", 64));
+
+	damon_set_pids((unsigned long []){1, 2}, 2);
+	damon_sprint_pids(buf, 64);
+	KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "1 2\n", 64));
+
+	damon_set_pids((unsigned long []){2}, 1);
+	damon_sprint_pids(buf, 64);
+	KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "2\n", 64));
+
+	damon_set_pids(NULL, 0);
+	damon_sprint_pids(buf, 64);
+	KUNIT_EXPECT_EQ(test, 0, strncmp(buf, "\n", 64));
+}
+
+static void damon_test_three_regions_in_vmas(struct kunit *test)
+{
+	struct region regions[3] = {0,};
+
+	struct vm_area_struct vmas[] = {
+		(struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
+		(struct vm_area_struct) {.vm_start = 20, .vm_end = 25},
+		(struct vm_area_struct) {.vm_start = 200, .vm_end = 210},
+		(struct vm_area_struct) {.vm_start = 210, .vm_end = 220},
+		(struct vm_area_struct) {.vm_start = 300, .vm_end = 305},
+		(struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
+	};
+	vmas[0].vm_next = &vmas[1];
+	vmas[1].vm_next = &vmas[2];
+	vmas[2].vm_next = &vmas[3];
+	vmas[3].vm_next = &vmas[4];
+	vmas[4].vm_next = &vmas[5];
+	vmas[5].vm_next = NULL;
+
+	damon_three_regions_in_vmas(&vmas[0], regions);
+
+	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
+	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
+	KUNIT_EXPECT_EQ(test, 200ul, regions[1].start);
+	KUNIT_EXPECT_EQ(test, 220ul, regions[1].end);
+	KUNIT_EXPECT_EQ(test, 300ul, regions[2].start);
+	KUNIT_EXPECT_EQ(test, 330ul, regions[2].end);
+}
+
+/* Clean up global state of damon */
+static void damon_cleanup_global_state(void)
+{
+	struct damon_task *t, *next;
+
+	damon_for_each_task_safe(t, next)
+		damon_destroy_task(t);
+
+	damon_rbuf_offset = 0;
+}
+
+static void damon_test_aggregate(struct kunit *test)
+{
+	unsigned long pids[] = {1, 2, 3};
+	unsigned long saddr[][3] = {{10, 20, 30}, {5, 42, 49}, {13, 33, 55} };
+	unsigned long eaddr[][3] = {{15, 27, 40}, {31, 45, 55}, {23, 44, 66} };
+	unsigned long accesses[][3] = {{42, 95, 84}, {10, 20, 30}, {0, 1, 2} };
+	struct damon_task *t;
+	struct damon_region *r;
+	int it, ir;
+	ssize_t sz, sr, sp;
+
+	damon_set_pids(pids, 3);
+
+	it = 0;
+	damon_for_each_task(t) {
+		for (ir = 0; ir < 3; ir++) {
+			r = damon_new_region(saddr[it][ir], eaddr[it][ir]);
+			r->nr_accesses = accesses[it][ir];
+			damon_add_region_tail(r, t);
+		}
+		it++;
+	}
+	kdamond_flush_aggregated();
+	it = 0;
+	damon_for_each_task(t) {
+		ir = 0;
+		damon_for_each_region(r, t) {
+			KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
+			ir++;
+		}
+		KUNIT_EXPECT_EQ(test, 3, ir);
+		it++;
+	}
+	KUNIT_EXPECT_EQ(test, 3, it);
+
+	sr = sizeof(r->vm_start) + sizeof(r->vm_end) + sizeof(r->nr_accesses);
+	sp = sizeof(t->pid) + sizeof(unsigned int) + 3 * sr;
+	sz = sizeof(struct timespec64) + sizeof(unsigned int) + 3 * sp;
+	KUNIT_EXPECT_EQ(test, (unsigned int)sz, damon_rbuf_offset);
+
+	damon_cleanup_global_state();
+}
+
+static void damon_test_write_rbuf(struct kunit *test)
+{
+	char *data;
+
+	data = "hello";
+	damon_write_rbuf(data, strnlen(data, 256));
+	KUNIT_EXPECT_EQ(test, damon_rbuf_offset, 5u);
+
+	damon_write_rbuf(data, 0);
+	KUNIT_EXPECT_EQ(test, damon_rbuf_offset, 5u);
+
+	KUNIT_EXPECT_EQ(test, strncmp(damon_rbuf, data, 5), 0);
+}
+
+static void damon_test_update_two_gaps(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r, *prev = NULL;
+	unsigned long regions[] = {10, 20, 20, 30,
+		50, 55, 55, 57, 57, 59,
+		70, 80, 80, 90, 90, 100};	/* 10-30, 50-59, 70-100 */
+	struct region new_regions[3] = {
+		(struct region){.start = 5, .end = 27},
+		(struct region){.start = 45, .end = 55},
+		(struct region){.start = 73, .end = 104} };
+	int i;
+	bool first_gap = true;
+
+	t = damon_new_task(42);
+	for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
+		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
+		damon_add_region_tail(r, t);
+	}
+	damon_add_task_tail(t);
+
+	damon_apply_three_regions(t, new_regions);
+
+	damon_for_each_region(r, t) {
+		if (prev == NULL) {
+			KUNIT_EXPECT_EQ(test, r->vm_start, 5ul);
+			goto next;
+		}
+
+		if (prev->vm_end != r->vm_start && first_gap) {
+			KUNIT_EXPECT_EQ(test, prev->vm_end, 27ul);
+			KUNIT_EXPECT_EQ(test, r->vm_start, 45ul);
+			first_gap = false;
+			goto next;
+		}
+
+		if (prev->vm_end != r->vm_start && !first_gap) {
+			KUNIT_EXPECT_EQ(test, prev->vm_end, 55ul);
+			KUNIT_EXPECT_EQ(test, r->vm_start, 73ul);
+			goto next;
+		}
+
+next:
+		prev = r;
+	}
+
+	damon_cleanup_global_state();
+}
+
+static void damon_test_update_two_gaps2(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+	/* 10-20-30, 50-55-57-59, 70-80-90-100 */
+	unsigned long regions[] = {10, 20, 20, 30,
+		50, 55, 55, 57, 57, 59,
+		70, 80, 80, 90, 90, 100};
+	struct region new_regions[3] = {
+		(struct region){.start = 5, .end = 27},
+		(struct region){.start = 56, .end = 57},
+		(struct region){.start = 65, .end = 104} };
+	/* expect 5-27, 56-57, 65-80-90-104 */
+	unsigned long answers[] = {5, 20, 20, 27,
+		56, 57,
+		65, 80, 80, 90, 90, 104};
+	int i;
+
+	t = damon_new_task(42);
+	for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
+		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
+		damon_add_region_tail(r, t);
+	}
+	damon_add_task_tail(t);
+
+	damon_apply_three_regions(t, new_regions);
+
+	for (i = 0; i < ARRAY_SIZE(answers) / 2; i++) {
+		r = damon_nth_region_of(t, i);
+		KUNIT_EXPECT_EQ(test, r->vm_start, answers[i * 2]);
+		KUNIT_EXPECT_EQ(test, r->vm_end, answers[i++ * 2 + 1]);
+	}
+
+	damon_cleanup_global_state();
+}
+
+static void damon_test_update_two_gaps3(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+	/* 10-20-30, 50-55-57-59, 70-80-90-100 */
+	unsigned long regions[] = {10, 20, 20, 30,
+		50, 55, 55, 57, 57, 59,
+		70, 80, 80, 90, 90, 100};
+	struct region new_regions[3] = {
+		(struct region){.start = 5, .end = 27},
+		(struct region){.start = 61, .end = 63},
+		(struct region){.start = 65, .end = 104} };
+	/* expect 5-27, 56-57, 65-80-90-104 */
+	unsigned long answers[] = {5, 20, 20, 27,
+		61, 63,
+		65, 80, 80, 90, 90, 104};
+	int i;
+
+	t = damon_new_task(42);
+	for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
+		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
+		damon_add_region_tail(r, t);
+	}
+	damon_add_task_tail(t);
+
+	damon_apply_three_regions(t, new_regions);
+
+	for (i = 0; i < ARRAY_SIZE(answers) / 2; i++) {
+		r = damon_nth_region_of(t, i);
+		KUNIT_EXPECT_EQ(test, r->vm_start, answers[i * 2]);
+		KUNIT_EXPECT_EQ(test, r->vm_end, answers[i++ * 2 + 1]);
+	}
+
+	damon_cleanup_global_state();
+}
+
+static void damon_test_update_two_gaps4(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+	/* 10-20-30, 50-55-57-59, 70-80-90-100 */
+	unsigned long regions[] = {10, 20, 20, 30,
+		50, 55, 55, 57, 57, 59,
+		70, 80, 80, 90, 90, 100};
+	struct region new_regions[3] = {
+		(struct region){.start = 5, .end = 7},
+		(struct region){.start = 30, .end = 32},
+		(struct region){.start = 65, .end = 68} };
+	/* expect 5-27, 56-57, 65-80-90-104 */
+	unsigned long answers[] = {5, 7, 30, 32, 65, 68};
+	int i;
+
+	t = damon_new_task(42);
+	for (i = 0; i < ARRAY_SIZE(regions) / 2; i++) {
+		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
+		damon_add_region_tail(r, t);
+	}
+	damon_add_task_tail(t);
+
+	damon_apply_three_regions(t, new_regions);
+
+	for (i = 0; i < ARRAY_SIZE(answers) / 2; i++) {
+		r = damon_nth_region_of(t, i);
+		KUNIT_EXPECT_EQ(test, r->vm_start, answers[i * 2]);
+		KUNIT_EXPECT_EQ(test, r->vm_end, answers[i++ * 2 + 1]);
+	}
+
+	damon_cleanup_global_state();
+}
+
+static void damon_test_split_evenly(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+	unsigned long i;
+
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(NULL, 5), -EINVAL);
+
+	t = damon_new_task(42);
+	r = damon_new_region(0, 100);
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(r, 0), -EINVAL);
+
+	damon_add_region_tail(r, t);
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(r, 10), 0);
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 10u);
+
+	i = 0;
+	damon_for_each_region(r, t) {
+		KUNIT_EXPECT_EQ(test, r->vm_start, i++ * 10);
+		KUNIT_EXPECT_EQ(test, r->vm_end, i * 10);
+	}
+	damon_free_task(t);
+
+	t = damon_new_task(42);
+	r = damon_new_region(5, 59);
+	damon_add_region_tail(r, t);
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(r, 5), 0);
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 5u);
+
+	i = 0;
+	damon_for_each_region(r, t) {
+		if (i == 4)
+			break;
+		KUNIT_EXPECT_EQ(test, r->vm_start, 5 + 10 * i++);
+		KUNIT_EXPECT_EQ(test, r->vm_end, 5 + 10 * i);
+	}
+	KUNIT_EXPECT_EQ(test, r->vm_start, 5 + 10 * i);
+	KUNIT_EXPECT_EQ(test, r->vm_end, 59ul);
+	damon_free_task(t);
+
+	t = damon_new_task(42);
+	r = damon_new_region(5, 6);
+	damon_add_region_tail(r, t);
+	KUNIT_EXPECT_EQ(test, damon_split_region_evenly(r, 2), -EINVAL);
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 1u);
+
+	damon_for_each_region(r, t) {
+		KUNIT_EXPECT_EQ(test, r->vm_start, 5ul);
+		KUNIT_EXPECT_EQ(test, r->vm_end, 6ul);
+	}
+	damon_free_task(t);
+}
+
+static void damon_test_split_at(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	t = damon_new_task(42);
+	r = damon_new_region(0, 100);
+	damon_add_region_tail(r, t);
+	damon_split_region_at(r, 25);
+	KUNIT_EXPECT_EQ(test, r->vm_start, 0ul);
+	KUNIT_EXPECT_EQ(test, r->vm_end, 25ul);
+
+	r = damon_next_region(r);
+	KUNIT_EXPECT_EQ(test, r->vm_start, 25ul);
+	KUNIT_EXPECT_EQ(test, r->vm_end, 100ul);
+
+	damon_free_task(t);
+}
+
+static void damon_test_merge_two(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r, *r2, *r3;
+	int i;
+
+	t = damon_new_task(42);
+	r = damon_new_region(0, 100);
+	r->nr_accesses = 10;
+	damon_add_region_tail(r, t);
+	r2 = damon_new_region(100, 300);
+	r2->nr_accesses = 20;
+	damon_add_region_tail(r2, t);
+
+	damon_merge_two_regions(r, r2);
+	KUNIT_EXPECT_EQ(test, r->vm_start, 0ul);
+	KUNIT_EXPECT_EQ(test, r->vm_end, 300ul);
+	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
+
+	i = 0;
+	damon_for_each_region(r3, t) {
+		KUNIT_EXPECT_PTR_EQ(test, r, r3);
+		i++;
+	}
+	KUNIT_EXPECT_EQ(test, i, 1);
+
+	damon_free_task(t);
+}
+
+static void damon_test_merge_regions_of(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
+	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
+	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
+
+	unsigned long saddrs[] = {0, 114, 130, 156, 170};
+	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
+	int i;
+
+	t = damon_new_task(42);
+	for (i = 0; i < ARRAY_SIZE(sa); i++) {
+		r = damon_new_region(sa[i], ea[i]);
+		r->nr_accesses = nrs[i];
+		damon_add_region_tail(r, t);
+	}
+
+	damon_merge_regions_of(t, 9);
+	/* 0-112, 114-130, 130-156, 156-170 */
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 5u);
+	for (i = 0; i < 5; i++) {
+		r = damon_nth_region_of(t, i);
+		KUNIT_EXPECT_EQ(test, r->vm_start, saddrs[i]);
+		KUNIT_EXPECT_EQ(test, r->vm_end, eaddrs[i]);
+	}
+	damon_free_task(t);
+}
+
+static void damon_test_split_regions_of(struct kunit *test)
+{
+	struct damon_task *t;
+	struct damon_region *r;
+
+	t = damon_new_task(42);
+	r = damon_new_region(0, 22);
+	damon_add_region_tail(r, t);
+	damon_split_regions_of(t);
+	KUNIT_EXPECT_EQ(test, nr_damon_regions(t), 2u);
+	damon_free_task(t);
+}
+
+static void damon_test_kdamond_need_stop(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, kdamond_need_stop());
+}
+
+static struct kunit_case damon_test_cases[] = {
+	KUNIT_CASE(damon_test_str_to_pids),
+	KUNIT_CASE(damon_test_tasks),
+	KUNIT_CASE(damon_test_regions),
+	KUNIT_CASE(damon_test_set_pids),
+	KUNIT_CASE(damon_test_three_regions_in_vmas),
+	KUNIT_CASE(damon_test_aggregate),
+	KUNIT_CASE(damon_test_write_rbuf),
+	KUNIT_CASE(damon_test_update_two_gaps),
+	KUNIT_CASE(damon_test_update_two_gaps2),
+	KUNIT_CASE(damon_test_update_two_gaps3),
+	KUNIT_CASE(damon_test_update_two_gaps4),
+	KUNIT_CASE(damon_test_split_evenly),
+	KUNIT_CASE(damon_test_split_at),
+	KUNIT_CASE(damon_test_merge_two),
+	KUNIT_CASE(damon_test_merge_regions_of),
+	KUNIT_CASE(damon_test_split_regions_of),
+	KUNIT_CASE(damon_test_kdamond_need_stop),
+	{},
+};
+
+static struct kunit_suite damon_test_suite = {
+	.name = "damon",
+	.test_cases = damon_test_cases,
+};
+kunit_test_suite(damon_test_suite);
+
+#endif /* _DAMON_TEST_H */
+
+#endif	/* CONFIG_DAMON_TEST */
diff --git a/mm/damon.c b/mm/damon.c
index 0e99b4875700..c4b6b2db9a8c 100644
--- a/mm/damon.c
+++ b/mm/damon.c
@@ -1262,3 +1262,5 @@ static int __init damon_init(void)
 }
 
 module_init(damon_init);
+
+#include "damon-test.h"
-- 
2.17.1

