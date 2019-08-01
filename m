Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F2B7DF84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbfHAPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 11:55:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44633 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfHAPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:55:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71FtFSv005653
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 08:55:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71FtFSv005653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564674916;
        bh=76NIrjIvesy59Nd3IEmwdsY3tnoGCMVrjv+NstgvWvk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GdR5eM2h4oKlKqQ1Jt4LFJQWDdsiX99pXxru87Me74kFQr0+PkpMAyuTYY3YtRVVh
         6OpApZSDaVQpqHK91RFTH9V3rUWuPZJSsG9fQTqmOgKld7vabQeTtXpzYE8qZ4rPPF
         uWs7yz3aUGK3QaXPdfIC56oeOoz0mD/mOK0Vnw8Ng2borKVm7eKEWcGKx59e0N1OuE
         qevuQeD8irt6St4uZcLoquGrxd8Zrrf1rQafQs2H63CwONAadzx8hRbIUNhJckbGKh
         +XxwBXr36S5tOvujNkwsqJz/RzF5FMXoa5Z4r2EKpJje9Sbniawx5uP6wlTUpSmYXO
         N8e7yrZsM9XDw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71FtEcc005650;
        Thu, 1 Aug 2019 08:55:14 -0700
Date:   Thu, 1 Aug 2019 08:55:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-854bdb3cbde94bb953cd49942762b03e69ac3842@git.kernel.org>
Cc:     peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          peterz@infradead.org
In-Reply-To: <20190726185753.262895510@linutronix.de>
References: <20190726185753.262895510@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] watchdog: Mark watchdog_hrtimer to expire in hard
 interrupt context
Git-Commit-ID: 854bdb3cbde94bb953cd49942762b03e69ac3842
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  854bdb3cbde94bb953cd49942762b03e69ac3842
Gitweb:     https://git.kernel.org/tip/854bdb3cbde94bb953cd49942762b03e69ac3842
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 26 Jul 2019 20:30:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:43:18 +0200

watchdog: Mark watchdog_hrtimer to expire in hard interrupt context

The watchdog hrtimer must expire in hard interrupt context even on
PREEMPT_RT=y kernels as otherwise the hard/softlockup detection logic would
not work.

No functional change.

[ tglx: Split out from larger combo patch. Added changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190726185753.262895510@linutronix.de


---
 kernel/watchdog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7f9e7b9306fe..f41334ef0971 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -490,10 +490,10 @@ static void watchdog_enable(unsigned int cpu)
 	 * Start the timer first to prevent the NMI watchdog triggering
 	 * before the timer has a chance to fire.
 	 */
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	hrtimer->function = watchdog_timer_fn;
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 
 	/* Initialize timestamp */
 	__touch_watchdog();
