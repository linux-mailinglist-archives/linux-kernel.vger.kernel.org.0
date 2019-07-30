Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B87B5CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 00:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388245AbfG3Wkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jul 2019 18:40:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58694 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbfG3Wkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:40:49 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hsanP-0002Nd-EU; Wed, 31 Jul 2019 00:40:39 +0200
Message-Id: <20190730223348.409366334@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 31 Jul 2019 00:33:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Julia Cartwright <julia@ni.com>
Subject: [patch 0/7] posix-timers: Prepare for PREEMPT_RT - part 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series prepares posix-timers for RT. The main change here is
to utilize the hrtimer synchronization mechanism to prevent priority
inversion and live locks on timer deletion.

This does not cover the posix CPU timers as they need more special
treatment for RT which is covered in a separate series.

Applies on top of:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

Thanks,

	tglx

8<---------------
 fs/timerfd.c                 |    6 +++-
 include/linux/posix-timers.h |    5 ++-
 kernel/time/alarmtimer.c     |    2 -
 kernel/time/itimer.c         |    1 
 kernel/time/posix-timers.c   |   61 +++++++++++++++++++++++++++++++++++--------
 5 files changed, 60 insertions(+), 15 deletions(-)


