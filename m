Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0E695730
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfHTGOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 02:14:40 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37712 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbfHTGOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:14:40 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id AE5EA20B7188; Mon, 19 Aug 2019 23:14:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE5EA20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1566281679;
        bh=irR5tenrmHwMixa4DhE9mKUf8q1VdVSaHTLm1Tuq9yA=;
        h=From:To:Cc:Subject:Date:From;
        b=cuZpaUG5UeYZabz6oj8RDw5nXWLrMKQlGvwqEH61vpCcMvvbx+jn98by0EUpmUT6a
         zcb4blqVOXkVebSjaczWLBjfWMWtR/mbapJcKNSpir7WhOaZdS/KrYKp3XAEnsHhyQ
         uq6RDsIUM90aYLW8/6RLLIqSl+EWGZjcVXalIyW0=
From:   longli@linuxonhyperv.com
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH 0/3] fix interrupt swamp in NVMe
Date:   Mon, 19 Aug 2019 23:14:26 -0700
Message-Id: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

This patch set tries to fix interrupt swamp in NVMe devices.

On large systems with many CPUs, a number of CPUs may share one NVMe hardware
queue. It may have this situation where several CPUs are issuing I/Os, and
all the I/Os are returned on the CPU where the hardware queue is bound to.
This may result in that CPU swamped by interrupts and stay in interrupt mode
for extended time while other CPUs continue to issue I/O. This can trigger
Watchdog and RCU timeout, and make the system unresponsive.

This patch set addresses this by enforcing scheduling and throttling I/O when
CPU is starved in this situation.

Long Li (3):
  sched: define a function to report the number of context switches on a
    CPU
  sched: export idle_cpu()
  nvme: complete request in work queue on CPU with flooded interrupts

 drivers/nvme/host/core.c | 57 +++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 include/linux/sched.h    |  2 ++
 kernel/sched/core.c      |  7 +++++
 4 files changed, 66 insertions(+), 1 deletion(-)

-- 
2.17.1

