Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A0D104763
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2019 01:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfKUAPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Nov 2019 19:15:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:58450 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKUAPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:15:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 16:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="381553873"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2019 16:15:34 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 80ACB3002B7; Wed, 20 Nov 2019 16:15:34 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 01/12] perf pmu: Use file system cache to optimize sysfs access
Date:   Wed, 20 Nov 2019 16:15:11 -0800
Message-Id: <20191121001522.180827-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121001522.180827-1-andi@firstfloor.org>
References: <20191121001522.180827-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

pmu.c does a lot of redundant /sys accesses while parsing aliases
and probing for PMUs. On large systems with a lot of PMUs this
can get expensive (>2s):

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 27.25    1.227847           8    160888     16976 openat
 26.42    1.190481           7    164224    164077 stat

Add a cache to remember if specific file names exist or don't
exist, which eliminates most of this overhead.

Also optimize some stat() calls to be slightly cheaper access()

Resulting in:

  0.18    0.004166           2      1851       305 open
  0.08    0.001970           2       829       622 access

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use single lookup function as API (Jiri)
---
 tools/perf/util/Build     |  1 +
 tools/perf/util/fncache.c | 63 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/fncache.h |  7 +++++
 tools/perf/util/pmu.c     | 34 +++++++--------------
 tools/perf/util/srccode.c |  9 +-----
 5 files changed, 83 insertions(+), 31 deletions(-)
 create mode 100644 tools/perf/util/fncache.c
 create mode 100644 tools/perf/util/fncache.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b8e05a147b2b..aab05e2c01a5 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -49,6 +49,7 @@ perf-y += header.o
 perf-y += callchain.o
 perf-y += values.o
 perf-y += debug.o
+perf-y += fncache.o
 perf-y += machine.o
 perf-y += map.o
 perf-y += pstack.o
diff --git a/tools/perf/util/fncache.c b/tools/perf/util/fncache.c
new file mode 100644
index 000000000000..5afcd7edbe7a
--- /dev/null
+++ b/tools/perf/util/fncache.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Manage a cache of file names' existence */
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <linux/list.h>
+#include "fncache.h"
+
+struct fncache {
+	struct hlist_node nd;
+	bool res;
+	char name[];
+};
+
+#define FNHSIZE 61
+
+static struct hlist_head fncache_hash[FNHSIZE];
+
+unsigned shash(const unsigned char *s)
+{
+	unsigned h = 0;
+	while (*s)
+		h = 65599 * h + *s++;
+	return h ^ (h >> 16);
+}
+
+static bool lookup_fncache(const char *name, bool *res)
+{
+	int h = shash((const unsigned char *)name) % FNHSIZE;
+	struct fncache *n;
+
+	hlist_for_each_entry (n, &fncache_hash[h], nd) {
+		if (!strcmp(n->name, name)) {
+			*res = n->res;
+			return true;
+		}
+	}
+	return false;
+}
+
+static void update_fncache(const char *name, bool res)
+{
+	struct fncache *n = malloc(sizeof(struct fncache) + strlen(name) + 1);
+	int h = shash((const unsigned char *)name) % FNHSIZE;
+
+	if (!n)
+		return;
+	strcpy(n->name, name);
+	n->res = res;
+	hlist_add_head(&n->nd, &fncache_hash[h]);
+}
+
+/* No LRU, only use when bounded in some other way. */
+bool file_available(const char *name)
+{
+	bool res;
+
+	if (lookup_fncache(name, &res))
+		return res;
+	res = access(name, R_OK) == 0;
+	update_fncache(name, res);
+	return res;
+}
diff --git a/tools/perf/util/fncache.h b/tools/perf/util/fncache.h
new file mode 100644
index 000000000000..fe020beaefb1
--- /dev/null
+++ b/tools/perf/util/fncache.h
@@ -0,0 +1,7 @@
+#ifndef _FCACHE_H
+#define _FCACHE_H 1
+
+unsigned shash(const unsigned char *s);
+bool file_available(const char *name);
+
+#endif
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index db1e57113f4b..65780494a290 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -24,6 +24,7 @@
 #include "pmu-events/pmu-events.h"
 #include "string2.h"
 #include "strbuf.h"
+#include "fncache.h"
 
 struct perf_pmu_format {
 	char *name;
@@ -82,7 +83,6 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
  */
 static int pmu_format(const char *name, struct list_head *format)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
 
@@ -92,8 +92,8 @@ static int pmu_format(const char *name, struct list_head *format)
 	snprintf(path, PATH_MAX,
 		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/format", sysfs, name);
 
-	if (stat(path, &st) < 0)
-		return 0;	/* no error if format does not exist */
+	if (!file_available(path))
+		return 0;
 
 	if (perf_pmu__format_parse(path, format))
 		return -1;
@@ -475,7 +475,6 @@ static int pmu_aliases_parse(char *dir, struct list_head *head)
  */
 static int pmu_aliases(const char *name, struct list_head *head)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
 
@@ -485,8 +484,8 @@ static int pmu_aliases(const char *name, struct list_head *head)
 	snprintf(path, PATH_MAX,
 		 "%s/bus/event_source/devices/%s/events", sysfs, name);
 
-	if (stat(path, &st) < 0)
-		return 0;	 /* no error if 'events' does not exist */
+	if (!file_available(path))
+		return 0;
 
 	if (pmu_aliases_parse(path, head))
 		return -1;
@@ -525,7 +524,6 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
  */
 static int pmu_type(const char *name, __u32 *type)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	FILE *file;
 	int ret = 0;
@@ -537,7 +535,7 @@ static int pmu_type(const char *name, __u32 *type)
 	snprintf(path, PATH_MAX,
 		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/type", sysfs, name);
 
-	if (stat(path, &st) < 0)
+	if (access(path, R_OK) < 0)
 		return -1;
 
 	file = fopen(path, "r");
@@ -628,14 +626,11 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
 static bool pmu_is_uncore(const char *name)
 {
 	char path[PATH_MAX];
-	struct perf_cpu_map *cpus;
-	const char *sysfs = sysfs__mountpoint();
+	const char *sysfs;
 
+	sysfs = sysfs__mountpoint();
 	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
-	cpus = __pmu_cpumask(path);
-	perf_cpu_map__put(cpus);
-
-	return !!cpus;
+	return file_available(path);
 }
 
 /*
@@ -645,7 +640,6 @@ static bool pmu_is_uncore(const char *name)
  */
 static int is_arm_pmu_core(const char *name)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
 
@@ -655,10 +649,7 @@ static int is_arm_pmu_core(const char *name)
 	/* Look for cpu sysfs (specific to arm) */
 	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
 				sysfs, name);
-	if (stat(path, &st) == 0)
-		return 1;
-
-	return 0;
+	return file_available(path);
 }
 
 static char *perf_pmu__getcpuid(struct perf_pmu *pmu)
@@ -1534,7 +1525,6 @@ bool pmu_have_event(const char *pname, const char *name)
 
 static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 {
-	struct stat st;
 	char path[PATH_MAX];
 	const char *sysfs;
 
@@ -1544,10 +1534,8 @@ static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
 
 	snprintf(path, PATH_MAX,
 		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/%s", sysfs, pmu->name, name);
-
-	if (stat(path, &st) < 0)
+	if (!file_available(path))
 		return NULL;
-
 	return fopen(path, "r");
 }
 
diff --git a/tools/perf/util/srccode.c b/tools/perf/util/srccode.c
index d84ed8b6caaa..c29edaaca863 100644
--- a/tools/perf/util/srccode.c
+++ b/tools/perf/util/srccode.c
@@ -16,6 +16,7 @@
 #include "srccode.h"
 #include "debug.h"
 #include <internal/lib.h> // page_size
+#include "fncache.h"
 
 #define MAXSRCCACHE (32*1024*1024)
 #define MAXSRCFILES     64
@@ -36,14 +37,6 @@ static LIST_HEAD(srcfile_list);
 static long map_total_sz;
 static int num_srcfiles;
 
-static unsigned shash(unsigned char *s)
-{
-	unsigned h = 0;
-	while (*s)
-		h = 65599 * h + *s++;
-	return h ^ (h >> 16);
-}
-
 static int countlines(char *map, int maplen)
 {
 	int numl;
-- 
2.23.0

