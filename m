Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C51788EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfG2Jxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 05:53:31 -0400
Received: from foss.arm.com ([217.140.110.172]:41040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbfG2Jxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:53:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EC661597;
        Mon, 29 Jul 2019 02:53:30 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7C013F694;
        Mon, 29 Jul 2019 02:53:29 -0700 (PDT)
Subject: Re: [PATCH] irqchip/gic-v3: mark expected switch fall-through
To:     Matteo Croce <mcroce@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20190729001119.2478-1-mcroce@redhat.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <3fe34829-7ae5-58e8-48f4-39f0c6122b92@kernel.org>
Date:   Mon, 29 Jul 2019 10:53:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729001119.2478-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2019 01:11, Matteo Croce wrote:
> Mark switch cases where we are expecting to fall through,
> fixes the following warnings:
> 
> drivers/irqchip/irq-gic-v3.c: In function ‘gic_cpu_sys_reg_init’:
> ./arch/arm64/include/asm/sysreg.h:853:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   asm volatile(__msr_s(r, "%x0") : : "rZ" (__val));  \
>   ^~~
> ./arch/arm64/include/asm/arch_gicv3.h:20:29: note: in expansion of macro ‘write_sysreg_s’
>  #define write_gicreg(v, r)  write_sysreg_s(v, SYS_ ## r)
>                              ^~~~~~~~~~~~~~
> drivers/irqchip/irq-gic-v3.c:773:4: note: in expansion of macro ‘write_gicreg’
>     write_gicreg(0, ICC_AP0R2_EL1);
>     ^~~~~~~~~~~~
> drivers/irqchip/irq-gic-v3.c:774:3: note: here
>    case 6:
>    ^~~~
> 
> drivers/irqchip/irq-gic-v3.c:788:3: note: in expansion of macro ‘write_gicreg’
>    write_gicreg(0, ICC_AP1R2_EL1);
>    ^~~~~~~~~~~~
>   CC      net/ipv4/af_inet.o
> drivers/irqchip/irq-gic-v3.c:789:2: note: here
>   case 6:
>   ^~~~
> 
> ./arch/arm64/include/asm/arch_gicv3.h:20:29: note: in expansion of macro ‘write_sysreg_s’
>  #define write_gicreg(v, r)  write_sysreg_s(v, SYS_ ## r)
>                              ^~~~~~~~~~~~~~
> drivers/irqchip/irq-gic-v3.c:790:3: note: in expansion of macro ‘write_gicreg’
>    write_gicreg(0, ICC_AP1R1_EL1);
>    ^~~~~~~~~~~~
> drivers/irqchip/irq-gic-v3.c:791:2: note: here
>   case 5:
>   ^~~~
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 9bca4896fa6f..4a5d220698f6 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -771,8 +771,10 @@ static void gic_cpu_sys_reg_init(void)
>  		case 7:
>  			write_gicreg(0, ICC_AP0R3_EL1);
>  			write_gicreg(0, ICC_AP0R2_EL1);
> +			/* fallthrough */
>  		case 6:
>  			write_gicreg(0, ICC_AP0R1_EL1);
> +			/* fallthrough */
>  		case 5:
>  		case 4:
>  			write_gicreg(0, ICC_AP0R0_EL1);
> @@ -786,8 +788,10 @@ static void gic_cpu_sys_reg_init(void)
>  	case 7:
>  		write_gicreg(0, ICC_AP1R3_EL1);
>  		write_gicreg(0, ICC_AP1R2_EL1);
> +		/* fallthrough */
>  	case 6:
>  		write_gicreg(0, ICC_AP1R1_EL1);
> +		/* fallthrough */
>  	case 5:
>  	case 4:
>  		write_gicreg(0, ICC_AP1R0_EL1);
> 

Already fixed here[1].

	M.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-5.3&id=52f8c8b32ea2f2044efcb4214c1857e29f421c5d
-- 
Jazz is not dead, it just smells funny...
