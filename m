Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E87713822D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgAKP7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 10:59:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41446 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbgAKP7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:59:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so4772452qke.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 07:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YwOxAUOQlGAOKDvCOZdw7tGVrmEYd8EilAE9D9adyH4=;
        b=dQw7p/6NB+KFvFWV27Yu3Nr/2Ykn9x0HRWaIZQ2yKQ7lwCSdeoPuhLwcTI2lh1puGe
         trMoNQmR0gXaTu+wcZCL5VC3Nb4LuECtLSqY9ZJSl0nJoYeRJJgu2C87UHhLTK/YS7HE
         hFDgwvwKei623RPHA2YgLq8CGTE8Cy0mizwZPmfxzYfwlj07PSa1TufX20t0ypHlkmvD
         KDdwGIngnDdPtklj/yEpYJSs8/tX0VkUeKa4ToGDGIAV6fqr5mpzWUMn6tr+V33c35QB
         +XjMxpKb44/mK3ts5dKXQ3Kx5ukJvqKaexId5tm7qZhG53zbnqAYWJEZiwgaU6B2HL4Q
         eksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YwOxAUOQlGAOKDvCOZdw7tGVrmEYd8EilAE9D9adyH4=;
        b=mQVYE9Ionpy7eN1k++sst6pTh1OFvAtP3CPL3Px4Gki/h9FTk/1B5xiP7V4R4gMsXI
         /dIwOQRH2nDFWHisrbVepicZxhzM/SztGelb6aArYGonrvbrPnzA9VEaBvD41UDgzbfg
         3zTTFSgSsUTwbxAN3poBRZhMuaku4RrSJnNZoPJDxBQPS8hSM8D5pDUbiPaP9mg0rltv
         joTz7KLuS/sllq5vIfLVhJTEpdf9xdhll147QZWxu+ylljchY+HjD+OHjk+5hfRJtSFK
         nu4Irq6ghSUGolD6W8UEgr5eaQjj86LMuVtjoVChXana4F0U92q6ri6qDr/v45q9Cd+a
         lG3w==
X-Gm-Message-State: APjAAAU+jbPT5TYwAKoPyifC50t8Um9vooSpAg4N1Vc6DAY5z551IEqr
        ZYaXeyG143fdH4AjsKvb3ZYPsg==
X-Google-Smtp-Source: APXvYqx7r36xEsdk9y5LC7i3GtyNp2dVl9FNlxSvnmiMoqeYWhuRZO9n2Ff+9l8dCChseIXW/db0kg==
X-Received: by 2002:a05:620a:138d:: with SMTP id k13mr3761930qki.239.1578758350662;
        Sat, 11 Jan 2020 07:59:10 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id l49sm2843478qtk.7.2020.01.11.07.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 Jan 2020 07:59:10 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
Subject: [Patch v7 1/7] sched/pelt: Add support to track thermal pressure
Date:   Sat, 11 Jan 2020 10:59:00 -0500
Message-Id: <1578758346-507-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
References: <1578758346-507-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extrapolating on the existing framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressure. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a cpu running a rt/dl task through util_avg, the
average thermal pressure is tracked through load_avg. This is because
thermal pressure signal is weighted "delta" capacity and is not
binary(util_avg is binary). "delta capacity" here means delta between the
actual capacity of a cpu and the decreased capacity a cpu due to a thermal
event.

In order to track average thermal pressure, a new sched_avg variable
avg_thermal is introduced. Function update_thermal_load_avg can be called
to do the periodic bookkeeping (accumulate, decay and average) of the
thermal pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---

v6->v7:
	- Added CONFIG_HAVE_SCHED_THERMAL_PRESSURE to stub out
	  update_thermal_load_avg in unsupported architectures as per
	  review comments from Peter, Dietmar and Quentin.
	- Updated comment for update_thermal_load_avg as per review
	  comments from Peter and Dietmar.

 include/trace/events/sched.h |  4 ++++
 init/Kconfig                 |  4 ++++
 kernel/sched/pelt.c          | 31 +++++++++++++++++++++++++++++++
 kernel/sched/pelt.h          | 16 ++++++++++++++++
 kernel/sched/sched.h         |  1 +
 5 files changed, 56 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 420e80e..a8fb667 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -613,6 +613,10 @@ DECLARE_TRACE(pelt_dl_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
 
+DECLARE_TRACE(pelt_thermal_tp,
+	TP_PROTO(struct rq *rq),
+	TP_ARGS(rq));
+
 DECLARE_TRACE(pelt_irq_tp,
 	TP_PROTO(struct rq *rq),
 	TP_ARGS(rq));
diff --git a/init/Kconfig b/init/Kconfig
index f6a4a91..c16ea88 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -450,6 +450,10 @@ config HAVE_SCHED_AVG_IRQ
 	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
 	depends on SMP
 
+config HAVE_SCHED_THERMAL_PRESSURE
+	bool "Enable periodic averaging of thermal pressure"
+	depends on SMP
+
 config BSD_PROCESS_ACCT
 	bool "BSD Process Accounting"
 	depends on MULTIUSER
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index bd006b7..5d1fbf0 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -367,6 +367,37 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
+/*
+ * thermal:
+ *
+ *   load_sum = \Sum se->avg.load_sum but se->avg.load_sum is not tracked
+ *
+ *   util_avg and runnable_load_avg are not supported and meaningless.
+ *
+ * Unlike rt/dl utilization tracking that track time spent by a cpu
+ * running a rt/dl task through util_avg, the average thermal pressure is
+ * tracked through load_avg. This is because thermal pressure signal is
+ * weighted "delta" capacity and is not binary(util_avg is binary). "delta
+ * capacity" here means delta between the actual capacity of a cpu and the
+ * decreased capacity a cpu due to a thermal event.
+ */
+
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	if (___update_load_sum(now, &rq->avg_thermal,
+			       capacity,
+			       capacity,
+			       capacity)) {
+		___update_load_avg(&rq->avg_thermal, 1, 1);
+		trace_pelt_thermal_tp(rq);
+		return 1;
+	}
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 /*
  * irq:
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index afff644..cb20c80 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -7,6 +7,16 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
 
+#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
+#else
+static inline int
+update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
 #else
@@ -159,6 +169,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 }
 
 static inline int
+update_thermal_rq_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+
+static inline int
 update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c7..37bd7ef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -944,6 +944,7 @@ struct rq {
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
+	struct sched_avg	avg_thermal;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.1.4

