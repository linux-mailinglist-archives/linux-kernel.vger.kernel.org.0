Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2975019A89A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 11:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgDAJ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 05:26:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36498 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDAJ0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YYo5EKAQ9jeZ5u7WqOrUteHoNVI7yscIqPfvElnPohU=; b=HqlQzdOTso81BOo6+3TntCLG5T
        +mklMvBXZ3e9he4xGmkeNbi5t4ugfq8TrkzZhGPidhsp4gu1JaVtXXetqw7yhu4LHwDN7l1kw8AK4
        SbaSKoUfEejrcmc9QD+nxze0g+FJwnwAJRiPl9XWJBVSuBhQNqbxn1tGUyUaRW1kFRn8P/xQMLP/W
        8wGd/lYGxfnlq0wolb36aIUKGWJ2gNtigsU9cCfadQ6lGbFzAyM+q71bYpiNpgG5y7CBoMsQ//11X
        uvFMcEOTovRgxSdVXgk1LtROyqmNO7W36ElgiDHK6bcqJvUrG+7vId3gUCIH0kInt/u5Eggov+BtQ
        FyrGhJJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJZdg-000832-JJ; Wed, 01 Apr 2020 09:26:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E7008301631;
        Wed,  1 Apr 2020 11:26:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D34ED29E1FE81; Wed,  1 Apr 2020 11:26:18 +0200 (CEST)
Date:   Wed, 1 Apr 2020 11:26:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Enrico Weigelt <info@metux.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] ppc/crash: Reset spinlocks during crash
Message-ID: <20200401092618.GW20713@hirez.programming.kicks-ass.net>
References: <20200401000020.590447-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401000020.590447-1-leonardo@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:00:21PM -0300, Leonardo Bras wrote:
> During a crash, there is chance that the cpus that handle the NMI IPI
> are holding a spin_lock. If this spin_lock is needed by crashing_cpu it
> will cause a deadlock. (rtas.lock and printk logbuf_lock as of today)
> 
> This is a problem if the system has kdump set up, given if it crashes
> for any reason kdump may not be saved for crash analysis.
> 
> After NMI IPI is sent to all other cpus, force unlock all spinlocks
> needed for finishing crash routine.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>

> @@ -129,6 +132,13 @@ static void crash_kexec_prepare_cpus(int cpu)
>  	/* Would it be better to replace the trap vector here? */
>  
>  	if (atomic_read(&cpus_in_crash) >= ncpus) {
> +		/*
> +		 * At this point no other CPU is running, and some of them may
> +		 * have been interrupted while holding one of the locks needed
> +		 * to complete crashing. Free them so there is no deadlock.
> +		 */
> +		arch_spin_unlock(&logbuf_lock.raw_lock);
> +		arch_spin_unlock(&rtas.lock);
>  		printk(KERN_EMERG "IPI complete\n");
>  		return;
>  	}

You might want to add a note to your asm/spinlock.h that you rely on
spin_unlock() unconditionally clearing a lock.

This isn't naturally true for all lock implementations. Consider ticket
locks, doing a surplus unlock will wreck your lock state in that case.
So anybody poking at the powerpc spinlock implementation had better know
you rely on this.
