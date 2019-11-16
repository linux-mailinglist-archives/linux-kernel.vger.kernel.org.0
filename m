Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C224FF5D0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2019 22:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfKPVdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Nov 2019 16:33:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56230 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPVdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 16:33:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so13439998wmb.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2019 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=owZTASE9Gi7Z7CfD/qTqWo13NQYy8n0G69xiMTlpZok=;
        b=LTqmq4f+RKCOtNLmmaXB6yfaZg/qqLOSgQSz/QIoWo102Srqyl0hY4DRnaTtFUhRlp
         z2mHyTRR0j+akQBlJ87g/y+E8/z+rlCjB7Isxx1OBlxqv94e5PcdJTLsoG2yYcshAUbP
         k4avzdj1WS0SlUT/dm2MqYE2tYMUTBdvYmJ9Db4XwFviiiWgrQhj5ijf3jI1tjfOIC+m
         LWccdWdkU98kvmdKXat784GobV6Lk134MmzOjtkaVxhi62VKreDy4OXjug6WUlFlRO/O
         MB4XZ9w7d6ctfVFosfpUIZtJw4a5tmMAgujACv7h6TyS1A7F+Z453O26adlxi1CYKZdO
         t8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=owZTASE9Gi7Z7CfD/qTqWo13NQYy8n0G69xiMTlpZok=;
        b=iWTqRnuexOpyNAdwbAlUnAzmtgXHwEQnrjR9xDiSWxsw77jtQ+FvwZ3tNLrlRPErR8
         tkwHyNa2bINHlnBxs/nOO1fyy7hJSf6xxnNj4ii8uicpD/uAtWBV4bYHc4eRYZzdrxcR
         LX6WatPJ1MXJ8m9Wc/lgaVExiFcvpD7vjuAu58C4FFrkItjNdYtwmdiC2Wxj4H6Q2CDy
         65230q8JKDKuM81qfmsg/wxcygv/H9WEv/oWXap+JIqngejHnW2GKNWmlEoq2mgNBExd
         3Qiq6t8Muyno1NtJ9mynOco7J8yyYv0/g7Gktyvj19VJPol0O8vzoef7QuKyRm77KmOt
         L1/g==
X-Gm-Message-State: APjAAAX+PDFv1AuE24amuwUDLOp4XMKIy3C7r/xczxvBv+AXCOeZ4EyU
        UJJuAqw8bryDS1Hq2sMm5AQYrIzV
X-Google-Smtp-Source: APXvYqwHLiwuB3OwwWvJJZSAbANU9jnuxNY7CTDbPspjPkJR7mCEj0iTXksfM65xf7uWA/WOIIdNQQ==
X-Received: by 2002:a1c:a404:: with SMTP id n4mr21150430wme.135.1573940015999;
        Sat, 16 Nov 2019 13:33:35 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i14sm3579254wrn.31.2019.11.16.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2019 13:33:35 -0800 (PST)
Date:   Sat, 16 Nov 2019 22:33:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [GIT PULL] perf fixes
Message-ID: <20191116213333.GA84250@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: d00dbd29814236ad128ff9517e8f7af6b6ef4ba0 perf/core: Fix missing static inline on perf_cgroup_switch()

Misc fixes: a handful of AUX event handling related fixes, a Sparse fix 
and two ABI fixes.

 Thanks,

	Ingo

------------------>
Alexander Shishkin (4):
      perf/aux: Fix the aux_output group inheritance fix
      perf/core: Reattach a misplaced comment
      perf/aux: Disallow aux_output for kernel events
      perf/core: Consistently fail fork on allocation failures

Ben Dooks (Codethink) (1):
      perf/core: Fix missing static inline on perf_cgroup_switch()

Peter Zijlstra (1):
      perf/core: Disallow uncore-cgroup events


 kernel/events/core.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aec8dba2bea4..00a014670ed0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1031,7 +1031,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 {
 }
 
-void
+static inline void
 perf_cgroup_switch(struct task_struct *task, struct task_struct *next)
 {
 }
@@ -10535,6 +10535,15 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		goto err_ns;
 	}
 
+	/*
+	 * Disallow uncore-cgroup events, they don't make sense as the cgroup will
+	 * be different on other CPUs in the uncore mask.
+	 */
+	if (pmu->task_ctx_nr == perf_invalid_context && cgroup_fd != -1) {
+		err = -EINVAL;
+		goto err_pmu;
+	}
+
 	if (event->attr.aux_output &&
 	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
 		err = -EOPNOTSUPP;
@@ -11323,8 +11332,11 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	int err;
 
 	/*
-	 * Get the target context (task or percpu):
+	 * Grouping is not supported for kernel events, neither is 'AUX',
+	 * make sure the caller's intentions are adjusted.
 	 */
+	if (attr->aux_output)
+		return ERR_PTR(-EINVAL);
 
 	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
 				 overflow_handler, context, -1);
@@ -11336,6 +11348,9 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	/* Mark owner so we could distinguish it from user events. */
 	event->owner = TASK_TOMBSTONE;
 
+	/*
+	 * Get the target context (task or percpu):
+	 */
 	ctx = find_get_context(event->pmu, task, event);
 	if (IS_ERR(ctx)) {
 		err = PTR_ERR(ctx);
@@ -11787,7 +11802,7 @@ inherit_event(struct perf_event *parent_event,
 						   GFP_KERNEL);
 		if (!child_ctx->task_ctx_data) {
 			free_event(child_event);
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 		}
 	}
 
@@ -11890,7 +11905,7 @@ static int inherit_group(struct perf_event *parent_event,
 		if (IS_ERR(child_ctr))
 			return PTR_ERR(child_ctr);
 
-		if (sub->aux_event == parent_event &&
+		if (sub->aux_event == parent_event && child_ctr &&
 		    !perf_get_aux_event(child_ctr, leader))
 			return -EINVAL;
 	}
