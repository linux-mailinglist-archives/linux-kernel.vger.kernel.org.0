Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D623E8F985
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 05:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfHPDpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 23:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfHPDpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 23:45:38 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3AF12077C;
        Fri, 16 Aug 2019 03:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565927137;
        bh=X/G1J6e5tvrQ7VSjJaRotZVksE4JpISYktIN29eFZmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AXmatuGmPlP7Oov/iWpv3k9RYe6FozzmBpDo4BGoRHK4PhVHG4elewMnZdhuX4s75
         b74kM1aiNRy5KirnymYTrhedzCWTl+VYsQ6G7zUbXg4/I+rI2+9vUnq+N1v871ibEc
         SaX7qIBs7vDDun793edgPbIqpcpqylvf4VH6x8fI=
Date:   Fri, 16 Aug 2019 12:45:32 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: fix potential deadlock in kprobe_optimizer()
Message-Id: <20190816124532.e96b01c68617925b8373f3a5@kernel.org>
In-Reply-To: <20190812184302.GA7010@xps-13>
References: <20190812184302.GA7010@xps-13>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Thank you for reporting this bug.

On Mon, 12 Aug 2019 20:43:02 +0200
Andrea Righi <andrea.righi@canonical.com> wrote:

> lockdep reports the following:
> 
>  WARNING: possible circular locking dependency detected
> 
>  kworker/1:1/48 is trying to acquire lock:
>  000000008d7a62b2 (text_mutex){+.+.}, at: kprobe_optimizer+0x163/0x290
> 
>  but task is already holding lock:
>  00000000850b5e2d (module_mutex){+.+.}, at: kprobe_optimizer+0x31/0x290
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #1 (module_mutex){+.+.}:
>         __mutex_lock+0xac/0x9f0
>         mutex_lock_nested+0x1b/0x20
>         set_all_modules_text_rw+0x22/0x90
>         ftrace_arch_code_modify_prepare+0x1c/0x20
>         ftrace_run_update_code+0xe/0x30
>         ftrace_startup_enable+0x2e/0x50
>         ftrace_startup+0xa7/0x100
>         register_ftrace_function+0x27/0x70
>         arm_kprobe+0xb3/0x130
>         enable_kprobe+0x83/0xa0
>         enable_trace_kprobe.part.0+0x2e/0x80
>         kprobe_register+0x6f/0xc0
>         perf_trace_event_init+0x16b/0x270
>         perf_kprobe_init+0xa7/0xe0
>         perf_kprobe_event_init+0x3e/0x70
>         perf_try_init_event+0x4a/0x140
>         perf_event_alloc+0x93a/0xde0
>         __do_sys_perf_event_open+0x19f/0xf30
>         __x64_sys_perf_event_open+0x20/0x30
>         do_syscall_64+0x65/0x1d0
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  -> #0 (text_mutex){+.+.}:
>         __lock_acquire+0xfcb/0x1b60
>         lock_acquire+0xca/0x1d0
>         __mutex_lock+0xac/0x9f0
>         mutex_lock_nested+0x1b/0x20
>         kprobe_optimizer+0x163/0x290
>         process_one_work+0x22b/0x560
>         worker_thread+0x50/0x3c0
>         kthread+0x112/0x150
>         ret_from_fork+0x3a/0x50
> 
>  other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(module_mutex);
>                                 lock(text_mutex);
>                                 lock(module_mutex);
>    lock(text_mutex);
> 
>   *** DEADLOCK ***
> 
> As a reproducer I've been using bcc's funccount.py
> (https://github.com/iovisor/bcc/blob/master/tools/funccount.py),
> for example:
> 
>  # ./funccount.py '*interrupt*'
> 
> That immediately triggers the lockdep splat.
> 
> Fix by acquiring text_mutex before module_mutex in kprobe_optimizer().

OK, this looks good to me :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Fixes: d5b844a2cf50 ("ftrace/x86: Remove possible deadlock between register_kprobe() and ftrace_run_update_code()")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  kernel/kprobes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9873fc627d61..d9770a5393c8 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -470,6 +470,7 @@ static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
>   */
>  static void do_optimize_kprobes(void)
>  {
> +	lockdep_assert_held(&text_mutex);
>  	/*
>  	 * The optimization/unoptimization refers online_cpus via
>  	 * stop_machine() and cpu-hotplug modifies online_cpus.
> @@ -487,9 +488,7 @@ static void do_optimize_kprobes(void)
>  	    list_empty(&optimizing_list))
>  		return;
>  
> -	mutex_lock(&text_mutex);
>  	arch_optimize_kprobes(&optimizing_list);
> -	mutex_unlock(&text_mutex);
>  }
>  
>  /*
> @@ -500,6 +499,7 @@ static void do_unoptimize_kprobes(void)
>  {
>  	struct optimized_kprobe *op, *tmp;
>  
> +	lockdep_assert_held(&text_mutex);
>  	/* See comment in do_optimize_kprobes() */
>  	lockdep_assert_cpus_held();
>  
> @@ -507,7 +507,6 @@ static void do_unoptimize_kprobes(void)
>  	if (list_empty(&unoptimizing_list))
>  		return;
>  
> -	mutex_lock(&text_mutex);
>  	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
>  	/* Loop free_list for disarming */
>  	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
> @@ -524,7 +523,6 @@ static void do_unoptimize_kprobes(void)
>  		} else
>  			list_del_init(&op->list);
>  	}
> -	mutex_unlock(&text_mutex);
>  }
>  
>  /* Reclaim all kprobes on the free_list */
> @@ -556,6 +554,7 @@ static void kprobe_optimizer(struct work_struct *work)
>  {
>  	mutex_lock(&kprobe_mutex);
>  	cpus_read_lock();
> +	mutex_lock(&text_mutex);
>  	/* Lock modules while optimizing kprobes */
>  	mutex_lock(&module_mutex);
>  
> @@ -583,6 +582,7 @@ static void kprobe_optimizer(struct work_struct *work)
>  	do_free_cleaned_kprobes();
>  
>  	mutex_unlock(&module_mutex);
> +	mutex_unlock(&text_mutex);
>  	cpus_read_unlock();
>  	mutex_unlock(&kprobe_mutex);
>  
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
