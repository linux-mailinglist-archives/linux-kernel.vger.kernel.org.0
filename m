Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1F18D29B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 16:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgCTPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 11:13:30 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:52741 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726951AbgCTPNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:13:30 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 59CC91C3711
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 15:13:28 +0000 (GMT)
Received: (qmail 30708 invoked from network); 20 Mar 2020 15:13:28 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 20 Mar 2020 15:13:28 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 3/4] sched/fair: Clear SMT siblings after determining the core is not idle
Date:   Fri, 20 Mar 2020 15:12:44 +0000
Message-Id: <20200320151245.21152-4-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200320151245.21152-1-mgorman@techsingularity.net>
References: <20200320151245.21152-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clearing of SMT siblings from the SIS mask before checking for an idle
core is a small but unnecessary cost. Defer the clearing of the siblings
until the scan moves to the next potential target. The cost of this was
not measured as it is borderline noise but it should be self-evident.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7f4356c520be..41913fac68de 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6005,10 +6005,11 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 				break;
 			}
 		}
-		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 
 		if (idle)
 			return core;
+
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 	}
 
 	/*
-- 
2.16.4

