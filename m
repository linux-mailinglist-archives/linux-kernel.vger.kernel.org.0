Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64E10143D54
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jan 2020 13:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUMzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jan 2020 07:55:51 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:56578 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgAUMzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:55:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6A6A4FB03;
        Tue, 21 Jan 2020 13:55:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5hwBqkAmIvg2; Tue, 21 Jan 2020 13:55:46 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 4A920404A9; Tue, 21 Jan 2020 13:55:46 +0100 (CET)
Date:   Tue, 21 Jan 2020 13:55:46 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/etnaviv: only reject timeouts with tv_nsec >= 2
 seconds
Message-ID: <20200121125546.GA71415@bogon.m.sigxcpu.org>
References: <20200121114553.2667556-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200121114553.2667556-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Jan 21, 2020 at 12:45:25PM +0100, Arnd Bergmann wrote:
> As Guido G�nther reported, get_abs_timeout() in the etnaviv user space
> sometimes passes timeouts with nanosecond values larger than 1000000000,
> which gets rejected after my first patch.
> 
> To avoid breaking this, while also not allowing completely arbitrary
> values, set the limit to 1999999999 and use set_normalized_timespec64()
> to get the correct format before comparing it.

I'm seeing values up to 5 seconds so I need

     if (args->timeout.tv_nsec > (5 * NSEC_PER_SEC))

to unbreak rendering. Which seems to match what mesa's get_abs_timeout()
does and how it's invoked.

   with that:

Tested-by: Guido G�nther <agx@sigxcpu.org>

Cheers,
 -- Guido

> 
> This also addresses the off-by-1 glitch reported by Ben Hutchings.
> 
> Fixes: 172a216ff334 ("drm/etnaviv: reject timeouts with tv_nsec >= NSEC_PER_SEC")
> Cc: Guido G�nther <agx@sigxcpu.org>
> Link: https://patchwork.kernel.org/patch/11291089/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 10 +++++++---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h |  6 ++----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 3eb0f9223bea..d94740c123d3 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -292,7 +292,11 @@ static int etnaviv_ioctl_gem_cpu_prep(struct drm_device *dev, void *data,
>  	if (args->op & ~(ETNA_PREP_READ | ETNA_PREP_WRITE | ETNA_PREP_NOSYNC))
>  		return -EINVAL;
>  
> -	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> +	/*
> +	 * existing user space passes non-normalized timespecs, but never
> +	 * more than 2 seconds worth of nanoseconds
> +	 */
> +	if (args->timeout.tv_nsec >= (2 * NSEC_PER_SEC))
>  		return -EINVAL;
>  
>  	obj = drm_gem_object_lookup(file, args->handle);
> @@ -358,7 +362,7 @@ static int etnaviv_ioctl_wait_fence(struct drm_device *dev, void *data,
>  	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
>  		return -EINVAL;
>  
> -	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> +	if (args->timeout.tv_nsec >= (2 * NSEC_PER_SEC))
>  		return -EINVAL;
>  
>  	if (args->pipe >= ETNA_MAX_PIPES)
> @@ -412,7 +416,7 @@ static int etnaviv_ioctl_gem_wait(struct drm_device *dev, void *data,
>  	if (args->flags & ~(ETNA_WAIT_NONBLOCK))
>  		return -EINVAL;
>  
> -	if (args->timeout.tv_nsec > NSEC_PER_SEC)
> +	if (args->timeout.tv_nsec >= (2 * NSEC_PER_SEC))
>  		return -EINVAL;
>  
>  	if (args->pipe >= ETNA_MAX_PIPES)
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> index efc656efeb0f..3e47050af706 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -109,12 +109,10 @@ static inline size_t size_vstruct(size_t nelem, size_t elem_size, size_t base)
>  static inline unsigned long etnaviv_timeout_to_jiffies(
>  	const struct drm_etnaviv_timespec *timeout)
>  {
> -	struct timespec64 ts, to = {
> -		.tv_sec = timeout->tv_sec,
> -		.tv_nsec = timeout->tv_nsec,
> -	};
> +	struct timespec64 ts, to;
>  
>  	ktime_get_ts64(&ts);
> +	set_normalized_timespec64(&to, timeout->tv_sec, timeout->tv_nsec);
>  
>  	/* timeouts before "now" have already expired */
>  	if (timespec64_compare(&to, &ts) <= 0)
> -- 
> 2.25.0
> 
