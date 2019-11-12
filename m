Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB2F92FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKLOsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 09:48:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37206 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfKLOsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:48:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so18840310wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 06:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VcaG2lDl8zjlKAxkjXFQbB9SbmB4BcbtNZh1LgjcepQ=;
        b=j6aIgkN6gaSzdGFkKmBCYQr7HPRXYhWKb52HobZdBOxVJODVcsk5osCVurJS2DZodK
         V1Pef7fEafO2EDIXcXVF4xzc+Kp5yegbKhQeNgJ6oemafqyKAGRsNxEgDX4zCAUlXG2a
         gXFFBv8lRTcC4p7p3vzZ5h2zfR8gjGRPezGQVNRQEOzxTGQ3R/kz+PzqS33UAH18ydYZ
         udg7LClJeZZZKEyK3K1sYaET4iFbjkvQfF/QscC9KBRTeF0qEYsTEZuqqXZf+1Po37ix
         Byc/ZqJ9z4D2Hu6WE3Y3a+GoEOUv0cYuYKsTLNanpo+IGkrKdEE1ZqvrJsPe3UVj5uHJ
         42jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VcaG2lDl8zjlKAxkjXFQbB9SbmB4BcbtNZh1LgjcepQ=;
        b=Jk0NIzHVKp7JA9nfpSRoCsXRRxxZJjwOqFDoHKkX8P8VJRSLkeZtd00iM3cqL0Ly3O
         ltREFJUY9qsY0vTX/oZaNAlVSfVsLKfy1X9ErivVAiSFNu+9gE4VCqPwqI2qgfvE5PyE
         V9BXuCKoF4j9Op0V9FAS4ZNSalI2Nfkdjx1spLr7PIErmNvN8779TVSWnk9zuEBqW6xN
         zf/p1RZQdaNB7+gIWtXuhcsj2xPYrZnOIqfyvMe6bY0AWjCb+E83kKWoOacyGOO0c0i6
         kIufemn62Xr+NkAQd64+ZtdXzIC3KlpN7TklmkB+p/pOKHAmgMyeD0cTDJybzv8liti9
         ExPw==
X-Gm-Message-State: APjAAAWlAbVvQT1SlifRpNdmlHkKrAshY9nOHk68wbcrzIEc0cla1c6+
        4HJrqKghtReMG3G+gk0tLagzf0/vqHw=
X-Google-Smtp-Source: APXvYqxNtzLwPhiiIlMv2HQakc2/gnSDvm2gBKGq3tzbCCtI8PaZaVwGqOL5Pq5t8cn+mpDn40qDgA==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr7820455wrp.265.1573570100407;
        Tue, 12 Nov 2019 06:48:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e45f:4180:5590:a312])
        by smtp.gmail.com with ESMTPSA id f17sm2924719wmj.40.2019.11.12.06.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 06:48:19 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, mgorman@suse.de,
        dsmythies@telus.net
Cc:     linux-pm@vger.kernel.or, torvalds@linux-foundation.org,
        tglx@linutronix.de, sargun@sargun.me, tj@kernel.org,
        xiexiuqi@huawei.com, xiezhipeng1@huawei.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/freq: move call to cpufreq_update_util
Date:   Tue, 12 Nov 2019 15:48:13 +0100
Message-Id: <1573570093-1340-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_cfs_rq_load_avg() calls cfs_rq_util_change() everytime pelt decays,
which might be inefficient when cpufreq driver has rate limitation.

When a task is attached on a CPU, we have call path:

update_blocked_averages()
  update_cfs_rq_load_avg()
    cfs_rq_util_change -- > trig frequency update
  attach_entity_load_avg()
    cfs_rq_util_change -- > trig frequency update

The 1st frequency update will not take into account the utilization of the
newly attached task and the 2nd one might be discard because of rate
limitation of the cpufreq driver.

update_cfs_rq_load_avg() is only called by update_blocked_averages()
and update_load_avg() so we can move the call to
{cfs_rq,cpufreq}_util_change() into these 2 functions. It's also
interesting to notice that update_load_avg() already calls directly
cfs_rq_util_change() for !SMP case.

This changes will also ensure that cpufreq_update_util() is called even
when there is no more CFS rq in the leaf_cfs_rq_list to update but only
irq, rt or dl pelt signals.

Reported-by: Doug Smythies <dsmythies@telus.net>
Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

---

I have just rebased the patch on latest tip/sched/core and made it a proper
patchset after Doug reported that the problem has diseappeared according to
his 1st results but tests results are not all based on the same v5.4-rcX
and with menu instead of teo governor.

 kernel/sched/fair.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e458f52..c93d534 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3508,9 +3508,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (decayed)
-		cfs_rq_util_change(cfs_rq, 0);
-
 	return decayed;
 }
 
@@ -3620,8 +3617,12 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
 		update_tg_load_avg(cfs_rq, 0);
 
-	} else if (decayed && (flags & UPDATE_TG))
-		update_tg_load_avg(cfs_rq, 0);
+	} else if (decayed) {
+		cfs_rq_util_change(cfs_rq, 0);
+
+		if (flags & UPDATE_TG)
+			update_tg_load_avg(cfs_rq, 0);
+	}
 }
 
 #ifndef CONFIG_64BIT
@@ -7484,6 +7485,7 @@ static void update_blocked_averages(int cpu)
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
+	int decayed = 0;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7493,9 +7495,9 @@ static void update_blocked_averages(int cpu)
 	 * that RT, DL and IRQ signals have been updated before updating CFS.
 	 */
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
+	decayed |= update_irq_load_avg(rq, 0);
 
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7529,6 +7531,9 @@ static void update_blocked_averages(int cpu)
 	}
 
 	update_blocked_load_status(rq, !done);
+
+	if (decayed)
+		cpufreq_update_util(rq, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -7585,6 +7590,7 @@ static inline void update_blocked_averages(int cpu)
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	const struct sched_class *curr_class;
 	struct rq_flags rf;
+	int decayed = 0;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
@@ -7594,13 +7600,16 @@ static inline void update_blocked_averages(int cpu)
 	 * that RT, DL and IRQ signals have been updated before updating CFS.
 	 */
 	curr_class = rq->curr->sched_class;
-	update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
-	update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
-	update_irq_load_avg(rq, 0);
+	decayed |= update_rt_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &rt_sched_class);
+	decayed |= update_dl_rq_load_avg(rq_clock_pelt(rq), rq, curr_class == &dl_sched_class);
+	decayed |= update_irq_load_avg(rq, 0);
 
-	update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
+	decayed |= update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
 
 	update_blocked_load_status(rq, cfs_rq_has_blocked(cfs_rq) || others_have_blocked(rq));
+
+	if (decayed)
+		cpufreq_update_util(rq, 0);
 	rq_unlock_irqrestore(rq, &rf);
 }
 
-- 
2.7.4

