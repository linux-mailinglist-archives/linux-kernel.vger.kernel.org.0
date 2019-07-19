Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C426E704
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2019 16:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfGSOAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jul 2019 10:00:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35651 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbfGSOA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:00:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so29142140wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8yrjFRKlFsxVAR2E0++WqOpY0GWxGblducHQHkY1HEY=;
        b=T0d6z3Cez6qRVDVaOQsSiBEn85ZpJa+5xCv/f1iL9SlOqKH3zgCa8UAj4QK1uwS7FL
         bf/UlhrxAuruNQlg166Ix46yLpIDyh2Ukoh72xCHmQ0ArgnWCxagRGlimTF2nf+BE2pt
         gUXN/eG8M9T97Pif5vi10XIRS/PGo5vw421ZYTF/PQ9iRUCLTp2Lk263KRb4LwIa4ZX4
         aEgOMkUVmU1q2lwVEdg+Lt5TuqPOmhPJByQgWyhZ+X1mcj0Gks4KzqYbgRuXFLKmNqEE
         XfjubzKClJ0ANOBTMyvDpGjrPoIW3OyXU9QmqTXEbyLsaAwVtRH7o3oUHsglKebjy3u9
         c0aw==
X-Gm-Message-State: APjAAAUZy3KxemTvKkuM9IEPC3eHkCQwoVDtkIlrvS0cJJb44b/SoAx7
        NHtJvCkK2bT0yP63qf+qrTpGGA==
X-Google-Smtp-Source: APXvYqxJCvEAw/vqa9oX28xD/MSPcsylOV5V73eEkaHVPMQUVfjxB3BjQ3EDQ2+lBb+vN72lL4GiYA==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr47466519wmj.167.1563544827281;
        Fri, 19 Jul 2019 07:00:27 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id f10sm21276926wrs.22.2019.07.19.07.00.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 07:00:26 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org
Subject: [PATCH v9 1/8] sched/topology: Adding function partition_sched_domains_locked()
Date:   Fri, 19 Jul 2019 15:59:53 +0200
Message-Id: <20190719140000.31694-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190719140000.31694-1-juri.lelli@redhat.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Introducing function partition_sched_domains_locked() by taking
the mutex locking code out of the original function.  That way
the work done by partition_sched_domains_locked() can be reused
without dropping the mutex lock.

No change of functionality is introduced by this patch.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/topology.h | 10 ++++++++++
 kernel/sched/topology.c        | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index cfc0a89a7159..d7166f8c0215 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -161,6 +161,10 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void partition_sched_domains_locked(int ndoms_new,
+					   cpumask_var_t doms_new[],
+					   struct sched_domain_attr *dattr_new);
+
 extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 				    struct sched_domain_attr *dattr_new);
 
@@ -213,6 +217,12 @@ unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
 
 struct sched_domain_attr;
 
+static inline void
+partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+			       struct sched_domain_attr *dattr_new)
+{
+}
+
 static inline void
 partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 			struct sched_domain_attr *dattr_new)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f53f89df837d..362c383ec4bd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2159,16 +2159,16 @@ static int dattrs_equal(struct sched_domain_attr *cur, int idx_cur,
  * ndoms_new == 0 is a special case for destroying existing domains,
  * and it will not create the default domain.
  *
- * Call with hotplug lock held
+ * Call with hotplug lock and sched_domains_mutex held
  */
-void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
-			     struct sched_domain_attr *dattr_new)
+void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
+				    struct sched_domain_attr *dattr_new)
 {
 	bool __maybe_unused has_eas = false;
 	int i, j, n;
 	int new_topology;
 
-	mutex_lock(&sched_domains_mutex);
+	lockdep_assert_held(&sched_domains_mutex);
 
 	/* Always unregister in case we don't destroy any domains: */
 	unregister_sched_domain_sysctl();
@@ -2251,6 +2251,15 @@ void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 	ndoms_cur = ndoms_new;
 
 	register_sched_domain_sysctl();
+}
 
+/*
+ * Call with hotplug lock held
+ */
+void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
+			     struct sched_domain_attr *dattr_new)
+{
+	mutex_lock(&sched_domains_mutex);
+	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
 	mutex_unlock(&sched_domains_mutex);
 }
-- 
2.17.2

