Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A4B0241
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2019 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbfIKQ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Sep 2019 12:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfIKQ5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:57:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 181183082B45;
        Wed, 11 Sep 2019 16:57:36 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-113.phx2.redhat.com [10.3.117.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D45860BEC;
        Wed, 11 Sep 2019 16:57:30 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH RT v3 0/5] RCU fixes
Date:   Wed, 11 Sep 2019 17:57:24 +0100
Message-Id: <20190911165729.11178-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 11 Sep 2019 16:57:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With these patches, rcutorture works on PREEMPT_RT_FULL.

Scott Wood (5):
  rcu: Acquire RCU lock when disabling BHs
  sched: Rename sleeping_lock to rt_invol_sleep
  sched: migrate_dis/enable: Use rt_invol_sleep
  rcu: Disable use_softirq on PREEMPT_RT
  rcutorture: Avoid problematic critical section nesting

 include/linux/rcupdate.h   | 40 +++++++++++++++----
 include/linux/sched.h      | 19 ++++-----
 kernel/cpu.c               |  2 +
 kernel/locking/rtmutex.c   | 14 +++----
 kernel/locking/rwlock-rt.c | 16 ++++----
 kernel/rcu/rcutorture.c    | 96 +++++++++++++++++++++++++++++++++++++++-------
 kernel/rcu/tree.c          |  9 ++++-
 kernel/rcu/tree_plugin.h   |  8 ++--
 kernel/sched/core.c        |  4 ++
 kernel/softirq.c           | 14 +++++--
 kernel/time/hrtimer.c      |  4 +-
 11 files changed, 168 insertions(+), 58 deletions(-)

-- 
1.8.3.1

