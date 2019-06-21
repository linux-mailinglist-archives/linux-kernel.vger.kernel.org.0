Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C054EAD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFUOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 10:36:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:36:50 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1heKel-0004et-Bn; Fri, 21 Jun 2019 16:36:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] posix-timers: Remove "it_signal = NULL" assignment in itimer_delete()
Date:   Fri, 21 Jun 2019 16:36:42 +0200
Message-Id: <20190621143643.25649-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621143643.25649-1-bigeasy@linutronix.de>
References: <20190621143643.25649-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

itimer_delete() is invoked during do_exit(). At this point it is the
last thread in the group dying and doing the clean up.
Since it is the last thread in the group, there can not be any other
task attempting to lock the itimer which means the NULL assignment (which
avoids lookups in __lock_timer()) is not required.

The assignment and comment was copied in commit 0e568881178ff ("[PATCH]
fix posix-timers to have proper per-process scope") from
sys_timer_delete() which was/is the syscall interface and requires the
assignment.

Remove the superfluous ->it_signal = NULL assignment.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/posix-timers.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 29176635991f0..caa63e58e3d88 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -990,11 +990,6 @@ static void itimer_delete(struct k_itimer *timer)
 		goto retry_delete;
 	}
 	list_del(&timer->list);
-	/*
-	 * This keeps any tasks waiting on the spin lock from thinking
-	 * they got something (see the lock code above).
-	 */
-	timer->it_signal = NULL;
 
 	unlock_timer(timer, flags);
 	release_posix_timer(timer, IT_ID_SET);
-- 
2.20.1

