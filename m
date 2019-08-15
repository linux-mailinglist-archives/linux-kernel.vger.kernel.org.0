Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5F78E8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 12:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbfHOKCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 06:02:08 -0400
Received: from dougal.metanate.com ([90.155.101.14]:21187 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730737AbfHOKCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8blkr2TAgrrLU5ErStb9NjbvRn/ljxlIFTVyJhRAASQ=; b=DQXe0WChux6D4O6/u8qn8B8Wjl
        omIoE+Q2QqbHoJB3p9/BQiElfAvjPrT4dBMgE3WQJYH017SHngYJ2Q3as1cSTpNuJZJemcQsGCKee
        Ne+EHE0k2tFpljH+IrrHkYP/uuBp7wa38mfbmadbZTk+gNRfx6ZedRroyjuPMulDVFeKWjKtTe03e
        twdjHTQnoJkGywFj1xoD/r8uSNThH5AYDlwZhC/XCyd+DeS+BRgkN91uJU2dxbLRvJucaIPLoQoCa
        hZB2Jf2lkqKmXGCQY2dz+HUjJ5Cwi/XI4tvv2RDcyJseGM5N3AVa3E8S3agfDhmS9An9AaIzGgRiz
        tkok2q2g==;
Received: from 188-39-28-98.static.enta.net ([188.39.28.98] helo=donbot.corp.numark.com)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1hyCZv-0001ER-BC; Thu, 15 Aug 2019 11:01:55 +0100
From:   John Keeping <john@metanate.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH v2 2/3] perf unwind: fix libunwind when tid != pid
Date:   Thu, 15 Aug 2019 11:01:45 +0100
Message-Id: <20190815100146.28842-2-john@metanate.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190815100146.28842-1-john@metanate.com>
References: <20190804124434.204da4ac.john@metanate.com>
 <20190815100146.28842-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e5adfc3e7e77 ("perf map: Synthesize maps only for thread group
leader") changed the recording side so that we no longer get mmap events
for threads other than the thread group leader (when synthesising these
events for threads which exist before perf is started).

When a file recorded after this change is loaded, the lack of mmap
records mean that unwinding is not set up for any other threads.

This can be seen in a simple record/report scenario:

	perf record --call-graph=dwarf -t $TID
	perf report

If $TID is a process ID then the report will show call graphs, but if
$TID is a secondary thread the output is as if --call-graph=none was
specified.

Following the rationale in that commit, move the libunwind fields into
struct map_groups and update the libunwind functions to take this
instead of the struct thread.  This is only required for
unwind__finish_access which must now be called from map_groups__delete
and the others are changed for symmetry.

Note that unwind__get_entries keeps the thread argument since it is
required for symbol lookup and the libdw unwind provider uses the thread
ID.

Fixes: e5adfc3e7e77 ("perf map: Synthesize maps only for thread group leader")
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: John Keeping <john@metanate.com>
---
v2:
- Remove unrelated change that has moved to the next patch
- Improve commit message to describe a scenario that shows the bug
---
 tools/perf/util/map.c                    |  3 ++-
 tools/perf/util/map_groups.h             |  4 +++
 tools/perf/util/thread.c                 |  7 +++--
 tools/perf/util/thread.h                 |  4 ---
 tools/perf/util/unwind-libunwind-local.c | 18 ++++++-------
 tools/perf/util/unwind-libunwind.c       | 34 ++++++++++++------------
 tools/perf/util/unwind.h                 | 25 ++++++++---------
 7 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 44b556812e4b..27b7b102e4a2 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -647,6 +647,7 @@ struct map_groups *map_groups__new(struct machine *machine)
 void map_groups__delete(struct map_groups *mg)
 {
 	map_groups__exit(mg);
+	unwind__finish_access(mg);
 	free(mg);
 }
 
@@ -887,7 +888,7 @@ int map_groups__clone(struct thread *thread, struct map_groups *parent)
 		if (new == NULL)
 			goto out_unlock;
 
-		err = unwind__prepare_access(thread, new, NULL);
+		err = unwind__prepare_access(mg, new, NULL);
 		if (err)
 			goto out_unlock;
 
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 5f25efa6d6bc..77252e14008f 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -31,6 +31,10 @@ struct map_groups {
 	struct maps	 maps;
 	struct machine	 *machine;
 	refcount_t	 refcnt;
+#ifdef HAVE_LIBUNWIND_SUPPORT
+	void				*addr_space;
+	struct unwind_libunwind_ops	*unwind_libunwind_ops;
+#endif
 };
 
 #define KMAP_NAME_LEN 256
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 590793cc5142..bbf7816cba31 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -105,7 +105,6 @@ void thread__delete(struct thread *thread)
 	}
 	up_write(&thread->comm_lock);
 
-	unwind__finish_access(thread);
 	nsinfo__zput(thread->nsinfo);
 	srccode_state_free(&thread->srccode_state);
 
@@ -252,7 +251,7 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
 		list_add(&new->list, &thread->comm_list);
 
 		if (exec)
-			unwind__flush_access(thread);
+			unwind__flush_access(thread->mg);
 	}
 
 	thread->comm_set = true;
@@ -332,7 +331,7 @@ int thread__insert_map(struct thread *thread, struct map *map)
 {
 	int ret;
 
-	ret = unwind__prepare_access(thread, map, NULL);
+	ret = unwind__prepare_access(thread->mg, map, NULL);
 	if (ret)
 		return ret;
 
@@ -352,7 +351,7 @@ static int __thread__prepare_access(struct thread *thread)
 	down_read(&maps->lock);
 
 	for (map = maps__first(maps); map; map = map__next(map)) {
-		err = unwind__prepare_access(thread, map, &initialized);
+		err = unwind__prepare_access(thread->mg, map, &initialized);
 		if (err || initialized)
 			break;
 	}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index e97ef6977eb9..bf06113be4f3 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -44,10 +44,6 @@ struct thread {
 	struct thread_stack	*ts;
 	struct nsinfo		*nsinfo;
 	struct srccode_state	srccode_state;
-#ifdef HAVE_LIBUNWIND_SUPPORT
-	void				*addr_space;
-	struct unwind_libunwind_ops	*unwind_libunwind_ops;
-#endif
 	bool			filter;
 	int			filter_entry_depth;
 };
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 71a788921b62..ebdbb056510c 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -616,26 +616,26 @@ static unw_accessors_t accessors = {
 	.get_proc_name		= get_proc_name,
 };
 
-static int _unwind__prepare_access(struct thread *thread)
+static int _unwind__prepare_access(struct map_groups *mg)
 {
-	thread->addr_space = unw_create_addr_space(&accessors, 0);
-	if (!thread->addr_space) {
+	mg->addr_space = unw_create_addr_space(&accessors, 0);
+	if (!mg->addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
 		return -ENOMEM;
 	}
 
-	unw_set_caching_policy(thread->addr_space, UNW_CACHE_GLOBAL);
+	unw_set_caching_policy(mg->addr_space, UNW_CACHE_GLOBAL);
 	return 0;
 }
 
-static void _unwind__flush_access(struct thread *thread)
+static void _unwind__flush_access(struct map_groups *mg)
 {
-	unw_flush_cache(thread->addr_space, 0, 0);
+	unw_flush_cache(mg->addr_space, 0, 0);
 }
 
-static void _unwind__finish_access(struct thread *thread)
+static void _unwind__finish_access(struct map_groups *mg)
 {
-	unw_destroy_addr_space(thread->addr_space);
+	unw_destroy_addr_space(mg->addr_space);
 }
 
 static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
@@ -660,7 +660,7 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	 */
 	if (max_stack - 1 > 0) {
 		WARN_ONCE(!ui->thread, "WARNING: ui->thread is NULL");
-		addr_space = ui->thread->addr_space;
+		addr_space = ui->thread->mg->addr_space;
 
 		if (addr_space == NULL)
 			return -1;
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index c0811977d7d5..b843f9d0a9ea 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -11,13 +11,13 @@ struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *arm64_unwind_libunwind_ops;
 
-static void unwind__register_ops(struct thread *thread,
+static void unwind__register_ops(struct map_groups *mg,
 			  struct unwind_libunwind_ops *ops)
 {
-	thread->unwind_libunwind_ops = ops;
+	mg->unwind_libunwind_ops = ops;
 }
 
-int unwind__prepare_access(struct thread *thread, struct map *map,
+int unwind__prepare_access(struct map_groups *mg, struct map *map,
 			   bool *initialized)
 {
 	const char *arch;
@@ -28,7 +28,7 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
 	if (!dwarf_callchain_users)
 		return 0;
 
-	if (thread->addr_space) {
+	if (mg->addr_space) {
 		pr_debug("unwind: thread map already set, dso=%s\n",
 			 map->dso->name);
 		if (initialized)
@@ -37,14 +37,14 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
 	}
 
 	/* env->arch is NULL for live-mode (i.e. perf top) */
-	if (!thread->mg->machine->env || !thread->mg->machine->env->arch)
+	if (!mg->machine->env || !mg->machine->env->arch)
 		goto out_register;
 
-	dso_type = dso__type(map->dso, thread->mg->machine);
+	dso_type = dso__type(map->dso, mg->machine);
 	if (dso_type == DSO__TYPE_UNKNOWN)
 		return 0;
 
-	arch = perf_env__arch(thread->mg->machine->env);
+	arch = perf_env__arch(mg->machine->env);
 
 	if (!strcmp(arch, "x86")) {
 		if (dso_type != DSO__TYPE_64BIT)
@@ -59,37 +59,37 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
 		return 0;
 	}
 out_register:
-	unwind__register_ops(thread, ops);
+	unwind__register_ops(mg, ops);
 
-	err = thread->unwind_libunwind_ops->prepare_access(thread);
+	err = mg->unwind_libunwind_ops->prepare_access(mg);
 	if (initialized)
 		*initialized = err ? false : true;
 	return err;
 }
 
-void unwind__flush_access(struct thread *thread)
+void unwind__flush_access(struct map_groups *mg)
 {
 	if (!dwarf_callchain_users)
 		return;
 
-	if (thread->unwind_libunwind_ops)
-		thread->unwind_libunwind_ops->flush_access(thread);
+	if (mg->unwind_libunwind_ops)
+		mg->unwind_libunwind_ops->flush_access(mg);
 }
 
-void unwind__finish_access(struct thread *thread)
+void unwind__finish_access(struct map_groups *mg)
 {
 	if (!dwarf_callchain_users)
 		return;
 
-	if (thread->unwind_libunwind_ops)
-		thread->unwind_libunwind_ops->finish_access(thread);
+	if (mg->unwind_libunwind_ops)
+		mg->unwind_libunwind_ops->finish_access(mg);
 }
 
 int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 			 struct thread *thread,
 			 struct perf_sample *data, int max_stack)
 {
-	if (thread->unwind_libunwind_ops)
-		return thread->unwind_libunwind_ops->get_entries(cb, arg, thread, data, max_stack);
+	if (thread->mg->unwind_libunwind_ops)
+		return thread->mg->unwind_libunwind_ops->get_entries(cb, arg, thread, data, max_stack);
 	return 0;
 }
diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index 8a44a1569a21..3a7d00c20d86 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct map;
+struct map_groups;
 struct perf_sample;
 struct symbol;
 struct thread;
@@ -19,9 +20,9 @@ struct unwind_entry {
 typedef int (*unwind_entry_cb_t)(struct unwind_entry *entry, void *arg);
 
 struct unwind_libunwind_ops {
-	int (*prepare_access)(struct thread *thread);
-	void (*flush_access)(struct thread *thread);
-	void (*finish_access)(struct thread *thread);
+	int (*prepare_access)(struct map_groups *mg);
+	void (*flush_access)(struct map_groups *mg);
+	void (*finish_access)(struct map_groups *mg);
 	int (*get_entries)(unwind_entry_cb_t cb, void *arg,
 			   struct thread *thread,
 			   struct perf_sample *data, int max_stack);
@@ -46,20 +47,20 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 #endif
 
 int LIBUNWIND__ARCH_REG_ID(int regnum);
-int unwind__prepare_access(struct thread *thread, struct map *map,
+int unwind__prepare_access(struct map_groups *mg, struct map *map,
 			   bool *initialized);
-void unwind__flush_access(struct thread *thread);
-void unwind__finish_access(struct thread *thread);
+void unwind__flush_access(struct map_groups *mg);
+void unwind__finish_access(struct map_groups *mg);
 #else
-static inline int unwind__prepare_access(struct thread *thread __maybe_unused,
+static inline int unwind__prepare_access(struct map_groups *mg __maybe_unused,
 					 struct map *map __maybe_unused,
 					 bool *initialized __maybe_unused)
 {
 	return 0;
 }
 
-static inline void unwind__flush_access(struct thread *thread __maybe_unused) {}
-static inline void unwind__finish_access(struct thread *thread __maybe_unused) {}
+static inline void unwind__flush_access(struct map_groups *mg __maybe_unused) {}
+static inline void unwind__finish_access(struct map_groups *mg __maybe_unused) {}
 #endif
 #else
 static inline int
@@ -72,14 +73,14 @@ unwind__get_entries(unwind_entry_cb_t cb __maybe_unused,
 	return 0;
 }
 
-static inline int unwind__prepare_access(struct thread *thread __maybe_unused,
+static inline int unwind__prepare_access(struct map_groups *mg __maybe_unused,
 					 struct map *map __maybe_unused,
 					 bool *initialized __maybe_unused)
 {
 	return 0;
 }
 
-static inline void unwind__flush_access(struct thread *thread __maybe_unused) {}
-static inline void unwind__finish_access(struct thread *thread __maybe_unused) {}
+static inline void unwind__flush_access(struct map_groups *mg __maybe_unused) {}
+static inline void unwind__finish_access(struct map_groups *mg __maybe_unused) {}
 #endif /* HAVE_DWARF_UNWIND_SUPPORT */
 #endif /* __UNWIND_H */
-- 
2.22.0

