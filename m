Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C84E79F25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2019 05:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbfG3C7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 22:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732279AbfG3C7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:59:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F3CF21726;
        Tue, 30 Jul 2019 02:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455586;
        bh=ib1kpFIfnxarzVnaH8Mp7xTrOeabcixMemFWZEXgSMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qcmo9JMooFQHsguGwAjt6yRIyGbXpFCaPnhFQUX9gvnmAmfoEH8rf1GErkZRwTzQJ
         9ZteLFMy57P80qFbKyhK3fiaWsd6D5WYOjv2BnkfhJULczDnhi8HxaF7Va5btmCLjJ
         Qu4HaeUDOtjyevYV+YhFrwNJgVmCwZ040zqBu8gU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 062/107] libperf: Include perf_evsel in evsel object
Date:   Mon, 29 Jul 2019 23:55:25 -0300
Message-Id: <20190730025610.22603-63-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Including perf_evsel in evsel object, will continue to move other
generic things into libperf's perf_evsel struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-36-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c         |  2 +-
 tools/perf/builtin-trace.c         |  2 +-
 tools/perf/ui/browsers/hists.c     |  8 ++++----
 tools/perf/util/evlist.c           | 16 ++++++++--------
 tools/perf/util/evlist.h           | 12 ++++++------
 tools/perf/util/evsel.c            |  4 ++--
 tools/perf/util/evsel.h            | 16 ++++++++--------
 tools/perf/util/parse-events.c     | 20 ++++++++++----------
 tools/perf/util/stat-display.c     |  4 ++--
 tools/perf/util/trace-event-info.c |  4 ++--
 10 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index c02ecb295f23..70247f1b23da 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2929,7 +2929,7 @@ static int timehist_check_attr(struct perf_sched *sched,
 	struct evsel *evsel;
 	struct evsel_runtime *er;
 
-	list_for_each_entry(evsel, &evlist->entries, node) {
+	list_for_each_entry(evsel, &evlist->entries, core.node) {
 		er = perf_evsel__get_runtime(evsel);
 		if (er == NULL) {
 			pr_err("Failed to allocate memory for evsel runtime data\n");
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 51d142594a12..29dbf99f6081 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2636,7 +2636,7 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 			continue;
 		}
 
-		list_del_init(&evsel->node);
+		list_del_init(&evsel->core.node);
 		evsel->evlist = NULL;
 		evsel__delete(evsel);
 	}
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b83258bece05..280347499c50 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3212,7 +3212,7 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 {
 	struct evsel_menu *menu = container_of(browser,
 						    struct evsel_menu, b);
-	struct evsel *evsel = list_entry(entry, struct evsel, node);
+	struct evsel *evsel = list_entry(entry, struct evsel, core.node);
 	struct hists *hists = evsel__hists(evsel);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	unsigned long nr_events = hists->stats.nr_events[PERF_RECORD_SAMPLE];
@@ -3309,13 +3309,13 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 			ui_browser__show_title(&menu->b, title);
 			switch (key) {
 			case K_TAB:
-				if (pos->node.next == &evlist->entries)
+				if (pos->core.node.next == &evlist->entries)
 					pos = perf_evlist__first(evlist);
 				else
 					pos = perf_evsel__next(pos);
 				goto browse_hists;
 			case K_UNTAB:
-				if (pos->node.prev == &evlist->entries)
+				if (pos->core.node.prev == &evlist->entries)
 					pos = perf_evlist__last(evlist);
 				else
 					pos = perf_evsel__prev(pos);
@@ -3351,7 +3351,7 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
 static bool filter_group_entries(struct ui_browser *browser __maybe_unused,
 				 void *entry)
 {
-	struct evsel *evsel = list_entry(entry, struct evsel, node);
+	struct evsel *evsel = list_entry(entry, struct evsel, core.node);
 
 	if (symbol_conf.event_group && !perf_evsel__is_group_leader(evsel))
 		return true;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 38a3c6d16b4b..227576bf16c0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -119,7 +119,7 @@ static void perf_evlist__purge(struct evlist *evlist)
 	struct evsel *pos, *n;
 
 	evlist__for_each_entry_safe(evlist, n, pos) {
-		list_del_init(&pos->node);
+		list_del_init(&pos->core.node);
 		pos->evlist = NULL;
 		evsel__delete(pos);
 	}
@@ -180,7 +180,7 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
 void evlist__add(struct evlist *evlist, struct evsel *entry)
 {
 	entry->evlist = evlist;
-	list_add_tail(&entry->node, &evlist->entries);
+	list_add_tail(&entry->core.node, &evlist->entries);
 	entry->idx = evlist->nr_entries;
 	entry->tracking = !entry->idx;
 
@@ -193,7 +193,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
-	list_del_init(&evsel->node);
+	list_del_init(&evsel->core.node);
 	evlist->nr_entries -= 1;
 }
 
@@ -203,7 +203,7 @@ void perf_evlist__splice_list_tail(struct evlist *evlist,
 	struct evsel *evsel, *temp;
 
 	__evlist__for_each_entry_safe(list, temp, evsel) {
-		list_del_init(&evsel->node);
+		list_del_init(&evsel->core.node);
 		evlist__add(evlist, evsel);
 	}
 }
@@ -212,8 +212,8 @@ void __perf_evlist__set_leader(struct list_head *list)
 {
 	struct evsel *evsel, *leader;
 
-	leader = list_entry(list->next, struct evsel, node);
-	evsel = list_entry(list->prev, struct evsel, node);
+	leader = list_entry(list->next, struct evsel, core.node);
+	evsel = list_entry(list->prev, struct evsel, core.node);
 
 	leader->nr_members = evsel->idx - leader->idx + 1;
 
@@ -268,7 +268,7 @@ static int evlist__add_attrs(struct evlist *evlist,
 		evsel = perf_evsel__new_idx(attrs + i, evlist->nr_entries + i);
 		if (evsel == NULL)
 			goto out_delete_partial_list;
-		list_add_tail(&evsel->node, &head);
+		list_add_tail(&evsel->core.node, &head);
 	}
 
 	perf_evlist__splice_list_tail(evlist, &head);
@@ -1680,7 +1680,7 @@ void perf_evlist__to_front(struct evlist *evlist,
 
 	evlist__for_each_entry_safe(evlist, n, evsel) {
 		if (evsel->leader == move_evsel->leader)
-			list_move_tail(&evsel->node, &move);
+			list_move_tail(&evsel->core.node, &move);
 	}
 
 	list_splice(&move, &evlist->entries);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 99621c056d09..1315e64ad69e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -230,12 +230,12 @@ static inline bool perf_evlist__empty(struct evlist *evlist)
 
 static inline struct evsel *perf_evlist__first(struct evlist *evlist)
 {
-	return list_entry(evlist->entries.next, struct evsel, node);
+	return list_entry(evlist->entries.next, struct evsel, core.node);
 }
 
 static inline struct evsel *perf_evlist__last(struct evlist *evlist)
 {
-	return list_entry(evlist->entries.prev, struct evsel, node);
+	return list_entry(evlist->entries.prev, struct evsel, core.node);
 }
 
 size_t perf_evlist__fprintf(struct evlist *evlist, FILE *fp);
@@ -253,7 +253,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define __evlist__for_each_entry(list, evsel) \
-        list_for_each_entry(evsel, list, node)
+        list_for_each_entry(evsel, list, core.node)
 
 /**
  * evlist__for_each_entry - iterate thru all the evsels
@@ -269,7 +269,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define __evlist__for_each_entry_continue(list, evsel) \
-        list_for_each_entry_continue(evsel, list, node)
+        list_for_each_entry_continue(evsel, list, core.node)
 
 /**
  * evlist__for_each_entry_continue - continue iteration thru all the evsels
@@ -285,7 +285,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define __evlist__for_each_entry_reverse(list, evsel) \
-        list_for_each_entry_reverse(evsel, list, node)
+        list_for_each_entry_reverse(evsel, list, core.node)
 
 /**
  * evlist__for_each_entry_reverse - iterate thru all the evsels in reverse order
@@ -302,7 +302,7 @@ void perf_evlist__to_front(struct evlist *evlist,
  * @evsel: struct evsel iterator
  */
 #define __evlist__for_each_entry_safe(list, tmp, evsel) \
-        list_for_each_entry_safe(evsel, tmp, list, node)
+        list_for_each_entry_safe(evsel, tmp, list, core.node)
 
 /**
  * evlist__for_each_entry_safe - safely iterate thru all the evsels
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 652e53279b28..8fed22d889a4 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -236,7 +236,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->evlist	   = NULL;
 	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
-	INIT_LIST_HEAD(&evsel->node);
+	INIT_LIST_HEAD(&evsel->core.node);
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
@@ -1318,7 +1318,7 @@ void perf_evsel__close_fd(struct evsel *evsel)
 
 void perf_evsel__exit(struct evsel *evsel)
 {
-	assert(list_empty(&evsel->node));
+	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
 	perf_evsel__free_counts(evsel);
 	perf_evsel__free_fd(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 5fec1ca64f58..d74cac6fe306 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -7,6 +7,7 @@
 #include <stddef.h>
 #include <linux/perf_event.h>
 #include <linux/types.h>
+#include <internal/evsel.h>
 #include "xyarray.h"
 #include "symbol_conf.h"
 #include "cpumap.h"
@@ -87,8 +88,7 @@ struct bpf_object;
 /** struct evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
- * @node - To insert it into evlist->entries or in other list_heads, say in
- *         the event parsing routines.
+ * @core - libperf evsel object
  * @name - Can be set to retain the original event name passed by the user,
  *         so that when showing results in tools such as 'perf stat', we
  *         show the name used, not some alias.
@@ -101,7 +101,7 @@ struct bpf_object;
  * @priv:   And what is in its containing unnamed union are tool specific
  */
 struct evsel {
-	struct list_head	node;
+	struct perf_evsel	core;
 	struct evlist	*evlist;
 	struct perf_event_attr	attr;
 	char			*filter;
@@ -386,12 +386,12 @@ int perf_evsel__parse_sample_timestamp(struct evsel *evsel,
 
 static inline struct evsel *perf_evsel__next(struct evsel *evsel)
 {
-	return list_entry(evsel->node.next, struct evsel, node);
+	return list_entry(evsel->core.node.next, struct evsel, core.node);
 }
 
 static inline struct evsel *perf_evsel__prev(struct evsel *evsel)
 {
-	return list_entry(evsel->node.prev, struct evsel, node);
+	return list_entry(evsel->core.node.prev, struct evsel, core.node);
 }
 
 /**
@@ -478,15 +478,15 @@ static inline int perf_evsel__group_idx(struct evsel *evsel)
 
 /* Iterates group WITHOUT the leader. */
 #define for_each_group_member(_evsel, _leader) 					\
-for ((_evsel) = list_entry((_leader)->node.next, struct evsel, node); 	\
+for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node); \
      (_evsel) && (_evsel)->leader == (_leader);					\
-     (_evsel) = list_entry((_evsel)->node.next, struct evsel, node))
+     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
 /* Iterates group WITH the leader. */
 #define for_each_group_evsel(_evsel, _leader) 					\
 for ((_evsel) = _leader; 							\
      (_evsel) && (_evsel)->leader == (_leader);					\
-     (_evsel) = list_entry((_evsel)->node.next, struct evsel, node))
+     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
 static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
 {
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 38eeca6fa1fc..e111c0e0a5ac 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -343,7 +343,7 @@ __add_event(struct list_head *list, int *idx,
 	if (config_terms)
 		list_splice(config_terms, &evsel->config_terms);
 
-	list_add_tail(&evsel->node, list);
+	list_add_tail(&evsel->core.node, list);
 	return evsel;
 }
 
@@ -526,7 +526,7 @@ static int add_tracepoint(struct list_head *list, int *idx,
 		list_splice(&config_terms, &evsel->config_terms);
 	}
 
-	list_add_tail(&evsel->node, list);
+	list_add_tail(&evsel->core.node, list);
 	return 0;
 }
 
@@ -660,15 +660,15 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 
 		pr_debug("Failed to add BPF event %s:%s\n",
 			 group, event);
-		list_for_each_entry_safe(evsel, tmp, &new_evsels, node) {
-			list_del_init(&evsel->node);
+		list_for_each_entry_safe(evsel, tmp, &new_evsels, core.node) {
+			list_del_init(&evsel->core.node);
 			evsel__delete(evsel);
 		}
 		return err;
 	}
 	pr_debug("adding %s:%s\n", group, event);
 
-	list_for_each_entry(pos, &new_evsels, node) {
+	list_for_each_entry(pos, &new_evsels, core.node) {
 		pr_debug("adding %s:%s to %p\n",
 			 group, event, pos);
 		pos->bpf_fd = fd;
@@ -1458,8 +1458,8 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
 	bool is_leader = true;
 	int i, nr_pmu = 0, total_members, ret = 0;
 
-	leader = list_first_entry(list, struct evsel, node);
-	evsel = list_last_entry(list, struct evsel, node);
+	leader = list_first_entry(list, struct evsel, core.node);
+	evsel = list_last_entry(list, struct evsel, core.node);
 	total_members = evsel->idx - leader->idx + 1;
 
 	leaders = calloc(total_members, sizeof(uintptr_t));
@@ -1555,7 +1555,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
 		return;
 
 	__perf_evlist__set_leader(list);
-	leader = list_entry(list->next, struct evsel, node);
+	leader = list_entry(list->next, struct evsel, core.node);
 	leader->group_name = name ? strdup(name) : NULL;
 }
 
@@ -2050,9 +2050,9 @@ foreach_evsel_in_last_glob(struct evlist *evlist,
 		if (!last)
 			return 0;
 
-		if (last->node.prev == &evlist->entries)
+		if (last->core.node.prev == &evlist->entries)
 			return 0;
-		last = list_entry(last->node.prev, struct evsel, node);
+		last = list_entry(last->core.node.prev, struct evsel, core.node);
 	} while (!last->cmdline_group_boundary);
 
 	return 0;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 1f099823a1f9..17b7d3b55b5f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -548,8 +548,8 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 	struct evlist *evlist = counter->evlist;
 	struct evsel *alias;
 
-	alias = list_prepare_entry(counter, &(evlist->entries), node);
-	list_for_each_entry_continue (alias, &evlist->entries, node) {
+	alias = list_prepare_entry(counter, &(evlist->entries), core.node);
+	list_for_each_entry_continue (alias, &evlist->entries, core.node) {
 		if (strcmp(perf_evsel__name(alias), perf_evsel__name(counter)) ||
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index d7ae0627ac47..7efdbb182ea1 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -408,7 +408,7 @@ get_tracepoints_path(struct list_head *pattrs)
 	struct evsel *pos;
 	int nr_tracepoints = 0;
 
-	list_for_each_entry(pos, pattrs, node) {
+	list_for_each_entry(pos, pattrs, core.node) {
 		if (pos->attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
 		++nr_tracepoints;
@@ -443,7 +443,7 @@ bool have_tracepoints(struct list_head *pattrs)
 {
 	struct evsel *pos;
 
-	list_for_each_entry(pos, pattrs, node)
+	list_for_each_entry(pos, pattrs, core.node)
 		if (pos->attr.type == PERF_TYPE_TRACEPOINT)
 			return true;
 
-- 
2.21.0

