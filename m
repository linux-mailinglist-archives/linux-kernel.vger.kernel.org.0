Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7528A154BF7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 20:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgBFTUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 14:20:20 -0500
Received: from foss.arm.com ([217.140.110.172]:33686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgBFTUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:20:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B9B0101E;
        Thu,  6 Feb 2020 11:20:16 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42DC13F52E;
        Thu,  6 Feb 2020 11:20:15 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, adharmap@codeaurora.org,
        pkondeti@codeaurora.org
Subject: [PATCH v4 3/4] sched: Remove for_each_lower_domain()
Date:   Thu,  6 Feb 2020 19:19:56 +0000
Message-Id: <20200206191957.12325-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200206191957.12325-1-valentin.schneider@arm.com>
References: <20200206191957.12325-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last remaining user of this macro has just been removed, get rid of
it.

Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1a88dc8ad11b7..2f59e5ccd43ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1337,8 +1337,6 @@ extern void sched_ttwu_pending(void);
 	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
 			__sd; __sd = __sd->parent)
 
-#define for_each_lower_domain(sd) for (; sd; sd = sd->child)
-
 /**
  * highest_flag_domain - Return highest sched_domain containing flag.
  * @cpu:	The CPU whose highest level of sched domain is to
-- 
2.24.0

