Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 981A21472C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jan 2020 21:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbgAWUlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jan 2020 15:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgAWUjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:39:45 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C88324689;
        Thu, 23 Jan 2020 20:39:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1iujGR-000mXt-Iv; Thu, 23 Jan 2020 15:39:43 -0500
Message-Id: <20200123203943.466391736@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Jan 2020 15:39:38 -0500
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
Subject: [PATCH RT 08/30] hrtimer: Use READ_ONCE to access timer->base in
 hrimer_grab_expiry_lock()
References: <20200123203930.646725253@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19.94-rt39-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Julien Grall <julien.grall@arm.com>

[ Upstream commit 2c8fdbe7ef0ad06c1a326886c5954e117b5657d6 ]

The update to timer->base is protected by the base->cpu_base->lock().
However, hrtimer_grab_expirty_lock() does not access it with the lock.

So it would theorically be possible to have timer->base changed under
our feet. We need to prevent the compiler to refetch timer->base so the
check and the access is performed on the same base.

Other access of timer->base are either done with a lock or protected
with READ_ONCE(). So use READ_ONCE() in hrtimer_grab_expirty_lock().

Signed-off-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 94d97eae0a46..d6026c170c2d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -941,7 +941,7 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
 
 void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
-	struct hrtimer_clock_base *base = timer->base;
+	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
 	if (base && base->cpu_base) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
-- 
2.24.1


