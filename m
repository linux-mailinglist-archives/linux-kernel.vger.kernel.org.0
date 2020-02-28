Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB73173CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgB1QcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Feb 2020 11:32:07 -0500
Received: from foss.arm.com ([217.140.110.172]:41066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgB1QcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:32:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B11FEC;
        Fri, 28 Feb 2020 08:32:06 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B62F3F73B;
        Fri, 28 Feb 2020 08:32:05 -0800 (PST)
Date:   Fri, 28 Feb 2020 16:32:03 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380
 enqueue_task_fair+0x328/0x440
Message-ID: <20200228163202.aebqzo6n363oqdg5@e107158-lin.cambridge.arm.com>
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com>
 <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com>
 <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
 <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com>
 <1a607a98-f12a-77bd-2062-c3e599614331@de.ibm.com>
 <CAKfTPtBZ2X8i6zMgrA1gNJmwoSnyRc76yXmLZEwboJmF-R9QVg@mail.gmail.com>
 <b664f050-72d6-a483-be0a-8504f687f225@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b664f050-72d6-a483-be0a-8504f687f225@de.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28/20 16:42, Christian Borntraeger wrote:
> 
> 
> On 28.02.20 16:37, Vincent Guittot wrote:
> > On Fri, 28 Feb 2020 at 16:08, Christian Borntraeger
> > <borntraeger@de.ibm.com> wrote:
> >>
> >> Also happened with 5.4:
> >> Seems that I just happen to have an interesting test workload/system size interaction
> >> on a newly installed system that triggers this.
> > 
> > you will probably go back to 5.1 which is the version where we put
> > back the deletion of unused cfs_rq from the list which can trigger the
> > warning:
> > commit 039ae8bcf7a5 : (Fix O(nr_cgroups) in the load balancing path)
> > 
> > AFAICT, we haven't changed this since
> 
> So you do know what is the problem? If not is there any debug option or
> patch that I could apply to give you more information?
> 

It might be a long shot as I'm not particularly knowledgeable about this code
path, but could we be missing rcu_read_lock/unlock around the call to
unthrottle_cfs_rq() here?

---

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fc1dfc007604..56aa5cfbb7f1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7434,6 +7434,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)

        raw_spin_unlock_irq(&cfs_b->lock);

+       rcu_read_lock();
        for_each_online_cpu(i) {
                struct cfs_rq *cfs_rq = tg->cfs_rq[i];
                struct rq *rq = cfs_rq->rq;
@@ -7447,6 +7448,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
                        unthrottle_cfs_rq(cfs_rq);
                rq_unlock_irq(rq, &rf);
        }
+       rcu_read_unlock();
        if (runtime_was_enabled && !runtime_enabled)
                cfs_bandwidth_usage_dec();
 out_unlock:

