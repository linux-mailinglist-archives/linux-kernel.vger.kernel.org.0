Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E370B9964
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 23:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfITV4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 17:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729702AbfITV4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:56:23 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B039206C2;
        Fri, 20 Sep 2019 21:56:22 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1iBQt3-0005Gs-CH; Fri, 20 Sep 2019 17:56:21 -0400
Message-Id: <20190920215311.165260719@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 20 Sep 2019 17:53:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>, tom.zanussi@linux.intel.com
Subject: [RFC][PATCH RT 0/7] Revert of simple work, and backport workqueue rework
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to backport some of the fixes done in upstream RT, I need
to revert the simple work code and incorporate the work queue rework
that was done in rt-devel. I originally thought this crashed under
stress test (as I reported in the stable meeting), but found that
the system booted a different kernel that had known issues. 4.19-rt with
these patches have passed all my tests. But before posting an rc1, 
I was hoping to get some people to look it over and perhaps even test
it some to make sure there's not any issues here.

The reason I'm doing this is that this goes beyond the stable scope
for 4.19-rt, but I believe it is still necessary.

-- Steve



Daniel Wagner (1):
      thermal: Defer thermal wakups to threads

Sebastian Andrzej Siewior (3):
      fs/aio: simple simple work
      block: blk-mq: move blk_queue_usage_counter_release() into process context
      workqueue: rework

Steven Rostedt (VMware) (3):
      revert-aio
      revert-thermal
      revert-block

----
 block/blk-core.c                       |  10 +-
 drivers/block/loop.c                   |   2 +-
 drivers/spi/spi-rockchip.c             |   1 -
 drivers/thermal/x86_pkg_temp_thermal.c |  52 +-----
 fs/aio.c                               |  12 +-
 include/linux/blk-cgroup.h             |   2 +-
 include/linux/blkdev.h                 |   4 +-
 include/linux/interrupt.h              |   5 -
 include/linux/kthread-cgroup.h         |  17 --
 include/linux/kthread.h                |  15 +-
 include/linux/swait.h                  |  14 ++
 include/linux/workqueue.h              |   4 -
 init/main.c                            |   1 -
 kernel/irq/manage.c                    |  36 +---
 kernel/kthread.c                       |  14 --
 kernel/sched/core.c                    |   1 +
 kernel/time/hrtimer.c                  |  24 ---
 kernel/workqueue.c                     | 300 ++++++++++++++-------------------
 18 files changed, 168 insertions(+), 346 deletions(-)
 delete mode 100644 include/linux/kthread-cgroup.h
