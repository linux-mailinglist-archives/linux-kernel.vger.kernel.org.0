Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C40C94901
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfHSPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:48:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47593 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfHSPpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:42 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqm-0006up-CD; Mon, 19 Aug 2019 17:45:40 +0200
Message-Id: <20190819143802.514575219@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:31:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 12/44] itimers: Use quick sample function
References: <20190819143141.221906747@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_itimer() locks sighand lock and checks whether the timer is already
expired. If it is not expired then the thread group cputime accounting is
already enabled. Use the sampling function not the one which is meant for
starting a timer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/itimer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -58,7 +58,7 @@ static void get_cpu_itimer(struct task_s
 		struct task_cputime cputime;
 		u64 t;
 
-		thread_group_cputimer(tsk, &cputime);
+		thread_group_sample_cputime(tsk, &cputime);
 		if (clock_id == CPUCLOCK_PROF)
 			t = cputime.utime + cputime.stime;
 		else


