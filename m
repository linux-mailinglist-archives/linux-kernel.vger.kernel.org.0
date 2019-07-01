Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC24AF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 03:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfFSBTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 21:19:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfFSBTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 21:19:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCB123082133;
        Wed, 19 Jun 2019 01:19:12 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-117-83.phx2.redhat.com [10.3.117.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 984F617C41;
        Wed, 19 Jun 2019 01:19:08 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RT 0/4] Address rcutorture issues
Date:   Tue, 18 Jun 2019 20:19:04 -0500
Message-Id: <20190619011908.25026-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 19 Jun 2019 01:19:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With these patches, rcutorture mostly works on PREEMPT_RT_FULL.  I still
once in a while get forward progress complaints (particularly,
rcu_torture_fwd_prog_cr) when a grace period is held up for a few seconds
after which point so many callbacks have been enqueued that even making
reasonable progress isn't going to beat the timeout.  I believe I've only
seen this when running heavy loads in addition to rcutorture (though I've
done more testing under load than without); I don't know whether the
forward progress tests are expected to work under such load.

Scott Wood (4):
  rcu: Acquire RCU lock when disabling BHs
  sched: migrate_enable: Use sleeping_lock to indicate involuntary sleep
  rcu: unlock special: Treat irq and preempt disabled the same
  rcutorture: Avoid problematic critical section nesting

 include/linux/rcupdate.h |  4 +++
 include/linux/sched.h    |  4 +--
 kernel/rcu/rcutorture.c  | 92 ++++++++++++++++++++++++++++++++++++++++--------
 kernel/rcu/tree_plugin.h | 12 ++-----
 kernel/rcu/update.c      |  4 +++
 kernel/sched/core.c      |  2 ++
 kernel/softirq.c         | 12 +++++--
 7 files changed, 102 insertions(+), 28 deletions(-)

-- 
1.8.3.1

