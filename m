Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9366B2943E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbfEXJKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 05:10:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37454 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389425AbfEXJKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 05:10:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78A40A78;
        Fri, 24 May 2019 02:10:33 -0700 (PDT)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED86E3F5AF;
        Fri, 24 May 2019 02:10:31 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] clocksource/arm_arch_timer: Don't trace count reader functions
Date:   Fri, 24 May 2019 10:10:25 +0100
Message-Id: <1558689025-50679-1-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With v5.2-rc1, The ftrace functions_graph tracer locks up whenever it is
enabled on arm64.

Since commit 0ea415390cd3 ("clocksource/arm_arch_timer: Use
arch_timer_read_counter to access stable counters") a function pointer
is consistently used to read the counter instead of potentially
referencing an inlinable function.

The graph tacers relies on accessing the timer counters to compute the
time spent in functions which causes the lockup when attempting to trace
these code paths.

Annontate the arm arch timer counter accessors as notrace.

Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use
       arch_timer_read_counter to access stable counters")
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/clocksource/arm_arch_timer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index b2a951a..5c69c9a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -149,22 +149,22 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
 	return val;
 }
 
-static u64 arch_counter_get_cntpct_stable(void)
+static notrace u64 arch_counter_get_cntpct_stable(void)
 {
 	return __arch_counter_get_cntpct_stable();
 }
 
-static u64 arch_counter_get_cntpct(void)
+static notrace u64 arch_counter_get_cntpct(void)
 {
 	return __arch_counter_get_cntpct();
 }
 
-static u64 arch_counter_get_cntvct_stable(void)
+static notrace u64 arch_counter_get_cntvct_stable(void)
 {
 	return __arch_counter_get_cntvct_stable();
 }
 
-static u64 arch_counter_get_cntvct(void)
+static notrace u64 arch_counter_get_cntvct(void)
 {
 	return __arch_counter_get_cntvct();
 }
-- 
1.9.1

