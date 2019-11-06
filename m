Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46923F0CB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 04:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbfKFDJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 22:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388388AbfKFDIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 22:08:40 -0500
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC7A222C6;
        Wed,  6 Nov 2019 03:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573009719;
        bh=ZnFz+lH+tOpk7R3l2NW9L4pWuZOSXkhyLiTtLd8lH/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtu1+UO/1dSiXIg5QxdVpziDoACpmiQoeTCqFgsTSuO5jdZVs5DEPcL3rYS5meA78
         NHJ0umFT22KEdRz2PzODRsOW6SoV/LKv0Jn7uf+AV9MY8tDEj3bi4DOAPp4MFgCVOc
         C4SF2DljRgUBV8M4qUdabpoucTbcGDW8bG0E2sTo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Pavel Machek <pavel@ucw.cz>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 8/9] leds: Use all-in-one vtime aware kcpustat accessor
Date:   Wed,  6 Nov 2019 04:08:06 +0100
Message-Id: <20191106030807.31091-9-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191106030807.31091-1-frederic@kernel.org>
References: <20191106030807.31091-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can now safely read user kcpustat fields on nohz_full CPUs.
Use the appropriate accessor.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 drivers/leds/trigger/ledtrig-activity.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index ddfc5edd07c8..20250de1138d 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -57,9 +57,12 @@ static void led_activity_function(struct timer_list *t)
 	curr_used = 0;
 
 	for_each_possible_cpu(i) {
-		curr_used += kcpustat_cpu(i).cpustat[CPUTIME_USER]
-			  +  kcpustat_cpu(i).cpustat[CPUTIME_NICE]
-			  +  kcpustat_field(&kcpustat_cpu(i), CPUTIME_SYSTEM, i)
+		u64 user, nice, sys, guest, guest_nice;
+
+		kcpustat_cputime(&kcpustat_cpu(i), i, &user, &nice, &sys,
+				 &guest, &guest_nice);
+
+		curr_used += user + nice + sys
 			  +  kcpustat_cpu(i).cpustat[CPUTIME_SOFTIRQ]
 			  +  kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
 		cpus++;
-- 
2.23.0

