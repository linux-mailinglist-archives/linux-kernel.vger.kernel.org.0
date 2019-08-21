Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D997FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2019 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfHUQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Aug 2019 12:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfHUQWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:22:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AEBC22DA7;
        Wed, 21 Aug 2019 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566404549;
        bh=uKsVNis+LsCYM1npzutJ33qZg3nrwWpmgnmroIqEDT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+Onsyrbs0XKyrv41eDp7HLcxHvh7N2mqUuLgVCfngayJwLIgKaCSWLsbTSoFCe1F
         7rqzKWwlbCVdS9GXmCfQa863TJGRWMAgzayHYp/rEbae4BaVHi08to9Es72A3T1vQk
         Vmk/UVgzZdTasd8DvgumijBKiaL8jQzlyf9ZHFkw=
Date:   Wed, 21 Aug 2019 17:22:24 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190821162224.vduxnioxdm3m5vgh@willie-the-truck>
References: <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
 <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
 <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
 <20190820135612.GS2332@hirez.programming.kicks-ass.net>
 <20190820202932.GW28441@linux.ibm.com>
 <20190821103200.kpufwtviqhpbuv2n@willie-the-truck>
 <20190821132310.GC28441@linux.ibm.com>
 <20190821133247.vke6fnndm64h2lla@willie-the-truck>
 <20190821135610.GD28441@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821135610.GD28441@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 06:56:10AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 21, 2019 at 02:32:48PM +0100, Will Deacon wrote:
> > On Wed, Aug 21, 2019 at 06:23:10AM -0700, Paul E. McKenney wrote:
> > > On Wed, Aug 21, 2019 at 11:32:01AM +0100, Will Deacon wrote:
> > > > void bar(u64 *x)
> > > > {
> > > > 	*(volatile u64 *)x = 0xabcdef10abcdef10;
> > > > }
> > > > 
> > > > then I get:
> > > > 
> > > > bar:
> > > > 	mov	w1, 61200
> > > > 	movk	w1, 0xabcd, lsl 16
> > > > 	str	w1, [x0]
> > > > 	str	w1, [x0, 4]
> > > > 	ret
> > > > 
> > > > so I'm not sure that WRITE_ONCE would even help :/
> > > 
> > > Well, I can have the LWN article cite your email, then.  So thank you
> > > very much!
> > > 
> > > Is generation of this code for a 64-bit volatile store considered a bug?
> > 
> > I consider it a bug for the volatile case, and the one compiler person I've
> > spoken to also seems to reckon it's a bug, so hopefully it will be fixed.
> > I'm led to believe it's an optimisation in the AArch64 backend of GCC.
> 
> Here is hoping for the fix!
> 
> > > Or does ARMv8 exclude the possibility of 64-bit MMIO registers?  And I
> > > would guess that Thomas and Linus would ask a similar bugginess question
> > > for normal stores.  ;-)
> > 
> > We use inline asm for MMIO, fwiw.
> 
> I should have remembered that, shouldn't I have?  ;-)
> 
> Is that also common practice across other embedded kernels these days?

I think so. Sometimes you care about things like the addressing mode being
used, so it's easier to roll it by hand.

Will
