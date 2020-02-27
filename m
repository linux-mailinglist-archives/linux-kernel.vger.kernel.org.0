Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8D171F51
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2020 15:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbgB0OeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 09:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387606AbgB0OeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:34:04 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D16246AF;
        Thu, 27 Feb 2020 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582814043;
        bh=Fo2bDZpGJ+4PkvElHct0HikKzFK2miB2beL6Mv/GKqk=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nQHl8csMI/vhtNi5QP/X+frnTRNGlnTgdKe/zquZfExF/9rxtBenUuZ5TqJhSo1pb
         zmAoeormRQ9fPNykU/Ip9YMofMU4/jnJ+7gW61qbFqmDTD2aYORau2vuS+S/KLPZBS
         a8oM98g2LOgn1V56vGrfvh1RR4QZLPQXC+MLiuhc=
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
Subject: [PATCH RT 08/23] sched: migrate disable: Protect cpus_ptr with lock
Date:   Thu, 27 Feb 2020 08:33:19 -0600
Message-Id: <d9c0759fade25e7da05b84f96f1ff602b6fdf413.1582814004.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
In-Reply-To: <cover.1582814004.git.zanussi@kernel.org>
References: <cover.1582814004.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

v4.14.170-rt75-rc2 stable review patch.
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

