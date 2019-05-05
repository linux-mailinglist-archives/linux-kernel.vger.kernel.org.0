Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B532313F4A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfEEL6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 07:58:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56902 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbfEEL6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 07:58:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A6E71993;
        Sun,  5 May 2019 04:58:36 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82F2B3F5C1;
        Sun,  5 May 2019 04:58:34 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 7/7] sched: export the newly added tracepoints
Date:   Sun,  5 May 2019 12:57:32 +0100
Message-Id: <20190505115732.9844-8-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190505115732.9844-1-qais.yousef@arm.com>
References: <20190505115732.9844-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that external modules can hook into them and extract the info they
need. Since these new tracepoints have no events associated with them
exporting these tracepoints make them useful for external modules to
perform testing and debugging. There's no other way otherwise to access
them.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778c48a7fda..1841a4e9918e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -22,6 +22,14 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/sched.h>
 
+/*
+ * Export tracepoints that act as a bare tracehook (ie: have no trace event
+ * associated with them) to allow external modules to probe them.
+ */
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_load_rq);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_load_se);
+EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized);
+
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
-- 
2.17.1

