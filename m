Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2EE131A15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jan 2020 22:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgAFVHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jan 2020 16:07:46 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46256 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgAFVHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:07:45 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so50116591ioi.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 13:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRpwQviknb25UoZmbJMLN6EJGSP9FYuSxPxJ31clxVs=;
        b=b3B5l/u9gjT+OpYHkhEegMK+pBwrPRkSjcRruBCbXIAjTmW48tye354OZERmQSamB4
         Pjhy7cDKQeD0thwr0RaYeHK3mokcLMiTaSz73ClS8ThVz1b7Xh1glcIw/XliWXWe89aG
         rlWq2dTdRX3UdRtC8BzSOc3OkazGkrp+7veIltbgQAIWHYw4eQVhAMmA5wygomf1G+dB
         gUdpD85w9ZnSfpJ7rzTdVvEs4vpZOrZw6H2JE2k16gfkiogmGfY2yA29+1vfJw5CW0ep
         iMhCompfFlJYZ8HF38JfyA7iOWkigqMftEDU4Kl7td+2HG3SbsZse6lbr0NRRRzF4APL
         lxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRpwQviknb25UoZmbJMLN6EJGSP9FYuSxPxJ31clxVs=;
        b=eBUGw9wo9uDTMzyzXNoHynLVr4xojd16Qt3Ev7mpD53ITNlp2tdop4TagKaTISrawk
         bB0Tnqi3y1H2RTloqW7iNtMpj/5xM+nxqoDALpWMKKH2/9fy2ziyKRvynmz8YU/VRST1
         UsZR4C6Ioe6PcAmwk+B6fvkYNEEx2UD+mc0K1/+AR/66Jot+mrC/GF5Bon7oR8tPW1Zk
         leAtpnAMAa2igOkt0t0/YsbDrTxUWipWlxOhGEZlJdn3JomNk4XtSgIrI3s7aho50okH
         WbBZeQ0WFXujqYscDHjqTeM9bMa7sF9xxwx+58p/qAC8beeU7PcgruDCRnIUyufDEGSs
         Nr5Q==
X-Gm-Message-State: APjAAAUJsa+ziqrBepGdCFUy19OhK1ISIDppLx+AtOP758ml5YLs33E/
        TPviGZ8DYxvAydLNf76xTDA9U8J/KVLdtPHCDfjc6g==
X-Google-Smtp-Source: APXvYqzc+ndsPGVWQqd03R9vgmoEdYCbRH0T8wxQshOrpgT1uPAz0/P2devjATpA6jCfqYmFYGzlDY97JfI5jbp1ng0=
X-Received: by 2002:a02:ce8a:: with SMTP id y10mr71794309jaq.21.1578344863555;
 Mon, 06 Jan 2020 13:07:43 -0800 (PST)
MIME-Version: 1.0
References: <20200106203700.21009-1-tony@atomide.com>
In-Reply-To: <20200106203700.21009-1-tony@atomide.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 6 Jan 2020 13:07:32 -0800
Message-ID: <CAOesGMiNbyUXwPFsG-ipTn-xfEs+A2hG8Q8MTcSLz5794GCv0g@mail.gmail.com>
Subject: Re: [PATCH] clocksource: timer-ti-dm: Fix regression
To:     Tony Lindgren <tony@atomide.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 12:37 PM Tony Lindgren <tony@atomide.com> wrote:
>
> Clean-up commit 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to
> platform_get_irq") caused a regression where we now try to access
> uninitialized data for timer:
>
> drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
> drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>
> On boot we now get:
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000004
> ...
> (omap_dm_timer_probe) from [<c061ac7c>] (platform_drv_probe+0x48/0x98)
> (platform_drv_probe) from [<c0618c04>] (really_probe+0x1dc/0x348)
> (really_probe) from [<c0618ef4>] (driver_probe_device+0x5c/0x160)
>
> Let's fix the issue by moving platform_get_irq to happen after timer has
> been allocated.
>
> Fixes: 8c82723414d5 ("clocksource/drivers/timer-ti-dm: Switch to platform_get_irq")
> Cc: Yangtao Li <tiny.windzz@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Olof Johansson <olof@lixom.net>

> ---
>
> I did not notice simlar issue with other patches in the series, but
> please do double check Yangtao.

Yeah, this even seems to be caught at build (but our builds have been
so noisy with warnings lately that they're hard to spot):

/build/drivers/clocksource/timer-ti-dm.c: In function 'omap_dm_timer_probe':
/build/drivers/clocksource/timer-ti-dm.c:798:13: warning: 'timer' may
be used uninitialized in this function [-Wmaybe-uninitialized]
  798 |  timer->irq = platform_get_irq(pdev, 0);
      |  ~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~


-Olof
