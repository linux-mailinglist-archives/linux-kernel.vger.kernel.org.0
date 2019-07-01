Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3AB130C7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2019 16:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfECO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 May 2019 10:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfECO42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 10:56:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A040D2070B;
        Fri,  3 May 2019 14:56:27 +0000 (UTC)
Date:   Fri, 3 May 2019 10:56:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tom.zanussi@linux.intel.com
Subject: Re: [PATCH] Documentation/trace: Add clarification how histogram
 onmatch works
Message-ID: <20190503105626.453d32c4@gandalf.local.home>
In-Reply-To: <20190503143537.19752-1-tstoyanov@vmware.com>
References: <20190503143537.19752-1-tstoyanov@vmware.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 May 2019 17:35:37 +0300
Tzvetomir Stoyanov <tstoyanov@vmware.com> wrote:

> The current trace documentation, the section describing histogram's "onmatch"
> is not straightforward enough about how this action is applied. It is not
> clear what criteria are used to "match" both events. A short note is added,
> describing what exactly is compared in order to match the events.

Hi Tzvetomir,

Thanks for sending this. Some minor tweaks below.

> 
> Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> ---
>  Documentation/trace/histogram.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/trace/histogram.txt b/Documentation/trace/histogram.txt
> index 7ffea6aa22e3..b75a75cfab8c 100644
> --- a/Documentation/trace/histogram.txt
> +++ b/Documentation/trace/histogram.txt
> @@ -1863,7 +1863,10 @@ hist trigger specification.
>  
>      The 'matching.event' specification is simply the fully qualified
>      event name of the event that matches the target event for the
> -    onmatch() functionality, in the form 'system.event_name'.
> +    onmatch() functionality, in the form 'system.event_name'. Histogram
> +    keys of both events are compared to find if events match. In case
> +    multiple histogram keys are used, they all must match in the specified
> +    order.

I would reword that to be:

	In the case that multiple histogram keys are used, both events
	must have the same number of keys, and the keys must match in
	the same order.

>  
>      Finally, the number and type of variables/fields in the 'param
>      list' must match the number and types of the fields in the
> @@ -1920,9 +1923,9 @@ hist trigger specification.
>  	    /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
>  
>      Then, when the corresponding thread is actually scheduled onto the
> -    CPU by a sched_switch event, calculate the latency and use that
> -    along with another variable and an event field to generate a
> -    wakeup_latency synthetic event:
> +    CPU by a sched_switch event (saved_pid matches next_pid), calculate

	CPU by a sched_switch event (where the sched_waking key
	"saved_pid" matches the sched_switch key "next_pid"),

Other than that, looks good.

Could you send a v2 with the updates?

Thanks!

-- Steve


> +    the latency and use that along with another variable and an event field
> +    to generate a wakeup_latency synthetic event:
>  
>      # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:\
>              onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,\

