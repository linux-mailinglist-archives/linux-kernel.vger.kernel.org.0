Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7883C15D32E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 08:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgBNHvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 02:51:50 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:53356 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgBNHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 02:51:47 -0500
Received: by mail-pg1-f202.google.com with SMTP id t17so5563266pgb.20
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 23:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AeARklAI4wkNnAg/cGpZSPjuAHJ+hARasiCvJQxYyEo=;
        b=ITedSQx3bjIWH4nXDwgVKm1eJgwuab4E0XttrqPIUoOyNH3bdU8AlBmDK1X4oCPzsr
         kpGm/86Q/Mt1cFjGcIpnsan+4qoV0pscbr6CboesGK8IcjGBdfubvwKmFCbv17TiYIpS
         96CbMNXT3y+RehwPCQBEITtimRJgCTjd6xHhNvsPgUv3AC5AGMI/DchbBqQH9v1t/N5g
         P5qJIssNRl5Hch7lyTv51VzmTKFLxVhMKyhY4EX0s4VKLqhxqcZrDsRrddygY/08orHh
         taD4Zfl5jUDxpvU0phLQ4/q5ZoajdSn+42xgCryPy87Vd7GH/p753Xq/lT51Bm9hrypQ
         z2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AeARklAI4wkNnAg/cGpZSPjuAHJ+hARasiCvJQxYyEo=;
        b=DJDvLOCdk4Qrf2zNkWz+dNkFmXnJplwJ1EPCNzNTlJbE4Uv+2+smW1YHZfv3XslP3A
         3duS+UYEqadHNyfX9gD4/41iqElSomeH3k+2ZX6JUfpFiZpE3sTLX29rNI+YglrHHUBG
         +lYgVgBWDHxoEYfE5125y4V3EI4R1D2GOFc9T27pTgiEglsCPLnpVlVg3relFrD/nYsQ
         TMopoefZUeHfD7fT05asZhxcHl41eU/FcwHKzURakopw6CIac5CQJgCYVXfYHXukOdq5
         3qXu91xtljl+S4op+etZe4F8BBS4PTt0yAe2q0N1C/05ngrBjzA+B3xZRnPqo2j4aTDu
         e2YA==
X-Gm-Message-State: APjAAAWShOyrJEqQkXFc9ufR1QkQMMrk86kC2DOoTRGgb23oUOY/BmVk
        xBbeIfVbpUzJQepdTWrShjmwCnFxIc+E
X-Google-Smtp-Source: APXvYqwVhzRGG2q8qg7PEz9pWpjQnDjfjNro/7O0bnlMq1jPSU8YBFDkAh7s5g2wDD1rDZwkBxNVLhv+np9x
X-Received: by 2002:a63:705e:: with SMTP id a30mr2067907pgn.182.1581666706043;
 Thu, 13 Feb 2020 23:51:46 -0800 (PST)
Date:   Thu, 13 Feb 2020 23:51:29 -0800
In-Reply-To: <20200214075133.181299-1-irogers@google.com>
Message-Id: <20200214075133.181299-3-irogers@google.com>
Mime-Version: 1.0
References: <20191206231539.227585-1-irogers@google.com> <20200214075133.181299-1-irogers@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v6 2/6] lib: introduce generic min-heap
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Supports push, pop and converting an array into a heap. If the sense of
the compare function is inverted then it can provide a max-heap.
Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/min_heap.h | 135 +++++++++++++++++++++++++++
 lib/Kconfig.debug        |  10 ++
 lib/Makefile             |   1 +
 lib/test_min_heap.c      | 194 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 include/linux/min_heap.h
 create mode 100644 lib/test_min_heap.c

diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
new file mode 100644
index 000000000000..0f04f49c0779
--- /dev/null
+++ b/include/linux/min_heap.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MIN_HEAP_H
+#define _LINUX_MIN_HEAP_H
+
+#include <linux/bug.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+/**
+ * struct min_heap - Data structure to hold a min-heap.
+ * @data: Start of array holding the heap elements.
+ * @size: Number of elements currently in the heap.
+ * @cap: Maximum number of elements that can be held in current storage.
+ */
+struct min_heap {
+	void *data;
+	int size;
+	int cap;
+};
+
+/**
+ * struct min_heap_callbacks - Data/functions to customise the min_heap.
+ * @elem_size: The size of each element in bytes.
+ * @cmp: Partial order function for this heap 'less'/'<' for min-heap,
+ *       'greater'/'>' for max-heap.
+ * @swp: Swap elements function.
+ */
+struct min_heap_callbacks {
+	int elem_size;
+	bool (*cmp)(const void *lhs, const void *rhs);
+	void (*swp)(void *lhs, void *rhs);
+};
+
+/* Sift the element at pos down the heap. */
+static __always_inline
+void min_heapify(struct min_heap *heap, int pos,
+		const struct min_heap_callbacks *func)
+{
+	void *left_child, *right_child, *parent, *large_or_smallest;
+	u8 *data = (u8 *)heap->data;
+
+	for (;;) {
+		if (pos * 2 + 1 >= heap->size)
+			break;
+
+		left_child = data + ((pos * 2 + 1) * func->elem_size);
+		parent = data + (pos * func->elem_size);
+		large_or_smallest = parent;
+		if (func->cmp(left_child, large_or_smallest))
+			large_or_smallest = left_child;
+
+		if (pos * 2 + 2 < heap->size) {
+			right_child = data + ((pos * 2 + 2) * func->elem_size);
+			if (func->cmp(right_child, large_or_smallest))
+				large_or_smallest = right_child;
+		}
+		if (large_or_smallest == parent)
+			break;
+		func->swp(large_or_smallest, parent);
+		if (large_or_smallest == left_child)
+			pos = (pos * 2) + 1;
+		else
+			pos = (pos * 2) + 2;
+	}
+}
+
+/* Floyd's approach to heapification that is O(size). */
+static __always_inline
+void min_heapify_all(struct min_heap *heap,
+		const struct min_heap_callbacks *func)
+{
+	int i;
+
+	for (i = heap->size / 2; i >= 0; i--)
+		min_heapify(heap, i, func);
+}
+
+/* Remove minimum element from the heap, O(log2(size)). */
+static __always_inline
+void min_heap_pop(struct min_heap *heap,
+		const struct min_heap_callbacks *func)
+{
+	u8 *data = (u8 *)heap->data;
+
+	if (WARN_ONCE(heap->size <= 0, "Popping an empty heap"))
+		return;
+
+	/* Place last element at the root (position 0) and then sift down. */
+	heap->size--;
+	memcpy(data, data + (heap->size * func->elem_size), func->elem_size);
+	min_heapify(heap, 0, func);
+}
+
+/*
+ * Remove the minimum element and then push the given element. The
+ * implementation performs 1 sift (O(log2(size))) and is therefore more
+ * efficient than a pop followed by a push that does 2.
+ */
+static __always_inline
+void min_heap_pop_push(struct min_heap *heap,
+		const void *element,
+		const struct min_heap_callbacks *func)
+{
+	memcpy(heap->data, element, func->elem_size);
+	min_heapify(heap, 0, func);
+}
+
+/* Push an element on to the heap, O(log2(size)). */
+static __always_inline
+void min_heap_push(struct min_heap *heap, const void *element,
+		const struct min_heap_callbacks *func)
+{
+	void *child, *parent;
+	int pos;
+	u8 *data = (u8 *)heap->data;
+
+	if (WARN_ONCE(heap->size >= heap->cap, "Pushing on a full heap"))
+		return;
+
+	/* Place at the end of data. */
+	pos = heap->size;
+	memcpy(data + (pos * func->elem_size), element, func->elem_size);
+	heap->size++;
+
+	/* Sift child at pos up. */
+	for (; pos > 0; pos = (pos - 1) / 2) {
+		child = data + (pos * func->elem_size);
+		parent = data + ((pos - 1) / 2) * func->elem_size;
+		if (func->cmp(parent, child))
+			break;
+		func->swp(parent, child);
+	}
+}
+
+#endif /* _LINUX_MIN_HEAP_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1458505192cd..e61e7fee9364 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1771,6 +1771,16 @@ config TEST_LIST_SORT
 
 	  If unsure, say N.
 
+config TEST_MIN_HEAP
+	tristate "Min heap test"
+	depends on DEBUG_KERNEL || m
+	help
+	  Enable this to turn on min heap function tests. This test is
+	  executed only once during system boot (so affects only boot time),
+	  or at module load time.
+
+	  If unsure, say N.
+
 config TEST_SORT
 	tristate "Array-based sort test"
 	depends on DEBUG_KERNEL || m
diff --git a/lib/Makefile b/lib/Makefile
index f19b85c87fda..171a6d7874a9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -70,6 +70,7 @@ CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
+obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
diff --git a/lib/test_min_heap.c b/lib/test_min_heap.c
new file mode 100644
index 000000000000..0f06d1f757b5
--- /dev/null
+++ b/lib/test_min_heap.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) "min_heap_test: " fmt
+
+/*
+ * Test cases for the min max heap.
+ */
+
+#include <linux/log2.h>
+#include <linux/min_heap.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+
+static __init bool less_than(const void *lhs, const void *rhs)
+{
+	return *(int *)lhs < *(int *)rhs;
+}
+
+static __init bool greater_than(const void *lhs, const void *rhs)
+{
+	return *(int *)lhs > *(int *)rhs;
+}
+
+static __init void swap_ints(void *lhs, void *rhs)
+{
+	int temp = *(int *)lhs;
+
+	*(int *)lhs = *(int *)rhs;
+	*(int *)rhs = temp;
+}
+
+static __init int pop_verify_heap(bool min_heap,
+				struct min_heap *heap,
+				const struct min_heap_callbacks *funcs)
+{
+	int last;
+	int *values = (int *)heap->data;
+	int err = 0;
+
+	last = values[0];
+	min_heap_pop(heap, funcs);
+	while (heap->size > 0) {
+		if (min_heap) {
+			if (last > values[0]) {
+				pr_err("error: expected %d <= %d\n", last,
+					values[0]);
+				err++;
+			}
+		} else {
+			if (last < values[0]) {
+				pr_err("error: expected %d >= %d\n", last,
+					values[0]);
+				err++;
+			}
+		}
+		last = values[0];
+		min_heap_pop(heap, funcs);
+	}
+	return err;
+}
+
+static __init int test_heapify_all(bool min_heap)
+{
+	int values[] = { 3, 1, 2, 4, 0x8000000, 0x7FFFFFF, 0,
+			 -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
+	struct min_heap heap = {
+		.data = values,
+		.size = ARRAY_SIZE(values),
+		.cap =  ARRAY_SIZE(values),
+	};
+	struct min_heap_callbacks funcs = {
+		.elem_size = sizeof(int),
+		.cmp = min_heap ? less_than : greater_than,
+		.swp = swap_ints,
+	};
+	int i, err;
+
+	/* Test with known set of values. */
+	min_heapify_all(&heap, &funcs);
+	err = pop_verify_heap(min_heap, &heap, &funcs);
+
+
+	/* Test with randomly generated values. */
+	heap.size = ARRAY_SIZE(values);
+	for (i = 0; i < heap.size; i++)
+		values[i] = get_random_int();
+
+	min_heapify_all(&heap, &funcs);
+	err += pop_verify_heap(min_heap, &heap, &funcs);
+
+	return err;
+}
+
+static __init int test_heap_push(bool min_heap)
+{
+	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
+			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
+	int values[ARRAY_SIZE(data)];
+	struct min_heap heap = {
+		.data = values,
+		.size = 0,
+		.cap =  ARRAY_SIZE(values),
+	};
+	struct min_heap_callbacks funcs = {
+		.elem_size = sizeof(int),
+		.cmp = min_heap ? less_than : greater_than,
+		.swp = swap_ints,
+	};
+	int i, temp, err;
+
+	/* Test with known set of values copied from data. */
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		min_heap_push(&heap, &data[i], &funcs);
+
+	err = pop_verify_heap(min_heap, &heap, &funcs);
+
+	/* Test with randomly generated values. */
+	while (heap.size < heap.cap) {
+		temp = get_random_int();
+		min_heap_push(&heap, &temp, &funcs);
+	}
+	err += pop_verify_heap(min_heap, &heap, &funcs);
+
+	return err;
+}
+
+static __init int test_heap_pop_push(bool min_heap)
+{
+	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
+			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
+	int values[ARRAY_SIZE(data)];
+	struct min_heap heap = {
+		.data = values,
+		.size = 0,
+		.cap =  ARRAY_SIZE(values),
+	};
+	struct min_heap_callbacks funcs = {
+		.elem_size = sizeof(int),
+		.cmp = min_heap ? less_than : greater_than,
+		.swp = swap_ints,
+	};
+	int i, temp, err;
+
+	/* Fill values with data to pop and replace. */
+	temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		min_heap_push(&heap, &temp, &funcs);
+
+	/* Test with known set of values copied from data. */
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		min_heap_pop_push(&heap, &data[i], &funcs);
+
+	err = pop_verify_heap(min_heap, &heap, &funcs);
+
+	heap.size = 0;
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		min_heap_push(&heap, &temp, &funcs);
+
+	/* Test with randomly generated values. */
+	for (i = 0; i < ARRAY_SIZE(data); i++) {
+		temp = get_random_int();
+		min_heap_pop_push(&heap, &temp, &funcs);
+	}
+	err += pop_verify_heap(min_heap, &heap, &funcs);
+
+	return err;
+}
+
+static int __init test_min_heap_init(void)
+{
+	int err = 0;
+
+	err += test_heapify_all(true);
+	err += test_heapify_all(false);
+	err += test_heap_push(true);
+	err += test_heap_push(false);
+	err += test_heap_pop_push(true);
+	err += test_heap_pop_push(false);
+	if (err) {
+		pr_err("test failed with %d errors\n", err);
+		return -EINVAL;
+	}
+	pr_info("test passed\n");
+	return 0;
+}
+module_init(test_min_heap_init);
+
+static void __exit test_min_heap_exit(void)
+{
+	/* do nothing */
+}
+module_exit(test_min_heap_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.25.0.265.gbab2e86ba0-goog

