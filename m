Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59925948C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 17:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfHSPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 11:46:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47743 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfHSPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 11:45:50 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzjqu-0006z2-FN; Mon, 19 Aug 2019 17:45:48 +0200
Message-Id: <20190819143804.344061838@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 19 Aug 2019 16:32:12 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [patch 31/44] posix-cpu-timers: Remove the odd field rename defines
References: <20190819143141.221906747@linutronix.de>
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


