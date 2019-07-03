Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBAA45ED5C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2019 22:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfGCURR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jul 2019 16:17:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37503 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCURQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:17:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63KGQFd3442527
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 13:16:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63KGQFd3442527
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562184987;
        bh=lTjT1ss8m7bqfxP4X5rrXZSR25lcNzJsXBSext0b6Hw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gA9SKzG0px+us+o0DTccHcDn0SMvu1wiLd5RkqMFi5WVvnSfGwx3RaYCeH+I49+EY
         +3BYaz8DGTkWF3Mx16PbxncSQCc7yrwTG3VGKJm5KX9H6DrhING0MXo4Ecxoxt60UJ
         9xGx/jJfSGsXeTRakgmJou/puT0e17P/Si9MCYxhqqguC75TW54yodoqp0uMD+B5e/
         xQIHOne4wmMAoD7l/rGR2Z0LOP4eWhnh+Xwoe2l7/z9GFQaK7OQD0gUOUHeZD8symQ
         DqvfrJffe9ukC4KgGqqLFwkpbMO9h5eFSyaQwbNigrcHn4D/21btIxyrdnnSX/mIpR
         ZFISPf8tpoZFw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63KGQNN3442524;
        Wed, 3 Jul 2019 13:16:26 -0700
Date:   Wed, 3 Jul 2019 13:16:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Xu <tipbot@zytor.com>
Message-ID: <tip-042c79988172ec394d62ba762f09b77e14ecc5b6@git.kernel.org>
Cc:     mingo@kernel.org, lcapitulino@redhat.com, tglx@linutronix.de,
        peterx@redhat.com, mtosatti@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: peterx@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          mtosatti@redhat.com, mingo@kernel.org, lcapitulino@redhat.com,
          tglx@linutronix.de
In-Reply-To: <20190628105942.14131-1-peterx@redhat.com>
References: <20190628105942.14131-1-peterx@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timer: Document TIMER_PINNED
Git-Commit-ID: 042c79988172ec394d62ba762f09b77e14ecc5b6
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

Commit-ID:  042c79988172ec394d62ba762f09b77e14ecc5b6
Gitweb:     https://git.kernel.org/tip/042c79988172ec394d62ba762f09b77e14ecc5b6
Author:     Peter Xu <peterx@redhat.com>
AuthorDate: Fri, 28 Jun 2019 18:59:42 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Jul 2019 22:11:58 +0200

timer: Document TIMER_PINNED

The flag hints the user that the pinned timers will always be run on a
static CPU (because that should be what "pinned" means...) but that's
not the truth, at least with the current implementation.

For example, currently if a pinned timer is set up but later mod_timer()
upon the pinned timer is invoked, mod_timer() will still try to queue the
timer on the current processor and migrate the timer if necessary.

Document it a bit with the definition of TIMER_PINNED so that all future
users will use it correctly.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Link: https://lkml.kernel.org/r/20190628105942.14131-1-peterx@redhat.com

---
 include/linux/timer.h | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 7b066fd38248..282e4f2a532a 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -36,19 +36,30 @@ struct timer_list {
 #define __TIMER_LOCKDEP_MAP_INITIALIZER(_kn)
 #endif
 
-/*
- * A deferrable timer will work normally when the system is busy, but
- * will not cause a CPU to come out of idle just to service it; instead,
- * the timer will be serviced when the CPU eventually wakes up with a
- * subsequent non-deferrable timer.
+/**
+ * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
+ * system is busy, but will not cause a CPU to come out of idle just
+ * to service it; instead, the timer will be serviced when the CPU
+ * eventually wakes up with a subsequent non-deferrable timer.
  *
- * An irqsafe timer is executed with IRQ disabled and it's safe to wait for
- * the completion of the running instance from IRQ handlers, for example,
- * by calling del_timer_sync().
+ * @TIMER_IRQSAFE: An irqsafe timer is executed with IRQ disabled and
+ * it's safe to wait for the completion of the running instance from
+ * IRQ handlers, for example, by calling del_timer_sync().
  *
  * Note: The irq disabled callback execution is a special case for
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
+ *
+ * @TIMER_PINNED: A pinned timer will not be affected by any timer
+ * placement heuristics (like, NOHZ) and will always expire on the CPU
+ * on which the timer was enqueued.
+ *
+ * Note: Because enqueuing of timers can migrate the timer from one
+ * CPU to another, pinned timers are not guaranteed to stay on the
+ * initialy selected CPU.  They move to the CPU on which the enqueue
+ * function is invoked via mod_timer() or add_timer().  If the timer
+ * should be placed on a particular CPU, then add_timer_on() has to be
+ * used.
  */
 #define TIMER_CPUMASK		0x0003FFFF
 #define TIMER_MIGRATING		0x00040000
