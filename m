Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD715FB49
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 01:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBOADq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 19:03:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgBOADp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:03:45 -0500
Received: from paulmck-ThinkPad-P72.c.hoisthospitality.com (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5AC217F4;
        Sat, 15 Feb 2020 00:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725025;
        bh=13j0NPOr5vBp1ezTZptPTV/PU6uJALEN//ojIKeUz+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1in78FLM4ukIufgC6fi/2twMXjXXxdFnOW6YkboMdLl7Ue+ImCw+kd08bhh/10uJX
         M58LdHCFJYlukyji4z0K87vm6jGz/ADzDQAEGQcSsmjDsdmZAT4Kb7XyZzR01VOfS5
         7M22/tgcVJ1u/4IGaBTNPfmDJ7/jE5xBc7ECWrpY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH tip/core/rcu 1/4] locktorture: Print ratio of acquisitions, not failures
Date:   Fri, 14 Feb 2020 16:03:34 -0800
Message-Id: <20200215000337.14667-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200215000312.GA14585@paulmck-ThinkPad-P72>
References: <20200215000312.GA14585@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The __torture_print_stats() function in locktorture.c carefully
initializes local variable "min" to statp[0].n_lock_acquired, but
then compares it to statp[i].n_lock_fail.  Given that the .n_lock_fail
field should normally be zero, and given the initialization, it seems
reasonable to display the maximum and minimum number acquisitions
instead of miscomputing the maximum and minimum number of failures.
This commit therefore switches from failures to acquisitions.

And this turns out to be not only a day-zero bug, but entirely my
own fault.  I hate it when that happens!

Fixes: 0af3fe1efa53 ("locktorture: Add a lock-torture kernel module")
Reported-by: Will Deacon <will@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/locktorture.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 99475a6..687c1d8 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -696,10 +696,10 @@ static void __torture_print_stats(char *page,
 		if (statp[i].n_lock_fail)
 			fail = true;
 		sum += statp[i].n_lock_acquired;
-		if (max < statp[i].n_lock_fail)
-			max = statp[i].n_lock_fail;
-		if (min > statp[i].n_lock_fail)
-			min = statp[i].n_lock_fail;
+		if (max < statp[i].n_lock_acquired)
+			max = statp[i].n_lock_acquired;
+		if (min > statp[i].n_lock_acquired)
+			min = statp[i].n_lock_acquired;
 	}
 	page += sprintf(page,
 			"%s:  Total: %lld  Max/Min: %ld/%ld %s  Fail: %d %s\n",
-- 
2.9.5

