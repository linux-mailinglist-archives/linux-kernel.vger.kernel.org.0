Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D1A7771D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2019 07:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfG0F5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jul 2019 01:57:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfG0F4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 01:56:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA1DD883D7;
        Sat, 27 Jul 2019 05:56:48 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-116-73.phx2.redhat.com [10.3.116.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B76FF19C71;
        Sat, 27 Jul 2019 05:56:47 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT 4/8] sched: migrate disable: Protect cpus_ptr with lock
Date:   Sat, 27 Jul 2019 00:56:34 -0500
Message-Id: <20190727055638.20443-5-swood@redhat.com>
In-Reply-To: <20190727055638.20443-1-swood@redhat.com>
References: <20190727055638.20443-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 27 Jul 2019 05:56:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various places assume that cpus_ptr is protected by rq/pi locks,
so don't change it before grabbing those locks.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 99a3cfccf4d3..38a9a9df5638 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7283,9 +7283,8 @@ void dump_cpu_task(int cpu)
 	struct rq *rq;
 	struct rq_flags rf;
 
-	p->cpus_ptr = cpumask_of(smp_processor_id());
-
 	rq = task_rq_lock(p, &rf);
+	p->cpus_ptr = cpumask_of(smp_processor_id());
 	update_nr_migratory(p, -1);
 	p->nr_cpus_allowed = 1;
 	task_rq_unlock(rq, p, &rf);
@@ -7297,9 +7296,8 @@ void dump_cpu_task(int cpu)
 	struct rq *rq;
 	struct rq_flags rf;
 
-	p->cpus_ptr = &p->cpus_mask;
-
 	rq = task_rq_lock(p, &rf);
+	p->cpus_ptr = &p->cpus_mask;
 	p->nr_cpus_allowed = cpumask_weight(&p->cpus_mask);
 	update_nr_migratory(p, 1);
 	task_rq_unlock(rq, p, &rf);
-- 
1.8.3.1

