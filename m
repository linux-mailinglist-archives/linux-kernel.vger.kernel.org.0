Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4F135EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 17:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbgAIQvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 11:51:50 -0500
Received: from foss.arm.com ([217.140.110.172]:34604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731549AbgAIQvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:51:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 988491FB;
        Thu,  9 Jan 2020 08:51:49 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 519C73F703;
        Thu,  9 Jan 2020 08:51:48 -0800 (PST)
Date:   Thu, 9 Jan 2020 16:51:46 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC v5 56/57] arm64: entry: Avoid empty alternatives entries
Message-ID: <20200109165145.GI3112@lakrids.cambridge.arm.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-57-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-57-jthierry@redhat.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:59PM +0000, Julien Thierry wrote:
> kernel_ventry will create alternative entries to potentially replace
> 0 instructions with 0 instructions for EL1 vectors. While this does not
> cause an issue, it pointlessly takes up some bytes in the alternatives
> section.
> 
> Do not generate such entries.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>

This looks like a sensible cleanup on its own. FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/entry.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 7c6a0a41676f..605bb7cbe499 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -60,16 +60,16 @@
>  	.macro kernel_ventry, el, label, regsize = 64
>  	.align 7
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> -alternative_if ARM64_UNMAP_KERNEL_AT_EL0
>  	.if	\el == 0
> +alternative_if ARM64_UNMAP_KERNEL_AT_EL0
>  	.if	\regsize == 64
>  	mrs	x30, tpidrro_el0
>  	msr	tpidrro_el0, xzr
>  	.else
>  	mov	x30, xzr
>  	.endif
> -	.endif
>  alternative_else_nop_endif
> +	.endif
>  #endif
>  
>  	sub	sp, sp, #S_FRAME_SIZE
> -- 
> 2.21.0
> 
