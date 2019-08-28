Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4279FBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 09:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfH1Hbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 03:31:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36470 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfH1Hbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:31:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so975814pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kGLm/3S6HbogwpS+pmEjYJKGtydqwdRO0UoTI8Vz4MU=;
        b=PU1/H6oDzSqsIvUvfizbT85t4zs7+D5FHRps5ki//0CQ7XpO6N8nSL+T8dPeKUYzgC
         xQTis/UEHfVqliecdQj0E95B+RaEH5cJ6lTSTuFfUH+CsSLVqjd6RptdLSU6WsUEGREy
         V9qEJuXD24WOvwjMIJDaiN5h4+CXKh6QMz6fNXnUbz6iAb2k9KVYjRoyomlnmIxjpERm
         QIjOOuRFTlvM0wIDSJ1ko3TZQNC+MX0scxE2xMKsNG/TCkijfkd3UsLm1QZwJ1z+W0bt
         OrrfBUmXu/tV8hqy5U95wle5fhrjnidjxsyPzQZSvoyDqNitCLGR87JydwBQdujfxix9
         O+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kGLm/3S6HbogwpS+pmEjYJKGtydqwdRO0UoTI8Vz4MU=;
        b=SOyg2tBfmm4L70iDgYilRBg/O725rEquJPvJPygaNUpjndKlst+USOnX4WOmfhYwp4
         8Ar3OEC8pkMT5YJIsssZ8CIQ2GuefBLIzRSf/GH0yPkbBDZfbK18m0PT8PmjwJlEEbcg
         XpAaWwX7dmizCjIgFBNHpkiXNgonqnvT9UwYdM0a5pax5t/bMrelwxmpdIJ3bE5xcgeq
         uJZG72w0I29gRGjfDdMEniQRUVFL3x50lHnoSFFa3vrmlNxIj6vIk/qM15ZvxU54Sv5M
         SBEJkGyEh5LF38SrerGFFTwtqwJo+b4trZJjasHr9fGGBi3cNSorrC1/qkkLJl3lNca3
         p2xA==
X-Gm-Message-State: APjAAAXnqz1giP64hD+Ws6EvJvDmL8nlXOW5QYxr56cIbmss+Bh72agJ
        WejDdslRRyPqvi5xX9fAhxE=
X-Google-Smtp-Source: APXvYqydwPdpHO3GMIDlt5RZ9tnke87YyS501asfalG6HoJW7NutTq81//VBIeGf02EoiXgDHJipkg==
X-Received: by 2002:a62:2c93:: with SMTP id s141mr3094738pfs.114.1566977508654;
        Wed, 28 Aug 2019 00:31:48 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:31:48 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Date:   Wed, 28 Aug 2019 16:31:22 +0900
Message-Id: <20190828073130.83800-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828073130.83800-1-namhyung@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support cgroup tracking, add CGROUP event to save a link between
cgroup path and inode number.  The attr.cgroup bit was also added to
enable cgroup tracking from userspace.

This event will be generated when a new cgroup becomes active.
Userspace might need to synthesize those events for existing cgroups.

As aux_output change is also going on, I just added the bit here as
well to remove possible conflicts later.

Cc: Tejun Heo <tj@kernel.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/uapi/linux/perf_event.h |  15 ++++-
 kernel/events/core.c            | 112 ++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..cb07c24b715f 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -374,7 +374,9 @@ struct perf_event_attr {
 				namespaces     :  1, /* include namespaces data */
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
-				__reserved_1   : 33;
+				aux_output     :  1, /* generate AUX records instead of events */
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -999,6 +1001,17 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				ino;
+	 *	u64				path_len;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0463c1151bae..d898263db4fc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -386,6 +386,7 @@ static atomic_t nr_freq_events __read_mostly;
 static atomic_t nr_switch_events __read_mostly;
 static atomic_t nr_ksymbol_events __read_mostly;
 static atomic_t nr_bpf_events __read_mostly;
+static atomic_t nr_cgroup_events __read_mostly;
 
 static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
@@ -4314,6 +4315,8 @@ static void unaccount_event(struct perf_event *event)
 		atomic_dec(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_dec(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_dec(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_dec(&nr_task_events);
 	if (event->attr.freq)
@@ -7217,6 +7220,106 @@ void perf_event_namespaces(struct task_struct *task)
 			NULL);
 }
 
+/*
+ * cgroup tracking
+ */
+#ifdef CONFIG_CGROUPS
+
+struct perf_cgroup_event {
+	char				*path;
+	struct {
+		struct perf_event_header	header;
+		u64				ino;
+		u64				path_len;
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
+	__output_copy(&handle, cgroup_event->path,
+		      cgroup_event->event_id.path_len);
+
+	perf_event__output_id_sample(event, &handle, &sample);
+
+	perf_output_end(&handle);
+out:
+	cgroup_event->event_id.header.size = header_size;
+}
+
+void perf_event_cgroup(struct cgroup *cgrp)
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
+			.ino = cgrp->kn->id.ino,
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
+	cgroup_event.event_id.path_len = size;
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
@@ -10232,6 +10335,8 @@ static void account_event(struct perf_event *event)
 		atomic_inc(&nr_comm_events);
 	if (event->attr.namespaces)
 		atomic_inc(&nr_namespaces_events);
+	if (event->attr.cgroup)
+		atomic_inc(&nr_cgroup_events);
 	if (event->attr.task)
 		atomic_inc(&nr_task_events);
 	if (event->attr.freq)
@@ -12186,6 +12291,12 @@ static void perf_cgroup_css_free(struct cgroup_subsys_state *css)
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
@@ -12207,6 +12318,7 @@ static void perf_cgroup_attach(struct cgroup_taskset *tset)
 struct cgroup_subsys perf_event_cgrp_subsys = {
 	.css_alloc	= perf_cgroup_css_alloc,
 	.css_free	= perf_cgroup_css_free,
+	.css_online	= perf_cgroup_css_online,
 	.attach		= perf_cgroup_attach,
 	/*
 	 * Implicitly enable on dfl hierarchy so that perf events can
-- 
2.23.0.187.g17f5b7556c-goog

