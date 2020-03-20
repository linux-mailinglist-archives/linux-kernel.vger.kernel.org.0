Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91918CEB3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 14:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCTNVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 09:21:46 -0400
Received: from foss.arm.com ([217.140.110.172]:48904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgCTNVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:21:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 351367FA;
        Fri, 20 Mar 2020 06:21:45 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 483593F85E;
        Fri, 20 Mar 2020 06:21:44 -0700 (PDT)
From:   vincent.donnefort@arm.com
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH] sched: Remove unused last_load_update_tick rq member
Date:   Fri, 20 Mar 2020 13:21:35 +0000
Message-Id: <1584710495-308969-1-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Donnefort <vincent.donnefort@arm.com>

The commit 5e83eafbfd3b ("sched/fair: Remove the rq->cpu_load[] update
code") eliminated the use case for rq->last_load_update_tick. Removing
it.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a9983d..c41ee26 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6685,7 +6685,6 @@ void __init sched_init(void)
 
 		rq_attach_root(rq, &def_root_domain);
 #ifdef CONFIG_NO_HZ_COMMON
-		rq->last_load_update_tick = jiffies;
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9ea6478..6e14fad 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -860,7 +860,6 @@ struct rq {
 #endif
 #ifdef CONFIG_NO_HZ_COMMON
 #ifdef CONFIG_SMP
-	unsigned long		last_load_update_tick;
 	unsigned long		last_blocked_load_update_tick;
 	unsigned int		has_blocked_load;
 #endif /* CONFIG_SMP */
-- 
2.7.4

