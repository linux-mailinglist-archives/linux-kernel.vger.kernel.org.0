Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60820BB74E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2019 16:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbfIWO4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 10:56:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58793 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfIWO4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:56:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCPld-0007aK-1z; Mon, 23 Sep 2019 16:56:45 +0200
Message-Id: <20190923145435.507024424@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 23 Sep 2019 16:54:35 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch V2 0/6] posix-cpu-timers: Fix bogus permission checks
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When cleaning up posix-cpu-timers I discovered that the permission checks
for process clocks and process timers are completely bonkers. The only
requirement is that the target PID is a group leader. Which means that any
process can read the clocks and attach timers to any other process without
priviledge restrictions.

That's just wrong because the clocks and timers can be used to observe
behaviour and both reading the clocks and arming timers adds overhead and
influences runtime performance of the target process.

Changes vs. V1:

  - Address the review comments from Frederic

  - Actually return -EPERM when the permission check fails.
    See patch 6/6 for rationale

V1 can be found here:

  https://lore.kernel.org/r/20190905120339.561100423@linutronix.de

I still did not come around to write self tests and won't do so in the next
weeks as I'm traveling as of tomorrow and then going on vacation (finally) :)

Thanks,

	tglx

---
 posix-cpu-timers.c |   71 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 22 deletions(-)



