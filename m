Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFCC15BC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2020 11:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgBMKUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Feb 2020 05:20:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMKUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:20:51 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C9F0217F4;
        Thu, 13 Feb 2020 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581589251;
        bh=BQdXfzJ9MTc8kZVQk6XRTVIqTC/mKl2mX43WGj7zAXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wpln0ZBWzD9KiIfhJ1zVzBs/HVAJYzDwSr0HONyos29N+Dq1rNPB7/57yeBOcQyUk
         34sJ7+c86Zmj8aL+PeKOE9ml9iMq9Mmnw0zjDY2jN5/W0W23YfKULJ3aZGCti+bMFV
         gWABNf0bQpOYF8FiYyp+SnfGfK0EKm1kq6WHs6+c=
Date:   Thu, 13 Feb 2020 10:20:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Stefan Asserhall <stefana@xilinx.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>, git <git@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: [PATCH 7/7] microblaze: Do atomic operations by using exclusive
 ops
Message-ID: <20200213102045.GC1405@willie-the-truck>
References: <cover.1581522136.git.michal.simek@xilinx.com>
 <ba3047649af07dadecf1a52e7d815db8f068eb24.1581522136.git.michal.simek@xilinx.com>
 <20200212155500.GB14973@hirez.programming.kicks-ass.net>
 <4b46b33e-14ad-7097-f0db-2915ac772f15@xilinx.com>
 <20200213085849.GL14897@hirez.programming.kicks-ass.net>
 <20200213091651.GA14946@hirez.programming.kicks-ass.net>
 <20200213100403.GA1405@willie-the-truck>
 <BYAPR02MB4997A184EFBE4DA755BA1C1CDD1A0@BYAPR02MB4997.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB4997A184EFBE4DA755BA1C1CDD1A0@BYAPR02MB4997.namprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:14:13AM +0000, Stefan Asserhall wrote:
> > On Thu, Feb 13, 2020 at 10:16:51AM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 13, 2020 at 09:58:49AM +0100, Peter Zijlstra wrote:
> > >
> > > > The thing is, your bog standard LL/SC _SHOULD_ fail the SC if
> > > > someone else does a regular store to the same variable. See the
> > > > example in Documentation/atomic_t.txt.
> > > >
> > > > That is, a competing SW/SWI should result in the interconnect
> > > > responding with something other than EXOKAY, the SWX should fail and
> > MSR[C] <- 1.
> > >
> > > The thing is; we have code that relies on this behaviour. There are a
> > > few crusty SMP archs that sorta-kinda limp along (mostly by disabling
> > > some of the code and praying the rest doesn't trigger too often), but
> > > we really should not allow more broken SMP archs.
> > 
> > I did find this in the linked pdf:
> > 
> >   | If the store [swx] is successful, the sequence of instructions from
> >   | the semaphore load to the semaphore store appear to be executed
> >   | atomically - no other device modified the semaphore location between
> >   | the read and the update.
> > 
> > which sounds like we're ok, although it could be better worded.
> > 
> > One part I haven't figured out is what happens if you take an interrupt between
> > the lwx and the swx and whether you can end up succeeding thanks to
> > somebody else's reservation. Also, the manual is silent about the interaction
> > with TLB invalidation and just refers to "address" when talking about the
> > reservation. What happens if a user thread triggers CoW while another is in the
> > middle of a lwx/swx?
> > 
> > Will
> 
> The manual says "Reset, interrupts, exceptions, and breaks (including the BRK 
> and BRKI instructions) all clear the reservation." In case of a TLB invalidation 
> between lwx and swx, you will get a TLB miss exception when attempting the
> swx, and the reservation will be cleared due to the exception.

Perfect, then I think we're good to go!

Will
