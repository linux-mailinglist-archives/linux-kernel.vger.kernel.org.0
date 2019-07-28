Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78EAF78034
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2019 17:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfG1Pa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jul 2019 11:30:26 -0400
Received: from foss.arm.com ([217.140.110.172]:33540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfG1PaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:30:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7BBF344;
        Sun, 28 Jul 2019 08:30:24 -0700 (PDT)
Received: from [10.37.12.40] (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A3F53F71F;
        Sun, 28 Jul 2019 08:30:23 -0700 (PDT)
Subject: Re: [patch 2/5] lib/vdso: Move fallback invocation to the callers
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Bolle <pebolle@tiscali.nl>, Will Deacon <will@kernel.org>
References: <20190728131251.622415456@linutronix.de>
 <20190728131648.695579736@linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <5f5d5c53-9582-7455-bebd-aa5597467199@arm.com>
Date:   Sun, 28 Jul 2019 16:31:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190728131648.695579736@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/19 2:12 PM, Thomas Gleixner wrote:
> To allow syscall fallbacks using the legacy 32bit syscall for 32bit VDSO
> builds, move the fallback invocation out into the callers.
> 
> Split the common code out of __cvdso_clock_gettime/getres() and invoke the
> syscall fallback in the 64bit and 32bit variants.
> 
> Preparatory work for using legacy syscalls in 32bit VDSO. No functional
> change.
>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  lib/vdso/gettimeofday.c |   53 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -51,7 +51,7 @@ static int do_hres(const struct vdso_dat
>  		ns = vdso_ts->nsec;
>  		last = vd->cycle_last;
>  		if (unlikely((s64)cycles < 0))
> -			return clock_gettime_fallback(clk, ts);
> +			return -1;
>  
>  		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
>  		ns >>= vd->shift;
> @@ -82,14 +82,14 @@ static void do_coarse(const struct vdso_
>  }
>  
>  static __maybe_unused int
> -__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
> +__cvdso_clock_gettime_common(clockid_t clock, struct __kernel_timespec *ts)
>  {
>  	const struct vdso_data *vd = __arch_get_vdso_data();
>  	u32 msk;
>  
>  	/* Check for negative values or invalid clocks */
>  	if (unlikely((u32) clock >= MAX_CLOCKS))
> -		goto fallback;
> +		return -1;
>  
>  	/*
>  	 * Convert the clockid to a bitmask and use it to check which
> @@ -104,9 +104,17 @@ static __maybe_unused int
>  	} else if (msk & VDSO_RAW) {
>  		return do_hres(&vd[CS_RAW], clock, ts);
>  	}
> +	return -1;
> +}
>  
> -fallback:
> -	return clock_gettime_fallback(clock, ts);
> +static __maybe_unused int
> +__cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
> +{
> +	int ret = __cvdso_clock_gettime_common(clock, ts);
> +
> +	if (unlikely(ret))
> +		return clock_gettime_fallback(clock, ts);
> +	return 0;
>  }
>  
>  static __maybe_unused int
> @@ -115,9 +123,12 @@ static __maybe_unused int
>  	struct __kernel_timespec ts;
>  	int ret;
>  
> -	ret = __cvdso_clock_gettime(clock, &ts);
> +	ret = __cvdso_clock_gettime_common(clock, &ts);
>  
> -	if (ret == 0) {
> +	if (unlikely(ret))
> +		ret = clock_gettime_fallback(clock, &ts);
> +
> +	if (likely(!ret)) {
>  		res->tv_sec = ts.tv_sec;
>  		res->tv_nsec = ts.tv_nsec;
>  	}
> @@ -163,17 +174,18 @@ static __maybe_unused time_t __cvdso_tim
>  
>  #ifdef VDSO_HAS_CLOCK_GETRES
>  static __maybe_unused
> -int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
> +int __cvdso_clock_getres_common(clockid_t clock, struct __kernel_timespec *res)
>  {
>  	const struct vdso_data *vd = __arch_get_vdso_data();
> -	u64 ns;
> +	u64 hrtimer_res;
>  	u32 msk;
> -	u64 hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
> +	u64 ns;
>  
>  	/* Check for negative values or invalid clocks */
>  	if (unlikely((u32) clock >= MAX_CLOCKS))
> -		goto fallback;
> +		return -1;
>  
> +	hrtimer_res = READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
>  	/*
>  	 * Convert the clockid to a bitmask and use it to check which
>  	 * clocks are handled in the VDSO directly.
> @@ -195,16 +207,22 @@ int __cvdso_clock_getres(clockid_t clock
>  		 */
>  		ns = hrtimer_res;
>  	} else {
> -		goto fallback;
> +		return -1;
>  	}
>  
>  	res->tv_sec = 0;
>  	res->tv_nsec = ns;
>  
>  	return 0;
> +}
> +
> +int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
> +{
> +	int ret = __cvdso_clock_getres_common(clock, res);
>  
> -fallback:
> -	return clock_getres_fallback(clock, res);
> +	if (unlikely(ret))
> +		return clock_getres_fallback(clock, res);
> +	return 0;
>  }
>  
>  static __maybe_unused int
> @@ -213,13 +231,14 @@ static __maybe_unused int
>  	struct __kernel_timespec ts;
>  	int ret;
>  
> -	ret = __cvdso_clock_getres(clock, &ts);
> +	ret = __cvdso_clock_getres_common(clock, &ts);
> +	if (unlikely(ret))
> +		ret = clock_getres_fallback(clock, &ts);
>  
> -	if (ret == 0) {
> +	if (likely(!ret)) {
>  		res->tv_sec = ts.tv_sec;
>  		res->tv_nsec = ts.tv_nsec;
>  	}
> -
>  	return ret;
>  }
>  #endif /* VDSO_HAS_CLOCK_GETRES */
> 
> 

-- 
Regards,
Vincenzo
