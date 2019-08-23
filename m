Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12CFC9AE3D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2019 13:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392970AbfHWLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Aug 2019 07:38:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34974 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732231AbfHWLiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:38:51 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i17u5-00010K-D2; Fri, 23 Aug 2019 13:38:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] tick: Mark sched_timer in hard interrupt context
Date:   Fri, 23 Aug 2019 13:38:45 +0200
Message-Id: <20190823113845.12125-3-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823113845.12125-1-bigeasy@linutronix.de>
References: <20190823113845.12125-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sched_timer should be initialized with the _HARD suffix. Most of
this already happened in commit
	902a9f9c50905 ("tick: Mark tick related hrtimers to expiry in hard interru=
pt context")

but this one instance has been missed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cc1a322121b4b..433879b35cbb7 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1239,7 +1239,7 @@ static void tick_nohz_switch_to_nohz(void)
 	 * Recycle the hrtimer in ts, so we can share the
 	 * hrtimer_forward with the highres code.
 	 */
-	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
+	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	/* Get the next period */
 	next =3D tick_init_jiffy_update();
=20
--=20
2.23.0

