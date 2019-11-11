Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8327F79DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2019 18:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKR0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Nov 2019 12:26:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42102 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfKKR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CH7Wf1Qu0hYS+0roY7xlHo+VoYO/vNf9BDuGjbmkngw=; b=p5lP7arg/P4WHXTuz0iuPHsXR
        +8PgAhog65jjyMDDHJaowse9/lo2wn5Xy13Bo0MMO+AvYomrQ6+efEA6mffoTRhMyRoM6232fsorP
        WslFzURJjYmYyPQS95s74Gho0exECRBBIPq3EwhkcZzjU5kyLMdiOKXk1lLZxMyv8sedsa4Elyq9f
        8vMZHs0mXdIol4xMrBggjmnLk0OK7VWb2BAwulto/8aMoi53aNQt34Uf1fuQt1//kNs6C8FwPC5Wj
        GmVc2jCiAS8an7USZn6SRx5vo0ruariV0oTfdtSsUfqbZbP76rLGHkhC4Le9/oh6Qc+oCyA45Y1nw
        eCzO+l2sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUDRf-0006nr-BO; Mon, 11 Nov 2019 17:25:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B08830018B;
        Mon, 11 Nov 2019 18:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C93E520302EFB; Mon, 11 Nov 2019 18:25:41 +0100 (CET)
Date:   Mon, 11 Nov 2019 18:25:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com, rabin@rab.in,
        Mark Rutland <mark.rutland@arm.com>, james.morse@arm.com
Subject: Re: [PATCH -v5 13/17] arm/ftrace: Use __patch_text_real()
Message-ID: <20191111172541.GT5671@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132458.220458362@infradead.org>
 <20191111164703.GA11521@willie-the-truck>
 <20191111171955.GO4114@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111171955.GO4114@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 06:19:55PM +0100, Peter Zijlstra wrote:

> If you can give me a Tested-by, I'll replace it with the below... :-)
> 
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -22,6 +22,7 @@
>  #include <asm/ftrace.h>
>  #include <asm/insn.h>
>  #include <asm/set_memory.h>
> +#include <asm/patch.h>
>  
>  #ifdef CONFIG_THUMB2_KERNEL
>  #define	NOP		0xf85deb04	/* pop.w {lr} */
> @@ -35,9 +36,7 @@ static int __ftrace_modify_code(void *da
>  {
>  	int *command = data;
>  
> -	set_kernel_text_rw();
>  	ftrace_modify_all_code(*command);
> -	set_kernel_text_ro();
>  
>  	return 0;
>  }
> @@ -59,13 +58,11 @@ static unsigned long adjust_address(stru
>  
>  int ftrace_arch_code_modify_prepare(void)
>  {
> -	set_all_modules_text_rw();
>  	return 0;
>  }
>  
>  int ftrace_arch_code_modify_post_process(void)
>  {
> -	set_all_modules_text_ro();
>  	/* Make sure any TLB misses during machine stop are cleared. */
>  	flush_tlb_all();
>  	return 0;
> @@ -97,10 +94,7 @@ static int ftrace_modify_code(unsigned l
>  			return -EINVAL;
>  	}
>  
> -	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
> -		return -EPERM;
> -
> -	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
> +	__patch_text_real((void *)pc, new, true);

I'll even make that: __patch_text((void *)pc, new);

>  
>  	return 0;
>  }
