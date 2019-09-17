Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC13B48B0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 09:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404581AbfIQH7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 03:59:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40863 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfIQH7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:59:46 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iA8Ol-00060O-8v; Tue, 17 Sep 2019 09:59:43 +0200
Date:   Tue, 17 Sep 2019 09:59:43 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v3 3/5] sched: migrate_dis/enable: Use rt_invol_sleep
Message-ID: <20190917075943.qsaakyent4dxjkq4@linutronix.de>
References: <20190911165729.11178-1-swood@redhat.com>
 <20190911165729.11178-4-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190911165729.11178-4-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-09-11 17:57:27 [+0100], Scott Wood wrote:
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 885a195dfbe0..32c6175b63b6 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -308,7 +308,9 @@ void pin_current_cpu(void)
>  	preempt_lazy_enable();
>  	preempt_enable();
>  
> +	rt_invol_sleep_inc();
>  	__read_rt_lock(cpuhp_pin);
> +	rt_invol_sleep_dec();
>  
>  	preempt_disable();
>  	preempt_lazy_disable();

I understand the other one. But now looking at it, both end up in
rt_spin_lock_slowlock_locked() which would be the proper place to do
that annotation. Okay.

Sebastian
