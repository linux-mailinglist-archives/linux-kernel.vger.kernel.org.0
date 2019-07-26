Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA07760B5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfGZI3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 04:29:35 -0400
Received: from foss.arm.com ([217.140.110.172]:39470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfGZI3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:29:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69DAF344;
        Fri, 26 Jul 2019 01:29:34 -0700 (PDT)
Received: from e107985-lin.arm.com (e107985-lin.cambridge.arm.com [10.1.194.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 402243F71A;
        Fri, 26 Jul 2019 01:29:33 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] sched/deadline: Fix double accounting in push_dl_task() & some cleanups
Date:   Fri, 26 Jul 2019 09:27:51 +0100
Message-Id: <20190726082756.5525-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running a simple DL workload (1 DL (12000, 100000, 100000) task
per CPU) on Arm64 & x86 systems I noticed that some of the
SCHED_WARN_ON() in the rq/running bandwidth (bw) functions trigger.
Patch 1/5 contains a proposal to fix this.

Patch 2-5/5 contain various smaller cleanups I discovered while
debugging the actual issue.

Dietmar Eggemann (5):
  sched/deadline: Fix double accounting of rq/running bw in
    push_dl_task()
  sched/deadline: Remove unused int flags from __dequeue_task_dl()
  sched/deadline: Use __sub_running_bw() throughout
    dl_change_utilization()
  sched/deadline: Cleanup on_dl_rq() handling
  sched/deadline: Use return value of SCHED_WARN_ON() in bw accounting

 kernel/sched/deadline.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

-- 
2.17.1

