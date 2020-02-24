Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 843CE169D14
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 05:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgBXEia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 23:38:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34638 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgBXEiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so3531952plt.1;
        Sun, 23 Feb 2020 20:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4eHKSd/8mkM2kER+9+rci5W290arYgxT45RAnH1cyzU=;
        b=IUqUpIhX0NSR0Id7zjxFcCQdilEPLdD6TqvZRAdkmIlTU87WDykMfMec2mVRPcEF9G
         jkjdBbE8VrDGysnbRbm++GwRA0pMbWtn9OK1kYbVGqWtPmU84bPs9vPK9Bs73aQXoTA0
         OG1RCNLOUHObFCHFqIYrSv7V92EYW24j3uqtReyYMuKCtn7HFxvNEPrUbvlm1Igiy09z
         1uaqwAhuov3UrhjHfEdjItCBWeyslxNmV/F5OY/OIk73rxp3pU8TeOqyVj4767e1xlBk
         rKiZQAnFOS3EqmS+Ztt1N4XRad4hmjZ//p5AtEdG1e6Ezp4hU68y+t8p2hkDwjXdpzut
         grrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4eHKSd/8mkM2kER+9+rci5W290arYgxT45RAnH1cyzU=;
        b=mzEfNxnp5clyec/nqhbza63butQo/1KmYY7dRnaZYBiUbTboHHtXVc5J8pNTnu06zm
         UTNGeKHmaCfB5XF/8y9ugqOWFDT9Fdg0gw7ptwQ1ThIiUl4BT1gUStdYVh9iz4wjkOBo
         twcM4v+62XFCE2+hI2Vrbw18HtyJpSOBPY8LXhcYeMGH4F3++1Legz1xtiVGIL3BD8Aj
         PWdbSbAtoSI8/hZBViSbHJejNgLZRLzSdN9zgN18/BXf6szuJ5UDozhERpkb5jJgzcF6
         5+8mhifSoYf3a/8YToCspJZ3kiJPYKYbOmLExpSIj4RgP/WlnKqQ7MwdV15jgeGf7rk2
         DnCA==
X-Gm-Message-State: APjAAAXeXcLJjVzaJhNG6F9vefFMdRxXe6i6fOYcypZ5ul2ezRRmoLTR
        5MGD3TKLULVK5P88zHopYNw=
X-Google-Smtp-Source: APXvYqzhW8eQ8yDhpWrFlRNRPKCU03QvVHMn9I+OZbVPDsVMl6ykNIfgIMpiby0Pp8lbsAyMboIIfg==
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr18068680pjb.21.1582519103420;
        Sun, 23 Feb 2020 20:38:23 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:22 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 07/10] perf record: Support synthesizing cgroup events
Date:   Mon, 24 Feb 2020 13:37:46 +0900
Message-Id: <20200224043749.69466-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
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
 tools/perf/util/cgroup.h           |   1 +
 tools/perf/util/event.c            |   1 +
 tools/perf/util/synthetic-events.c | 113 +++++++++++++++++++++++++++++
 tools/perf/util/synthetic-events.h |   1 +
 tools/perf/util/tool.h             |   1 +
 6 files changed, 122 insertions(+)

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
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index e98d5975fe55..8337ec452c66 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -18,6 +18,7 @@ struct cgroup {
 
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
index cd336eb8886b..e826ccad1ebd 100644
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
@@ -413,6 +414,118 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
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
+		/* any sane path should be less than PATH_MAX */
+		if (strlen(path) + strlen(dent->d_name) + 1 >= PATH_MAX)
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
+	char cgrp_root[PATH_MAX];
+	size_t mount_len;  /* length of mount point in the path */
+
+	if (cgroupfs__mountpoint(cgrp_root, PATH_MAX, "perf_event") < 0) {
+		pr_debug("cannot find cgroup mount point\n");
+		return -1;
+	}
+
+	mount_len = strlen(cgrp_root);
+	/* make sure the path starts with a slash (after mount point) */
+	strcat(cgrp_root, "/");
+
+	if (perf_event__walk_cgroup_tree(tool, &event, cgrp_root, mount_len,
+					 process, machine) < 0)
+		return -1;
+
+	return 0;
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
2.25.0.265.gbab2e86ba0-goog

