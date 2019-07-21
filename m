Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6076F2E3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2019 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfGUL3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jul 2019 07:29:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfGUL3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:29:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE212308AA11;
        Sun, 21 Jul 2019 11:29:13 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30D885D9D3;
        Sun, 21 Jul 2019 11:29:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 34/79] libperf: Add perf_evlist and perf_evsel structs
Date:   Sun, 21 Jul 2019 13:24:21 +0200
Message-Id: <20190721112506.12306-35-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Sun, 21 Jul 2019 11:29:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding perf_evlist and perf_evsel structs into libperf.

It's added as a declarations into into:
  include/perf/evlist.h
  include/perf/evsel.h

which will be included by users.

The definitions are added into:
  include/internal/evlist.h
  include/internal/evsel.h

which is not to be included by users, but shared
within perf and libperf.

Link: http://lkml.kernel.org/n/tip-2f3px8ns5vq5075l0sv3dc02@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/Build                     | 2 ++
 tools/perf/lib/evlist.c                  | 4 ++++
 tools/perf/lib/evsel.c                   | 4 ++++
 tools/perf/lib/include/internal/evlist.h | 9 +++++++++
 tools/perf/lib/include/internal/evsel.h  | 9 +++++++++
 tools/perf/lib/include/perf/evlist.h     | 7 +++++++
 tools/perf/lib/include/perf/evsel.h      | 7 +++++++
 7 files changed, 42 insertions(+)
 create mode 100644 tools/perf/lib/evlist.c
 create mode 100644 tools/perf/lib/evsel.c
 create mode 100644 tools/perf/lib/include/internal/evlist.h
 create mode 100644 tools/perf/lib/include/internal/evsel.h
 create mode 100644 tools/perf/lib/include/perf/evlist.h
 create mode 100644 tools/perf/lib/include/perf/evsel.h

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index 9beadfc81a71..b27c1543b046 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -1,3 +1,5 @@
 libperf-y += core.o
 libperf-y += cpumap.o
 libperf-y += threadmap.o
+libperf-y += evsel.o
+libperf-y += evlist.o
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
new file mode 100644
index 000000000000..646bdd518793
--- /dev/null
+++ b/tools/perf/lib/evlist.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/evlist.h>
+#include <linux/list.h>
+#include <internal/evlist.h>
diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
new file mode 100644
index 000000000000..12e86de1994b
--- /dev/null
+++ b/tools/perf/lib/evsel.c
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <perf/evsel.h>
+#include <linux/list.h>
+#include <internal/evsel.h>
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
new file mode 100644
index 000000000000..7fbfe5716652
--- /dev/null
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_EVLIST_H
+#define __LIBPERF_INTERNAL_EVLIST_H
+
+struct perf_evlist {
+	struct list_head	entries;
+};
+
+#endif /* __LIBPERF_INTERNAL_EVLIST_H */
diff --git a/tools/perf/lib/include/internal/evsel.h b/tools/perf/lib/include/internal/evsel.h
new file mode 100644
index 000000000000..690943d0408a
--- /dev/null
+++ b/tools/perf/lib/include/internal/evsel.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_INTERNAL_EVSEL_H
+#define __LIBPERF_INTERNAL_EVSEL_H
+
+struct perf_evsel {
+	struct list_head	node;
+};
+
+#endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
new file mode 100644
index 000000000000..92b0eb39caec
--- /dev/null
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_EVLIST_H
+#define __LIBPERF_EVLIST_H
+
+struct perf_evlist;
+
+#endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/include/perf/evsel.h b/tools/perf/lib/include/perf/evsel.h
new file mode 100644
index 000000000000..162bffd43409
--- /dev/null
+++ b/tools/perf/lib/include/perf/evsel.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_EVSEL_H
+#define __LIBPERF_EVSEL_H
+
+struct perf_evsel;
+
+#endif /* __LIBPERF_EVSEL_H */
-- 
2.21.0

