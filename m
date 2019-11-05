Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB49F0555
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 19:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390792AbfKEStv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 13:49:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38404 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390777AbfKEStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:49:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id e2so22138046qkn.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//sItIXLl6E4Ye9AiiPOHeektXX9ZAo/gSmUR4HA0Qs=;
        b=T1AsK/X293UuDDf3vetvrnF+e4m4Efzz4Y69za3KWN4Xo+EIFMCKYOGIkNE5g6Rgua
         EVVcKVf7j0f4vptuaNqtczhCFAMrCmlx0R1llPT0pqBksrl1YlwoEVX2n+iGyPl9Ghvf
         ZkTCVWmV4TUSNoAGfrude0gL41pcMCB4XiwgXTTXF6AGlnfoGxGTeVj7LPaBSGPKF1gY
         yRdhNtGwgq8pxPuuHE5K0xgYPzb5NcsaQgGaw23ufIRRWsUHq+ip/sVJgeITS2G3SFhr
         1YKM5sP2i0UMtt+uuV/ToOR0UnANnyEftFhCP7PbaDp+aqpYa7UdEheSyh8lKS6RUYbh
         SCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//sItIXLl6E4Ye9AiiPOHeektXX9ZAo/gSmUR4HA0Qs=;
        b=fy+lz9J20tWS331eQrZn9h2QHU5vwPFxu+u33DnKUS+jmpQXA7BPK9dGxjgVlfx4mc
         NooQM+XYwXoAXt12q2CkVDR2W/7c4n4wyqqTOKKJLwVrvjS9eLr/v45s03+2G8iCGpKa
         h61QeyVA3cQ7etRZI+6Q+AHs/1seN4uUx9yzNaCS1MbJyTrnDkNP+W8RjGg4RB2vxxRU
         l7dG8ufd+FKrl950P4Lp+mIsZlNrq0zhtx47gy1GkCoPwQ6l39y2ZNPnV0ZVRRrAUKCQ
         XPrbVKwS908PDASMiNHcOaCPo5rKkoQnHUq9r8OhYrDj7OpDwgbv/GFXiflDUW4W+X5J
         Ia9A==
X-Gm-Message-State: APjAAAXZXOwNOigLZ0hrLIyxC4xOMtx6345Pkk83fyq43fd+h2RyEWCf
        oQvuXUp1g5IFhaXkXdx1ONjHVw==
X-Google-Smtp-Source: APXvYqz+t/jl/6a/LgMZieMFQi6rRtYbI/j1Qej+iIQDbIIYIsFYeR//qt3xgVCyfT3NI0JDx8mxzw==
X-Received: by 2002:a37:4dd2:: with SMTP id a201mr8093655qkb.5.1572979789538;
        Tue, 05 Nov 2019 10:49:49 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id j7sm6832565qkd.46.2019.11.05.10.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Nov 2019 10:49:48 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v5 1/6] sched/pelt.c: Add support to track thermal pressure
Date:   Tue,  5 Nov 2019 13:49:41 -0500
Message-Id: <1572979786-20361-2-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extrapolating on the exisiting framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressure. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a cpu running a rt/dl task through util_avg,
the average thermal pressure is tracked through load_avg. This is
because thermal pressure signal is weighted "delta" capacity
and is not binary(util_avg is binary). "delta capacity" here
means delta between the actual capacity of a cpu and the decreased
capacity a cpu due to a thermal event.
In order to track average thermal pressure, a new sched_avg variable
avg_thermal is introduced. Function update_thermal_load_avg can be called
to do the periodic bookeeping (accumulate, decay and average)
of the thermal pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/pelt.c  | 13 +++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a96db50..3821069 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -353,6 +353,19 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	if (___update_load_sum(now, &rq->avg_thermal,
+			       capacity,
+			       capacity,
+			       capacity)) {
+		___update_load_avg(&rq->avg_thermal, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 /*
  * irq:
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index afff644..c74226d 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -6,6 +6,7 @@ int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se
 int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity);
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 int update_irq_load_avg(struct rq *rq, u64 running);
@@ -159,6 +160,12 @@ update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 }
 
 static inline int
+update_thermal_load_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
+
+static inline int
 update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b..d5d82c8 100644
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

