Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0797601
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfHUJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 05:24:24 -0400
Received: from foss.arm.com ([217.140.110.172]:55072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfHUJYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:24:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 609271597;
        Wed, 21 Aug 2019 02:24:18 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D4A63F706;
        Wed, 21 Aug 2019 02:24:17 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, maz@kernel.org,
        bigeasy@linutronix.de, rostedt@goodmis.org,
        Julien Grall <julien.grall@arm.com>
Subject: [RT PATCH 3/3] hrtimer: Prevent using uninitialized spin_lock in hrtimer_grab_expiry_lock()
Date:   Wed, 21 Aug 2019 10:24:09 +0100
Message-Id: <20190821092409.13225-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190821092409.13225-1-julien.grall@arm.com>
References: <20190821092409.13225-1-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

migration_base is used as a placeholder when an hrtimer is switching
between base (see switch_hrtimer_timer_base). It is possible
theoritically possible to have timer->base equal to migration_base.

Even if it is a placeholder, it would pass all the current check in
hrtimer_grab_expiry_lock() leading to use softirq_expiry_lock
uninitialized.

This is can be prevented by checking whether the base is equal to
the placeholder (i.e. migration_base).

Furthermore, all the path leading to hrtimer_grab_expiry_lock() assumes
timer->base and timer->base->cpu_base are always non-NULL. So it is safe
to remove the NULL checks here.

Signed-off-by: Julien Grall <julien.grall@arm.com>

---

I don't have a reproducer so far, but I can't see why it would not be
possible to happen.
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 119414a2f59c..5eb45a868de9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -934,7 +934,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (timer->is_soft && base && base->cpu_base) {
+	if (timer->is_soft && base != &migration_base) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
-- 
2.11.0

