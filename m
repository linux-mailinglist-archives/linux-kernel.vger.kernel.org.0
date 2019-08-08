Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DE686BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2019 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbfHHUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Aug 2019 16:37:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54222 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfHHUhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:37:08 -0400
Received: from p200300ddd71876597e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7659:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvp9Y-0007ps-VX; Thu, 08 Aug 2019 22:36:53 +0200
Date:   Thu, 8 Aug 2019 22:36:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
In-Reply-To: <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com>
Message-ID: <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com> <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com> <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de> <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de> <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com> <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de> <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom,

On Thu, 1 Aug 2019, Lendacky, Thomas wrote:
> On 8/1/19 5:13 AM, Thomas Gleixner wrote:
> >   2.1.9 Timers
> > 
> >    Each core includes the following timers. These timers do not vary in
> >    frequency regardless of the current P-state or C-state.
> > 
> >    * Core::X86::Msr::TSC; the TSC increments at the rate specified by the
> >      P0 Pstate. See Core::X86::Msr::PStateDef.
> > 
> >    * The APIC timer (Core::X86::Apic::TimerInitialCount and
> >      Core::X86::Apic::TimerCurrentCount), which increments at the rate of
> >      2xCLKIN; the APIC timer may increment in units of between 1 and 8.
> > 
> > The Ryzens use a 100MHz input clock for the APIC normally, but I'm not sure
> > whether this is subject to overclocking. If so then it should be possible
> > to figure that out somehow. Tom?
> 
> Let me check with the hardware folks and I'll get back to you.

any update on this? The problem seems to come in from several sides now.

Thanks,

	tglx
