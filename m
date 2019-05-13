Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3F1B3B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2019 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfEMKNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 May 2019 06:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbfEMKNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 06:13:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D50E308FC22;
        Mon, 13 May 2019 10:13:07 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64FFC68438;
        Mon, 13 May 2019 10:13:05 +0000 (UTC)
Date:   Mon, 13 May 2019 12:13:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 9/9] perf/x86: Use update attribute groups for default
 attributes
Message-ID: <20190513101304.GC9646@krava>
References: <20190512155518.21468-1-jolsa@kernel.org>
 <20190512155518.21468-10-jolsa@kernel.org>
 <20190513093545.GM2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513093545.GM2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 13 May 2019 10:13:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:35:45AM +0200, Peter Zijlstra wrote:
> On Sun, May 12, 2019 at 05:55:18PM +0200, Jiri Olsa wrote:
> > Using the new pmu::update_attrs attribute group for default
> > attributes - freeze_on_smi, allow_tsx_force_abort.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 7db858c3bbec..e721be25abfb 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3888,8 +3888,6 @@ static __initconst const struct x86_pmu core_pmu = {
> >  	.check_period		= intel_pmu_check_period,
> >  };
> >  
> > -static struct attribute *intel_pmu_attrs[];
> > -
> >  static __initconst const struct x86_pmu intel_pmu = {
> >  	.name			= "Intel",
> >  	.handle_irq		= intel_pmu_handle_irq,
> > @@ -3921,8 +3919,6 @@ static __initconst const struct x86_pmu intel_pmu = {
> >  	.format_attrs		= intel_arch3_formats_attr,
> >  	.events_sysfs_show	= intel_event_sysfs_show,
> >  
> > -	.attrs			= intel_pmu_attrs,
> > -
> >  	.cpu_prepare		= intel_pmu_cpu_prepare,
> >  	.cpu_starting		= intel_pmu_cpu_starting,
> >  	.cpu_dying		= intel_pmu_cpu_dying,
> > @@ -4449,6 +4445,10 @@ static struct attribute_group group_format_extra_skl = {
> >  	.is_visible = exra_is_visible,
> >  };
> >  
> > +static struct attribute_group group_default = {
> > +	.attrs = intel_pmu_attrs,
> > +};
> > +
> >  static const struct attribute_group *attr_update[] = {
> >  	&group_events_td,
> >  	&group_events_mem,
> > @@ -4457,6 +4457,7 @@ static const struct attribute_group *attr_update[] = {
> >  	&group_caps_lbr,
> >  	&group_format_extra,
> >  	&group_format_extra_skl,
> > +	&group_default,
> >  	NULL,
> >  };
> 
> 
> Ah, I would have expected to see this somewhat dodgy hack go away too:
> 
> 	static struct attribute *intel_pmu_attrs[] = {
> 		&dev_attr_freeze_on_smi.attr,
> 		NULL, /* &dev_attr_allow_tsx_force_abort.attr.attr */
> 		NULL,
> 	};
> 
> 	intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;
> 
> 
> That just begs for a .visislbe too, right?

right, we could do that.. I'll check on it and send separate patch

thanks,
jirka
