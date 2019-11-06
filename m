Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFEEF16E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2019 14:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfKFNZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Nov 2019 08:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbfKFNZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:25:23 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3EA21D7F;
        Wed,  6 Nov 2019 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573046722;
        bh=uv8hUmh6ncxpuKvxrxfi4R6VPvr+dCvkWzsGjjJTEC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcAR6fNJha9ieBKnJHttNjn+7tKtiaWUhgLYjUFs7st2ied/tjEb3nDJYWcHwIa8Z
         si4qk8wAMhoT1OLUwot7OMn7TMrzTia3LB2Y94iaO+TlhwSeazyD9ZfUA/1sWsniAb
         4RYOLS2bmE2krTU+GKDHOC8Q4sLJ1UkhUvclZ3oo=
Date:   Wed, 6 Nov 2019 13:25:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/50] arm64: Add loglvl to dump_backtrace()
Message-ID: <20191106132516.GC5808@willie-the-truck>
References: <20191106030542.868541-1-dima@arista.com>
 <20191106030542.868541-10-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106030542.868541-10-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:05:00AM +0000, Dmitry Safonov wrote:
> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
> 
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
> 
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
> 
> Add log level argument to dump_backtrace() as a preparation for
> introducing show_stack_loglvl().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> [1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/arm64/include/asm/stacktrace.h |  3 ++-
>  arch/arm64/kernel/process.c         |  2 +-
>  arch/arm64/kernel/traps.c           | 17 +++++++++--------
>  3 files changed, 12 insertions(+), 10 deletions(-)

[...]

> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 34739e80211b..59072c7b9fb4 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -52,9 +52,9 @@ static const char *handler[]= {
>  
>  int show_unhandled_signals = 0;
>  
> -static void dump_backtrace_entry(unsigned long where)
> +static void dump_backtrace_entry(unsigned long where, const char *loglvl)
>  {
> -	printk(" %pS\n", (void *)where);
> +	printk("%s %pS\n", loglvl, (void *)where);
>  }
>  
>  static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
> @@ -82,12 +82,13 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
>  	printk("%sCode: %s\n", lvl, str);
>  }
>  
> -void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
> +void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
> +		    const char *loglvl)
>  {
>  	struct stackframe frame;
>  	int skip = 0;
>  
> -	pr_debug("%s(regs = %p tsk = %p)\n", __func__, regs, tsk);
> +	printk("%s%s(regs = %p tsk = %p)\n", loglvl, __func__, regs, tsk);

This one needs to stay as pr_debug().

Will
