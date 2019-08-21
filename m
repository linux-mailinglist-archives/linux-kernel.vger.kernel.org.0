Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E935975FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 11:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHUJYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 05:24:18 -0400
Received: from foss.arm.com ([217.140.110.172]:55050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfHUJYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:24:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2474360;
        Wed, 21 Aug 2019 02:24:15 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD8D63F706;
        Wed, 21 Aug 2019 02:24:14 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, maz@kernel.org,
        bigeasy@linutronix.de, rostedt@goodmis.org,
        Julien Grall <julien.grall@arm.com>
Subject: [RT PATCH 1/3] hrtimer: Use READ_ONCE to access timer->base in hrimer_grab_expiry_lock()
Date:   Wed, 21 Aug 2019 10:24:07 +0100
Message-Id: <20190821092409.13225-2-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190821092409.13225-1-julien.grall@arm.com>
References: <20190821092409.13225-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The update to timer->base is protected by the base->cpu_base->lock().
However, hrtimer_grab_expirty_lock() does not access it with the lock.

So it would theorically be possible to have timer->base changed under
our feet. We need to prevent the compiler to refetch timer->base so the
check and the access is performed on the same base.

Other access of timer->base are either done with a lock or protected
with READ_ONCE(). So use READ_ONCE() in hrtimer_grab_expirty_lock().

Signed-off-by: Julien Grall <julien.grall@arm.com>

---

This is rather theoritical so far as I don't have a reproducer for this.
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7d7db8802131..b869e816e96a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -932,7 +932,7 @@ EXPORT_SYMBOL_GPL(hrtimer_forward);
 
 void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
-	struct hrtimer_clock_base *base = timer->base;
+	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
 	if (base && base->cpu_base) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
-- 
2.11.0

