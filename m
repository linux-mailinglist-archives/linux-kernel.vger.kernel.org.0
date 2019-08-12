Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B4689F04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 15:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfHLM7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 08:59:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44458 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHLM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:59:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id e24so1504856ljg.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2Nq/zcAHmKnyWJZUFugKDFlDxB+1xeCPHyjsiZ4S/U=;
        b=Ox3zecLLBuTUitWMEKguTdU+91neVQRMhUjF6XXwufTANvpF5wwbvg6lM78G+Xci5J
         G1tchLUxkpKCj/Y26M92mAcJRJSu9KaiN6smELAF0Q2nUpe6XEUap8WZ//TMKWUR5DwT
         +cw4rg1DGLeah4TpC2+nEkyq+6Lc9hakaFV2uI45V9ZqAUP4v+f2lR7ah2r6nDBtXpUQ
         xfIOmb52HehnFaFM9Gs84NzOw3jrumOVjQfcQqZEbDFNgjifAG20QNgIOeP5JcEblyYv
         tPkUqHQ9MhstecI/OjGLmqhkAPbiLgfcSui740aqrmvu8m5+P1FZf4GVGKLUQUzJyIVM
         w5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2Nq/zcAHmKnyWJZUFugKDFlDxB+1xeCPHyjsiZ4S/U=;
        b=lyIb1ddV2tJYsR+Q+RQZb8W9+FwgyCmUKvFY5fyl75/FV7x9PFdx9kqhM6hnnIQptt
         gp5F3IzSV1HIIb+2AIInssAGuEu48e0ZdwMXkDlS0RsNXEWE2WOXoI++7Zy1buwid0fg
         a1ewgrOqWhTSgptfugzDWu+ydMXb8Xv0DMNxCQOmhzpjrtvxQzgyJFIpdFnlBORxjKuh
         PNg+eGjSyHUH+4XR5eHr2k3rbS2r1tfIloJo+LG6YNUie1jGbwcRef2e2JdPUmkaBmpw
         Rxqnt2+o7VsQ1W8qPNdNemb+7U5znqxhJxoVDUXx0/lfRnQ6F7vniS+brEyFuDZc93/t
         /n0g==
X-Gm-Message-State: APjAAAVRLhJF+g/bywcG0cy2aLJGn7TI+L2uo7lyGGP7+k7k2VK+NQ4m
        B0vNpnz80gwdUrpDVjiGo0oBPE1Hqqc3WMBRbf4=
X-Google-Smtp-Source: APXvYqxwe25Z+YQzEjGWC7ePKovdbzR8uhCgFxhBz9fGHIchB8hh/uLGhqKsLm+UkHO3cKBtu/UqoezbFItlEudWmEk=
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr18122610lji.84.1565614793893;
 Mon, 12 Aug 2019 05:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
 <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com> <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de>
 <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com> <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com> <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de>
 <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com> <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
 <1803ad97-74f4-28c6-58c8-c52b3d1e5b1f@linux.intel.com> <alpine.DEB.2.21.1908121423040.7324@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908121423040.7324@nanos.tec.linutronix.de>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Mon, 12 Aug 2019 20:59:42 +0800
Message-ID: <CAERHkrttXdZhZHZs+JasZU6a2kEb1vc6KB25+LbpQycenJZpOg@mail.gmail.com>
Subject: Re: [PATCH] x86/apic: Handle missing global clockevent gracefully
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 8:25 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 12 Aug 2019, Li, Aubrey wrote:
> > On 2019/8/9 20:54, Thomas Gleixner wrote:
> > > +   local_irq_disable();
> > >     /*
> > >      * Setup the APIC counter to maximum. There is no way the lapic
> > >      * can underflow in the 100ms detection time frame
> > >      */
> > >     __setup_APIC_LVTT(0xffffffff, 0, 0);
> > >
> > > -   /* Let the interrupts run */
> > > -   local_irq_enable();
> > > +   /*
> > > +    * Methods to terminate the calibration loop:
> > > +    *  1) Global clockevent if available (jiffies)
> > > +    *  2) TSC if available and frequency is known
> > > +    */
> > > +   jif_start = READ_ONCE(jiffies);
> > > +
> > > +   if (tsc_khz) {
> > > +           tsc_start = rdtsc();
> > > +           tsc_perj = div_u64((u64)tsc_khz * 1000, HZ);
> > > +   }
> > > +
> > > +   while (lapic_cal_loops <= LAPIC_CAL_LOOPS) {
> >
> > Is this loop still meaningful, can we just invoke the handler twice
> > before and after the tick?
>
> And that solves what?
>

I meant, can we do this one time?
- lapic_cal_t1 = read APIC counter
- /* Wait for a tick to elapse */
- lapic_cal_t2 = read APIC counter

I'm not clear why we still need this loop, to use the
existing lapic_cal_handler()?

Thanks,
-Aubrey
