Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0E9EB585
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfJaQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 12:57:01 -0400
Received: from foss.arm.com ([217.140.110.172]:52308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbfJaQ5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:57:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F3A1FB;
        Thu, 31 Oct 2019 09:57:00 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D0743F6C4;
        Thu, 31 Oct 2019 09:56:59 -0700 (PDT)
Date:   Thu, 31 Oct 2019 16:56:57 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 4/6] sched/fair: update cpu_capcity to reflect thermal
 pressure
Message-ID: <20191031165656.oad63hug4t7nlopl@e107158-lin.cambridge.arm.com>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-5-git-send-email-thara.gopinath@linaro.org>
 <20191023122252.dz7obopab6iizy4s@e107158-lin.cambridge.arm.com>
 <20191028153010.GE4097@hirez.programming.kicks-ass.net>
 <20191031105342.b3sl5xhysldfla3g@e107158-lin.cambridge.arm.com>
 <5DBB05BC.40502@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5DBB05BC.40502@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/19 12:03, Thara Gopinath wrote:
> On 10/31/2019 06:53 AM, Qais Yousef wrote:
> > On 10/28/19 16:30, Peter Zijlstra wrote:
> >> On Wed, Oct 23, 2019 at 01:28:40PM +0100, Qais Yousef wrote:
> >>> On 10/22/19 16:34, Thara Gopinath wrote:
> >>>> cpu_capacity relflects the maximum available capacity of a cpu. Thermal
> >>>> pressure on a cpu means this maximum available capacity is reduced. This
> >>>> patch reduces the average thermal pressure for a cpu from its maximum
> >>>> available capacity so that cpu_capacity reflects the actual
> >>>> available capacity.
> >>>>
> >>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> >>>> ---
> >>>>  kernel/sched/fair.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index 4f9c2cb..be3e802 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -7727,6 +7727,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
> >>>>  
> >>>>  	used = READ_ONCE(rq->avg_rt.util_avg);
> >>>>  	used += READ_ONCE(rq->avg_dl.util_avg);
> >>>> +	used += READ_ONCE(rq->avg_thermal.load_avg);
> >>>
> >>> Maybe a naive question - but can we add util_avg with load_avg without
> >>> a conversion? I thought the 2 signals have different properties.
> >>
> >> Changelog of patch #1 explains, it's in that dense blob of text.
> >>
> >> But yes, you're quite right that that wants a comment here.
> > 
> > Thanks for the pointer! A comment would be nice indeed.
> > 
> > To make sure I got this correctly - it's because avg_thermal.load_avg
> > represents delta_capacity which is already a 'converted' form of load. So this
> > makes avg_thermal.load_avg a util_avg really. Correct?
> Hello Quais,
> 
> Sorry for not replying to your earlier email. Thanks for the review.
> So if you look at the code, util_sum in calculated as a binary signal
> converted into capacity. Check out the the below snippet from accumulate_sum
> 
>    if (load)
>                 sa->load_sum += load * contrib;
>         if (runnable)
>                 sa->runnable_load_sum += runnable * contrib;
>         if (running)
>                 sa->util_sum += contrib << SCHED_CAPACITY_SHIFT;
> 
> So the actual delta for the thermal pressure will never be considered
> if util_avg is used.
> 
> I will update this patch with relevant comment.

Okay thanks for the explanation.

--
Qais Yousef
