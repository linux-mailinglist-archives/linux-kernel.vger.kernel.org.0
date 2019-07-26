Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7260D771F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 21:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388565AbfGZTS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 15:18:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50184 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387455AbfGZTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:18:57 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hr5jx-00019l-7Z; Fri, 26 Jul 2019 21:18:53 +0200
Message-Id: <20190726183048.982726647@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 26 Jul 2019 20:30:48 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 00/12] (hr)timers: Prepare for PREEMPT_RT support
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series brings the bulk of PREEMPT_RT specific changes for the
(hr)timer code:

  - Handle timer deletion correctly under RT to avoid priority inversion
    and life locks

    This mechanism might be useful for VMs as well when a vCPU
    executing a timer callback gets scheduled out and on another vCPU
    del_timer_sync() or hrtimer_cancel() is invoked.

    The mitigation would only work when paravirt spinlocks are
    enabled. I've not implemented that, as I don't know whether this is a
    real world issue. I just noticed that it is basically the same
    problem. Adding it would be trivial.

  - Prepare for moving most hrtimer callbacks into softirq context and mark
    timers which need to expire in hard interrupt context even on RT so
    they don't get moved.

The timerwheel still needs some special handling for IRQSAFE timers (grrrr)
which I'm still working on to find a less fugly solution.

Thanks,

	tglx



