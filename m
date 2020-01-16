Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E58213D0D9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 01:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbgAPABG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jan 2020 19:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbgAPABF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 19:01:05 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1EC2084D;
        Thu, 16 Jan 2020 00:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579132865;
        bh=ciFT8G0ig7AoC90XTjW1a7CBM1WZ+CVeOWBez3oxXJs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DoVqZUNAYc8CRttyVvmleFlgkFSVtlwU8hNhpNZDfpw6l2Yh51mVFu+qEOHD6uYbg
         d2dRAKwu0Ol5I1IRO6v0WwVweZ95n4PIRbKUhkdrNopyA6AU2Uwm4k5TXubFZkC0YI
         H3ht6KskOM/pTr1jbPSH3JQh38GIfgNwwUNLCIsg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 987B1352274D; Wed, 15 Jan 2020 16:01:04 -0800 (PST)
Date:   Wed, 15 Jan 2020 16:01:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, bristot@redhat.com,
        frextrite@gmail.com, madhuparnabhowmik04@gmail.com,
        urezki@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 rcu-dev] rcuperf: Measure memory footprint during
 kfree_rcu() test
Message-ID: <20200116000104.GO2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191219211349.235877-1-joel@joelfernandes.org>
 <20191221000729.GH2889@paulmck-ThinkPad-P72>
 <20191221033714.GB156579@google.com>
 <20200106195200.GS13449@paulmck-ThinkPad-P72>
 <20200115220300.GA94036@google.com>
 <20200115224251.GK2935@paulmck-ThinkPad-P72>
 <20200115224542.GB94036@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115224542.GB94036@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 05:45:42PM -0500, Joel Fernandes wrote:
> On Wed, Jan 15, 2020 at 02:42:51PM -0800, Paul E. McKenney wrote:
> > > [snip]
> > > > > We can certainly refine it further but at this time I am thinking of spending
> > > > > my time reviewing Lai's patches and learning some other RCU things I need to
> > > > > catch up on. If you hate this patch too much, we can also defer this patch
> > > > > review for a bit and I can carry it in my tree for now as it is only a patch
> > > > > to test code. But honestly, in its current form I am sort of happy with it.
> > > > 
> > > > OK, I will keep it as is for now and let's look again later on.  It is not
> > > > in the bucket for the upcoming merge window in any case, so we do have
> > > > quite a bit of time.
> > > > 
> > > > It is not that I hate it, but rather that I want to be able to give
> > > > good answers to questions that might come up.  And given that I have
> > > > occasionally given certain people a hard time about their statistics,
> > > > it is only reasonable to expect them to return the favor.  I wouldn't
> > > > want you to be caught in the crossfire.  ;-)
> > > 
> > > Since the weights were concerning, I was thinking of just using a weight of
> > > (1 / N) where N is the number of samples. Essentially taking the average.
> > > That could be simple enough and does not cause your concerns with weight
> > > tuning. I tested it and looks good, I'll post it shortly.
> > 
> > YES!!!  ;-)
> > 
> > Snapshot mem_begin before entering the loop.  For the mean value to
> > be solid, you need at least 20-30 samples, which might mean upping the
> > default for kfree_loops.  Have an "unsigned long long" to accumulate the
> > sum, which should avoid any possibility of overflow for current systems
> > and for all systems for kfree_loops less than PAGE_SIZE.  At which point,
> > forget the "%" stuff and just sum up the si_mem_available() on each pass
> > through the loop.
> > 
> > Do the division on exit from the loop, preferably checking for divide
> > by zero.
> > 
> > Straightforward, fast, reasonably reliable, and easy to defend.
> 
> I mostly did it along these lines. Hopefully the latest posting is reasonable
> enough ;-) I sent it twice because I messed up the authorship (sorry).

No problem with the authorship-fix resend!

But let's get this patch consistent with basic statistics!

You really do need 20-30 samples for an average to mean much.

Of course, right now you default kfree_loops to 10.  You are doing
8000 kmalloc()/kfree_rcu() loops on each pass.  This is large enough
that just dropping the "% 4" should be just fine from the viewpoint of
si_mem_available() overhead.  But 8000 allocations and frees should get
done in way less than one second, so kicking the default kfree_loops up
to 30 should be a non-problem.

Then the patch would be both simpler and statistically valid.

So could you please stop using me as the middleman in your fight with
the laws of mathematics and get this patch to a defensible state?  ;-)

							Thanx, Paul
