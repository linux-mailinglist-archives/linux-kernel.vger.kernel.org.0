Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AD4141029
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jan 2020 18:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgAQRn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jan 2020 12:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgAQRla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:41:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D34EB21D56;
        Fri, 17 Jan 2020 17:41:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1isVce-000QQj-Ot; Fri, 17 Jan 2020 12:41:28 -0500
Message-Id: <20200117174128.650393932@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Jan 2020 12:41:20 -0500
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
        Julien Grall <julien.grall@arm.com>
Subject: [PATCH RT 09/32] hrtimer: Dont grab the expiry lock for non-soft hrtimer
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

From: Julien Grall <julien.grall@arm.com>

[ Upstream commit fd420354bea2f57c11f3de191dffdeea76531e76 ]

Acquiring the lock in hrtimer_grab_expiry_lock() is designed for
sleeping-locks and should not be used with disabled interrupts.
hrtimer_cancel() may invoke hrtimer_grab_expiry_lock() also for locks
which expire in hard-IRQ context.

Let hrtimer_cancel() invoke hrtimer_grab_expiry_lock() only for locks
which expire in softirq context.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: rewrite changelog]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index d6026c170c2d..49d20fe8570f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -943,7 +943,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (base && base->cpu_base) {
+	if (timer->is_soft && base && base->cpu_base) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
-- 
2.24.1


