Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F331557D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Feb 2020 13:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgBGMeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Feb 2020 07:34:24 -0500
Received: from smtpbgbr2.qq.com ([54.207.22.56]:55292 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgBGMeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:34:24 -0500
X-QQ-mid: bizesmtp26t1581078855tcx3a4b6
Received: from 10.0.2.15 (unknown [221.222.188.180])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 07 Feb 2020 20:34:09 +0800 (CST)
X-QQ-SSF: 01100000002000E0VI10B00A0000000
X-QQ-FEAT: 1hOA1ipPpV7rqcVL8s9O6ZcFUfX8v+RFWl1FztjmXmNtEr3rf+JvTyZ1c63IQ
        LPdoXbrEwIUcvm2t2BlNBYb66FdBUEAPvh8LGV3SNI29HMjkBwrFFl5XtPxMziyqhc/yMMg
        +vfU9mV9QHanKDkmB8VKAI8S7gcU+k0sL2ErE5+urMTtWS0WnVl6jXuxgughvZ8tU9VbKk4
        3rZ3bz0peAkIX2dBAH0V/ViaIFgxa23q6c2oln5y3gncsI31YLgaXQ5hDvWAo6v0DhIK6WZ
        esYppoohdeSNJ3JyyDzw6OkciG/PRZGG8qxGnKFDleyjC6SDJ5ABDnDiqp6UUEkBv88NLDw
        NF6sAac
X-QQ-GoodBg: 0
From:   Wang Long <w@laoqinren.net>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, w@laoqinren.net
Subject: [PATCH RESEND] sched: update comment for sched_info.pcount and sched_info.run_delay
Date:   Fri,  7 Feb 2020 20:34:08 +0800
Message-Id: <1581078848-27015-1-git-send-email-w@laoqinren.net>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:laoqinren.net:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_info.pcount is the cumulative counters for all cpus and
sched_info.run_delay is the cumulative counters for all runqueues,
but the comment of these two member is inaccurate.

This patch make the comment more accurate.

Signed-off-by: Wang Long <w@laoqinren.net>
---
 include/linux/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0427849..08d8b24 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -291,10 +291,10 @@ struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
 
-	/* # of times we have run on this CPU: */
+	/* # of times we have run on all CPUs: */
 	unsigned long			pcount;
 
-	/* Time spent waiting on a runqueue: */
+	/* Time spent waiting on all runqueues: */
 	unsigned long long		run_delay;
 
 	/* Timestamps: */
-- 
1.8.3.1



