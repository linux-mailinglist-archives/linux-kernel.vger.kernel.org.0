Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E7526BE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2019 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfFYIfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jun 2019 04:35:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55531 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:35:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8YJ8g3531510
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:34:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8YJ8g3531510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451660;
        bh=fiP9agSJnu7+gpj/PqGK/hhgB0/v2ahUu3gAqA2yZws=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=KNzfVUUpbaQpFdTtIxtMX1cK5+X/yGbhNZcTzZkit5EsskbZgg1lwi3eIBFJ0v2Tb
         ZH4ZuTpdZdnZp9Xetw7PPtkBU84jjvaOqVyxNBI1wTsAXflufBWPLfwxAJq3g3dt5v
         1DEaXH4KmKFSXtviOknjftIH93cYjl6+xofLY5hBbcRUwXJgNs91N/8ODAfkt7E6Fh
         3+Y2rPqew0YgNtbdYKvg+toE9fMLFdXEZeDYKUW3KhOYpkT13zJX3BPQcq7LQkBqp2
         iJN79w/Pk4lmYvkYkMsWBLs0nVltIGpaeiQgbDIEMpvUPugNieT7T2KR33vPTelDUO
         xS4LtM5xobuig==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8YJKp3531507;
        Tue, 25 Jun 2019 01:34:19 -0700
Date:   Tue, 25 Jun 2019 01:34:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-a87498ace58e23b62a572dc7267579ede4c8495c@git.kernel.org>
Cc:     viresh.kumar@linaro.org, hpa@zytor.com, pjt@google.com,
        vincent.guittot@linaro.org, tkjos@google.com,
        linux-kernel@vger.kernel.org, smuckle@google.com,
        peterz@infradead.org, mingo@kernel.org, joelaf@google.com,
        tglx@linutronix.de, dietmar.eggemann@arm.com, balsini@android.com,
        quentin.perret@arm.com, patrick.bellasi@arm.com,
        morten.rasmussen@arm.com, rafael.j.wysocki@intel.com,
        tj@kernel.org, juri.lelli@redhat.com, surenb@google.com,
        torvalds@linux-foundation.org
Reply-To: dietmar.eggemann@arm.com, balsini@android.com,
          tglx@linutronix.de, morten.rasmussen@arm.com,
          quentin.perret@arm.com, patrick.bellasi@arm.com,
          rafael.j.wysocki@intel.com, tj@kernel.org, juri.lelli@redhat.com,
          surenb@google.com, torvalds@linux-foundation.org,
          viresh.kumar@linaro.org, hpa@zytor.com, pjt@google.com,
          vincent.guittot@linaro.org, tkjos@google.com, smuckle@google.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, joelaf@google.com
In-Reply-To: <20190621084217.8167-8-patrick.bellasi@arm.com>
References: <20190621084217.8167-8-patrick.bellasi@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/uclamp: Reset uclamp values on RESET_ON_FORK
Git-Commit-ID: a87498ace58e23b62a572dc7267579ede4c8495c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a87498ace58e23b62a572dc7267579ede4c8495c
Gitweb:     https://git.kernel.org/tip/a87498ace58e23b62a572dc7267579ede4c8495c
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Fri, 21 Jun 2019 09:42:08 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:47 +0200

sched/uclamp: Reset uclamp values on RESET_ON_FORK

A forked tasks gets the same clamp values of its parent however, when
the RESET_ON_FORK flag is set on parent, e.g. via:

   sys_sched_setattr()
      sched_setattr()
         __sched_setscheduler(attr::SCHED_FLAG_RESET_ON_FORK)

the new forked task is expected to start with all attributes reset to
default values.

Do that for utilization clamp values too by checking the reset request
from the existing uclamp_fork() call which already provides the required
initialization for other uclamp related bits.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alessio Balsini <balsini@android.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Paul Turner <pjt@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Link: https://lkml.kernel.org/r/20190621084217.8167-8-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e9a669266fa9..ecc304ab906f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1082,6 +1082,14 @@ static void uclamp_fork(struct task_struct *p)
 
 	for_each_clamp_id(clamp_id)
 		p->uclamp[clamp_id].active = false;
+
+	if (likely(!p->sched_reset_on_fork))
+		return;
+
+	for_each_clamp_id(clamp_id) {
+		uclamp_se_set(&p->uclamp_req[clamp_id],
+			      uclamp_none(clamp_id), false);
+	}
 }
 
 static void __init init_uclamp(void)
