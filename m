Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5028E53A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbfJYSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 14:14:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:41286 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388193AbfJYSO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 14:14:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 11:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="204622243"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Oct 2019 11:14:24 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D17F630054C; Fri, 25 Oct 2019 11:14:24 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, eranian@google.com, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 2/7] perf affinity: Add infrastructure to save/restore affinity
Date:   Fri, 25 Oct 2019 11:14:12 -0700
Message-Id: <20191025181417.10670-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025181417.10670-1-andi@firstfloor.org>
References: <20191025181417.10670-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The kernel perf subsystem has to IPI to the target CPU for many
operations. On systems with many CPUs and when managing many events the
overhead can be dominated by lots of IPIs.

An alternative is to set up CPU affinity in the perf tool, then set up
all the events for that CPU, and then move on to the next CPU.

Add some affinity management infrastructure to enable such a model.
Used in followon patches.

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use linux/bitmap.h functions.
---
 tools/perf/util/Build      |  1 +
 tools/perf/util/affinity.c | 72 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/affinity.h | 15 ++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 tools/perf/util/affinity.c
 create mode 100644 tools/perf/util/affinity.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 2c1504fe924c..c7d4eab017e5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -76,6 +76,7 @@ perf-y += sort.o
 perf-y += hist.o
 perf-y += util.o
 perf-y += cpumap.o
+perf-y += affinity.o
 perf-y += cputopo.o
 perf-y += cgroup.o
 perf-y += target.o
diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
new file mode 100644
index 000000000000..e197b0416f56
--- /dev/null
+++ b/tools/perf/util/affinity.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Manage affinity to optimize IPIs inside the kernel perf API. */
+#define _GNU_SOURCE 1
+#include <sched.h>
+#include <stdlib.h>
+#include <linux/bitmap.h>
+#include "perf.h"
+#include "cpumap.h"
+#include "affinity.h"
+
+static int get_cpu_set_size(void)
+{
+	int sz = cpu__max_cpu() + 8 - 1;
+	/*
+	 * sched_getaffinity doesn't like masks smaller than the kernel.
+	 * Hopefully that's big enough.
+	 */
+	if (sz < 4096)
+		sz = 4096;
+	return sz/8;
+}
+
+int affinity__setup(struct affinity *a)
+{
+	int cpu_set_size = get_cpu_set_size();
+
+	a->orig_cpus = bitmap_alloc(cpu_set_size*8);
+	if (!a->orig_cpus)
+		return -1;
+	sched_getaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
+	a->sched_cpus = bitmap_alloc(cpu_set_size*8);
+	if (!a->sched_cpus) {
+		free(a->orig_cpus);
+		return -1;
+	}
+	bitmap_zero((unsigned long *)a->sched_cpus, cpu_set_size);
+	a->changed = false;
+	return 0;
+}
+
+/*
+ * perf_event_open does an IPI internally to the target CPU.
+ * It is more efficient to change perf's affinity to the target
+ * CPU and then set up all events on that CPU, so we amortize
+ * CPU communication.
+ */
+void affinity__set(struct affinity *a, int cpu)
+{
+	int cpu_set_size = get_cpu_set_size();
+
+	if (cpu == -1)
+		return;
+	a->changed = true;
+	set_bit(cpu, a->sched_cpus);
+	/*
+	 * We ignore errors because affinity is just an optimization.
+	 * This could happen for example with isolated CPUs or cpusets.
+	 * In this case the IPIs inside the kernel's perf API still work.
+	 */
+	sched_setaffinity(0, cpu_set_size, (cpu_set_t *)a->sched_cpus);
+	clear_bit(cpu, a->sched_cpus);
+}
+
+void affinity__cleanup(struct affinity *a)
+{
+	int cpu_set_size = get_cpu_set_size();
+
+	if (a->changed)
+		sched_setaffinity(0, cpu_set_size, (cpu_set_t *)a->orig_cpus);
+	free(a->sched_cpus);
+	free(a->orig_cpus);
+}
diff --git a/tools/perf/util/affinity.h b/tools/perf/util/affinity.h
new file mode 100644
index 000000000000..008e2c3995b9
--- /dev/null
+++ b/tools/perf/util/affinity.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef AFFINITY_H
+#define AFFINITY_H 1
+
+struct affinity {
+	unsigned long *orig_cpus;
+	unsigned long *sched_cpus;
+	bool changed;
+};
+
+void affinity__cleanup(struct affinity *a);
+void affinity__set(struct affinity *a, int cpu);
+int affinity__setup(struct affinity *a);
+
+#endif
-- 
2.21.0

