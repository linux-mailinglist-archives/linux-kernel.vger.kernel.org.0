Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740D4168938
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgBUVZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgBUVZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:24 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E5282467A;
        Fri, 21 Feb 2020 21:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320323;
        bh=U3QRFgorUSPKmV1pjsKNqZxdmuKqHi6ASTjt45Lygjc=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YsRQzxWE3n5HLjDQRcu2WAdQciZkZRIetTpuume5gT0hZ+9OK2dJJHDW/o2FiZrBH
         qOBTcxdD894Mc+xLGB03o9eEfUTpZnnu3OBGgpP7z8Eo39s5Gcaun9YAqhlkajl8Yf
         0Lvy21CIr8un8Epg4iPd7YUJOG+1ZWygA2F5C8ZY=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 09/25] sched: migrate disable: Protect cpus_ptr with lock
Date:   Fri, 21 Feb 2020 15:24:37 -0600
Message-Id: <c58bd5258b0f4f0b9ee767ca91402fd392a8c8db.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 27ee52a891ed2c7e2e2c8332ccae0de7c2674b09 ]

Various places assume that cpus_ptr is protected by rq/pi locks,
so don't change it before grabbing those locks.

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/sched/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4708129e8df1..189e6f08575e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6923,9 +6923,8 @@ migrate_disable_update_cpus_allowed(struct task_struct *p)
 	struct rq *rq;
 	struct rq_flags rf;
 
-	p->cpus_ptr = cpumask_of(smp_processor_id());
-
 	rq = task_rq_lock(p, &rf);
+	p->cpus_ptr = cpumask_of(smp_processor_id());
 	update_nr_migratory(p, -1);
 	p->nr_cpus_allowed = 1;
 	task_rq_unlock(rq, p, &rf);
@@ -6937,9 +6936,8 @@ migrate_enable_update_cpus_allowed(struct task_struct *p)
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
2.14.1

