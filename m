Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1597753BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 18:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbfGYQUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 12:20:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39197 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387564AbfGYQUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:20:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PGJjOX1075825
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:19:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PGJjOX1075825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564071586;
        bh=3vavAncPZC5FEVF6GaaF5P3eu8gVu5cP7GVPBJ8PAEA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VhwdTYOs+m5EJdVWkwK6b0WelfaQF8vqbfmoeeBy+rAqTVpMPiBSXrY3jRkqhj7FI
         pr7/sgW9AS+KdhzJxt4pmpliGV4xIV0E1IsJCcvD9S6VLsSJmKUBarMmyQRzzK9D2C
         o8ehyINYG48kR1blLiQaf2EvHQdA6hEJy+oqLWLzbD1w4cutHYBf5/kYtNK6a0cSS/
         ViG1EQGGSVZ47zHZd4sYWSoa9+ZGOc8EYk99p0eQmDVCORUggOiVYcPSQRSIfK89IS
         kN2zHdD9bEuBaosdgX/+8adffzOa8qmYcUP6NdDxUhuQ2KEueBfnGYB/IBqJk4qTo7
         eG8PVQZo7u/QA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PGJjCb1075822;
        Thu, 25 Jul 2019 09:19:45 -0700
Date:   Thu, 25 Jul 2019 09:19:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-c22645f4c8f021fb1c5e7189eb1f968132cc0844@git.kernel.org>
Cc:     torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org, tj@kernel.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org
Reply-To: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
          hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de,
          dietmar.eggemann@arm.com, tj@kernel.org
In-Reply-To: <20190719140000.31694-2-juri.lelli@redhat.com>
References: <20190719140000.31694-2-juri.lelli@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Add
 partition_sched_domains_locked()
Git-Commit-ID: c22645f4c8f021fb1c5e7189eb1f968132cc0844
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c22645f4c8f021fb1c5e7189eb1f968132cc0844
Gitweb:     https://git.kernel.org/tip/c22645f4c8f021fb1c5e7189eb1f968132cc0844
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Fri, 19 Jul 2019 15:59:53 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:51:57 +0200

sched/topology: Add partition_sched_domains_locked()

Introduce the partition_sched_domains_locked() function by taking
the mutex locking code out of the original function.  That way
the work done by partition_sched_domains_locked() can be reused
without dropping the mutex lock.

No change of functionality is introduced by this patch.

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bristot@redhat.com
Cc: claudio@evidence.eu.com
Cc: lizefan@huawei.com
Cc: longman@redhat.com
Cc: luca.abeni@santannapisa.it
Cc: rostedt@goodmis.org
Cc: tommaso.cucinotta@santannapisa.it
Link: https://lkml.kernel.org/r/20190719140000.31694-2-juri.lelli@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched/topology.h | 10 ++++++++++
 kernel/sched/topology.c        | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7863bb62d2ab..f341163fedc9 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -150,6 +150,10 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void partition_sched_domains_locked(int ndoms_new,
+					   cpumask_var_t doms_new[],
+					   struct sched_domain_attr *dattr_new);
+
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -194,6 +198,12 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
 
 struct sched_domain_attr;
 
+static inline void
+partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+			       struct sched_domain_attr *dattr_new)
+{
+}
+
 static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4eea2c9bc732..5a174ae6ecf3 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2169,16 +2169,16 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  * ndoms_new == 0 is a special case for destroying existing domains,
  * and it will not create the default domain.
  *
- * Call with hotplug lock held
+ * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-			     struct sched_domain_attr *dattr_new)
+void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
 {
 	bool __maybe_unused has_eas = false;
 	int i, j, n;
 	int new_topology;
 
-	mutex_lock(&sched_domains_mutex);
+	lockdep_assert_held(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
 	unregister_sched_domain_sysctl();
@@ -2261,6 +2261,15 @@ match3:
 	ndoms_cur = ndoms_new;
 
 	register_sched_domain_sysctl();
+}
 
+/*
+ * Call with hotplug lock held
+ */
+void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	mutex_unlock(&sched_domains_mutex);
 }
