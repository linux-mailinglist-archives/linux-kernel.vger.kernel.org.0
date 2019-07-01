Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6E085959A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfF1IGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 04:06:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38900 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfF1IGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:06:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so5257176wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IEUt13ZTn0zBCZAP80Omheo6qj6rUso/70fm+QzSiTs=;
        b=Roc7d7JEQUmUpGO904rook2f2nelHQSlM9ZE0KUgz03vafRPQJGV4zX47uJjlZV0yU
         +C4zTkdGBy1mHV1X5vQc52sz1DpiAowhYWQRfbyCdkjzRIVIKpVwXPpQb1boPPHXL1OL
         8uHhpj6ZMYw4LB+Q6qlxlxBZpbIaSspK0vCUsz6XehJpTeJvY8+pD+FWdsk69GWsL0FS
         Dyvi+0BR3+uG2Hb+TE5VtIciTZto5AH+zfIbAtGjqbfok7DXKyVLXAND0uSXH3ls3pPm
         yV7CJInAy/XxM90QmjX2lhwXqP9/8mNKBR7Y9a9axK/VHVbZ6k+8Fo0wc2wU1SlQQuEG
         F2hg==
X-Gm-Message-State: APjAAAXCmoQKf/B3ZIWFOuO0xdjxnvpXCflJRteZmfTIbiNU7NUGn6RQ
        dYsacaDOWKKDsYTuyFwf1hAVIg==
X-Google-Smtp-Source: APXvYqzPRjytR9yU8/kgcOYCrhT7z5bh4HdwLxRR6gtwP84KVKSKW1hp4WvYsFE8Q2uc4rqaPnuQLw==
X-Received: by 2002:adf:f186:: with SMTP id h6mr6561363wro.274.1561709202544;
        Fri, 28 Jun 2019 01:06:42 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id z19sm1472774wmi.7.2019.06.28.01.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 01:06:42 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v8 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug lock order
Date:   Fri, 28 Jun 2019 10:06:16 +0200
Message-Id: <20190628080618.522-7-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190628080618.522-1-juri.lelli@redhat.com>
References: <20190628080618.522-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpuset_rwsem is going to be acquired from sched_setscheduler() with a
following patch. There are however paths (e.g., spawn_ksoftirqd) in
which sched_scheduler() is eventually called while holding hotplug lock;
this creates a dependecy between hotplug lock (to be always acquired
first) and cpuset_rwsem (to be always acquired after hotplug lock).

Fix paths which currently take the two locks in the wrong order (after
a following patch is applied).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h |  8 ++++----
 kernel/cgroup/cpuset.c | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 934633a05d20..7f1478c26a33 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -40,14 +40,14 @@ static inline bool cpusets_enabled(void)
 
 static inline void cpuset_inc(void)
 {
-	static_branch_inc(&cpusets_pre_enable_key);
-	static_branch_inc(&cpusets_enabled_key);
+	static_branch_inc_cpuslocked(&cpusets_pre_enable_key);
+	static_branch_inc_cpuslocked(&cpusets_enabled_key);
 }
 
 static inline void cpuset_dec(void)
 {
-	static_branch_dec(&cpusets_enabled_key);
-	static_branch_dec(&cpusets_pre_enable_key);
+	static_branch_dec_cpuslocked(&cpusets_enabled_key);
+	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
 }
 
 extern int cpuset_init(void);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a7c0c8d8f132..d92b351f89e3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1026,8 +1026,8 @@ static void rebuild_sched_domains_locked(void)
 	cpumask_var_t *doms;
 	int ndoms;
 
+	lockdep_assert_cpus_held();
 	percpu_rwsem_assert_held(&cpuset_rwsem);
-	get_online_cpus();
 
 	/*
 	 * We have raced with CPU hotplug. Don't do anything to avoid
@@ -1036,19 +1036,17 @@ static void rebuild_sched_domains_locked(void)
 	 */
 	if (!top_cpuset.nr_subparts_cpus &&
 	    !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
-		goto out;
+		return;
 
 	if (top_cpuset.nr_subparts_cpus &&
 	   !cpumask_subset(top_cpuset.effective_cpus, cpu_active_mask))
-		goto out;
+		return;
 
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
 
 	/* Have scheduler rebuild the domains */
 	partition_and_rebuild_sched_domains(ndoms, doms, attr);
-out:
-	put_online_cpus();
 }
 #else /* !CONFIG_SMP */
 static void rebuild_sched_domains_locked(void)
@@ -1058,9 +1056,11 @@ static void rebuild_sched_domains_locked(void)
 
 void rebuild_sched_domains(void)
 {
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	rebuild_sched_domains_locked();
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 }
 
 /**
@@ -2298,6 +2298,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = 0;
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
@@ -2335,6 +2336,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	}
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	return retval;
 }
 
@@ -2345,6 +2347,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	cpuset_filetype_t type = cft->private;
 	int retval = -ENODEV;
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2359,6 +2362,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	}
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	return retval;
 }
 
@@ -2397,6 +2401,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	kernfs_break_active_protection(of->kn);
 	flush_work(&cpuset_hotplug_work);
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2422,6 +2427,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	free_cpuset(trialcs);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
 	flush_workqueue(cpuset_migrate_mm_wq);
@@ -2552,6 +2558,7 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 		return -EINVAL;
 
 	css_get(&cs->css);
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
@@ -2559,6 +2566,7 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 	retval = update_prstate(cs, val);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	css_put(&cs->css);
 	return retval ?: nbytes;
 }
@@ -2764,6 +2772,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	if (!parent)
 		return 0;
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 
 	set_bit(CS_ONLINE, &cs->flags);
@@ -2816,6 +2825,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	spin_unlock_irq(&callback_lock);
 out_unlock:
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 	return 0;
 }
 
@@ -2834,6 +2844,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
+	get_online_cpus();
 	percpu_down_write(&cpuset_rwsem);
 
 	if (is_partition_root(cs))
@@ -2854,6 +2865,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	clear_bit(CS_ONLINE, &cs->flags);
 
 	percpu_up_write(&cpuset_rwsem);
+	put_online_cpus();
 }
 
 static void cpuset_css_free(struct cgroup_subsys_state *css)
-- 
2.17.2

