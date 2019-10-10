Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1CD5D2F78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfJJRUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 13:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfJJRUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:20:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9413A20659;
        Thu, 10 Oct 2019 17:20:15 +0000 (UTC)
Date:   Thu, 10 Oct 2019 13:20:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010132013.7f3388bc@gandalf.local.home>
In-Reply-To: <20191010170111.GQ2328@hirez.programming.kicks-ass.net>
References: <20191009223638.60b78727@oasis.local.home>
        <20191010073121.GN2311@hirez.programming.kicks-ass.net>
        <20191010093329.GI2359@hirez.programming.kicks-ass.net>
        <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
        <20191010122909.GK2359@hirez.programming.kicks-ass.net>
        <20191010105515.5eba7f31@gandalf.local.home>
        <20191010170111.GQ2328@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 19:01:11 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Oct 10, 2019 at 10:55:15AM -0400, Steven Rostedt wrote:
> 
> > OK, so basically this moves the enabling of function tracing from
> > within the ftrace_module_enable() code without releasing the
> > ftrace_lock mutex.
> > 
> > But we have an issue with the state of the module here, as it is still
> > set as MODULE_STATE_UNFORMED. Let's look at what happens if we have:
> > 
> > 
> > 	CPU0				CPU1
> > 	----				----
> >  echo function > current_tracer
> > 				modprobe foo
> > 				  enable foo functions to be traced
> > 				  (foo function records not disabled)
> >  echo nop > current_tracer
> > 
> >    disable all functions being
> >    traced including foo functions
> > 
> >    arch calls set_all_modules_text_rw()
> >     [skips UNFORMED modules, which foo still is ]
> > 
> > 				  set foo's text to read-only
> > 				  foo's state to COMING
> > 
> >    tries to disable foo's functions
> >    foo's text is read-only
> > 
> >    BUG trying to write to ro text!!!
> > 
> > 
> > Like I said, this is very subtle. It may no longer be a bug on x86
> > with your patches, but it will bug on ARM or anything else that still
> > uses set_all_modules_text_rw() in the ftrace prepare code.  
> 
> I can't immediately follow, but I think we really should go there.
> 
> For now, something like this might work:

Hmm, I'm lost at what the below is trying to do with respect to the
above.

-- Steve

> 
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -34,6 +34,8 @@
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  
> +static int ftrace_poke_late = 0;
> +
>  int ftrace_arch_code_modify_prepare(void)
>      __acquires(&text_mutex)
>  {
> @@ -43,12 +45,15 @@ int ftrace_arch_code_modify_prepare(void
>  	 * ftrace has it set to "read/write".
>  	 */
>  	mutex_lock(&text_mutex);
> +	ftrace_poke_late = 1;
>  	return 0;
>  }
>  
>  int ftrace_arch_code_modify_post_process(void)
>      __releases(&text_mutex)
>  {
> +	text_poke_finish();
> +	ftrace_poke_late = 0;
>  	mutex_unlock(&text_mutex);
>  	return 0;
>  }
> @@ -116,7 +121,10 @@ ftrace_modify_code_direct(unsigned long
>  		return ret;
>  
>  	/* replace the text with the new text */
> -	text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
> +	if (ftrace_poke_late)
> +		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> +	else
> +		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
>  	return 0;
>  }
>  

