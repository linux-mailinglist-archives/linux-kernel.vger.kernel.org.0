Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57D07772F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 22:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGZUoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 16:44:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfGZUob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:44:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E778E218B8;
        Fri, 26 Jul 2019 20:44:29 +0000 (UTC)
Date:   Fri, 26 Jul 2019 16:44:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [patch 10/12] hrtimer: Determine hard/soft expiry mode for
 hrtimer sleepers on RT
Message-ID: <20190726164428.40a4e4b4@gandalf.local.home>
In-Reply-To: <20190726185753.645792403@linutronix.de>
References: <20190726183048.982726647@linutronix.de>
        <20190726185753.645792403@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019 20:30:58 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> +++ b/kernel/time/hrtimer.c
> @@ -1662,6 +1662,30 @@ static enum hrtimer_restart hrtimer_wake
>  static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
>  				   clockid_t clock_id, enum hrtimer_mode mode)
>  {
> +	/*
> +	 * On PREEMPT_RT enabled kernels hrtimers which are not explicitely
> +	 * marked for hard interrupt expiry mode are moved into soft
> +	 * interrupt context either for latency reasons or because the
> +	 * hrtimer callback takes regular spinlocks or invokes other
> +	 * functions which are not suitable for hard interrupt context on
> +	 * PREEMPT_RT.

Have we marked all timer handlers that have normal spin_locks as
HRTIMER_MODE_SOFT? Otherwise, can't we switch one to hard below and
having their handler grab a spin_lock/mutex in hard interrupt context
in RT?

-- Steve


> +	 *
> +	 * The hrtimer_sleeper callback is RT compatible in hard interrupt
> +	 * context, but there is a latency concern: Untrusted userspace can
> +	 * spawn many threads which arm timers for the same expiry time on
> +	 * the same CPU. That causes a latency spike due to the wakeup of
> +	 * a gazillion threads.
> +	 *
> +	 * OTOH, priviledged real-time user space applications rely on the
> +	 * low latency of hard interrupt wakeups. If the current task is in
> +	 * a real-time scheduling class, mark the mode for hard interrupt
> +	 * expiry.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		if (task_is_realtime(current) && !(mode & HRTIMER_MODE_SOFT))
> +			mode |= HRTIMER_MODE_HARD;
> +	}
> +
>  	__hrtimer_init(&sl->timer, clock_id, mode);
>  	sl->timer.function = hrtimer_wakeup;
>  	sl->task = current;

