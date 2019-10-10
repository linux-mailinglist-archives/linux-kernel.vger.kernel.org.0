Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83832D2F19
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2019 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfJJQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Oct 2019 12:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJJQ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 12:59:18 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B402214E0;
        Thu, 10 Oct 2019 16:59:17 +0000 (UTC)
Date:   Thu, 10 Oct 2019 12:59:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191010125915.34a2cfdf@gandalf.local.home>
In-Reply-To: <20191010105515.5eba7f31@gandalf.local.home>
References: <20191009223638.60b78727@oasis.local.home>
        <20191010073121.GN2311@hirez.programming.kicks-ass.net>
        <20191010093329.GI2359@hirez.programming.kicks-ass.net>
        <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
        <20191010122909.GK2359@hirez.programming.kicks-ass.net>
        <20191010105515.5eba7f31@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 10:55:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

I'll try to add more detail (mapping to functions)

> 
> OK, so basically this moves the enabling of function tracing from
> within the ftrace_module_enable() code without releasing the
> ftrace_lock mutex.
> 
> But we have an issue with the state of the module here, as it is still
> set as MODULE_STATE_UNFORMED. Let's look at what happens if we have:
> 
> 
> 	CPU0				CPU1
> 	----				----
>  echo function > current_tracer

Just need to know that the above will now have all loaded modules have
their functions being traced. That is ftrace_startup > 0.


> 				modprobe foo
> 				  enable foo functions to be traced
> 				  (foo function records not disabled)

In your code, we have here:
				load_module()
				  foo->state == UNFORMED

				  ftrace_module_init()
				    ftrace_process_locs()
				      mutex_lock(ftrace_lock);
				       __ftrace_replace_code(rec, 1)
				      /* Enabling foo's functions */
				      mutex_unlock(ftrace_lock);

				  

>  echo nop > current_tracer
> 
>    disable all functions being
>    traced including foo functions

ftrace_shutdown()
  ftrace_run_update_code()
    ftrace_arch_code_modify_prepare()

    [ on arm and nds32 ]
> 
>    arch calls set_all_modules_text_rw()
>     [skips UNFORMED modules, which foo still is ]
> 
> 				  set foo's text to read-only
> 				  foo's state to COMING

				  complete_formation()
				    module_enable_ro()

> 
>    tries to disable foo's functions
>    foo's text is read-only

    arch_ftrace_update_code()
      ftrace_modify_all_code()

      [ Includes foo's functions ]

> 
>    BUG trying to write to ro text!!!

Hope that makes more sense.

-- Steve

> 
> 
> Like I said, this is very subtle. It may no longer be a bug on x86
> with your patches, but it will bug on ARM or anything else that still
> uses set_all_modules_text_rw() in the ftrace prepare code.
