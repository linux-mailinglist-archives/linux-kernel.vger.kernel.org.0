Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C140E3D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2019 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfJXUdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Oct 2019 16:33:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60874 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfJXUdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GVODDosAz0KEwdHpAoHPZ1mcsfz+QIahQyGZ0FFdveI=; b=EWkROy1UNPTh1cenqdA4Lbg0U
        SFH3/12wnub2nQFPEEaf4U/aYASqjMm0xqUrLVylowlgDwWhLiVA6jRnBfYgdrvpv99RFEk4H6rwa
        6KyCw7Pk8KQ2sg8lPMEMyxiQgwTJxRSFGdvONnPWbzu3ieGxWjg/x+ZaRABi4tcFlFx+vxgdqFjin
        RbXncK9O1MEWFeqi9pntFjmWvn6dAB9CNLVqNeWDyZmQCXSRLyPTzZG+hEyppPqpPJofUCFOMbtuu
        mOFqtBPJhcfTLtkBx4RpxKD/YohtclX4KYsxwHBGrkKQwyTBHMnftmraNMMiR1JT93Jm6rtiSbeuu
        Ywv5jGfrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNjn9-0004Is-K2; Thu, 24 Oct 2019 20:33:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D53B300EBF;
        Thu, 24 Oct 2019 22:32:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28BA6201A6638; Thu, 24 Oct 2019 22:33:06 +0200 (CEST)
Date:   Thu, 24 Oct 2019 22:33:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jeyu@kernel.org
Subject: Re: [PATCH v4 15/16] module: Move where we mark modules RO,X
Message-ID: <20191024203306.GL4114@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.801435443@infradead.org>
 <20191021135312.jbbxsuipxldocdjk@treble>
 <20191021141402.GI1817@hirez.programming.kicks-ass.net>
 <20191023114835.GT1817@hirez.programming.kicks-ass.net>
 <20191023151654.GF19358@hirez.programming.kicks-ass.net>
 <20191023171514.7hkhtvfcj5vluwcg@treble>
 <20191024105904.GB4131@hirez.programming.kicks-ass.net>
 <20191024183115.jomddpijq5u453qc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024183115.jomddpijq5u453qc@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 01:31:15PM -0500, Josh Poimboeuf wrote:

> How about something like this?  Completely untested, but if you agree
> with this approach I could hack up kpatch-build to test it properly.
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index ab4a4606d19b..597bf32bc591 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -239,6 +239,17 @@ static int klp_resolve_symbols(Elf_Shdr *relasec, struct module *pmod)
>  		if (ret)
>  			return ret;
>  
> +		/*
> +		 * Prevent module patches from using livepatch relas for
> +		 * vmlinux symbols.  Presumably such symbols are exported and
> +		 * normal relas can instead be used at patch module loading
> +		 * time.
> +		 */
> +		if (!vmlinux && core_kernel_text(addr)) {
> +			pr_err("unsupported livepatch symbol\n");
> +			return -EINVAL;
> +		}
> +
>  		sym->st_value = addr;
>  	}

If that works, this is much simpler and therefore preferred.
