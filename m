Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819EA2E277
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2019 18:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfE2QoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 May 2019 12:44:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2QoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sxzAs+3HnzYC9EoyXWpVI8ykljmz5DFHFWPIJsNygyQ=; b=opPA4eY5MGIVUeEnQjWc3VAJ/
        4oXlxib2TTPMoX4NSr7melN23eKj6rkoxnQGfN6bLUlJ185bd3ROanNSCEa9f3oCT4lHpf94pxEWV
        ISvHz2YaNLlTt6LLkY+yt7WQ5KlhFsAU6o76aU3PMhiLsNwdZ57JEgNB6YxzN5IyY41YQSOqm+lRI
        YW5k1rqgXLu8LSpCwKHeGb2q0JJi+0CJH9px60p4G+8Cc29Ep2boOiEcaoiFTtz2l3hm88Wi2jRyH
        N0y0NQSVEBJicGKx1lUK22DOUrEoOK10QfZplisFB6S48RHDIWlgurzwmzq9vwtzEeuQAJEi52l+E
        7b7E2XGPw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW1gP-0002uk-4d; Wed, 29 May 2019 16:44:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51939201D5AB3; Wed, 29 May 2019 18:44:07 +0200 (CEST)
Date:   Wed, 29 May 2019 18:44:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au,
        acme@redhat.com, eranian@google.com, fweisbec@gmail.com,
        jolsa@redhat.com
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190529164407.GA2623@hirez.programming.kicks-ass.net>
References: <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
 <20190529130521.GA11023@fuggles.cambridge.arm.com>
 <20190529132515.GW2623@hirez.programming.kicks-ass.net>
 <20190529143510.GA11154@fuggles.cambridge.arm.com>
 <20190529161955.GZ2623@hirez.programming.kicks-ass.net>
 <20190529162528.GB12420@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529162528.GB12420@fuggles.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 05:25:28PM +0100, Will Deacon wrote:

> > > > On Wed, May 29, 2019 at 02:05:21PM +0100, Will Deacon wrote:
> > > > > On Wed, May 29, 2019 at 02:55:57PM +0200, Peter Zijlstra wrote:
> > > > 
> > > > > >  	if (user_mode(regs)) {
> > > > > 
> > > > > Hmm, so it just occurred to me that Mark's observation is that the regs
> > > > > can be junk in some cases. In which case, should we be checking for
> > > > > kthreads first?

> Sorry, I'm not trying to catch you out! Just trying to understand what the
> semantics are supposed to be.
> 
> I do find the concept of user_mode(regs) bizarre for the idle task. By the
> above, we definitely have a bug on arm64 (user_mode(regs) tends to be
> true for the idle task), and I couldn't figure out how you avoided it on
> x86. I guess it happens to work because the stack is zero-initialised or
> something?

So lets take the whole thing:

static void perf_sample_regs_user(struct perf_regs *regs_user,
				  struct pt_regs *regs,
				  struct pt_regs *regs_user_copy)
{
	if (user_mode(regs)) {
		regs_user->abi = perf_reg_abi(current);
		regs_user->regs = regs;
	} else if (!(current->flags & PF_KTHREAD)) {
		perf_get_regs_user(regs_user, regs, regs_user_copy);
	} else {
		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
		regs_user->regs = NULL;
	}
}

This is called from the perf-generate-a-sample path, which is typically
an exception (IRQ/NMI/whatever) or a software/tracepoint thing.

In the exception case, the @regs argument are the exception register, as
provided by your entry.S to your exception handlers. In the
software/tracepoint thing, it is the result of
perf_arch_fetch_caller_regs().

So @regs is always 'sane' and user_mode(regs) tells us if the exception
came from userspace (and software/tracepoints always fail this, they
'obviously' don't come from userspace). If we're idle, we're not from
userspace, so this branch doesn't matter.

Next, we test if there is a userspace part _at_all_, this is the newly
minted: '!(current->flags & PF_KTHREAD)', if that passes, we use
architecture magic -- task_pt_regs() -- to get the user-regs. This can
be crap. But since the idle task will always fail our test (as would
the old one, idle->mm is always NULL), we'll never get here for idle.

Then failing the above two, as we must for idle, we'll default to
ABI_NONE/NULL.


Does that help?
