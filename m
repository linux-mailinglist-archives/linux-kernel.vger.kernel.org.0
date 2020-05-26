Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CBB19B785
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 23:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbgDAVYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 17:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732357AbgDAVYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:24:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76EC7206F6;
        Wed,  1 Apr 2020 21:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585776259;
        bh=SpscMagTGAG+/VHvh41OMqrZQ5CvygLTC+B3GQz0ogk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=tVgRLcS2kdUtwBo1l6umHNb/ZLd3PjKyaifUwJ/xOhBSMlofuc0U1uiJgfN0BQpaG
         gp1Y+HCjgEV7x2MOKJKTAdIBFlQT+Fb4savqUbGMk/uYZnDwlc7VVE5a5U/eIl837P
         2oq9+460OYha2qZ+/LKOXsVWJznHfv2y2T72cyC4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5243735226B3; Wed,  1 Apr 2020 14:24:19 -0700 (PDT)
Date:   Wed, 1 Apr 2020 14:24:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: What should we be doing to stress-test kfree_rcu()?
Message-ID: <20200401212419.GN19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200401184415.GA7619@paulmck-ThinkPad-P72>
 <20200401205012.GC206273@google.com>
 <20200401211607.GA7531@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401211607.GA7531@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:16:07PM +0200, Uladzislau Rezki wrote:
> On Wed, Apr 01, 2020 at 04:50:12PM -0400, Joel Fernandes wrote:
> > On Wed, Apr 01, 2020 at 11:44:15AM -0700, Paul E. McKenney wrote:
> > > Hello!
> > > 
> > > What should we be doing to stress-test kfree_rcu(), including its ability
> > > to cope with OOM conditions?  Yes, rcuperf runs are nice, but they are not
> > > currently doing much more than testing base functionality, performance,
> > > and scalability.
> > 
> > I already stress kfree_rcu() with rcuperf right now to a point of OOM and
> > make sure it does not OOM. The way I do this is set my VM to low memory (like
> > 512MB) and then flood kfree_rcu()s. After the shrinker changes, I don't see
> > OOM with my current rcuperf settings.
> > 
> > Not saying that my testing is sufficient, just saying this is what I do. It
> > would be good to get a real workload to trigger lot of kfree_rcu() activity
> > as well especially on low memory systems. Any ideas on that?
> > 
> > One idea could be to trigger memory pressure from unrelated allocations (such
> > as userspace memory hogs), and see how it perform with memory-pressure. For
> > one, the shrinker should trigger in such situations to force the queue into
> > waiting for a GP in such situations instead of batching too much.

This would be good!

> > We are also missing vmalloc() tests. I remember Vlad had some clever vmalloc
> > tests around for his great vmalloc rewrites :). Vlad, any thoughts on getting
> > to stress kvfree_rcu()?
> > 
> Actually i updated(localy for my tests) the lib/test_vmalloc.c module with extra
> test cases to stress kvfree_rcu() stuff. I think i should add them :)

As would this!  ;-)

							Thanx, Paul
