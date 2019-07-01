Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB4E5959D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 10:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfF1IG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 04:06:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50399 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfF1IGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:06:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so8126661wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CCKTOX94dJMJaIi336ahfQwlG37S0yGGcCoKC+X5aD4=;
        b=D5fq92o5SRB81qL0haOeI9smb4BnjU2TdY2ryZb+IZv2zg1zoLHqDneXH+/WclNZpp
         zbHyquPL6IU/VQQ8PEY0fCJRnz7hKwF0c2xc6qa/BcGtTzs0YddLSeCUd+25TxbDya9v
         YoRNryGGgas2K3D9HAr3kydyO4vye250fwEzOvWWBBv+DAXe59YhrwDHttNNlah1SWtU
         vJZvB6fw1VPniefh4ySCC4LpFtkNSRxKQ1KUdYRi/iPMAeoXgCNRm0HTgGSNEuMHRv84
         VqXB+90NgNrPLdFQ9rqll2Up+2cMRQDIgQSKu34mTyCH7mfaLQjVJebt5YkZvt0fZBhm
         wFBw==
X-Gm-Message-State: APjAAAW5tmad+aqb6cPnC26cJSZ40F9dn1/+wlyEyXau/eEOehuJ/zAw
        JhWXPiuEMsVGVdZboSF8n48ksQ==
X-Google-Smtp-Source: APXvYqzAsUT+533HfWPDIvW6mCpCh1TTKCdObNW67mDZ8ojUOZbvV3FebhVmYfJcgNWue1+BgE/Zyg==
X-Received: by 2002:a1c:ef10:: with SMTP id n16mr5706288wmh.134.1561709205292;
        Fri, 28 Jun 2019 01:06:45 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id z19sm1472774wmi.7.2019.06.28.01.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Jun 2019 01:06:44 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v8 8/8] rcu/tree: Setschedule gp ktread to SCHED_FIFO outside of atomic region
Date:   Fri, 28 Jun 2019 10:06:18 +0200
Message-Id: <20190628080618.522-9-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190628080618.522-1-juri.lelli@redhat.com>
References: <20190628080618.522-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_setscheduler() needs to acquire cpuset_rwsem, but it is currently
called from an invalid (atomic) context by rcu_spawn_gp_kthread().

Fix that by simply moving sched_setscheduler_nocheck() call outside of
the atomic region, as it doesn't actually require to be guarded by
rcu_node lock.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 980ca3ca643f..32ea75acba14 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3123,13 +3123,13 @@ static int __init rcu_spawn_gp_kthread(void)
 	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start grace-period kthread, OOM is now expected behavior\n", __func__))
 		return 0;
+	if (kthread_prio)
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	rnp = rcu_get_root();
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rcu_state.gp_kthread = t;
-	if (kthread_prio) {
+	if (kthread_prio)
 		sp.sched_priority = kthread_prio;
-		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
-	}
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
-- 
2.17.2

