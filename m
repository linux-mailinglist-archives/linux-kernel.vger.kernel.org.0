Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E00715D6FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2020 12:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgBNLzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 06:55:55 -0500
Received: from foss.arm.com ([217.140.110.172]:60292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbgBNLzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 06:55:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D131D1FB;
        Fri, 14 Feb 2020 03:55:54 -0800 (PST)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 429223F68F;
        Fri, 14 Feb 2020 03:55:52 -0800 (PST)
Subject: Re: [patch V2 05/17] MIPS: vdso: Compile high resolution parts
 conditionally
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andrei Vagin <avagin@gmail.com>
References: <20200207123847.339896630@linutronix.de>
 <20200207124402.714585315@linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <8c0ee70a-2bb6-ebb3-05cf-ff305cbef70b@arm.com>
Date:   Fri, 14 Feb 2020 11:55:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207124402.714585315@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 12:38 PM, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> If neither the R4K nor the GIC timer is enabled in the kernel configuration
> then let the core VDSO code drop the high resolution parts at compile time.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/mips/include/asm/vdso/gettimeofday.h |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/arch/mips/include/asm/vdso/gettimeofday.h
> +++ b/arch/mips/include/asm/vdso/gettimeofday.h
> @@ -199,6 +199,13 @@ static __always_inline u64 __arch_get_hw
>  	return cycle_now;
>  }
>  
> +static inline bool mips_vdso_hres_capable(void)
> +{
> +	return IS_ENABLED(CONFIG_CSRC_R4K) ||
> +	       IS_ENABLED(CONFIG_CLKSRC_MIPS_GIC);
> +}
> +#define __arch_vdso_hres_capable mips_vdso_hres_capable
> +
>  static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
>  {
>  	return get_vdso_data();
> 

-- 
Regards,
Vincenzo
