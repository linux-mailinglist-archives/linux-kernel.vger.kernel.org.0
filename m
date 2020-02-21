Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE0168942
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2020 22:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgBUV0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Feb 2020 16:26:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbgBUVZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:39 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F7F24696;
        Fri, 21 Feb 2020 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320338;
        bh=L4UR3M1l22WWoKaD+AUUdwfvaMUZeDKgXjxjx9Cw+S0=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=wn140VYUwVHcWa5FXdNsp1yF7kYClQ7J7VBmrhNR/PyV2gkGysSjeU66mXYNRCukY
         WkTultJOAV/hQm/262GLzz4z4/45VvCNXscJCGx2KHegY5I/PTg9fFv7lHgCkk2L9y
         7o0GfNstZpNETej41HufCVRp8+57iaZ6Z4UvqW3Q=
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
Subject: [PATCH RT 24/25] sched: Provide migrate_disable/enable() inlines
Date:   Fri, 21 Feb 2020 15:24:52 -0600
Message-Id: <5e82e4f7f3bc60945e64b2ee8ac429d6c5b51838.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 87d447be4100447b42229cce5e9b33c7915871eb ]

Currently code which solely needs to prevent migration of a task uses
preempt_disable()/enable() pairs. This is the only reliable way to do so as
setting the task affinity to a single CPU can be undone by a setaffinity
operation from a different task/process. It's also significantly faster.

RT provides a seperate migrate_disable/enable() mechanism which does not
disable preemption to achieve the semantic requirements of a (almost) fully
preemptible kernel.

As it is unclear from looking at a given code path whether the intention is
to disable preemption or migration, introduce migrate_disable/enable()
inline functions which can be used to annotate code which merely needs to
disable migration. Map them to preempt_disable/enable() for now. The RT
substitution will be provided later.

Code which is annotated that way documents that it has no requirement to
protect against reentrancy of a preempting task. Either this is not
required at all or the call sites are already serialized by other means.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 include/linux/preempt.h | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 6728662a81e8..2e15fbc01eda 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -241,8 +241,30 @@ static inline int __migrate_disabled(struct task_struct *p)
 }
 
 #else
-#define migrate_disable()		preempt_disable()
-#define migrate_enable()		preempt_enable()
+/**
+ * migrate_disable - Prevent migration of the current task
+ *
+ * Maps to preempt_disable() which also disables preemption. Use
+ * migrate_disable() to annotate that the intent is to prevent migration
+ * but not necessarily preemption.
+ *
+ * Can be invoked nested like preempt_disable() and needs the corresponding
+ * number of migrate_enable() invocations.
+ */
+#define migrate_disable()	preempt_disable()
+
+/**
+ * migrate_enable - Allow migration of the current task
+ *
+ * Counterpart to migrate_disable().
+ *
+ * As migrate_disable() can be invoked nested only the uttermost invocation
+ * reenables migration.
+ *
+ * Currently mapped to preempt_enable().
+ */
+#define migrate_enable()	preempt_enable()
+
 static inline int __migrate_disabled(struct task_struct *p)
 {
 	return 0;
-- 
2.14.1

