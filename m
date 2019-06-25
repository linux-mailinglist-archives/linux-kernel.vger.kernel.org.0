Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F60526C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 10:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfFYIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 04:35:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47023 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfFYIfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:35:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8Z1En3531643
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:35:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8Z1En3531643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451703;
        bh=HCAO6roazkNZMaGrSuAF+672v1vmQg8+7OQL3VI7z3I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=s4nJCU7zxPLQEpiYZAcKAFoOSUckKdXVISe+q39dLS/Q9v9D2lLCqtE2nikyr6H85
         yWJFsWem9PpUDQX7Qzc6HGcM6DDEB/pTqJDhbofRBzR1jd0ajiRrXShztm7iGJ/g8H
         hNtUb+03jXy0DN2lZxMCNyKU5nmTRpY7ecHPd7Zn2Zo9MKc4lp9bfr7Tw2SuSxCVrN
         5anEYfmZekWj685AlaA/I7ZQ6BgrziHdK+JlSmdo1TS0IUF2PP6XbjGQcQwZX8sshP
         cC9uC34sV4/j1ZtTW2d/TZoDyYqrpkfb2qY4y1rIjBgSC4KF4pCuJ3SQ4o5AkvASqB
         mWm0tLIF9NRCw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8Z1nu3531612;
        Tue, 25 Jun 2019 01:35:01 -0700
Date:   Tue, 25 Jun 2019 01:35:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-1a00d999971c78ab024a17b0efc37d78404dd120@git.kernel.org>
Cc:     quentin.perret@arm.com, tglx@linutronix.de, smuckle@google.com,
        peterz@infradead.org, surenb@google.com, tj@kernel.org,
        torvalds@linux-foundation.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, patrick.bellasi@arm.com,
        tkjos@google.com, joelaf@google.com, vincent.guittot@linaro.org,
        hpa@zytor.com, morten.rasmussen@arm.com, balsini@android.com,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, pjt@google.com, mingo@kernel.org
Reply-To: tj@kernel.org, surenb@google.com, juri.lelli@redhat.com,
          torvalds@linux-foundation.org, dietmar.eggemann@arm.com,
          patrick.bellasi@arm.com, tkjos@google.com, joelaf@google.com,
          quentin.perret@arm.com, tglx@linutronix.de, smuckle@google.com,
          peterz@infradead.org, viresh.kumar@linaro.org,
          linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
          pjt@google.com, mingo@kernel.org, vincent.guittot@linaro.org,
          morten.rasmussen@arm.com, hpa@zytor.com, balsini@android.com
In-Reply-To: <20190621084217.8167-9-patrick.bellasi@arm.com>
References: <20190621084217.8167-9-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/uclamp: Set default clamps for RT tasks
Git-Commit-ID: 1a00d999971c78ab024a17b0efc37d78404dd120
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1a00d999971c78ab024a17b0efc37d78404dd120
Gitweb:     https://git.kernel.org/tip/1a00d999971c78ab024a17b0efc37d78404dd120
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:09 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:47 +0200

sched/uclamp: Set default clamps for RT tasks

By default FAIR tasks start without clamps, i.e. neither boosted nor
capped, and they run at the best frequency matching their utilization
demand.  This default behavior does not fit RT tasks which instead are
expected to run at the maximum available frequency, if not otherwise
required by explicitly capping them.

Enforce the correct behavior for RT tasks by setting util_min to max
whenever:

 1. the task is switched to the RT class and it does not already have a
    user-defined clamp value assigned.

 2. an RT task is forked from a parent with RESET_ON_FORK set.

NOTE: utilization clamp values are cross scheduling class attributes and
thus they are never changed/reset once a value has been explicitly
defined from user-space.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alessio Balsini <balsini@android.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20190621084217.8167-9-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ecc304ab906f..6cd5133f0c2a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1062,6 +1062,27 @@ static int uclamp_validate(struct task_struct *p,
 static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr)
 {
+	unsigned int clamp_id;
+
+	/*
+	 * On scheduling class change, reset to default clamps for tasks
+	 * without a task-specific value.
+	 */
+	for_each_clamp_id(clamp_id) {
+		struct uclamp_se *uc_se = &p->uclamp_req[clamp_id];
+		unsigned int clamp_value = uclamp_none(clamp_id);
+
+		/* Keep using defined clamps across class changes */
+		if (uc_se->user_defined)
+			continue;
+
+		/* By default, RT tasks always get 100% boost */
+		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
+			clamp_value = uclamp_none(UCLAMP_MAX);
+
+		uclamp_se_set(uc_se, clamp_value, false);
+	}
+
 	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
 		return;
 
@@ -1087,8 +1108,13 @@ static void uclamp_fork(struct task_struct *p)
 		return;
 
 	for_each_clamp_id(clamp_id) {
-		uclamp_se_set(&p->uclamp_req[clamp_id],
-			      uclamp_none(clamp_id), false);
+		unsigned int clamp_value = uclamp_none(clamp_id);
+
+		/* By default, RT tasks always get 100% boost */
+		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
+			clamp_value = uclamp_none(UCLAMP_MAX);
+
+		uclamp_se_set(&p->uclamp_req[clamp_id], clamp_value, false);
 	}
 }
 
