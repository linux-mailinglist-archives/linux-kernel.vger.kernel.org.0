Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 068EE46387
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 17:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfFNP7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 11:59:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38782 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfFNP7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:59:45 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hboc2-0002RQ-MH; Fri, 14 Jun 2019 17:59:34 +0200
Date:   Fri, 14 Jun 2019 17:59:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH v4 03/21] x86/hpet: Calculate ticks-per-second in a
 separate function
In-Reply-To: <alpine.DEB.2.21.1906141749330.1722@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906141756430.1722@nanos.tec.linutronix.de>
References: <1558660583-28561-1-git-send-email-ricardo.neri-calderon@linux.intel.com> <1558660583-28561-4-git-send-email-ricardo.neri-calderon@linux.intel.com> <alpine.DEB.2.21.1906141749330.1722@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jun 2019, Thomas Gleixner wrote:
> On Thu, 23 May 2019, Ricardo Neri wrote:
> >  int hpet_alloc(struct hpet_data *hdp)
> >  {
> >  	u64 cap, mcfg;
> > @@ -844,7 +867,6 @@ int hpet_alloc(struct hpet_data *hdp)
> >  	struct hpets *hpetp;
> >  	struct hpet __iomem *hpet;
> >  	static struct hpets *last;
> > -	unsigned long period;
> >  	unsigned long long temp;
> >  	u32 remainder;
> >  
> > @@ -894,12 +916,7 @@ int hpet_alloc(struct hpet_data *hdp)
> >  
> >  	last = hpetp;
> >  
> > -	period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
> > -		HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
> > -	temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
> > -	temp += period >> 1; /* round */
> > -	do_div(temp, period);
> > -	hpetp->hp_tick_freq = temp; /* ticks per second */
> > +	hpetp->hp_tick_freq = hpet_get_ticks_per_sec(cap);
> 
> Why are we actually computing this over and over?
> 
> In hpet_enable() which is the first function invoked we have:
> 
>         /*
>          * The period is a femto seconds value. Convert it to a
>          * frequency.
>          */
>         freq = FSEC_PER_SEC;
>         do_div(freq, hpet_period);
>         hpet_freq = freq;
> 
> So we already have ticks per second, aka frequency, right? So why do we
> need yet another function instead of using the value which is computed
> once? The frequency of the HPET channels has to be identical no matter
> what. If it's not HPET is broken beyond repair.

Aside of that this change breaks the IA64 support for /dev/hpet.

Thanks,

	tglx
