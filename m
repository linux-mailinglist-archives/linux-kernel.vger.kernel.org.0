Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF3298481
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 21:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfHUTcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 15:32:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57284 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbfHUTbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:31:02 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i0WJw-0004EQ-Ul; Wed, 21 Aug 2019 21:31:01 +0200
Message-Id: <20190821192921.499058279@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Aug 2019 21:09:11 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [patch V2 24/38] posix-cpu-timers: Remove the odd field rename defines
References: <20190821190847.665673890@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last users of the odd define based renaming of struct task_cputime
members are gone. Good riddance.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |   15 ---------------
 1 file changed, 15 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -62,21 +62,6 @@ static inline int clockid_to_fd(const cl
 	return ~(clk >> 3);
 }
 
-/*
- * Alternate field names for struct task_cputime when used on cache
- * expirations. Will go away soon.
- *
- * stime corresponds to CLOCKCPU_PROF
- * utime corresponds to CLOCKCPU_VIRT
- * sum_exex_runtime corresponds to CLOCKCPU_SCHED
- *
- * The ordering is currently enforced so struct task_cputime and the
- * expiries array in struct posix_cputimers are equivalent.
- */
-#define prof_exp			stime
-#define virt_exp			utime
-#define sched_exp			sum_exec_runtime
-
 #ifdef CONFIG_POSIX_TIMERS
 /**
  * posix_cputimers - Container for posix CPU timer related data


