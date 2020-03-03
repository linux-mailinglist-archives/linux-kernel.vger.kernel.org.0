Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164EF1774F3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 12:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgCCLDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 06:03:23 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:52045 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728452AbgCCLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:03:22 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 2382A1C3453
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 11:03:21 +0000 (GMT)
Received: (qmail 14225 invoked from network); 3 Mar 2020 11:03:20 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 3 Mar 2020 11:03:20 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paul McKenney <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/3] sched/fair: Fix statistics for find_idlest_group()
Date:   Tue,  3 Mar 2020 11:02:56 +0000
Message-Id: <20200303110258.1092-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303110258.1092-1-mgorman@techsingularity.net>
References: <20200303110258.1092-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Guittot <vincent.guittot@linaro.org>

From: Vincent Guittot <vincent.guittot@linaro.org>

sgs->group_weight is not set while gathering statistics in
update_sg_wakeup_stats(). This means that a group can be classified as
fully busy with 0 running tasks if utilization is high enough.

This path is mainly used for fork and exec.

Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20200218144534.4564-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fcc968669aea..4b5d5e5e701e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8561,6 +8561,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 
 	sgs->group_capacity = group->sgc->capacity;
 
+	sgs->group_weight = group->group_weight;
+
 	sgs->group_type = group_classify(sd->imbalance_pct, group, sgs);
 
 	/*
-- 
2.16.4

