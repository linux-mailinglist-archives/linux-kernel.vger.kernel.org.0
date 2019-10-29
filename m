Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D11E8882
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2019 13:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbfJ2Mn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Oct 2019 08:43:28 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46041 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfJ2Mn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:43:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id x21so2710141qto.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OMRxOWZpu1dr96++kRLkGqF4JG/vk7voGkpNSd1iKXw=;
        b=ozcm2IWkf2kNtuYCUjt+8ArvFK/2tKRtrBxPUJbunA7rPNlc0HxCY71sOWY0wV6yle
         VMaj+9CPSz7Yh+ObskBaZxF9CqEBImBFo4eqIbA/24KRyE8rBYcXoqKjRR4hwZ0qfPJO
         F0EaQVN+YNPh/tNG58mPvXtcqsJZiw7ZiYHf1FBOuACg8X8xJeJDCtMf8QuKRHKPg2c0
         uNVeP+ABNB3gsrrfXF8eQ2co4oiynkaswFhPcMWQMivdB92SNJhepyCg18vMBP7iW/DD
         8UYO8Qt3O9X5/xm/wHCkzkG+AmSkAdPwsvYNzEjD3JbgHgEwtq8TUO94E8rJy5ospivy
         pi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OMRxOWZpu1dr96++kRLkGqF4JG/vk7voGkpNSd1iKXw=;
        b=SlotPGe65bXKmJzGRbe4stc+sgSEC2EXtnRBuYLVmu5zFH1sSx4f9WfamET/5ZBVnt
         kxvn7EKkJYwrKY+CJnrPMKUjAF1/lIIZ8X0+SBnb0Aw/fja1bT7g4iYBOX5sPYSQasz/
         9L6QZupmJ75XZAUw9Zhuq+NZMYVxL1nZ9urtPlUMTdaTlSzgQ06zGO9cYinl5zC42GDG
         dZdBq/Gk86vQrPX5xgvsqkRTQDA+P5YYVU0d5Xce1+b1e+eEgEF6FU25evm99tydtjHA
         wbdyoSLa9gjbbsmN62O9e0vYT+hBiRzHlnq8WZVOOPqcUMBISOu9wRJsTvS4K149L53W
         02cQ==
X-Gm-Message-State: APjAAAUE2QWHa2HDs1+bvFeLjjqb8fvC69quhERnSXCbax22DfiulGVh
        uGIO8THgw0Kl0SkMU1C9FSFSRNjzc5BRWj6xibFh0A==
X-Google-Smtp-Source: APXvYqzDWQWqlapgFtGMUJS/HwMqtmBfC0dOaSKIjA060RzLLknu6eGt8PRIEE29kq1TixIMsSkusE9tCw1vWzpaF9o=
X-Received: by 2002:ac8:cc3:: with SMTP id o3mr4052238qti.239.1572353005620;
 Tue, 29 Oct 2019 05:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191015084139.8510-1-benjamin.gaignard@st.com>
In-Reply-To: <20191015084139.8510-1-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 29 Oct 2019 13:43:14 +0100
Message-ID: <CA+M3ks51SNOfM9YJFv8wkLDar0qvbwGQVzVwxEVP7T=bGeTcKw@mail.gmail.com>
Subject: Re: [PATCH] arm: kernel: initialize broadcast hrtimer based clock
 event device
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com, maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 15 oct. 2019 =C3=A0 10:42, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> On platforms implementing CPU power management, the CPUidle subsystem
> can allow CPUs to enter idle states where local timers logic is lost on p=
ower
> down. To keep the software timers functional the kernel relies on an
> always-on broadcast timer to be present in the platform to relay the
> interrupt signalling the timer expiries.
>
> For platforms implementing CPU core gating that do not implement an alway=
s-on
> HW timer or implement it in a broken way, this patch adds code to initial=
ize
> the kernel hrtimer based clock event device upon boot (which can be chose=
n as
> tick broadcast device by the kernel).
> It relies on a dynamically chosen CPU to be always powered-up. This CPU t=
hen
> relays the timer interrupt to CPUs in deep-idle states through its HW loc=
al
> timer device.
>
> Having a CPU always-on has implications on power management platform
> capabilities and makes CPUidle suboptimal, since at least a CPU is kept
> always in a shallow idle state by the kernel to relay timer interrupts,
> but at least leaves the kernel with a functional system with some working
> power management capabilities.
>
> The hrtimer based clock event device is unconditionally registered, but
> has the lowest possible rating such that any broadcast-capable HW clock
> event device present will be chosen in preference as the tick broadcast
> device.

Gentle ping,

Thanks,
Benjamin
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> Note:
> - The same reasons lead to same patch than for arm64 so I have copy the
>   commit message from: 9358d755bd5c ("arm64: kernel: initialize broadcast
>   hrtimer based clock event device")
>  arch/arm/kernel/time.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index b996b2cf0703..dddc7ebf4db4 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -9,6 +9,7 @@
>   *  reading the RTC at bootup, etc...
>   */
>  #include <linux/clk-provider.h>
> +#include <linux/clockchips.h>
>  #include <linux/clocksource.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> @@ -107,5 +108,6 @@ void __init time_init(void)
>                 of_clk_init(NULL);
>  #endif
>                 timer_probe();
> +               tick_setup_hrtimer_broadcast();
>         }
>  }
> --
> 2.15.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
