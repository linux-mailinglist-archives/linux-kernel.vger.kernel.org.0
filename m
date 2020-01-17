Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C1A141013
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 18:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgAQRmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 12:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbgAQRld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:41:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B3524683;
        Fri, 17 Jan 2020 17:41:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1isVci-000QbZ-0K; Fri, 17 Jan 2020 12:41:32 -0500
Message-Id: <20200117174131.893547195@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Jan 2020 12:41:41 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH RT 30/32] lib/smp_processor_id: Adjust check_preemption_disabled()
References: <20200117174111.282847363@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.94-rt39-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit af3c1c5fdf177870fb5e6e16b24e374696ab28f5 ]

The current->migrate_disable counter is not always defined leading to
build failures with DEBUG_PREEMPT && !PREEMPT_RT_BASE.

Restrict the access to ->migrate_disable to same set where
->migrate_disable is modified.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: adjust condition + description]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/smp_processor_id.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 0c80992aa337..2e7398534b66 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -22,8 +22,10 @@ notrace static unsigned int check_preemption_disabled(const char *what1,
 	 * Kernel threads bound to a single CPU can safely use
 	 * smp_processor_id():
 	 */
+#if defined(CONFIG_PREEMPT_RT_BASE) && (defined(CONFIG_SMP) || defined(CONFIG_SCHED_DEBUG))
 	if (current->migrate_disable)
 		goto out;
+#endif
 
 	if (current->nr_cpus_allowed == 1)
 		goto out;
-- 
2.24.1


