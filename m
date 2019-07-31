Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8BF7C544
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2019 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbfGaOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Jul 2019 10:46:36 -0400
Received: from foss.arm.com ([217.140.110.172]:48362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbfGaOqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:46:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42F3C344;
        Wed, 31 Jul 2019 07:46:32 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F5A23F694;
        Wed, 31 Jul 2019 07:46:31 -0700 (PDT)
Date:   Wed, 31 Jul 2019 15:46:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jiping Ma <jiping.ma2@windriver.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com, catalin.marinas@arm.com
Subject: Re: [PATCH] Function stack size and its name mismatch in arm64
Message-ID: <20190731144628.GD39768@lakrids.cambridge.arm.com>
References: <20190731090437.19867-1-jiping.ma2@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731090437.19867-1-jiping.ma2@windriver.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If you have a patch affecting arm64, please Cc LAKML and the arm64
maintainers. I've added them to this sub-thread.

On Wed, Jul 31, 2019 at 05:04:37PM +0800, Jiping Ma wrote:
> The PC of one the frame is matched to the next frame function, rather
> than the function of his frame.

As Steve said in another reply, please could you explain the problem
more thoroughly? An example would be very helpful.

It sounds like arm64 behaves differently to other architectures here,
which could be an arm64-specific bug, or it could be that the behaviour
is inconsistent across archtiectures and needs more general cleanup.

Thanks,
Mark.

> 
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> ---
>  kernel/trace/trace_stack.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 5d16f73898db..ed80b95abf06 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -40,16 +40,28 @@ static void print_max_stack(void)
>  
>  	pr_emerg("        Depth    Size   Location    (%d entries)\n"
>  			   "        -----    ----   --------\n",
> +#ifdef CONFIG_ARM64
> +			   stack_trace_nr_entries - 1);
> +#else
>  			   stack_trace_nr_entries);
> -
> +#endif
> +#ifdef CONFIG_ARM64
> +	for (i = 1; i < stack_trace_nr_entries; i++) {
> +#else
>  	for (i = 0; i < stack_trace_nr_entries; i++) {
> +#endif
>  		if (i + 1 == stack_trace_nr_entries)
>  			size = stack_trace_index[i];
>  		else
>  			size = stack_trace_index[i] - stack_trace_index[i+1];
>  
> +#ifdef CONFIG_ARM64
> +		pr_emerg("%3ld) %8d   %5d   %pS\n", i-1, stack_trace_index[i],
> +				size, (void *)stack_dump_trace[i-1]);
> +#else
>  		pr_emerg("%3ld) %8d   %5d   %pS\n", i, stack_trace_index[i],
>  				size, (void *)stack_dump_trace[i]);
> +#endif
>  	}
>  }
>  
> @@ -324,8 +336,11 @@ static int t_show(struct seq_file *m, void *v)
>  		seq_printf(m, "        Depth    Size   Location"
>  			   "    (%d entries)\n"
>  			   "        -----    ----   --------\n",
> +#ifdef CONFIG_ARM64
> +			   stack_trace_nr_entries - 1);
> +#else
>  			   stack_trace_nr_entries);
> -
> +#endif
>  		if (!stack_tracer_enabled && !stack_trace_max_size)
>  			print_disabled(m);
>  
> @@ -334,6 +349,10 @@ static int t_show(struct seq_file *m, void *v)
>  
>  	i = *(long *)v;
>  
> +#ifdef CONFIG_ARM64
> +	if (i == 0)
> +		return 0;
> +#endif
>  	if (i >= stack_trace_nr_entries)
>  		return 0;
>  
> @@ -342,9 +361,14 @@ static int t_show(struct seq_file *m, void *v)
>  	else
>  		size = stack_trace_index[i] - stack_trace_index[i+1];
>  
> +#ifdef CONFIG_ARM64
> +	seq_printf(m, "%3ld) %8d   %5d   ", i-1, stack_trace_index[i], size);
> +	trace_lookup_stack(m, i-1);
> +#else
>  	seq_printf(m, "%3ld) %8d   %5d   ", i, stack_trace_index[i], size);
>  
>  	trace_lookup_stack(m, i);
> +#endif
>  
>  	return 0;
>  }
> -- 
> 2.18.1
> 
