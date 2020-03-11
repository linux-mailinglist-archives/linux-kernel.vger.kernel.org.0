Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 037CF182090
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 19:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbgCKSRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 14:17:07 -0400
Received: from foss.arm.com ([217.140.110.172]:53264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730843AbgCKSRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:17:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6022A1045;
        Wed, 11 Mar 2020 11:17:05 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7C7223F6CF;
        Wed, 11 Mar 2020 11:17:04 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v2 8/9] sched/fair: Split select_task_rq_fair want_affine logic
Date:   Wed, 11 Mar 2020 18:16:00 +0000
Message-Id: <20200311181601.18314-9-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200311181601.18314-1-valentin.schneider@arm.com>
References: <20200311181601.18314-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The domain loop within select_task_rq_fair() depends on a few bits of
input, namely the SD flag we're looking for and whether we want_affine.

For !want_affine, the domain loop will walk up the hierarchy to reach the
highest domain with the requested sd_flag (SD_BALANCE_{WAKE, FORK, EXEC})
set. In other words, that's a call to highest_flag_domain().
Note that this is a static information wrt a given SD hierarchy, so we can
cache that - but that comes in a later patch to ease reviewing.

For want_affine, we'll walk up the hierarchy to reach the first domain with
SD_LOAD_BALANCE, SD_WAKE_AFFINE, and that spans the tasks's prev_cpu.  We
still save a pointer to the last visited domain that had the requested
sd_flag set, which means that if we fail to go through the affine
condition (e.g. no domain had SD_WAKE_AFFINE) we'll use the same SD as we
would have found if we had !want_affine.

Split the domain loop in !want_affine and want_affine paths. As it is,
this leads to two domain walks instead of a single one, but stay tuned for
the next patch.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f98dac0c7f82..a6fca6817e92 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6620,26 +6620,33 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	}
 
 	rcu_read_lock();
+
+	sd = highest_flag_domain(cpu, sd_flag);
+
+	/*
+	 * If !want_affine, we just look for the highest domain where
+	 * sd_flag is set.
+	 */
+	if (!want_affine)
+		goto scan;
+
+	/*
+	 * Otherwise we look for the lowest domain with SD_WAKE_AFFINE and that
+	 * spans both 'cpu' and 'prev_cpu'.
+	 */
 	for_each_domain(cpu, tmp) {
-		/*
-		 * If both 'cpu' and 'prev_cpu' are part of this domain,
-		 * cpu is a valid SD_WAKE_AFFINE target.
-		 */
-		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
+		if ((tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
 			if (cpu != prev_cpu)
 				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
 
-			sd = NULL; /* Prefer wake_affine over balance flags */
+			/* Prefer wake_affine over SD lookup */
+			sd = NULL;
 			break;
 		}
-
-		if (tmp->flags & sd_flag)
-			sd = tmp;
-		else if (!want_affine)
-			break;
 	}
 
+scan:
 	if (unlikely(sd)) {
 		/* Slow path */
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
-- 
2.24.0

