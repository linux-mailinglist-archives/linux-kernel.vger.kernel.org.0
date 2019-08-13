Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98A8ACF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 05:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHMDEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 23:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfHMDEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 23:04:06 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EAD7206C1;
        Tue, 13 Aug 2019 03:04:04 +0000 (UTC)
Date:   Mon, 12 Aug 2019 23:04:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, mingo@redhat.com,
        tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] trace:Add "gfp_t" support in synthetic_events
Message-ID: <20190812230403.01491479@oasis.local.home>
In-Reply-To: <ac10cc35-96f4-7f67-a259-2398d3136417@linux.intel.com>
References: <20190712015308.9908-1-zhengjun.xing@linux.intel.com>
        <1562947506.12920.0.camel@kernel.org>
        <ac10cc35-96f4-7f67-a259-2398d3136417@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019 09:04:28 +0800
Xing Zhengjun <zhengjun.xing@linux.intel.com> wrote:

> Hi Steve,
> 
>     Could you help to review? Thanks.

Thanks for the ping. Yes, I'll take a look at it. I'll be pulling in a
lot of patches that have queued up.

-- Steve


> 
> On 7/13/2019 12:05 AM, Tom Zanussi wrote:
> > Hi Zhengjun,
> > 
> > On Fri, 2019-07-12 at 09:53 +0800, Zhengjun Xing wrote:  
> >> Add "gfp_t" support in synthetic_events, then the "gfp_t" type
> >> parameter in some functions can be traced.
> >>
> >> Prints the gfp flags as hex in addition to the human-readable flag
> >> string.  Example output:
> >>
> >>    whoopsie-630 [000] ...1 78.969452: testevent: bar=b20
> >> (GFP_ATOMIC|__GFP_ZERO)
> >>      rcuc/0-11  [000] ...1 81.097555: testevent: bar=a20 (GFP_ATOMIC)
> >>      rcuc/0-11  [000] ...1 81.583123: testevent: bar=a20 (GFP_ATOMIC)
> >>
> >> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> >> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>  
> > 
> > Looks good to me, thanks!
> > 
> > Tom
> >   
> >> ---
> >>   kernel/trace/trace_events_hist.c | 19 +++++++++++++++++++
> >>   1 file changed, 19 insertions(+)
> >>
> >> diff --git a/kernel/trace/trace_events_hist.c
> >> b/kernel/trace/trace_events_hist.c
> >> index ca6b0dff60c5..30f0f32aca62 100644
> >> --- a/kernel/trace/trace_events_hist.c
> >> +++ b/kernel/trace/trace_events_hist.c
> >> @@ -13,6 +13,10 @@
> >>   #include <linux/rculist.h>
> >>   #include <linux/tracefs.h>
> >>   
> >> +/* for gfp flag names */
> >> +#include <linux/trace_events.h>
> >> +#include <trace/events/mmflags.h>
> >> +
> >>   #include "tracing_map.h"
> >>   #include "trace.h"
> >>   #include "trace_dynevent.h"
> >> @@ -752,6 +756,8 @@ static int synth_field_size(char *type)
> >>   		size = sizeof(unsigned long);
> >>   	else if (strcmp(type, "pid_t") == 0)
> >>   		size = sizeof(pid_t);
> >> +	else if (strcmp(type, "gfp_t") == 0)
> >> +		size = sizeof(gfp_t);
> >>   	else if (synth_field_is_string(type))
> >>   		size = synth_field_string_size(type);
> >>   
> >> @@ -792,6 +798,8 @@ static const char *synth_field_fmt(char *type)
> >>   		fmt = "%lu";
> >>   	else if (strcmp(type, "pid_t") == 0)
> >>   		fmt = "%d";
> >> +	else if (strcmp(type, "gfp_t") == 0)
> >> +		fmt = "%x";
> >>   	else if (synth_field_is_string(type))
> >>   		fmt = "%s";
> >>   
> >> @@ -834,9 +842,20 @@ static enum print_line_t
> >> print_synth_event(struct trace_iterator *iter,
> >>   					 i == se->n_fields - 1 ? ""
> >> : " ");
> >>   			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> >>   		} else {
> >> +			struct trace_print_flags __flags[] = {
> >> +			    __def_gfpflag_names, {-1, NULL} };
> >> +
> >>   			trace_seq_printf(s, print_fmt, se-  
> >>> fields[i]->name,  
> >>   					 entry->fields[n_u64],
> >>   					 i == se->n_fields - 1 ? ""
> >> : " ");
> >> +
> >> +			if (strcmp(se->fields[i]->type, "gfp_t") ==
> >> 0) {
> >> +				trace_seq_puts(s, " (");
> >> +				trace_print_flags_seq(s, "|",
> >> +						      entry-  
> >>> fields[n_u64],  
> >> +						      __flags);
> >> +				trace_seq_putc(s, ')');
> >> +			}
> >>   			n_u64++;
> >>   		}
> >>   	}  
> 

