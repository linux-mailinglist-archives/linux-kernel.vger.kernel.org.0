Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E03E7681
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2019 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391086AbfJ1Qfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Oct 2019 12:35:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730703AbfJ1Qfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4+K1/bmKx0JfCqxKDmPlAQkjGMz5sdzpbSR198DLpb8=; b=jneJ72dfq8edkHH/ghw9EkV+p
        os2ENaXowtdPqJC7h2bw4WQTgKxQp7v4EXT6y4P9GrhBj96VdI28RuD6W37WuSWoKB30cnf3ks1wH
        U+F8SJOQMXnakDWNavHCYFS1pItaDQf5yworCIZkmrGmkFVUVRKa7IhbvLd99zVB2/ydTWyYA1kGe
        RkkcXxlnSP7xQ+unnklzAgqe8lObhhMAA1X15hZKaG5wCSvL7avJWFSk+CP0Z2SyA4s8D0fvfTwnf
        TltRH/cBPFT9jjh5vZAPQ/UGlMLdS6RX741PazXsEvZ/w6kLwM86eBAkV/eeOT34R7bY3FTBsJslh
        BLR+aFV8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iP7zB-0001Pq-Le; Mon, 28 Oct 2019 16:35:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C30B306091;
        Mon, 28 Oct 2019 17:34:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B66E20C4EA0B; Mon, 28 Oct 2019 17:35:15 +0100 (CET)
Date:   Mon, 28 Oct 2019 17:35:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        rabin@rab.in, Mark Rutland <mark.rutland@arm.com>,
        james.morse@arm.com
Subject: Re: [PATCH v4 13/16] arm/ftrace: Use __patch_text_real()
Message-ID: <20191028163515.GE5671@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.687479693@infradead.org>
 <20191028162525.GF5576@willie-the-truck>
 <20191028163421.GI4097@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028163421.GI4097@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:34:21PM +0100, Peter Zijlstra wrote:
> On Mon, Oct 28, 2019 at 04:25:26PM +0000, Will Deacon wrote:
> > > @@ -97,10 +100,7 @@ static int ftrace_modify_code(unsigned l
> > >  			return -EINVAL;
> > >  	}
> > >  
> > > -	if (probe_kernel_write((void *)pc, &new, MCOUNT_INSN_SIZE))
> > > -		return -EPERM;
> > > -
> > > -	flush_icache_range(pc, pc + MCOUNT_INSN_SIZE);
> > > +	__patch_text_real((void *)pc, new, patch_text_remap);
> > 
> > Why can't you just pass 'true' for patch_text_remap? AFAICT, the only
> > time you want to pass false is during early boot when the text is
> > assumedly still writable without the fixmap.
> 
> Ah, it will also become true for module loading once we rework where we

'false'. That is module loading will again be able to poke without
alias map.

> flip the module text RO,X. See this patch:
> 
>   https://lkml.kernel.org/r/20191018074634.858645375@infradead.org
> 
> But for that to land, there's still a few other issues to fix (KLP).
