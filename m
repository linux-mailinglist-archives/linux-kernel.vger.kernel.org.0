Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2A29910
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403868AbfEXNgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 May 2019 09:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403788AbfEXNgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:36:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 874F1217F9;
        Fri, 24 May 2019 13:36:01 +0000 (UTC)
Date:   Fri, 24 May 2019 09:36:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] clocksource/arm_arch_timer: Don't trace count reader
 functions
Message-ID: <20190524093600.11ca3cb2@gandalf.local.home>
In-Reply-To: <1558689025-50679-1-git-send-email-julien.thierry@arm.com>
References: <1558689025-50679-1-git-send-email-julien.thierry@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2019 10:10:25 +0100
Julien Thierry <julien.thierry@arm.com> wrote:

> With v5.2-rc1, The ftrace functions_graph tracer locks up whenever it is
> enabled on arm64.
> 
> Since commit 0ea415390cd3 ("clocksource/arm_arch_timer: Use
> arch_timer_read_counter to access stable counters") a function pointer
> is consistently used to read the counter instead of potentially
> referencing an inlinable function.
> 
> The graph tacers relies on accessing the timer counters to compute the
> time spent in functions which causes the lockup when attempting to trace
> these code paths.
> 
> Annontate the arm arch timer counter accessors as notrace.
> 
> Fixes: 0ea415390cd3 ("clocksource/arm_arch_timer: Use
>        arch_timer_read_counter to access stable counters")
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> ---
>  drivers/clocksource/arm_arch_timer.c | 8 ++++----

Is there any reason to function trace any of the functions in this
file? If not, then I would suggest removing all the "notrace"
annotations from this file, and add in the Makefile for this directory:

CFLAGS_REMOVE_arm_arch_timer.o = $(CC_FLAGS_FTRACE)

Hmm, I need to go through all the Makefiles in the kernel and remove
the "-pg" and replace it with "$(CC_FLAGS_FTRACE)" as that's the safer
way of doing it now.

-- Steve


>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index b2a951a..5c69c9a 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -149,22 +149,22 @@ u32 arch_timer_reg_read(int access, enum arch_timer_reg reg,
>  	return val;
>  }
>  
> -static u64 arch_counter_get_cntpct_stable(void)
> +static notrace u64 arch_counter_get_cntpct_stable(void)
>  {
>  	return __arch_counter_get_cntpct_stable();
>  }
>  
> -static u64 arch_counter_get_cntpct(void)
> +static notrace u64 arch_counter_get_cntpct(void)
>  {
>  	return __arch_counter_get_cntpct();
>  }
>  
> -static u64 arch_counter_get_cntvct_stable(void)
> +static notrace u64 arch_counter_get_cntvct_stable(void)
>  {
>  	return __arch_counter_get_cntvct_stable();
>  }
>  
> -static u64 arch_counter_get_cntvct(void)
> +static notrace u64 arch_counter_get_cntvct(void)
>  {
>  	return __arch_counter_get_cntvct();
>  }

