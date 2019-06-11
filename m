Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994863C715
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2019 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbfFKJP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jun 2019 05:15:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfFKJP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 05:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VEECxa63lSDae44YYA0SmkX/nnYgGF1NhyGuBAx1jCI=; b=XCNS03hoWW8vU0KkhyVxGPJ6f
        n+Nq9eTPb2heNUo12nB3A4BhWw98SyHCSRjyFfNtBC00CtsfVPJFVhxv0Ke/4QOAxZXg81dp9TF6N
        BkZptKuD3RWSih9ooyCN5h506xvu0nilbBx8XTBlPHo6dvOyvVHaMrXTqonIGn7myRieJUvIHahRD
        G4ZqdLy5csut//3VWHVkbk0AEOIR9KxWxiiLJkvRPlClaIaI6BqoFxT+9ZSx7JK3q/RiMCIGzG8II
        etomQjJ1NReKz5VoBcGkXNg3dAmPeQDECmWb+cbOLova0UTApObf4FpXfkyB1hQZnYJzVZhy/6QkP
        y+dpLbAdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hacse-00069J-8B; Tue, 11 Jun 2019 09:15:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54CF8202173E3; Tue, 11 Jun 2019 11:15:46 +0200 (CEST)
Date:   Tue, 11 Jun 2019 11:15:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH/RFC 2/3] s390: improve wait logic of stop_machine
Message-ID: <20190611091546.GV3436@hirez.programming.kicks-ass.net>
References: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
 <20190608110853.35961-3-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608110853.35961-3-heiko.carstens@de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 01:08:52PM +0200, Heiko Carstens wrote:
> --- a/arch/s390/kernel/processor.c
> +++ b/arch/s390/kernel/processor.c
> @@ -31,6 +31,7 @@ struct cpu_info {
>  };
>  
>  static DEFINE_PER_CPU(struct cpu_info, cpu_info);
> +static DEFINE_PER_CPU(int, cpu_relax_retry);
>  
>  static bool machine_has_cpu_mhz;
>  
> @@ -58,13 +59,21 @@ void s390_update_cpu_mhz(void)
>  		on_each_cpu(update_cpu_mhz, NULL, 0);
>  }
>  
> +void notrace cpu_relax_yield(const struct cpumask *cpumask)
>  {
> +	int cpu;
> +
> +	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
> +		__this_cpu_write(cpu_relax_retry, 0);

I don't mind, but do we really need a per-cpu variable for this? Does it
really matter if you spin on a stack variable and occasionally spin a
bit longer due to the missed tail of the previous spin?

> +		cpu = cpumask_next(smp_processor_id(), cpumask);
> +		if (cpu >= nr_cpu_ids) {
> +			cpu = cpumask_first(cpumask);
> +			if (cpu == smp_processor_id())
> +				return;

If this function is passed an empty cpumask, the above will result in
'cpu == nr_cpu_ids' and the below might be unhappy with that.

(FWIW we do have cpumask_next_wrap(), but I admit it is somewhat awkward
to use)

> +		}
> +		if (arch_vcpu_is_preempted(cpu))
> +			smp_yield_cpu(cpu);
>  	}
>  }
>  EXPORT_SYMBOL(cpu_relax_yield);
