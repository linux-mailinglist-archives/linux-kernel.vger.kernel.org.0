Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C1FB59
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfD3OYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 10:24:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48224 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfD3OYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:24:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AC2280D;
        Tue, 30 Apr 2019 07:23:59 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB2183F719;
        Tue, 30 Apr 2019 07:23:57 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:23:55 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 1/7] ARM: vdso: Remove dependency with the arch_timer
 driver internals
Message-ID: <20190430142355.GF17870@fuggles.cambridge.arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408154907.223536-2-marc.zyngier@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Apr 08, 2019 at 04:49:01PM +0100, Marc Zyngier wrote:
> THe VDSO code uses the kernel helper that was originally designed
> to abstract the access between 32 and 64bit systems. It worked so
> far because this function is declared as 'inline'.
> 
> As we're about to revamp that part of the code, the VDSO would
> break. Let's fix it by doing what should have been done from
> the start, a proper system register access.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/cp15.h   | 2 ++
>  arch/arm/vdso/vgettimeofday.c | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)

This looks ok to me and I'd like to take the series via arm64, but I
could do with an Ack from Russell on these 32-bit ARM parts first.

Will

> diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
> index 07e27f212dc7..d2453e2d3f1f 100644
> --- a/arch/arm/include/asm/cp15.h
> +++ b/arch/arm/include/asm/cp15.h
> @@ -68,6 +68,8 @@
>  #define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
>  #define ICIALLU				__ACCESS_CP15(c7, 0, c5, 0)
>  
> +#define CNTVCT				__ACCESS_CP15_64(1, c14)
> +
>  extern unsigned long cr_alignment;	/* defined in entry-armv.S */
>  
>  static inline unsigned long get_cr(void)
> diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
> index a9dd619c6c29..7bdbf5d5c47d 100644
> --- a/arch/arm/vdso/vgettimeofday.c
> +++ b/arch/arm/vdso/vgettimeofday.c
> @@ -18,9 +18,9 @@
>  #include <linux/compiler.h>
>  #include <linux/hrtimer.h>
>  #include <linux/time.h>
> -#include <asm/arch_timer.h>
>  #include <asm/barrier.h>
>  #include <asm/bug.h>
> +#include <asm/cp15.h>
>  #include <asm/page.h>
>  #include <asm/unistd.h>
>  #include <asm/vdso_datapage.h>
> @@ -123,7 +123,8 @@ static notrace u64 get_ns(struct vdso_data *vdata)
>  	u64 cycle_now;
>  	u64 nsec;
>  
> -	cycle_now = arch_counter_get_cntvct();
> +	isb();
> +	cycle_now = read_sysreg(CNTVCT);
>  
>  	cycle_delta = (cycle_now - vdata->cs_cycle_last) & vdata->cs_mask;
>  
> -- 
> 2.20.1
> 
