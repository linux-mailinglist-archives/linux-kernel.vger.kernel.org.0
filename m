Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD814A638
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 15:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgA0OfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 09:35:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34709 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0OfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:35:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so5009929pfc.1;
        Mon, 27 Jan 2020 06:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rc4EGfuIuC09NWxx9hORj7M7blG1kkS6YkXGPimn7r4=;
        b=Hy3gItAM+OVn3adjJbNDp8JcZMbm3Y+l707Bkwazn/rSz7sP7loJZ5kcr4EP4HCq9e
         /yvSGWPgj560A3cqt4mBNfIWfqwJVqSvUEhC7n02a3d3IQ1PlbI7uqF/ZyvxHmCIhOvU
         ZgQTtOaS86EEehKAOxAofnCsv12k7GS2YT2zDYRZ1HgGxsNOH/d3lNgKDBaoNfWVZURX
         IOyBh6fYSkJX9Dsiqz4fj4xU3YoxFqTSdTJufj24pmgn+M1mmGKOXbdMRZ8ohBCcJuFD
         Ms2+TH/EEeQYdW4+gBHxFDhHp3QzKphDjd9YGtSYveXUfDhaGCxc72M3Pq96oE0uOMlv
         9wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Rc4EGfuIuC09NWxx9hORj7M7blG1kkS6YkXGPimn7r4=;
        b=baVVS7PLwVIPxXt3TgTqpsN9EmUdXfElR8ItNI1v+zm/n8mbSgRUlGQ0urjML4GS0L
         Mc9m7k73PdzHyyFxMvHsgnzysoy3IPzAwFYvVlzrXEnE2wFwyPhZ1542TgZnJI+2kEQL
         IB3AaX9zZ9rfLINNyoJ7Di6hqpTccuqzG6y3EgmKTHkePVbqvc/jpdHptZL6dcf+6RjC
         gsiNg/X0Pf/QH45mU95bY5hnOnY0rOvjjfMDfxSti7eVnR+FQkB5gBfnR9zXOORvQAHK
         F+rxbGllXYVxiu7UNEJ8ibJR5uPSjakz4p0kkH/vm/JJo+cHGeAlGCPG2PZUzNbdm80/
         68Rg==
X-Gm-Message-State: APjAAAUNOnpf1FbCD2ZiMkjuzaUk4dIkk88qX9gVwuN2ieBdSc6CdmkO
        J+WNIULUUp3DFjarWxDJyE4=
X-Google-Smtp-Source: APXvYqz2SW8B5hm2YH0n63R5I1xJ9qUoEVBdjpzPAQg3IZJqfVrAcP8lY1cBWOti88X10yzIHdWMlg==
X-Received: by 2002:a63:7053:: with SMTP id a19mr18777597pgn.377.1580135699435;
        Mon, 27 Jan 2020 06:34:59 -0800 (PST)
Received: from dosan.roam.corp.google.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id 3sm15898538pfi.13.2020.01.27.06.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:34:58 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf tools: Add machine pointer to struct hists
Date:   Mon, 27 Jan 2020 23:34:43 +0900
Message-Id: <20200127143443.89060-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation to handle cgroup events better for upcoming work.
Having a pointer to struct machine will make it easier to access more
data from output/sort routines.

I added session argument to perf_evsel__object_config callbacks to
enable this as hists objects are accessed via evsel in the normal
workflows.  So it can be NULL if those callbacks are never called or
session was not set when it's called.

If some codes want to access machine from a hists later, it should
check the pointer first.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evlist.c       |  8 ++++---
 tools/perf/util/evsel.c        | 38 ++++++++++++++++++++--------------
 tools/perf/util/evsel.h        | 28 ++++++++++++++++++-------
 tools/perf/util/hist.c         |  9 ++++++--
 tools/perf/util/hist.h         |  1 +
 tools/perf/util/parse-events.c |  4 ++--
 tools/perf/util/python.c       |  4 ++--
 7 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1548237b6558..870e56c75c23 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -248,8 +248,9 @@ int perf_evlist__add_dummy(struct evlist *evlist)
 		.config = PERF_COUNT_SW_DUMMY,
 		.size	= sizeof(attr), /* to capture ABI version */
 	};
-	struct evsel *evsel = perf_evsel__new_idx(&attr, evlist->core.nr_entries);
+	struct evsel *evsel;
 
+	evsel = perf_evsel__new_idx(&attr, evlist->core.nr_entries, NULL);
 	if (evsel == NULL)
 		return -ENOMEM;
 
@@ -265,7 +266,8 @@ static int evlist__add_attrs(struct evlist *evlist,
 	size_t i;
 
 	for (i = 0; i < nr_attrs; i++) {
-		evsel = perf_evsel__new_idx(attrs + i, evlist->core.nr_entries + i);
+		evsel = perf_evsel__new_idx(attrs + i,
+					    evlist->core.nr_entries + i, NULL);
 		if (evsel == NULL)
 			goto out_delete_partial_list;
 		list_add_tail(&evsel->core.node, &head);
@@ -1720,7 +1722,7 @@ int perf_evlist__add_sb_event(struct evlist **evlist,
 		attr->sample_id_all = 1;
 	}
 
-	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries);
+	evsel = perf_evsel__new_idx(attr, (*evlist)->core.nr_entries, NULL);
 	if (!evsel)
 		goto out_err;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c8dc4450884c..cf9bb7bb3542 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -56,21 +56,23 @@ struct perf_missing_features perf_missing_features;
 
 static clockid_t clockid;
 
-static int perf_evsel__no_extra_init(struct evsel *evsel __maybe_unused)
+static int perf_evsel__no_extra_init(struct evsel *evsel __maybe_unused,
+				     struct perf_session *session __maybe_unused)
 {
 	return 0;
 }
 
 void __weak test_attr__ready(void) { }
 
-static void perf_evsel__no_extra_fini(struct evsel *evsel __maybe_unused)
+static void perf_evsel__no_extra_fini(struct evsel *evsel __maybe_unused,
+				      struct perf_session *session __maybe_unused)
 {
 }
 
 static struct {
 	size_t	size;
-	int	(*init)(struct evsel *evsel);
-	void	(*fini)(struct evsel *evsel);
+	int	(*init)(struct evsel *evsel, struct perf_session *session);
+	void	(*fini)(struct evsel *evsel, struct perf_session *session);
 } perf_evsel__object = {
 	.size = sizeof(struct evsel),
 	.init = perf_evsel__no_extra_init,
@@ -78,8 +80,10 @@ static struct {
 };
 
 int perf_evsel__object_config(size_t object_size,
-			      int (*init)(struct evsel *evsel),
-			      void (*fini)(struct evsel *evsel))
+			      int (*init)(struct evsel *evsel,
+					  struct perf_session *session),
+			      void (*fini)(struct evsel *evsel,
+					   struct perf_session *session))
 {
 
 	if (object_size == 0)
@@ -234,8 +238,8 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
 #undef FUNCTION_EVENT
 }
 
-void evsel__init(struct evsel *evsel,
-		 struct perf_event_attr *attr, int idx)
+void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx,
+		 struct perf_session *session)
 {
 	perf_evsel__init(&evsel->core, attr);
 	evsel->idx	   = idx;
@@ -248,7 +252,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->bpf_obj	   = NULL;
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->config_terms);
-	perf_evsel__object.init(evsel);
+	perf_evsel__object.init(evsel, session);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
 	perf_evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
@@ -259,13 +263,14 @@ void evsel__init(struct evsel *evsel,
 	evsel->pmu_name      = NULL;
 }
 
-struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
+struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx,
+				  struct perf_session *session)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 
 	if (!evsel)
 		return NULL;
-	evsel__init(evsel, attr, idx);
+	evsel__init(evsel, attr, idx, session);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->core.attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
@@ -334,7 +339,8 @@ struct evsel *perf_evsel__new_cycles(bool precise)
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
-struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
+struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx,
+				    struct perf_session *session)
 {
 	struct evsel *evsel = zalloc(perf_evsel__object.size);
 	int err = -ENOMEM;
@@ -360,7 +366,7 @@ struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
 		event_attr_init(&attr);
 		attr.config = evsel->tp_format->id;
 		attr.sample_period = 1;
-		evsel__init(evsel, &attr, idx);
+		evsel__init(evsel, &attr, idx, session);
 	}
 
 	return evsel;
@@ -1271,7 +1277,7 @@ static void perf_evsel__free_config_terms(struct evsel *evsel)
 	}
 }
 
-void perf_evsel__exit(struct evsel *evsel)
+void perf_evsel__exit(struct evsel *evsel, struct perf_session *session)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist == NULL);
@@ -1285,12 +1291,12 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_thread_map__put(evsel->core.threads);
 	zfree(&evsel->group_name);
 	zfree(&evsel->name);
-	perf_evsel__object.fini(evsel);
+	perf_evsel__object.fini(evsel, session);
 }
 
 void evsel__delete(struct evsel *evsel)
 {
-	perf_evsel__exit(evsel);
+	perf_evsel__exit(evsel, NULL);
 	free(evsel);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index dc14f4a823cd..5f93620d7764 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -127,6 +127,7 @@ struct perf_cpu_map;
 struct target;
 struct thread_map;
 struct record_opts;
+struct perf_session;
 
 static inline struct perf_cpu_map *evsel__cpus(struct evsel *evsel)
 {
@@ -145,32 +146,43 @@ void perf_evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
 				struct perf_counts_values *count);
 
 int perf_evsel__object_config(size_t object_size,
-			      int (*init)(struct evsel *evsel),
-			      void (*fini)(struct evsel *evsel));
+			      int (*init)(struct evsel *evsel,
+					  struct perf_session *session),
+			      void (*fini)(struct evsel *evsel,
+					   struct perf_session *session));
 
-struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
+struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx,
+				  struct perf_session *session);
 
 static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 {
-	return perf_evsel__new_idx(attr, 0);
+	return perf_evsel__new_idx(attr, 0, NULL);
 }
 
-struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx);
+static inline struct evsel *evsel__new2(struct perf_event_attr *attr,
+					struct perf_session *session)
+{
+	return perf_evsel__new_idx(attr, 0, session);
+}
+
+struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx,
+				    struct perf_session *session);
 
 /*
  * Returns pointer with encoded error via <linux/err.h> interface.
  */
 static inline struct evsel *perf_evsel__newtp(const char *sys, const char *name)
 {
-	return perf_evsel__newtp_idx(sys, name, 0);
+	return perf_evsel__newtp_idx(sys, name, 0, NULL);
 }
 
 struct evsel *perf_evsel__new_cycles(bool precise);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
-void perf_evsel__exit(struct evsel *evsel);
+void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx,
+		 struct perf_session *session);
+void perf_evsel__exit(struct evsel *evsel, struct perf_session *session);
 void evsel__delete(struct evsel *evsel);
 
 struct callchain_param;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index ca5a8f4d007e..2c1f5a967180 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2775,7 +2775,8 @@ static void hists__delete_all_entries(struct hists *hists)
 	hists__delete_remaining_entries(&hists->entries_collapsed);
 }
 
-static void hists_evsel__exit(struct evsel *evsel)
+static void hists_evsel__exit(struct evsel *evsel,
+			      struct perf_session *session __maybe_unused)
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct perf_hpp_fmt *fmt, *pos;
@@ -2793,11 +2794,15 @@ static void hists_evsel__exit(struct evsel *evsel)
 	}
 }
 
-static int hists_evsel__init(struct evsel *evsel)
+static int hists_evsel__init(struct evsel *evsel,
+			     struct perf_session *session)
 {
 	struct hists *hists = evsel__hists(evsel);
 
 	__hists__init(hists, &perf_hpp_list);
+	if (session)
+		hists->machine = &session->machines.host;
+
 	return 0;
 }
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 0aa63aeb58ec..ffce7536761b 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -84,6 +84,7 @@ struct hists {
 	u64			nr_non_filtered_entries;
 	u64			callchain_period;
 	u64			callchain_non_filtered_period;
+	struct machine		*machine;
 	struct thread		*thread_filter;
 	const struct dso	*dso_filter;
 	const char		*uid_filter_str;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c01ba6f8fdad..7290513f7646 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -360,7 +360,7 @@ __add_event(struct list_head *list, int *idx,
 
 	event_attr_init(attr);
 
-	evsel = perf_evsel__new_idx(attr, *idx);
+	evsel = perf_evsel__new_idx(attr, *idx, NULL);
 	if (!evsel)
 		return NULL;
 
@@ -546,7 +546,7 @@ static int add_tracepoint(struct list_head *list, int *idx,
 {
 	struct evsel *evsel;
 
-	evsel = perf_evsel__newtp_idx(sys_name, evt_name, (*idx)++);
+	evsel = perf_evsel__newtp_idx(sys_name, evt_name, (*idx)++, NULL);
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name);
 		return PTR_ERR(evsel);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 83212c65848b..aa6319279448 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -795,13 +795,13 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	attr.sample_id_all  = sample_id_all;
 	attr.size	    = sizeof(attr);
 
-	evsel__init(&pevsel->evsel, &attr, idx);
+	evsel__init(&pevsel->evsel, &attr, idx, NULL);
 	return 0;
 }
 
 static void pyrf_evsel__delete(struct pyrf_evsel *pevsel)
 {
-	perf_evsel__exit(&pevsel->evsel);
+	perf_evsel__exit(&pevsel->evsel, NULL);
 	Py_TYPE(pevsel)->tp_free((PyObject*)pevsel);
 }
 
-- 
2.25.0.341.g760bfbb309-goog

