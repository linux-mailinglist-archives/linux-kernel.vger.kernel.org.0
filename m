Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D371291C1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Dec 2019 07:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLWGIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Dec 2019 01:08:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40007 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfLWGIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:08:30 -0500
Received: by mail-pg1-f193.google.com with SMTP id k25so8265399pgt.7;
        Sun, 22 Dec 2019 22:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jthIhZ/r78EEFW0yb2Oe43SaYjMNvPNHJLyoREGgoNw=;
        b=rjeyYEkoE474aRbY+AaEhfKgpVhxx8bZpf9h+IgXUqQhbue8aWcGuAK1sXdx/gxLUc
         W/K3OQj/RjTT2nEryrr5vMFiE+aadtFZIS5FOH72F68s6hz9a5W1cKdTkE+fY7IPujdD
         9dX3XDkfTmeanA3+MbmpwEw117kjKGaCEXwOSyINPVLuKe3vOfTyxA3NB9j6WOapSYKC
         Ll3b4fYGf9kExrJceITQWNB/MAnXayIaq1cNOzCUwK1XPy8s6Ftl2MtT+E3BLI66hbij
         lnGo6jvSblr14zPr6HYpIsIJElXVPH+CIlQtaE6dteWxhz4YGqvYvZqnWXUaRQ16pJ+B
         OcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jthIhZ/r78EEFW0yb2Oe43SaYjMNvPNHJLyoREGgoNw=;
        b=c7yo9hAIJq8TYG3hMZE/bQWTM+xiNX5641k3KU2vi5azqRrMxTwKAZlxVkyrgVRecU
         BNO1OtgTo5Upnzppc/Kxwwh6Ob251DKrRKgfZEcX1oV9wmGo8hnMe0tEolnnyoXPlicj
         R7ojEXajvRe7IC1D3vIwTXjfSNHp3nMa40DEjLs5iGY/skoINli3MJcIQ2MY/hpLlXT5
         iufqaeTYKQC8Er5BSpKj65d2nL1J5L5b/kN4NQYvarCXxJzEtZ0k9zT6ah6zRjJ3KAku
         IOX2EWVn/OKz+SLYeY7ikkYq1es3uinB10VTJU7fOTSdLZ8qO7Pf8M1Vx4U6yMmWD8NU
         1E/Q==
X-Gm-Message-State: APjAAAXQ+mVmLHwXdEUVgV7fUFwxR09J1qHUuTHdxYD9oHY9d9xcXVdg
        1YtPb/v8bQs0WbtTADyfao0=
X-Google-Smtp-Source: APXvYqxtJMlxwyDf/RCWXmGf2RNEdg7oUtRmObX2wYDC1kAKuR582pg06zrjXkfg7I56jG/lIkps2Q==
X-Received: by 2002:a63:7045:: with SMTP id a5mr30296820pgn.49.1577081309574;
        Sun, 22 Dec 2019 22:08:29 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p185sm22978212pfg.61.2019.12.22.22.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 22:08:29 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 6/9] perf record: Support synthesizing cgroup events
Date:   Mon, 23 Dec 2019 15:07:56 +0900
Message-Id: <20191223060759.841176-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesize cgroup events by iterating cgroup filesystem directories.
The cgroup event only saves the portion of cgroup path after the mount
point and the cgroup id (which actually is a file handle).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c        |   5 ++
 tools/perf/util/cgroup.c           |   3 +-
 tools/perf/util/cgroup.h           |   1 +
 tools/perf/util/event.c            |   1 +
 tools/perf/util/synthetic-events.c | 119 +++++++++++++++++++++++++++++
 tools/perf/util/synthetic-events.h |   1 +
 tools/perf/util/tool.h             |   1 +
 7 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4c301466101b..2802de9538ff 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1397,6 +1397,11 @@ static int record__synthesize(struct record *rec, bool tail)
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
 
+	err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
+					     machine);
+	if (err < 0)
+		pr_warning("Couldn't synthesize cgroup events.\n");
+
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
 					    process_synthesized_event, opts->sample_address,
 					    1);
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index 4e8ef1db0c94..5147d22b3bda 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -15,8 +15,7 @@ int nr_cgroups;
 
 static struct rb_root cgroup_tree = RB_ROOT;
 
-static int
-cgroupfs_find_mountpoint(char *buf, size_t maxlen)
+int cgroupfs_find_mountpoint(char *buf, size_t maxlen)
 {
 	FILE *fp;
 	char mountpoint[PATH_MAX + 1], tokens[PATH_MAX + 1], type[PATH_MAX + 1];
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index 381583df27c7..9a67060723fa 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -17,6 +17,7 @@ struct cgroup {
 
 extern int nr_cgroups; /* number of explicit cgroups defined */
 
+int cgroupfs_find_mountpoint(char *buf, size_t maxlen);
 struct cgroup *cgroup__get(struct cgroup *cgroup);
 void cgroup__put(struct cgroup *cgroup);
 
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 824c038e5c33..28801c867f39 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -33,6 +33,7 @@
 #include "bpf-event.h"
 #include "tool.h"
 #include "../perf.h"
+#include "cgroup.h"
 
 static const char *perf_event__names[] = {
 	[0]					= "TOTAL",
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index c423298fe62d..cfc850efa318 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -16,6 +16,7 @@
 #include "util/synthetic-events.h"
 #include "util/target.h"
 #include "util/time-utils.h"
+#include "util/cgroup.h"
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -413,6 +414,124 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	return rc;
 }
 
+static int perf_event__synthesize_cgroup(struct perf_tool *tool,
+					 union perf_event *event,
+					 char *path, size_t mount_len,
+					 perf_event__handler_t process,
+					 struct machine *machine)
+{
+	size_t event_size = sizeof(event->cgroup) - sizeof(event->cgroup.path);
+	size_t path_len = strlen(path) - mount_len + 1;
+	struct {
+		struct file_handle fh;
+		uint64_t cgroup_id;
+	} handle;
+	int mount_id;
+
+	while (path_len % sizeof(u64))
+		path[mount_len + path_len++] = '\0';
+
+	memset(&event->cgroup, 0, event_size);
+
+	event->cgroup.header.type = PERF_RECORD_CGROUP;
+	event->cgroup.header.size = event_size + path_len + machine->id_hdr_size;
+
+	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
+	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
+		pr_debug("stat failed: %s\n", path);
+		return -1;
+	}
+
+	event->cgroup.id = handle.cgroup_id;
+	strncpy(event->cgroup.path, path + mount_len, path_len);
+	memset(event->cgroup.path + path_len, 0, machine->id_hdr_size);
+
+	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
+		pr_debug("process synth event failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int perf_event__walk_cgroup_tree(struct perf_tool *tool,
+					union perf_event *event,
+					char *path, size_t mount_len,
+					perf_event__handler_t process,
+					struct machine *machine)
+{
+	size_t pos = strlen(path);
+	DIR *d;
+	struct dirent *dent;
+	int ret = 0;
+
+	if (perf_event__synthesize_cgroup(tool, event, path, mount_len,
+					  process, machine) < 0)
+		return -1;
+
+	d = opendir(path);
+	if (d == NULL) {
+		pr_debug("failed to open directory: %s\n", path);
+		return -1;
+	}
+
+	while ((dent = readdir(d)) != NULL) {
+		if (dent->d_type != DT_DIR)
+			continue;
+		if (!strcmp(dent->d_name, ".") ||
+		    !strcmp(dent->d_name, ".."))
+			continue;
+
+		if (path[pos - 1] != '/')
+			strcat(path, "/");
+		strcat(path, dent->d_name);
+
+		ret = perf_event__walk_cgroup_tree(tool, event, path,
+						   mount_len, process, machine);
+		if (ret < 0)
+			break;
+
+		path[pos] = '\0';
+	}
+
+	closedir(d);
+	return ret;
+}
+
+int perf_event__synthesize_cgroups(struct perf_tool *tool,
+				   perf_event__handler_t process,
+				   struct machine *machine)
+{
+	union perf_event event;
+	char *cgrp_root;
+	size_t mount_len;  /* length of mount point in the path */
+	int ret = -1;
+
+	cgrp_root = malloc(PATH_MAX);
+	if (cgrp_root == NULL)
+		return -1;
+
+	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX) < 0) {
+		pr_debug("cannot find cgroup mount point\n");
+		goto out;
+	}
+
+	mount_len = strlen(cgrp_root);
+	/* make sure the path starts with a slash (after mount point) */
+	strcat(cgrp_root, "/");
+
+	if (perf_event__walk_cgroup_tree(tool, &event, cgrp_root, mount_len,
+					 process, machine) < 0)
+		goto out;
+
+	ret = 0;
+
+out:
+	free(cgrp_root);
+
+	return ret;
+}
+
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
 				   struct machine *machine)
 {
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index baead0cdc381..e7a3e9589738 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -45,6 +45,7 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool, perf_event__handl
 int perf_event__synthesize_mmap_events(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine, bool mmap_data);
 int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_namespaces(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine);
+int perf_event__synthesize_cgroups(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format, const struct perf_sample *sample);
 int perf_event__synthesize_stat_config(struct perf_tool *tool, struct perf_stat_config *config, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process, bool attrs);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 472ef5eb4068..3fb67bd31e4a 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -79,6 +79,7 @@ struct perf_tool {
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
 	bool		namespace_events;
+	bool		cgroup_events;
 	bool		no_warn;
 	enum show_feature_header show_feat_hdr;
 };
-- 
2.24.1.735.g03f4e72817-goog

