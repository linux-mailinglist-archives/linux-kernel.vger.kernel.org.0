Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD8414A6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jan 2020 16:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgA0PG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jan 2020 10:06:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46915 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbgA0PG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:06:27 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iw5y0-0004xP-Vl; Mon, 27 Jan 2020 16:06:21 +0100
Date:   Mon, 27 Jan 2020 16:06:20 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC] per-CPU usage in perf core-book3s
Message-ID: <20200127150620.taio2txyqreg4kn6@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at usage of per-CPU variable cpu_hw_events in
arch/powerpc/perf/core-book3s.c.

power_pmu_enable() and power_pmu_disable() (pmu::pmu_enable() and
pmu::pmu_disable()) are accessing the variable and the callbacks are
invoked always with disabled interrupts.

power_pmu_event_init() (pmu::event_init()) is invoked from preemptible
context and uses get_cpu_var() to obtain a stable pointer (by disabling
preemption).

pmu::pmu_enable() and pmu::pmu_disable() can be invoked via a hrtimer
(perf_mux_hrtimer_handler()) and it invokes pmu::pmu_enable() and
pmu::pmu_disable() as part of the callback.

Is there anything that prevents the timer callback to interrupt
pmu::event_init() while it is accessing per-CPU data?

Sebastian
