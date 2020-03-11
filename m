Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54386182089
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 19:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730791AbgCKSQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Mar 2020 14:16:51 -0400
Received: from foss.arm.com ([217.140.110.172]:53188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbgCKSQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:16:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2C287FA;
        Wed, 11 Mar 2020 11:16:50 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AEA13F6CF;
        Wed, 11 Mar 2020 11:16:50 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: [PATCH v2 1/9] sched/fair: find_idlest_group(): Remove unused sd_flag parameter
Date:   Wed, 11 Mar 2020 18:15:53 +0000
Message-Id: <20200311181601.18314-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200311181601.18314-1-valentin.schneider@arm.com>
References: <20200311181601.18314-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last use of that parameter was removed by commit

  57abff067a08 ("sched/fair: Rework find_idlest_group()")

Get rid of the parameter.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..1c3311277fb3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5782,8 +5782,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 }
 
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag);
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 
 /*
  * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
@@ -5866,7 +5865,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		group = find_idlest_group(sd, p, cpu, sd_flag);
+		group = find_idlest_group(sd, p, cpu);
 		if (!group) {
 			sd = sd->child;
 			continue;
@@ -8624,8 +8623,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * Assumes p is allowed on at least one CPU in sd.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag)
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 {
 	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
 	struct sg_lb_stats local_sgs, tmp_sgs;
-- 
2.24.0

