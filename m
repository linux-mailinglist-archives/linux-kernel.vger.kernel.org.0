Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBBA8EEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbfHOOv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 10:51:57 -0400
Received: from foss.arm.com ([217.140.110.172]:45152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfHOOv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:51:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83931360;
        Thu, 15 Aug 2019 07:51:56 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76BB73F706;
        Thu, 15 Aug 2019 07:51:55 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        tglx@linutronix.de, qais.yousef@arm.com
Subject: [PATCH v2 1/4] sched/fair: Make need_active_balance() return bools
Date:   Thu, 15 Aug 2019 15:51:04 +0100
Message-Id: <20190815145107.5318-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815145107.5318-1-valentin.schneider@arm.com>
References: <20190815145107.5318-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That function has no need to return ints, make it return bools.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1054d2cf6aaa..22be1ca8d117 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8734,12 +8734,12 @@ voluntary_active_balance(struct lb_env *env)
 	return 0;
 }
 
-static int need_active_balance(struct lb_env *env)
+static bool need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
 	if (voluntary_active_balance(env))
-		return 1;
+		return true;
 
 	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
 }
-- 
2.22.0

