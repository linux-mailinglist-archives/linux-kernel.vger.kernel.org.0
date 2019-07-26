Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC26F771F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 21:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbfGZTTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 15:19:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50193 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388523AbfGZTS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:18:58 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5k1-0001Al-0Y; Fri, 26 Jul 2019 21:18:57 +0200
Message-Id: <20190726185753.262895510@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 20:30:54 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 06/12] watchdog: Mark watchdog_hrtimer to expire in hard
 interrupt context
References: <20190726183048.982726647@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The watchdog hrtimer must expire in hard interrupt context even on
PREEMPT_RT=y kernels as otherwise the hard/softlockup detection logic would
not work.

No functional change.

[ tglx: Split out from larger combo patch. Added changelog ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/watchdog.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -490,7 +490,7 @@ static void watchdog_enable(unsigned int
 	 * Start the timer first to prevent the NMI watchdog triggering
 	 * before the timer has a chance to fire.
 	 */
-	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	hrtimer->function = watchdog_timer_fn;
 	hrtimer_start(hrtimer, ns_to_ktime(sample_period),
 		      HRTIMER_MODE_REL_PINNED);


