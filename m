Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4043FBBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 23:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKMW24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 17:28:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39286 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfKMW24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 17:28:56 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iV184-0007aP-81; Wed, 13 Nov 2019 23:28:48 +0100
Date:   Wed, 13 Nov 2019 23:28:47 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     y2038@lists.linaro.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 21/23] y2038: itimer: change implementation to
 timespec64
In-Reply-To: <20191108211323.1806194-12-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1911132306070.2507@nanos.tec.linutronix.de>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-12-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Arnd Bergmann wrote:
>  TRACE_EVENT(itimer_state,
>  
> -	TP_PROTO(int which, const struct itimerval *const value,
> +	TP_PROTO(int which, const struct itimerspec64 *const value,
>  		 unsigned long long expires),
>  
>  	TP_ARGS(which, value, expires),
> @@ -321,12 +321,12 @@ TRACE_EVENT(itimer_state,
>  		__entry->which		= which;
>  		__entry->expires	= expires;
>  		__entry->value_sec	= value->it_value.tv_sec;
> -		__entry->value_usec	= value->it_value.tv_usec;
> +		__entry->value_usec	= value->it_value.tv_nsec / NSEC_PER_USEC;
>  		__entry->interval_sec	= value->it_interval.tv_sec;
> -		__entry->interval_usec	= value->it_interval.tv_usec;
> +		__entry->interval_usec	= value->it_interval.tv_nsec / NSEC_PER_USEC;

Hmm, having a division in a tracepoint is clearly suboptimal.

>  	),
>  
> -	TP_printk("which=%d expires=%llu it_value=%ld.%ld it_interval=%ld.%ld",
> +	TP_printk("which=%d expires=%llu it_value=%ld.%06ld it_interval=%ld.%06ld",

We print only 6 digits after the . so that would be even correct w/o a
division. But it probably does not matter much.

> @@ -197,19 +207,13 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
>  #define timeval_valid(t) \
>  	(((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))

Hrm, why do we have yet another incarnation of timeval_valid()? Can we
please have only one (the inline version)?

Thanks,

	tglx
