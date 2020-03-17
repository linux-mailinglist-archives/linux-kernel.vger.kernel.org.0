Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75E931890D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Mar 2020 22:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCQVz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Mar 2020 17:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgCQVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:55:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 589342076D;
        Tue, 17 Mar 2020 21:55:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jEKB7-000Evr-86; Tue, 17 Mar 2020 17:55:13 -0400
Message-Id: <20200317215513.130223852@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 17 Mar 2020 17:55:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yiwei Zhang <zzyiwei@google.com>
Subject: [for-next][PATCH 5/5] gpu/trace: add a gpu total memory usage tracepoint
References: <20200317215455.885042360@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yiwei Zhang <zzyiwei@google.com>

This change adds the below gpu memory tracepoint:
gpu_mem/gpu_mem_total: track global or proc gpu memory total usages

Per process tracking of total gpu memory usage in the gem layer is not
appropriate and hard to implement with trivial overhead. So for the gfx
device driver layer to track total gpu memory usage both globally and
per process in an easy and uniform way is to integrate the tracepoint in
this patch to the underlying varied implementations of gpu memory
tracking system from vendors.

Putting this tracepoint in the common trace events can not only help
wean the gfx drivers off of debugfs but also greatly help the downstream
Android gpu vendors because debugfs is to be deprecated in the upcoming
Android release. Then the gpu memory tracking of both Android kernel and
the upstream linux kernel can stay closely, which can benefit the whole
kernel eco-system in the long term.

Link: http://lkml.kernel.org/r/20200302235044.59163-1-zzyiwei@google.com

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Yiwei Zhang <zzyiwei@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/Kconfig                   |  2 ++
 drivers/gpu/Makefile              |  1 +
 drivers/gpu/trace/Kconfig         |  4 +++
 drivers/gpu/trace/Makefile        |  3 ++
 drivers/gpu/trace/trace_gpu_mem.c | 13 +++++++
 include/trace/events/gpu_mem.h    | 57 +++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)
 create mode 100644 drivers/gpu/trace/Kconfig
 create mode 100644 drivers/gpu/trace/Makefile
 create mode 100644 drivers/gpu/trace/trace_gpu_mem.c
 create mode 100644 include/trace/events/gpu_mem.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 8befa53f43be..e0eda1a5c3f9 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -200,6 +200,8 @@ source "drivers/thunderbolt/Kconfig"
 
 source "drivers/android/Kconfig"
 
+source "drivers/gpu/trace/Kconfig"
+
 source "drivers/nvdimm/Kconfig"
 
 source "drivers/dax/Kconfig"
diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index f17d01f076c7..835c88318cec 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
 obj-y			+= drm/ vga/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
+obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
diff --git a/drivers/gpu/trace/Kconfig b/drivers/gpu/trace/Kconfig
new file mode 100644
index 000000000000..c24e9edd022e
--- /dev/null
+++ b/drivers/gpu/trace/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config TRACE_GPU_MEM
+	bool
diff --git a/drivers/gpu/trace/Makefile b/drivers/gpu/trace/Makefile
new file mode 100644
index 000000000000..b70fbdc5847f
--- /dev/null
+++ b/drivers/gpu/trace/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_TRACE_GPU_MEM) += trace_gpu_mem.o
diff --git a/drivers/gpu/trace/trace_gpu_mem.c b/drivers/gpu/trace/trace_gpu_mem.c
new file mode 100644
index 000000000000..01e855897b6d
--- /dev/null
+++ b/drivers/gpu/trace/trace_gpu_mem.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPU memory trace points
+ *
+ * Copyright (C) 2020 Google, Inc.
+ */
+
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/gpu_mem.h>
+
+EXPORT_TRACEPOINT_SYMBOL(gpu_mem_total);
diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
new file mode 100644
index 000000000000..1897822a9150
--- /dev/null
+++ b/include/trace/events/gpu_mem.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * GPU memory trace points
+ *
+ * Copyright (C) 2020 Google, Inc.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM gpu_mem
+
+#if !defined(_TRACE_GPU_MEM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_GPU_MEM_H
+
+#include <linux/tracepoint.h>
+
+/*
+ * The gpu_memory_total event indicates that there's an update to either the
+ * global or process total gpu memory counters.
+ *
+ * This event should be emitted whenever the kernel device driver allocates,
+ * frees, imports, unimports memory in the GPU addressable space.
+ *
+ * @gpu_id: This is the gpu id.
+ *
+ * @pid: Put 0 for global total, while positive pid for process total.
+ *
+ * @size: Virtual size of the allocation in bytes.
+ *
+ */
+TRACE_EVENT(gpu_mem_total,
+
+	TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
+
+	TP_ARGS(gpu_id, pid, size),
+
+	TP_STRUCT__entry(
+		__field(uint32_t, gpu_id)
+		__field(uint32_t, pid)
+		__field(uint64_t, size)
+	),
+
+	TP_fast_assign(
+		__entry->gpu_id = gpu_id;
+		__entry->pid = pid;
+		__entry->size = size;
+	),
+
+	TP_printk("gpu_id=%u pid=%u size=%llu",
+		__entry->gpu_id,
+		__entry->pid,
+		__entry->size)
+);
+
+#endif /* _TRACE_GPU_MEM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.25.1


