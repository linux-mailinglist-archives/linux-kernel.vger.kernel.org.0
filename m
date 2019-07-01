Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D663B5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 15:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbfFJND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 09:03:29 -0400
Received: from foss.arm.com ([217.140.110.172]:42644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389123AbfFJND3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:03:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FFC1337;
        Mon, 10 Jun 2019 06:03:28 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 976183F557;
        Mon, 10 Jun 2019 06:03:27 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:03:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource/arm_arch_timer: extract elf_hwcap use to
 arch-helper
Message-ID: <20190610130325.GB25803@arrakis.emea.arm.com>
References: <20190430131413.10017-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430131413.10017-1-andrew.murray@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 02:14:13PM +0100, Andrew Murray wrote:
> diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
> index 0a8d7bba2cb0..f21e038dc9f3 100644
> --- a/arch/arm/include/asm/arch_timer.h
> +++ b/arch/arm/include/asm/arch_timer.h
> @@ -4,6 +4,7 @@
>  
>  #include <asm/barrier.h>
>  #include <asm/errno.h>
> +#include <asm/hwcap.h>
>  #include <linux/clocksource.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
> @@ -110,6 +111,18 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
>  	isb();
>  }
>  
> +static inline bool arch_timer_set_evtstrm_feature(void)
> +{
> +	elf_hwcap |= HWCAP_EVTSTRM;
> +#ifdef CONFIG_COMPAT
> +	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
> +#endif
> +}

There is no COMPAT support on arm32.

-- 
Catalin
