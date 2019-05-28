Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECB9D2CA20
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 17:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfE1PQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 11:16:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfE1PQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:16:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA8E5A3B49;
        Tue, 28 May 2019 15:16:44 +0000 (UTC)
Received: from inkernel.default (ovpn-116-60.phx2.redhat.com [10.3.116.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A9E67856B;
        Tue, 28 May 2019 15:16:38 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     williams@redhat.com, daniel@bristot.me,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: [RFC 0/3] preempt_tracer: Fix preempt_disable tracepoint
Date:   Tue, 28 May 2019 17:16:21 +0200
Message-Id: <cover.1559051152.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 28 May 2019 15:16:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While playing with the model + working in a fix for the task
context & trace recursion, I ended up hitting two cases in which the
preempt_disable/enable tracepoint was supposed to happen, but didn't.

There is an explanation for each case in the log message.

This is an RFC exposing the problem, with possible ways to fix it.
But I bet there might be better solutions as well, so this is a real
RFC.

Daniel Bristot de Oliveira (3):
  softirq: Use preempt_latency_stop/start to trace preemption
  preempt_tracer: Disable IRQ while starting/stopping due to a
    preempt_counter change
  preempt_tracer: Use a percpu variable to control traceble calls

 kernel/sched/core.c | 66 ++++++++++++++++++++++++++++++++++-----------
 kernel/softirq.c    | 13 ++++-----
 2 files changed, 55 insertions(+), 24 deletions(-)

-- 
2.20.1

