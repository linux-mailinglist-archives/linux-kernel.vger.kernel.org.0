Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75380F08C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 22:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbfKEVxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 16:53:43 -0500
Received: from foss.arm.com ([217.140.110.172]:54648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbfKEVxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 16:53:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2663246A;
        Tue,  5 Nov 2019 13:53:43 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.199.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAD913F6C4;
        Tue,  5 Nov 2019 13:53:42 -0800 (PST)
Date:   Tue, 5 Nov 2019 21:53:41 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v5 2/6] sched/fair: Add infrastructure to store and
 update instantaneous thermal pressure
Message-ID: <20191105215233.GA6450@e108754-lin>
References: <1572979786-20361-1-git-send-email-thara.gopinath@linaro.org>
 <1572979786-20361-3-git-send-email-thara.gopinath@linaro.org>
 <20191105202037.GA17494@e108754-lin>
 <5DC1E348.2090104@linaro.org>
 <20191105211446.GA25349@e108754-lin>
 <5DC1E9BC.1010001@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5DC1E9BC.1010001@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 Nov 2019 at 16:29:32 (-0500), Thara Gopinath wrote:
> On 11/05/2019 04:15 PM, Ionela Voinescu wrote:
> > On Tuesday 05 Nov 2019 at 16:02:00 (-0500), Thara Gopinath wrote:
> >> On 11/05/2019 03:21 PM, Ionela Voinescu wrote:
> >>> Hi Thara,
> >>>
> >>> On Tuesday 05 Nov 2019 at 13:49:42 (-0500), Thara Gopinath wrote:
> >>> [...]
> >>>> +static void trigger_thermal_pressure_average(struct rq *rq)
> >>>> +{
> >>>> +#ifdef CONFIG_SMP
> >>>> +	update_thermal_load_avg(rq_clock_task(rq), rq,
> >>>> +				per_cpu(thermal_pressure, cpu_of(rq)));
> >>>> +#endif
> >>>> +}
> >>>
> >>> Why did you decide to keep trigger_thermal_pressure_average and not
> >>> call update_thermal_load_avg directly?
> >>>
> >>> For !CONFIG_SMP you already have an update_thermal_load_avg function
> >>> that does nothing, in kernel/sched/pelt.h, so you don't need that
> >>> ifdef. 
> >> Hi,
> >>
> >> Yes you are right. But later with the shift option added, I shift
> >> rq_clock_task(rq) by the shift. I thought it is better to contain it in
> >> a function that replicate it in three different places. I can remove the
> >> CONFIG_SMP in the next version.
> > 
> > You could still keep that in one place if you shift the now argument of
> > ___update_load_sum instead.
> 
> No. I cannot do this. The authors of the pelt framework  prefers not to
> include a shift parameter there. I had discussed this with Vincent earlier.
> 

Right! I missed Vincent's last comment on this in v4. 

I would argue that it's more of a PELT parameter than a CFS parameter
:), where it's currently being used. I would also argue that's more of a
PELT parameter than a thermal parameter. It controls the PELT time
progression for the thermal signal, but it seems more to configure the
PELT algorithm, rather than directly characterize thermals.

In any case, it only seemed to me that adding a wrapper function for
this purpose only was not worth doing.

Thank you for clarifying,
Ionela.

> > 
> > To me that trigger_thermal_pressure_average function seems more code
> > than it's worth for this.
> > 
> > Thanks,
> > Ionela.
> > 
> >>>
> >>> Thanks,
> >>> Ionela.
> >>>
> >>>> +
> >>>>  /*
> >>>>   * All the scheduling class methods:
> >>>>   */
> >>>> -- 
> >>>> 2.1.4
> >>>>
> >>
> >>
> >> -- 
> >> Warm Regards
> >> Thara
> 
> 
> -- 
> Warm Regards
> Thara
