Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25CA712AB02
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Dec 2019 09:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfLZIiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Dec 2019 03:38:14 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfLZIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 03:38:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9991AB0110524FB17B9;
        Thu, 26 Dec 2019 16:38:11 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Thu, 26 Dec 2019 16:38:00 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/debug: Reset watchdog on all CPUs while processing sysrq-t
Date:   Thu, 26 Dec 2019 16:52:24 +0800
Message-ID: <20191226085224.48942-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lengthy output of sysrq-t may take a lot of time on slow serial console
with lots of processes and CPUs.

So we need to reset NMI-watchdog to avoid spurious lockup messages, and
we also reset softlockup watchdogs on all other CPUs since another CPU
might be blocked waiting for us to process an IPI or stop_machine.

Add to sysrq_sched_debug_show() as what we did in show_state_filter().

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/sched/debug.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c..879d3ccf3806 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -751,9 +751,16 @@ void sysrq_sched_debug_show(void)
 	int cpu;
 
 	sched_debug_header(NULL);
-	for_each_online_cpu(cpu)
+	for_each_online_cpu(cpu) {
+		/*
+		 * Need to reset softlockup watchdogs on all CPUs, because
+		 * another CPU might be blocked waiting for us to process
+		 * an IPI or stop_machine.
+		 */
+		touch_nmi_watchdog();
+		touch_all_softlockup_watchdogs();
 		print_cpu(NULL, cpu);
-
+	}
 }
 
 /*
-- 
2.17.1

