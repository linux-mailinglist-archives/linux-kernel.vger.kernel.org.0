Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBE895732
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 08:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfHTGOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Aug 2019 02:14:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37832 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfHTGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:14:50 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 663C820B7195; Mon, 19 Aug 2019 23:14:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 663C820B7195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1566281689;
        bh=2Rkx1o6sWSNY21Q3MnNz1y4rcc7n1BW0NJRzScVJzSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNXF2VaEip8OvlyZdhnOxMPgL2MMdaGBG5sf8QGulyP7h4zd0gqGfoja+4kQ7Zm92
         Tlby/vtpIdQvo8AU0hccvMtO4XTEhpQ7tb+2Cw0Dkkog8OWU9kqiAegnC07oV75kzp
         UtAHGYhmAqIx7Lc4ctLsrXkZ9HCWQYx2ruNVqRpQ=
From:   longli@linuxonhyperv.com
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [PATCH 2/3] sched: export idle_cpu()
Date:   Mon, 19 Aug 2019 23:14:28 -0700
Message-Id: <1566281669-48212-3-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
References: <1566281669-48212-1-git-send-email-longli@linuxonhyperv.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

This function is useful for device drivers to check if this CPU has work to
do in process context.

Signed-off-by: Long Li <longli@microsoft.com>
---
 include/linux/sched.h | 1 +
 kernel/sched/core.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 575f1ef7b159..a209941c1770 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1501,6 +1501,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allowed);
 extern u64 get_cpu_rq_switches(int cpu);
+extern int idle_cpu(int cpu);
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a76f0e97c2d..d1cedfb38174 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4023,6 +4023,7 @@ int idle_cpu(int cpu)
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(idle_cpu);
 
 /**
  * available_idle_cpu - is a given CPU idle for enqueuing work.
-- 
2.17.1

