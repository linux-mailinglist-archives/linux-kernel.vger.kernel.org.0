Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD695225
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 02:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfHTAHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 20:07:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbfHTAHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:07:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB462087E;
        Tue, 20 Aug 2019 00:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566259661;
        bh=mRNGqagv3FLOfbEDFWbY21Sn764t8uAC5ZUxJM6X+Ag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ljj/+BvVaFfJsr8EJP7pRhxXV5WOosE2S5EjgFFZL5EWJA+IUA4fRpKrvE+zIPWi8
         40VK1xyQ/1ub/fOJkjYEuAandPATqqA23MtQY7IdbMWQvwMS4mqRm15nNVJsET9Y7u
         qJIi+4w0pTk/PpkAoGYxQNX81kg78oZaIVSD3lX8=
Date:   Tue, 20 Aug 2019 09:07:35 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] kprobes: move kprobe_ftrace_handler() from x86 and
 make it weak
Message-Id: <20190820090735.a55e7d0b685adecf68fdb55b@kernel.org>
In-Reply-To: <20190819192628.5f550074@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
        <20190819192628.5f550074@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Mon, 19 Aug 2019 11:37:32 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> This code could be reused. So move it from x86 to common code.

Yes, it can be among some arch, but at first, please make your
architecture implementation. After making sure that is enough
stable, we will optimize (consolidate) the code.

For example,
> -		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> -		instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t));

This may depend on arch implementation of kprobes.

Could you make a copy and update comments on arm64?

Thank you,

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  arch/x86/kernel/kprobes/ftrace.c | 44 --------------------------------
>  kernel/kprobes.c                 | 44 ++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
> index c2ad0b9259ca..91ae1e3e65f7 100644
> --- a/arch/x86/kernel/kprobes/ftrace.c
> +++ b/arch/x86/kernel/kprobes/ftrace.c
> @@ -12,50 +12,6 @@
>  
>  #include "common.h"
>  
> -/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> -void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> -			   struct ftrace_ops *ops, struct pt_regs *regs)
> -{
> -	struct kprobe *p;
> -	struct kprobe_ctlblk *kcb;
> -
> -	/* Preempt is disabled by ftrace */
> -	p = get_kprobe((kprobe_opcode_t *)ip);
> -	if (unlikely(!p) || kprobe_disabled(p))
> -		return;
> -
> -	kcb = get_kprobe_ctlblk();
> -	if (kprobe_running()) {
> -		kprobes_inc_nmissed_count(p);
> -	} else {
> -		unsigned long orig_ip = instruction_pointer(regs);
> -		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> -		instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t));
> -
> -		__this_cpu_write(current_kprobe, p);
> -		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> -		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> -			/*
> -			 * Emulate singlestep (and also recover regs->ip)
> -			 * as if there is a 5byte nop
> -			 */
> -			instruction_pointer_set(regs,
> -				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
> -			if (unlikely(p->post_handler)) {
> -				kcb->kprobe_status = KPROBE_HIT_SSDONE;
> -				p->post_handler(p, regs, 0);
> -			}
> -			instruction_pointer_set(regs, orig_ip);
> -		}
> -		/*
> -		 * If pre_handler returns !0, it changes regs->ip. We have to
> -		 * skip emulating post_handler.
> -		 */
> -		__this_cpu_write(current_kprobe, NULL);
> -	}
> -}
> -NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> -
>  int arch_prepare_kprobe_ftrace(struct kprobe *p)
>  {
>  	p->ainsn.insn = NULL;
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f8400753a8a9..479148ee1822 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -960,6 +960,50 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
>  #endif /* CONFIG_OPTPROBES */
>  
>  #ifdef CONFIG_KPROBES_ON_FTRACE
> +/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> +void __weak kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> +				  struct ftrace_ops *ops, struct pt_regs *regs)
> +{
> +	struct kprobe *p;
> +	struct kprobe_ctlblk *kcb;
> +
> +	/* Preempt is disabled by ftrace */
> +	p = get_kprobe((kprobe_opcode_t *)ip);
> +	if (unlikely(!p) || kprobe_disabled(p))
> +		return;
> +
> +	kcb = get_kprobe_ctlblk();
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(p);
> +	} else {
> +		unsigned long orig_ip = instruction_pointer(regs);
> +		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> +		instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t));
> +
> +		__this_cpu_write(current_kprobe, p);
> +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> +			/*
> +			 * Emulate singlestep (and also recover regs->ip)
> +			 * as if there is a 5byte nop
> +			 */
> +			instruction_pointer_set(regs,
> +				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
> +			if (unlikely(p->post_handler)) {
> +				kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +				p->post_handler(p, regs, 0);
> +			}
> +			instruction_pointer_set(regs, orig_ip);
> +		}
> +		/*
> +		 * If pre_handler returns !0, it changes regs->ip. We have to
> +		 * skip emulating post_handler.
> +		 */
> +		__this_cpu_write(current_kprobe, NULL);
> +	}
> +}
> +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> +
>  static struct ftrace_ops kprobe_ftrace_ops __read_mostly = {
>  	.func = kprobe_ftrace_handler,
>  	.flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_IPMODIFY,
> -- 
> 2.23.0.rc1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
