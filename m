Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9BC4F7F2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2019 21:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfFVTbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jun 2019 15:31:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfFVTbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 15:31:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MJVEpd2308900
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 12:31:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MJVEpd2308900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561231875;
        bh=owktaK6C02+ol0OmqcZdlkYzJV3Rtku9x1+MkqsFvaQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=F7K5jvPH46CMuAu09wgVXf5rsh6BCgfZK4Q25V+PBn/wLAzfzzWlMuG2RMpyTpvLU
         Zin0f9sSBmj/HCudnm4bFsilPIoZ6pLxybYNasS9PnF0aZHcASxLcnIRtZw0lyM069
         5ylHxsXdEga+ZA39hTYH4/NwqlQ3cTih5bryrKJV9WOKnxtIt0FMc6kBfxnfSlyey6
         XRUSHdxMJRdwFdB3NFtwEqaNrqv8cUidhn48CCYDaMKYHs6hnYzUE4jnNPl+P9N0b4
         jgYtSJ0T666WH9Tbt3HyhyoTjBuBFgJkH869wAhuRQfKZ8BdRRNhflOA+0JPgkWbHZ
         y+7mztYwrS3nQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MJVEQN2308897;
        Sat, 22 Jun 2019 12:31:14 -0700
Date:   Sat, 22 Jun 2019 12:31:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-7586addb99322faf4d096fc8beb140f879409212@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        bigeasy@linutronix.de, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, bigeasy@linutronix.de,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190621143643.25649-3-bigeasy@linutronix.de>
References: <20190621143643.25649-3-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Use spin_lock_irq() in
 itimer_delete()
Git-Commit-ID: 7586addb99322faf4d096fc8beb140f879409212
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7586addb99322faf4d096fc8beb140f879409212
Gitweb:     https://git.kernel.org/tip/7586addb99322faf4d096fc8beb140f879409212
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Fri, 21 Jun 2019 16:36:43 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 12:14:22 +0200

posix-timers: Use spin_lock_irq() in itimer_delete()

itimer_delete() uses spin_lock_irqsave() to obtain a `flags' variable
which can then be passed to unlock_timer(). It uses already spin_lock
locking for the structure instead of lock_timer() because it has a timer
which can not be removed by others at this point. The cleanup is always
performed with enabled interrupts.

Use spin_lock_irq() / spin_unlock_irq() so the `flags' variable can be
removed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190621143643.25649-3-bigeasy@linutronix.de

---
 kernel/time/posix-timers.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index caa63e58e3d8..d7f2d91acdac 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -980,18 +980,16 @@ retry_delete:
  */
 static void itimer_delete(struct k_itimer *timer)
 {
-	unsigned long flags;
-
 retry_delete:
-	spin_lock_irqsave(&timer->it_lock, flags);
+	spin_lock_irq(&timer->it_lock);
 
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		unlock_timer(timer, flags);
+		spin_unlock_irq(&timer->it_lock);
 		goto retry_delete;
 	}
 	list_del(&timer->list);
 
-	unlock_timer(timer, flags);
+	spin_unlock_irq(&timer->it_lock);
 	release_posix_timer(timer, IT_ID_SET);
 }
 
