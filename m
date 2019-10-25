Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F077CE4157
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 04:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389703AbfJYCDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 22:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389657AbfJYCDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:03:11 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B43321929;
        Fri, 25 Oct 2019 02:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571968989;
        bh=RU2jcOFbNMVgSwsqFfCLTfXF+sdcXqGu7Jpw7yqMKAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=me0ybjEJ5+t6wajK6bYAJOI65Y8y2TidBH0CpkMubV57cY9zCfb9xo0NCqAayf7iS
         wraH0zyT3Jv0C2twNQoxAfmAnjThi/ARkjgcUz4KuyCRl7BVMa+OSpkJreZSUhnxIB
         MWORDY5tGkfAnFB5fMTlE0iAhkTwctiHdej7ywU0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 11/14 v2] sched/kcpustat: Introduce vtime-aware kcpustat accessor for CPUTIME_SYSTEM
Date:   Fri, 25 Oct 2019 04:03:03 +0200
Message-Id: <20191025020303.19342-1-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-12-frederic@kernel.org>
References: <20191016025700.31277-12-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kcpustat is not correctly supported on nohz_full CPUs. The tick doesn't
fire and the cputime therefore doesn't move forward. The issue has shown
up after the vanishing of the remaining 1Hz which has made the stall
visible.

We are solving that with checking the task running on a CPU through RCU
and reading its vtime delta that we add to the raw kcpustat values.

We make sure that we fetch a coherent raw-kcpustat/vtime-delta couple
sequence while checking that the CPU referred by the target vtime is the
correct one, under the locked vtime seqcount.

Only CPUTIME_SYSTEM is handled here as a start because it's the trivial
case. User and guest time will require more preparation work to
correctly handle niceness.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kernel_stat.h | 11 +++++
 kernel/sched/cputime.c      | 82 +++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 7ee2bb43b251..79781196eb25 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -78,6 +78,17 @@ static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
 	return kstat_cpu(cpu).irqs_sum;
 }
 
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
+extern u64 kcpustat_field(struct kernel_cpustat *kcpustat,
+			  enum cpu_usage_stat usage, int cpu);
+#else
+static inline u64 kcpustat_field(struct kernel_cpustat *kcpustat,
+				 enum cpu_usage_stat usage, int cpu)
+{
+	return kcpustat->cpustat[usage];
+}
+#endif
+
 extern void account_user_time(struct task_struct *, u64);
 extern void account_guest_time(struct task_struct *, u64);
 extern void account_system_time(struct task_struct *, int, u64);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index b931a19df093..e0cd20693ef5 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -911,4 +911,86 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 			*utime += vtime->utime + delta;
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
+
+static int kcpustat_field_vtime(u64 *cpustat,
+				struct vtime *vtime,
+				enum cpu_usage_stat usage,
+				int cpu, u64 *val)
+{
+	unsigned int seq;
+	int err;
+
+	do {
+		seq = read_seqcount_begin(&vtime->seqcount);
+
+		/*
+		 * We raced against context switch, fetch the
+		 * kcpustat task again.
+		 */
+		if (vtime->cpu != cpu && vtime->cpu != -1)
+			return -EAGAIN;
+
+		/*
+		 * Two possible things here:
+		 * 1) We are seeing the scheduling out task (prev) or any past one.
+		 * 2) We are seeing the scheduling in task (next) but it hasn't
+		 *    passed though vtime_task_switch() yet so the pending
+		 *    cputime of the prev task may not be flushed yet.
+		 *
+		 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
+		 */
+		if (vtime->state == VTIME_INACTIVE)
+			return -EAGAIN;
+
+		err = 0;
+
+		*val = cpustat[usage];
+
+		if (vtime->state == VTIME_SYS)
+			*val += vtime->stime + vtime_delta(vtime);
+
+	} while (read_seqcount_retry(&vtime->seqcount, seq));
+
+	return 0;
+}
+
+u64 kcpustat_field(struct kernel_cpustat *kcpustat,
+		   enum cpu_usage_stat usage, int cpu)
+{
+	u64 *cpustat = kcpustat->cpustat;
+	struct rq *rq;
+	u64 val;
+	int err;
+
+	if (!vtime_accounting_enabled_cpu(cpu))
+		return cpustat[usage];
+
+	/* Only support sys vtime for now */
+	if (usage != CPUTIME_SYSTEM)
+		return cpustat[usage];
+
+	rq = cpu_rq(cpu);
+
+	for (;;) {
+		struct task_struct *curr;
+		struct vtime *vtime;
+
+		rcu_read_lock();
+		curr = rcu_dereference(rq->curr);
+		if (WARN_ON_ONCE(!curr)) {
+			rcu_read_unlock();
+			return cpustat[usage];
+		}
+
+		vtime = &curr->vtime;
+		err = kcpustat_field_vtime(cpustat, vtime, usage, cpu, &val);
+		rcu_read_unlock();
+
+		if (!err)
+			return val;
+
+		cpu_relax();
+	}
+}
+EXPORT_SYMBOL_GPL(kcpustat_field);
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-- 
2.23.0

