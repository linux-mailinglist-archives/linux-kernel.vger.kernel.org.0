Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBEFF70A01
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2019 21:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbfGVTpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jul 2019 15:45:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37494 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfGVTp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F2L52boKDljt3MAEYZNfsqLyO7iVE7+Gf55mLSaK+Rs=; b=fsgUci+MojT5Whs0omyMgjOhW
        ZaotFFW/Iyprf3AnYHGb0ystKehFPlmXfbjQ0UxRv4fBGPqwEIH3WlM7RtCm85kTvXzL5A/V1heHy
        UVWqIRdzLI1DwxrTNg7nu+JNOUGBrrbelxFBVpIz4BQ6EWZF91F/s3moAUhMAsDDCZ4uzdkgZ2XGe
        WbaZSAUpaLGuw9qshg3ZDHmQZk4A7/vLG6gFB1yA1u4zR11DAJ59n4Ik0r/yB6XPv+0Jg01ewCg8R
        RBS6aoP6Z6V3U2ZmxP3rD+OH26/ecBSZSP507zprCOE9rw/PTVCc3Gboqo/whCv5PSkV7F+LbYVRW
        tTkWyXbYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpeFS-0006T0-Je; Mon, 22 Jul 2019 19:45:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 761B7980C59; Mon, 22 Jul 2019 21:45:24 +0200 (CEST)
Date:   Mon, 22 Jul 2019 21:45:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Fox <afox@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH] sched/cputime: make scale_stime() more precise
Message-ID: <20190722194524.GH6698@worktop.programming.kicks-ass.net>
References: <20190718131834.GA22211@redhat.com>
 <20190719110349.GG3419@hirez.programming.kicks-ass.net>
 <20190719140325.GA31938@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719140325.GA31938@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 04:03:25PM +0200, Oleg Nesterov wrote:
> On 07/19, Peter Zijlstra wrote:
> > Included below is also an x86_64 implementation in 2 instructions.
> 
> But we need the arch-neutral implementation anyway, the code above
> is the best I could invent.

Agreed; we do. Depending on the cost of division and if the arch has a
64x64->128 mult, it might be better to compute a reciprocal and multiply
that, but yes, long staring didn't get me much better ideas either.

> But see below!
> 
> > I'm still trying see if there's anything saner we can do...
> 
> Oh, please, it is not that I like my solution very much, I would like
> to see something more clever.
> 
> > static noinline u64 mul_u64_u64_div_u64(u64 a, u64 b, u64 c)
> > {
> > 	u64 q;
> > 	asm ("mulq %2; divq %3" : "=a" (q) : "a" (a), "rm" (b), "rm" (c) : "rdx");
> > 	return q;
> > }
> 
> Heh. I have to admit that I didn't know that divq divides 128bit by
> 64bit. gcc calls the __udivti3 intrinsic in this case so I wrongly
> came to conclusion this is not simple even on x86_64. Plus the fact
> that linux/math64.h only has mul_u64_u64_shr()...

C wants to promote the dividend and divisor to the same type (int128)
and then it runs into trouble.

But yeah, I don't know how many other 64bit archs can pull off that
trick. I asked, and ARGH64 cannot do that 128/64 (although it can do a
64x64->128 in two instructions).

