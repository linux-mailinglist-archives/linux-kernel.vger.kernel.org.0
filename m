Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEC9D8515
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2019 02:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390385AbfJPAup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Oct 2019 20:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfJPAup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 20:50:45 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4AC62067B;
        Wed, 16 Oct 2019 00:50:43 +0000 (UTC)
Subject: Re: [PATCH 10/34] m68k/coldfire: Use CONFIG_PREEMPTION
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-11-bigeasy@linutronix.de>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <39d20c16-50a4-34f5-f98c-979138bf1a29@linux-m68k.org>
Date:   Wed, 16 Oct 2019 10:50:41 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015191821.11479-11-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 16/10/19 5:17 am, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the entry code over to use CONFIG_PREEMPTION.
> 
> Cc: Greg Ungerer <gerg@linux-m68k.org>

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Do you want me to take this via the m68knommu git tree?
Or are you taking the whole series via some other tree?

Regards
Greg


> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   arch/m68k/coldfire/entry.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/coldfire/entry.S b/arch/m68k/coldfire/entry.S
> index 52d312d5b4d4f..d43a02795a4a4 100644
> --- a/arch/m68k/coldfire/entry.S
> +++ b/arch/m68k/coldfire/entry.S
> @@ -108,7 +108,7 @@ ENTRY(system_call)
>   	btst	#5,%sp@(PT_OFF_SR)	/* check if returning to kernel */
>   	jeq	Luser_return		/* if so, skip resched, signals */
>   
> -#ifdef CONFIG_PREEMPT
> +#ifdef CONFIG_PREEMPTION
>   	movel	%sp,%d1			/* get thread_info pointer */
>   	andl	#-THREAD_SIZE,%d1	/* at base of kernel stack */
>   	movel	%d1,%a0
> 
