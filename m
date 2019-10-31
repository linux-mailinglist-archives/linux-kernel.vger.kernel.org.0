Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89B2EADE4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 11:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfJaKxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 06:53:48 -0400
Received: from foss.arm.com ([217.140.110.172]:46982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfJaKxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:53:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4BB71F1;
        Thu, 31 Oct 2019 03:53:47 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A2483F719;
        Thu, 31 Oct 2019 03:53:46 -0700 (PDT)
Date:   Thu, 31 Oct 2019 10:53:43 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, edubezval@gmail.com, qperret@google.com,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [Patch v4 4/6] sched/fair: update cpu_capcity to reflect thermal
 pressure
Message-ID: <20191031105342.b3sl5xhysldfla3g@e107158-lin.cambridge.arm.com>
References: <1571776465-29763-1-git-send-email-thara.gopinath@linaro.org>
 <1571776465-29763-5-git-send-email-thara.gopinath@linaro.org>
 <20191023122252.dz7obopab6iizy4s@e107158-lin.cambridge.arm.com>
 <20191028153010.GE4097@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028153010.GE4097@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/19 16:30, Peter Zijlstra wrote:
> On Wed, Oct 23, 2019 at 01:28:40PM +0100, Qais Yousef wrote:
> > On 10/22/19 16:34, Thara Gopinath wrote:
> > > cpu_capacity relflects the maximum available capacity of a cpu. Thermal
> > > pressure on a cpu means this maximum available capacity is reduced. This
> > > patch reduces the average thermal pressure for a cpu from its maximum
> > > available capacity so that cpu_capacity reflects the actual
> > > available capacity.
> > > 
> > > Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> > > ---
> > >  kernel/sched/fair.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 4f9c2cb..be3e802 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7727,6 +7727,7 @@ static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
> > >  
> > >  	used = READ_ONCE(rq->avg_rt.util_avg);
> > >  	used += READ_ONCE(rq->avg_dl.util_avg);
> > > +	used += READ_ONCE(rq->avg_thermal.load_avg);
> > 
> > Maybe a naive question - but can we add util_avg with load_avg without
> > a conversion? I thought the 2 signals have different properties.
> 
> Changelog of patch #1 explains, it's in that dense blob of text.
> 
> But yes, you're quite right that that wants a comment here.

Thanks for the pointer! A comment would be nice indeed.

To make sure I got this correctly - it's because avg_thermal.load_avg
represents delta_capacity which is already a 'converted' form of load. So this
makes avg_thermal.load_avg a util_avg really. Correct?

If I managed to get it right somehow. It'd be nice if we can do inverse
conversion on delta_capacity so that avg_thermal.{load_avg, util_avg} meaning
is consistent across the board. But I don't feel strongly about it if this gets
documented properly.

Thanks

--
Qais Yousef
