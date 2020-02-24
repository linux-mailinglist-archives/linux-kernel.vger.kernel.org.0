Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B144A169D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 05:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgBXEiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Feb 2020 23:38:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36789 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgBXEiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 23:38:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so4704465pfv.3;
        Sun, 23 Feb 2020 20:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7WvQH86E8G9Z2VuEzqMrxve555txA5C/9ut31ViLqsU=;
        b=o0rBlHjYXSpSt0AW3QW5ZcQcPoaI1JXtU5QayUs9pZ7LyCWuZod5VAFNYbkhsNQz1p
         0ANuVazbuY4tEvIzTbfJ0pP/0agdxqjW5WqPRqyqatC3OpUXjbQbkUyQJ82SrWdktXuh
         /pEN6XFXv+mWGpLt39AbijJ6xoyfL5A2Uf2urnSZnfDjnS8rSEXx36LeB8zfg0dNc9Kc
         3muJYs+N0Nf+Ocje67AGKsTs01hJ8yCK0J0bItCurr/KOe5DrIE2Us2VlxQYTrwDLz0M
         yUlLjFp4KsvPxhpLW3rZUnaGNxrCrb7SAvqwaVE/5mOzejMv2Eq/JGxkAipHwViqkWe5
         fJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7WvQH86E8G9Z2VuEzqMrxve555txA5C/9ut31ViLqsU=;
        b=UevShyIO9+PkdfzOSifivCMa0osQ+JXQ8b1cVZUESVQpkOmc01YsUoVkcWqj31ikM/
         BOTdi0jqdySaD3PZVzuuVoT5TxKSuKIOkBNr/vRkbMb1bY5sV/1HEbwQmt3y1rl0e4H5
         qBJD0A3alifpZJ5lq3v1GankkZlPNnp4KMwv2yQr94ydYvc2cPNT+kjeiTieT588+hIQ
         9uq8IyBbSRtynfDpRPzeWNphZe9euo7+HyJlemy0GgcXLRdu2aRQFbUd23DGojZtsBp8
         i/7SIVFkLfgHbNIZD0/CswQtsbnyV5Uyjx2ZFMuHvUS5QZFVxVOwps0tWTaUH/DdNg8O
         5WEQ==
X-Gm-Message-State: APjAAAXtPnaaBV1U5e7RkRdvPSMZKCbh+yN1rS16gfVqt8m0CE9MRdAL
        tKsRJ6MzbCUiVmYFLtYcFvw=
X-Google-Smtp-Source: APXvYqyN+ZBr0qjVWOPUAOpNI7V0NqXWrOt/TWAI84XID8SabXgbSgQaKlv0jFvXGnRSC6pbl1iv0w==
X-Received: by 2002:a65:645a:: with SMTP id s26mr49498894pgv.135.1582519084055;
        Sun, 23 Feb 2020 20:38:04 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id g16sm10914060pgb.54.2020.02.23.20.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 20:38:03 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 01/10] perf/core: Add PERF_RECORD_CGROUP event
Date:   Mon, 24 Feb 2020 13:37:40 +0900
Message-Id: <20200224043749.69466-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224043749.69466-1-namhyung@kernel.org>
References: <20200224043749.69466-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support cgroup tracking, add CGROUP event to save a link between
cgroup path and id number.  This is needed since cgroups can go away
when userspace tries to read the cgroup info (from the id) later.
The attr.cgroup bit was also added to enable cgroup tracking from
userspace.

This event will be generated when a new cgroup becomes active.
Userspace might need to synthesize those events for existing cgroups.

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
[staticize perf_event_cgroup function]
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/uapi/linux/perf_event.h |  13 +++-
 kernel/events/core.c            | 111 ++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 377d794d3105..de2ab87ca92c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -377,7 +377,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1006,6 +1007,16 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				id;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2173c23c25b4..b4ddfb26b5e9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -386,6 +386,7 @@ static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
+static atomic_t nr_cgroup_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4455,6 +4456,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_dec(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_dec(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_dec(&nr_task_events);
 	if (event->attr.freq)
@@ -7564,6 +7567,105 @@ void perf_event_namespaces(struct task_struct *task)
 			NULL);
 }
 
+/*
+ * cgroup tracking
+ */
+#ifdef CONFIG_CGROUP_PERF
+
+struct perf_cgroup_event {
+	char				*path;
+	int				path_size;
+	struct {
+		struct perf_event_header	header;
+		u64				id;
+		char				path[];
+	} event_id;
+};
+
+static int perf_event_cgroup_match(struct perf_event *event)
+{
+	return event->attr.cgroup;
+}
+
+static void perf_event_cgroup_output(struct perf_event *event, void *data)
+{
+	struct perf_cgroup_event *cgroup_event = data;
+	struct perf_output_handle handle;
+	struct perf_sample_data sample;
+	u16 header_size = cgroup_event->event_id.header.size;
+	int ret;
+
+	if (!perf_event_cgroup_match(event))
+		return;
+
+	perf_event_header__init_id(&cgroup_event->event_id.header,
+				   &sample, event);
+	ret = perf_output_begin(&handle, event,
+				cgroup_event->event_id.header.size);
+	if (ret)
+		goto out;
+
+	perf_output_put(&handle, cgroup_event->event_id);
+	__output_copy(&handle, cgroup_event->path, cgroup_event->path_size);
+
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+out:
+	cgroup_event->event_id.header.size = header_size;
+}
+
+static void perf_event_cgroup(struct cgroup *cgrp)
+{
+	struct perf_cgroup_event cgroup_event;
+	char path_enomem[16] = "//enomem";
+	char *pathname;
+	size_t size;
+
+	if (!atomic_read(&nr_cgroup_events))
+		return;
+
+	cgroup_event = (struct perf_cgroup_event){
+		.event_id  = {
+			.header = {
+				.type = PERF_RECORD_CGROUP,
+				.misc = 0,
+				.size = sizeof(cgroup_event.event_id),
+			},
+			.id = cgroup_id(cgrp),
+		},
+	};
+
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (pathname == NULL) {
+		cgroup_event.path = path_enomem;
+	} else {
+		/* just to be sure to have enough space for alignment */
+		cgroup_path(cgrp, pathname, PATH_MAX - sizeof(u64));
+		cgroup_event.path = pathname;
+	}
+
+	/*
+	 * Since our buffer works in 8 byte units we need to align our string
+	 * size to a multiple of 8. However, we must guarantee the tail end is
+	 * zero'd out to avoid leaking random bits to userspace.
+	 */
+	size = strlen(cgroup_event.path) + 1;
+	while (!IS_ALIGNED(size, sizeof(u64)))
+		cgroup_event.path[size++] = '\0';
+
+	cgroup_event.event_id.header.size += size;
+	cgroup_event.path_size = size;
+
+	perf_iterate_sb(perf_event_cgroup_output,
+			&cgroup_event,
+			NULL);
+
+	kfree(pathname);
+}
+
+#endif
+
 /*
  * mmap tracking
  */
@@ -10607,6 +10709,8 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_inc(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_inc(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_inc(&nr_task_events);
 	if (event->attr.freq)
@@ -12583,6 +12687,12 @@ static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
 	kfree(jc);
 }
 
+static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
+{
+	perf_event_cgroup(css->cgroup);
+	return 0;
+}
+
 static int __perf_cgroup_move(void *info)
 {
 	struct task_struct *task = info;
@@ -12604,6 +12714,7 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
 struct cgroup_subsys perf_event_cgrp_subsys = {
 	.css_alloc	= perf_cgroup_css_alloc,
 	.css_free	= perf_cgroup_css_free,
+	.css_online	= perf_cgroup_css_online,
 	.attach		= perf_cgroup_attach,
 	/*
 	 * Implicitly enable on dfl hierarchy so that perf events can
-- 
2.25.0.265.gbab2e86ba0-goog

