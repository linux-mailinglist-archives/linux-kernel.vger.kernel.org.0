Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D627295237
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2019 02:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfHTAJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 20:09:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbfHTAJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:09:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FDC02087E;
        Tue, 20 Aug 2019 00:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566259781;
        bh=3dePchIXUrHARNvoOUntsAh0qrfK9lM9QkGh3Z6XwXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=asBsoarRoTvoLiVFt3+6TN9ttHcpCBbaKi0T2wz6/m7GAH1tqy4MWMmFLOhED4cK3
         qqtSRzJQSaez3m8UMAWsjKj54yK2lF4gBVmrDXmygSG1/UeQhQqf2x5QatOGhp9pgK
         hf+Sv8OU67xeW3NyS67PCYvJOf7nczxq91oNirvQ=
Date:   Tue, 20 Aug 2019 09:09:35 +0900
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
Subject: Re: [PATCH 2/4] kprobes/x86: use instruction_pointer and
 instruction_pointer_set
Message-Id: <20190820090935.a8357e7f8531340c054275f2@kernel.org>
In-Reply-To: <20190819192543.32cec143@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
        <20190819192543.32cec143@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 11:36:48 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> This is to make the kprobe_ftrace_handler() common, so we can move it
> to common code in next patch.
> 

BTW, this patch looks good, without next patch. Could you update the
patch description and resend it with my Ack?

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  arch/x86/kernel/kprobes/ftrace.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
> index 681a4b36e9bb..c2ad0b9259ca 100644
> --- a/arch/x86/kernel/kprobes/ftrace.c
> +++ b/arch/x86/kernel/kprobes/ftrace.c
> @@ -28,9 +28,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  	if (kprobe_running()) {
>  		kprobes_inc_nmissed_count(p);
>  	} else {
> -		unsigned long orig_ip = regs->ip;
> +		unsigned long orig_ip = instruction_pointer(regs);
>  		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> -		regs->ip = ip + sizeof(kprobe_opcode_t);
> +		instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t));
>  
>  		__this_cpu_write(current_kprobe, p);
>  		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> @@ -39,12 +39,13 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  			 * Emulate singlestep (and also recover regs->ip)
>  			 * as if there is a 5byte nop
>  			 */
> -			regs->ip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
> +			instruction_pointer_set(regs,
> +				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
>  			if (unlikely(p->post_handler)) {
>  				kcb->kprobe_status = KPROBE_HIT_SSDONE;
>  				p->post_handler(p, regs, 0);
>  			}
> -			regs->ip = orig_ip;
> +			instruction_pointer_set(regs, orig_ip);
>  		}
>  		/*
>  		 * If pre_handler returns !0, it changes regs->ip. We have to
> -- 
> 2.23.0.rc1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
