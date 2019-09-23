Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 636F6BBC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 21:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502454AbfIWTwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 15:52:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59750 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfIWTwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:52:03 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCUNH-00053G-9j; Mon, 23 Sep 2019 21:51:55 +0200
Date:   Mon, 23 Sep 2019 21:51:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, erosca@de.adit-jv.com,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V1 1/1] tick: broadcast-hrtimer: Fix a race in
 bc_set_next
In-Reply-To: <20190918144138.24839-2-balasubramani_vivekanandan@mentor.com>
Message-ID: <alpine.DEB.2.21.1909232041080.1934@nanos.tec.linutronix.de>
References: <20190918144138.24839-1-balasubramani_vivekanandan@mentor.com> <20190918144138.24839-2-balasubramani_vivekanandan@mentor.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019, Balasubramani Vivekanandan wrote:
> 
> When there are no more cpus subscribed to broadcast, the timer callback
> might not set the expiry time for hrtimer. Therefore the callback timer
> function is modified to set the state of broadcast clock to
> CLOCK_EVT_STATE_ONESHOT_STOPPED which in turn will set the expiry time
> of hrtimer to KTIME_MAX.

That's an ugly layering violation, really.

Aside of that the whole try to cancel logic and the comment that the
hrtimer cannot be armed from within the callback is wrong. All of this can
go way.

Find a completely untested patch below.

Thanks,

	tglx

8<---------------------
--- a/kernel/time/tick-broadcast-hrtimer.c
+++ b/kernel/time/tick-broadcast-hrtimer.c
@@ -42,39 +42,35 @@ static int bc_shutdown(struct clock_even
  */
 static int bc_set_next(ktime_t expires, struct clock_event_device *bc)
 {
-	int bc_moved;
 	/*
-	 * We try to cancel the timer first. If the callback is on
-	 * flight on some other cpu then we let it handle it. If we
-	 * were able to cancel the timer nothing can rearm it as we
-	 * own broadcast_lock.
+	 * This is called either from enter/exit idle code or from the
+	 * broadcast handler. In all cases tick_broadcast_lock is held.
 	 *
-	 * However we can also be called from the event handler of
-	 * ce_broadcast_hrtimer itself when it expires. We cannot
-	 * restart the timer because we are in the callback, but we
-	 * can set the expiry time and let the callback return
-	 * HRTIMER_RESTART.
+	 * hrtimer_cancel() cannot be called here neither from the
+	 * broadcast handler nor from the enter/exit idle code. The idle
+	 * code can run into the problem described in bc_shutdown() and the
+	 * broadcast handler cannot wait for itself to complete for obvious
+	 * reasons.
 	 *
-	 * Since we are in the idle loop at this point and because
-	 * hrtimer_{start/cancel} functions call into tracing,
-	 * calls to these functions must be bound within RCU_NONIDLE.
+	 * Each caller tries to arm the hrtimer on its own CPU, but if the
+	 * handler is currently running hrtimer_start() does not move
+	 * it. It keeps it on the CPU on which it is assigned at the
+	 * moment.
 	 */
-	RCU_NONIDLE(
-		{
-			bc_moved = hrtimer_try_to_cancel(&bctimer) >= 0;
-			if (bc_moved) {
-				hrtimer_start(&bctimer, expires,
-					      HRTIMER_MODE_ABS_PINNED_HARD);
-			}
-		}
-	);
-
-	if (bc_moved) {
-		/* Bind the "device" to the cpu */
-		bc->bound_on = smp_processor_id();
-	} else if (bc->bound_on == smp_processor_id()) {
-		hrtimer_set_expires(&bctimer, expires);
-	}
+	RCU_NONIDLE( {
+		hrtimer_start(&bctimer, expires, HRTIMER_MODE_ABS_PINNED_HARD);
+		/*
+		 * The core tick broadcast mode expects bc->bound_on to be set
+		 * correctly to prevent a CPU which has the broadcast hrtimer
+		 * armed from going deep idle.
+		 *
+		 * As tick_broadcast_lock is held, nothing can change the
+		 * cpu base which was just established in hrtimer_start()
+		 * above. So the below access is safe even without holding
+		 * the hrtimer base lock.
+		 */
+		bc->bound_on = bctimer.base->cpu_base->cpu;
+	} );
 	return 0;
 }
 
@@ -100,10 +96,6 @@ static enum hrtimer_restart bc_handler(s
 {
 	ce_broadcast_hrtimer.event_handler(&ce_broadcast_hrtimer);
 
-	if (clockevent_state_oneshot(&ce_broadcast_hrtimer))
-		if (ce_broadcast_hrtimer.next_event != KTIME_MAX)
-			return HRTIMER_RESTART;
-
 	return HRTIMER_NORESTART;
 }
 
