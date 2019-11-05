Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50FBF0558
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 19:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390837AbfKESuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 13:50:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34785 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390828AbfKESt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 13:49:57 -0500
Received: by mail-qk1-f194.google.com with SMTP id 205so20804376qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 10:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/uSdHlKPf1tWhKDunGI/tN+mu3wuDSTuhFonKqIHstk=;
        b=zhz9Ie/3qhCwSnRfeGZleXYj7TE0mY6013JOezcJuJbqNIZ0Yyz3f6AFxuKSwpCg5t
         ejai0aD/uweZBbIr1pAoz12BDN7NSvsiP/7Jp/JNQlaWjz08O+oxhg51H3duZT3fgTDy
         wXpo2ELGzDQ79mGVuX9D/S3r2q5vLiT8y8xlC1MSeZOYZr8w0E2z8701/sT15w+xjGvL
         5+JNahhHmE6PI3DGPA4iqBdRZFXJHMMj1DhNkMvAI8MuUI7Pa7VkMjiJZ5T3CKxpiu06
         wpJ0nz5ZG+taEnRd/Gwllc2Q4Y1R/tLmdoZBbEdYqfRP8p3fVjNHL84a8QqeD9NMTtFs
         uQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/uSdHlKPf1tWhKDunGI/tN+mu3wuDSTuhFonKqIHstk=;
        b=XR6jkxSkNR8Gu+DnEB+ufyqTxfVdJILcxDEL+IYV8ZQE0Vbfmk/20IAPSrPKkFC5IL
         7lm2oH61YeSfAwlrEuvCAQcy7XXIFnBzNNbqUsLVQRpSl5Z2SdZ/VjGDvFOBmfCcRN8j
         Yg6RE8MJkW4ZZY2/4TTYgVHn0guG064H1WVYSJxqNfT51reivzWzEBjX0ihYERg0bhun
         VEsKsV+4gYlX3y4k2VoUawrXo1V7HGsnDLdcMv0MlO7iCkEihh4YywA5MCNhh/SU14Oh
         UxFZhG2t/pIskTqXad8pkPL/odYyhiJD4I+KuBKUGMYyBmkIMtVYkJoEgceluxyEGuqo
         SDTA==
X-Gm-Message-State: APjAAAWSz0hlMI3mkovp3sNBolPHc7uRoGuTCSeuaBf5TfyohSm/L1F2
        Y58TfhpqJ21TDGT+YS/aS5F/VQOuHeo=
X-Google-Smtp-Source: APXvYqxQAWUYsgytD6yhx8qK6s6J4frcLIQ5To4Lb9k2kkaaXr9s5y2hUf+IWlbUTNFA6yFq7SCGcQ==
X-Received: by 2002:a05:620a:1437:: with SMTP id k23mr7967359qkj.15.1572979795875;
        Tue, 05 Nov 2019 10:49:55 -0800 (PST)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id j7sm6832565qkd.46.2019.11.05.10.49.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Nov 2019 10:49:55 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        edubezval@gmail.com, qperret@google.com
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: [Patch v5 6/6] sched/fair: Enable tuning of decay period
Date:   Tue,  5 Nov 2019 13:49:46 -0500
Message-Id: <1572979786-20361-7-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal pressure follows pelt signas which means the
decay period for thermal pressure is the default pelt
decay period. Depending on soc charecteristics and thermal
activity, it might be beneficial to decay thermal pressure
slower, but still in-tune with the pelt signals.
One way to achieve this is to provide a command line parameter
to set a decay shift parameter to an integer between 0 and 10.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v4->v5:
	- Changed _coeff to _shift as per review comments on the list.

 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 kernel/sched/fair.c                             | 25 +++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c82f87c..0b8f55e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4281,6 +4281,11 @@
 			incurs a small amount of overhead in the scheduler
 			but is useful for debugging and performance tuning.
 
+	sched_thermal_decay_shift=
+			[KNL, SMP] Set decay shift for thermal pressure signal.
+			Format: integer betweer 0 and 10
+			Default is 0.
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5f6c371..61a020b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -91,6 +91,18 @@ const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
  * and maximum available capacity due to thermal events.
  */
 static DEFINE_PER_CPU(unsigned long, thermal_pressure);
+/**
+ * By default the decay is the default pelt decay period.
+ * The decay shift can change the decay period in
+ * multiples of 32.
+ *  Decay shift		Decay period(ms)
+ *	0			32
+ *	1			64
+ *	2			128
+ *	3			256
+ *	4			512
+ */
+static int sched_thermal_decay_shift;
 
 static void trigger_thermal_pressure_average(struct rq *rq);
 
@@ -10435,6 +10447,15 @@ void update_thermal_pressure(int cpu, unsigned long capped_capacity)
 	delta = arch_scale_cpu_capacity(cpu) - capped_capacity;
 	per_cpu(thermal_pressure, cpu) = delta;
 }
+
+static int __init setup_sched_thermal_decay_shift(char *str)
+{
+	if (kstrtoint(str, 0, &sched_thermal_decay_shift))
+		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
+
+	return 1;
+}
+__setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 #endif
 
 /**
@@ -10444,8 +10465,8 @@ void update_thermal_pressure(int cpu, unsigned long capped_capacity)
 static void trigger_thermal_pressure_average(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-	update_thermal_load_avg(rq_clock_task(rq), rq,
-				per_cpu(thermal_pressure, cpu_of(rq)));
+	update_thermal_load_avg(rq_clock_task(rq) >> sched_thermal_decay_shift,
+				rq, per_cpu(thermal_pressure, cpu_of(rq)));
 #endif
 }
 
-- 
2.1.4

