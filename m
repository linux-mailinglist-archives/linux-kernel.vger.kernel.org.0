Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE8220C8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2019 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfEQXtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 19:49:20 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:34821 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfEQXtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 19:49:20 -0400
Received: by mail-yw1-f73.google.com with SMTP id r23so7899737ywg.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A7gs1+mF+FP/rGmpwnYONHmDSeyLtKWRbITND9nfmUM=;
        b=Bvr6EX1BZXsucquzdYD7Uqmbj6wwCOxg3rcQn60MXW4DU7nJ6/r0BcLbdwz5tSoo77
         t8gK6+Z8fzNWaCdetWoEM7f+2o8RnbLx8CS1YTx0OWWOXgHf9GbSSna8rk7ZkJtW9366
         qbOsVKy8h934mTsg17ZQzmg23y3wZf6pC6xq1BVMNnUuFeutN/8AR5EEbmK2sMuprJRg
         a6emrfrio99QVrVPAotorRVenxbKFArMXtlR5cm7+deloUaXTiqoqlTSpS4oeX0kgREi
         0grH9KoxLi4uE2v2hT9u5ceJ8cARpo0zsvhoqwkeDP3WrpIcGPvl6wRM7wSZypUbnFbe
         t2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A7gs1+mF+FP/rGmpwnYONHmDSeyLtKWRbITND9nfmUM=;
        b=F2XppEuHgDGHGRHx/VCKnMEvTIk1fCbQs5UT3TDUj1Dh5q8InwZtPmhJMy1t3gpXKH
         v3elyN5CLf9FmP2J8tV3265V5oaQZv79eqm8TJUvcabMTof5+iuk1RKTfGgJcP/KjQjX
         19/LaTZ2W3s6dhzC7LWSXJVPM5nMbTsWy7Dzcwj8PIkaetB6D0AtqZ+74DDd5rCQxQ1x
         j8PVOA+wQmsGZNqIGqUTZTjd5zhguJl1UJmpq4pcfmeuS4EJwMeXq9vE5rFM1//Qpdoo
         fCKRh9ROkr8TXv65HZrqG9MqTy/70w9b0K9F+HQEtCWAFFYn9taVBOthOuDB3/kC9kpt
         Pq9Q==
X-Gm-Message-State: APjAAAX20kVpTTGtZVkugxqB/nNG5M9KdVMXyIP20nq0UIVI9dTfmIBU
        sHLcBm0sJeCqG4wkAqSb9Kn02+dHcA4OBQ==
X-Google-Smtp-Source: APXvYqwKEww9mPrrXsrI0/TpLKrEc7pSe78bah2w5Z+0kdvcu66zLeplA2OTybD6hUGaqQkHasrvoaOkRdan0w==
X-Received: by 2002:a81:3589:: with SMTP id c131mr28332892ywa.456.1558136959229;
 Fri, 17 May 2019 16:49:19 -0700 (PDT)
Date:   Fri, 17 May 2019 16:49:09 -0700
Message-Id: <20190517234909.175734-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH] mm, memcg: introduce memory.events.local
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Chris Down <chris@chrisdown.name>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory controller in cgroup v2 exposes memory.events file for each
memcg which shows the number of times events like low, high, max, oom
and oom_kill have happened for the whole tree rooted at that memcg.
Users can also poll or register notification to monitor the changes in
that file. Any event at any level of the tree rooted at memcg will
notify all the listeners along the path till root_mem_cgroup. There are
existing users which depend on this behavior.

However there are users which are only interested in the events
happening at a specific level of the memcg tree and not in the events in
the underlying tree rooted at that memcg. One such use-case is a
centralized resource monitor which can dynamically adjust the limits of
the jobs running on a system. The jobs can create their sub-hierarchy
for their own sub-tasks. The centralized monitor is only interested in
the events at the top level memcgs of the jobs as it can then act and
adjust the limits of the jobs. Using the current memory.events for such
centralized monitor is very inconvenient. The monitor will keep
receiving events which it is not interested and to find if the received
event is interesting, it has to read memory.event files of the next
level and compare it with the top level one. So, let's introduce
memory.events.local to the memcg which shows and notify for the events
at the memcg level.

Now, does memory.stat and memory.pressure need their local versions.
IMHO no due to the no internal process contraint of the cgroup v2. The
memory.stat file of the top level memcg of a job shows the stats and
vmevents of the whole tree. The local stats or vmevents of the top level
memcg will only change if there is a process running in that memcg but
v2 does not allow that. Similarly for memory.pressure there will not be
any process in the internal nodes and thus no chance of local pressure.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |  7 ++++++-
 mm/memcontrol.c            | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 36bdfe8e5965..de77405eec46 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -239,8 +239,9 @@ struct mem_cgroup {
 	/* OOM-Killer disable */
 	int		oom_kill_disable;
 
-	/* memory.events */
+	/* memory.events and memory.events.local */
 	struct cgroup_file events_file;
+	struct cgroup_file events_local_file;
 
 	/* handle for "memory.swap.events" */
 	struct cgroup_file swap_events_file;
@@ -286,6 +287,7 @@ struct mem_cgroup {
 	atomic_long_t		vmevents_local[NR_VM_EVENT_ITEMS];
 
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
+	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
 	unsigned long		socket_pressure;
 
@@ -761,6 +763,9 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
 {
+	atomic_long_inc(&memcg->memory_events_local[event]);
+	cgroup_file_notify(&memcg->events_local_file);
+
 	do {
 		atomic_long_inc(&memcg->memory_events[event]);
 		cgroup_file_notify(&memcg->events_file);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2713b45ec3f0..a746127012fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5648,6 +5648,25 @@ static int memory_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int memory_events_local_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "low %lu\n",
+		   atomic_long_read(&memcg->memory_events_local[MEMCG_LOW]));
+	seq_printf(m, "high %lu\n",
+		   atomic_long_read(&memcg->memory_events_local[MEMCG_HIGH]));
+	seq_printf(m, "max %lu\n",
+		   atomic_long_read(&memcg->memory_events_local[MEMCG_MAX]));
+	seq_printf(m, "oom %lu\n",
+		   atomic_long_read(&memcg->memory_events_local[MEMCG_OOM]));
+	seq_printf(m, "oom_kill %lu\n",
+		   atomic_long_read(&memcg->memory_events_local[MEMCG_OOM_KILL])
+		   );
+
+	return 0;
+}
+
 static int memory_stat_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
@@ -5806,6 +5825,12 @@ static struct cftype memory_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, events_file),
 		.seq_show = memory_events_show,
 	},
+	{
+		.name = "events.local",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.file_offset = offsetof(struct mem_cgroup, events_local_file),
+		.seq_show = memory_events_local_show,
+	},
 	{
 		.name = "stat",
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.21.0.1020.gf2820cf01a-goog

