Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AC58E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 00:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfF0Wot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 18:44:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfF0Wos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:44:48 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hgd8B-00022x-EQ; Fri, 28 Jun 2019 00:44:40 +0200
Date:   Fri, 28 Jun 2019 00:44:38 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Stephane Eranian <eranian@google.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>
Subject: Re: [patch 26/29] x86/hpet: Consolidate clockevent functions
In-Reply-To: <20190626211753.GB101255@gmail.com>
Message-ID: <alpine.DEB.2.21.1906280041160.32342@nanos.tec.linutronix.de>
References: <20190623132340.463097504@linutronix.de> <20190623132436.461437795@linutronix.de> <20190626211753.GB101255@gmail.com>
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

On Wed, 26 Jun 2019, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> > -	evt->set_state_shutdown = hpet_msi_shutdown;
> > -	evt->set_state_oneshot = hpet_msi_set_oneshot;
> > -	evt->tick_resume = hpet_msi_resume;
> > -	evt->set_next_event = hpet_msi_next_event;
> > +	evt->set_state_shutdown = hpet_clkevt_shutdown;
> > +	evt->set_state_oneshot = hpet_clkevt_set_oneshot;
> > +	evt->set_next_event = hpet_clkevt_set_next_event;
> > +	evt->tick_resume = hpet_clkevt_msi_resume;
> >  	evt->cpumask = cpumask_of(hc->cpu);
> 
> My compulsive-obsessive half really wants this to look like:
> 
> > +	evt->set_state_shutdown	= hpet_clkevt_shutdown;
> > +	evt->set_state_oneshot	= hpet_clkevt_set_oneshot;
> > +	evt->set_next_event	= hpet_clkevt_set_next_event;
> > +	evt->tick_resume	= hpet_clkevt_msi_resume;
> >  	evt->cpumask		= cpumask_of(hc->cpu);

Just to remove all of that in the next patch again, which then has the
proper aligned thing to make you happy :)

> Also, maybe harmonize the callback names with the local function names, 
> like hpet_clkevt_set_next_event() already does and 
> hpet_clkevt_set_oneshot() almost does:
> 
>  s/hpet_clkevt_shutdown
>   /hpet_clkevt_set_state_shutdown
> 
>  s/hpet_clkevt_set_oneshot
>   /hpet_clkevt_set_state_oneshot
> 
>  s/hpet_clkevt_msi_resume
>   /hpet_clkevt_tick_resume
> 
> ... unless the name variations have some hidden purpose and meaning?

Historical but we want to preserve some of the old stuff for sentimental
reasons.

Thanks,

	tglx
