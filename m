Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A933EB868
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 21:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfJaUao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 16:30:44 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44404 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfJaUan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 16:30:43 -0400
Received: by linux.microsoft.com (Postfix, from userid 1040)
        id D4EE720B7192; Thu, 31 Oct 2019 13:30:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4EE720B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572553841;
        bh=QC5IgGNX+K4lVNk5r7CO7rrQsO2IiDjy89D6wZ29yao=;
        h=From:To:Cc:Subject:Date:From;
        b=mABEo0zYKzYzi4Eq8fYMg1nmLPNjv8cm6B8HL8F5JSjSSKQBh8O6TeOtjiRap2lTp
         WG+6t2Xu44TZ/prmYeQNicUvEOoVt1WLFWZoCYzN0lBqC1nMCDRib4hyU5dU6MIVQp
         7TOZJKntn6qA1qVjJj9UdRRo36aQjQ/jYwUWd6mk=
From:   Steve MacLean <steve.maclean@linux.microsoft.com>
Cc:     Steve MacLean <Steve.MacLean@Microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] perf inject --jit: Remove //anon mmap events
Date:   Thu, 31 Oct 2019 13:30:36 -0700
Message-Id: <1572553836-32361-1-git-send-email-steve.maclean@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve MacLean <Steve.MacLean@Microsoft.com>

While a JIT is jitting code it will eventually need to commit more pages and
change these pages to executable permissions.

Typically the JIT will want these colocated to minimize branch displacements.

The kernel will coalesce these anonymous mapping with identical permissions
before sending an MMAP event for the new pages. This means the mmap event for
the new pages will include the older pages.

These anonymous mmap events will obscure the jitdump injected pseudo events.
This means that the jitdump generated symbols, machine code, debugging info,
and unwind info will no longer be used.

Observations:

When a process emits a jit dump marker and a jitdump file, the perf-xxx.map
file represents inferior information which has been superceded by the
jitdump jit-xxx.dump file.

Further the '//anon*' mmap events are only required for the legacy
perf-xxx.map mapping.

When attaching to an existing process, the synthetic anon map events are
given a time stamp of -1. These should not obscure the jitdump events which
have an actual time.

Summary:

Use thread->priv to store whether a jitdump file has been processed

During "perf inject --jit", discard "//anon*" mmap events for any pid which
has sucessfully processed a jitdump file.

Committer testing:

// jitdump case
perf record <app with jitdump>
perf inject --jit --input perf.data --output perfjit.data

// verify mmap "//anon" events present initially
perf script --input perf.data --show-mmap-events | grep '//anon'
// verify mmap "//anon" events removed
perf script --input perfjit.data --show-mmap-events | grep '//anon'

// no jitdump case
perf record <app without jitdump>
perf inject --jit --input perf.data --output perfjit.data

// verify mmap "//anon" events present initially
perf script --input perf.data --show-mmap-events | grep '//anon'
// verify mmap "//anon" events not removed
perf script --input perfjit.data --show-mmap-events | grep '//anon'

Repro:

This issue was discovered while testing the initial CoreCLR jitdump
implementation. https://github.com/dotnet/coreclr/pull/26897.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
---
 tools/perf/builtin-inject.c |  4 ++--
 tools/perf/util/jitdump.c   | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3..0f38862 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -263,7 +263,7 @@ static int perf_event__jit_repipe_mmap(struct perf_tool *tool,
 	 * if jit marker, then inject jit mmaps and generate ELF images
 	 */
 	ret = jit_process(inject->session, &inject->output, machine,
-			  event->mmap.filename, sample->pid, &n);
+			  event->mmap.filename, event->mmap.pid, &n);
 	if (ret < 0)
 		return ret;
 	if (ret) {
@@ -301,7 +301,7 @@ static int perf_event__jit_repipe_mmap2(struct perf_tool *tool,
 	 * if jit marker, then inject jit mmaps and generate ELF images
 	 */
 	ret = jit_process(inject->session, &inject->output, machine,
-			  event->mmap2.filename, sample->pid, &n);
+			  event->mmap2.filename, event->mmap2.pid, &n);
 	if (ret < 0)
 		return ret;
 	if (ret) {
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index e3ccb0c..d18596e 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -26,6 +26,7 @@
 #include "jit.h"
 #include "jitdump.h"
 #include "genelf.h"
+#include "thread.h"
 
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
@@ -749,6 +750,28 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	return 0;
 }
 
+static void jit_add_pid(struct machine *machine, pid_t pid)
+{
+	struct thread *thread = machine__findnew_thread(machine, pid, pid);
+
+	if (!thread) {
+		pr_err("%s: thread %d not found or created\n", __func__, pid);
+		return;
+	}
+
+	thread->priv = (void *)1;
+}
+
+static bool jit_has_pid(struct machine *machine, pid_t pid)
+{
+	struct thread *thread = machine__find_thread(machine, pid, pid);
+
+	if (!thread)
+		return 0;
+
+	return (bool)thread->priv;
+}
+
 int
 jit_process(struct perf_session *session,
 	    struct perf_data *output,
@@ -764,8 +787,13 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	/*
 	 * first, detect marker mmap (i.e., the jitdump mmap)
 	 */
-	if (jit_detect(filename, pid))
+	if (jit_detect(filename, pid)) {
+		// Strip //anon* mmaps if we processed a jitdump for this pid
+		if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
+			return 1;
+
 		return 0;
+	}
 
 	memset(&jd, 0, sizeof(jd));
 
@@ -784,6 +812,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc *jd, union jr_entry *jr)
 
 	ret = jit_inject(&jd, filename);
 	if (!ret) {
+		jit_add_pid(machine, pid);
 		*nbytes = jd.bytes_written;
 		ret = 1;
 	}
-- 
1.8.3.1

