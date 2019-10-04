Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B24CB73D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 11:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbfJDJUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 05:20:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36263 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbfJDJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:20:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iGJlY-00017i-Pi; Fri, 04 Oct 2019 11:20:48 +0200
Date:   Fri, 4 Oct 2019 11:20:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <jlelli@redhat.com>
Subject: Re: [PATCH v2] lib/smp_processor_id: Don't use cpumask_equal()
Message-ID: <20191004092048.l2jeutbrffnwfol2@linutronix.de>
References: <20191003203608.21881-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191003203608.21881-1-longman@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-03 16:36:08 [-0400], Waiman Long wrote:
> The check_preemption_disabled() function uses cpumask_equal() to see
> if the task is bounded to the current CPU only. cpumask_equal() calls
> memcmp() to do the comparison. As x86 doesn't have __HAVE_ARCH_MEMCMP,
> the slow memcmp() function in lib/string.c is used.
> 
> On a RT kernel that call check_preemption_disabled() very frequently,
> below is the perf-record output of a certain microbenchmark:
> 
>   42.75%  2.45%  testpmd [kernel.kallsyms] [k] check_preemption_disabled
>   40.01% 39.97%  testpmd [kernel.kallsyms] [k] memcmp
> 
> We should avoid calling memcmp() in performance critical path. So the
> cpumask_equal() call is now replaced with an equivalent simpler check.

using a simple integer comparison is still more efficient than what
__HAVE_ARCH_MEMCMP can offer.

> Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by:  Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
