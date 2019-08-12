Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C30F189E33
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfHLMYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 08:24:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59870 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbfHLMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:24:46 -0400
Received: from p200300ddd71876867e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7686:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hx9NI-0003qj-7W; Mon, 12 Aug 2019 14:24:32 +0200
Date:   Mon, 12 Aug 2019 14:24:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Daniel Drake <drake@endlessm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] x86/apic: Handle missing global clockevent gracefully
In-Reply-To: <1803ad97-74f4-28c6-58c8-c52b3d1e5b1f@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1908121423040.7324@nanos.tec.linutronix.de>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com> <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com> <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de> <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de> <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com> <alpine.DEB.2.21.1908011054210.1965@nanos.tec.linutronix.de> <3d14b0cc-3cca-1874-3521-4ee2ec52141d@amd.com> <alpine.DEB.2.21.1908082235590.2882@nanos.tec.linutronix.de>
 <5bf28ba4-b7c1-51de-88ae-feebae2a28db@amd.com> <alpine.DEB.2.21.1908082306220.2882@nanos.tec.linutronix.de> <75e59ac6-5165-bd0a-aec9-be16d662ece9@amd.com> <alpine.DEB.2.21.1908091443030.21433@nanos.tec.linutronix.de>
 <1803ad97-74f4-28c6-58c8-c52b3d1e5b1f@linux.intel.com>
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

On Mon, 12 Aug 2019, Li, Aubrey wrote:
> On 2019/8/9 20:54, Thomas Gleixner wrote:
> > +	local_irq_disable();
> >  	/*
> >  	 * Setup the APIC counter to maximum. There is no way the lapic
> >  	 * can underflow in the 100ms detection time frame
> >  	 */
> >  	__setup_APIC_LVTT(0xffffffff, 0, 0);
> >  
> > -	/* Let the interrupts run */
> > -	local_irq_enable();
> > +	/*
> > +	 * Methods to terminate the calibration loop:
> > +	 *  1) Global clockevent if available (jiffies)
> > +	 *  2) TSC if available and frequency is known
> > +	 */
> > +	jif_start = READ_ONCE(jiffies);
> > +
> > +	if (tsc_khz) {
> > +		tsc_start = rdtsc();
> > +		tsc_perj = div_u64((u64)tsc_khz * 1000, HZ);
> > +	}
> > +
> > +	while (lapic_cal_loops <= LAPIC_CAL_LOOPS) {
> 
> Is this loop still meaningful, can we just invoke the handler twice
> before and after the tick?

And that solves what?

> Thanks,
> -Aubrey

<Remove tons of useless quote>

Can you please trim your replies?

Thanks,

	tglx
	
