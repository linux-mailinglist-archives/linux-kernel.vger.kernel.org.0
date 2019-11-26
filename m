Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0708210A67D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2019 23:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfKZWYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Nov 2019 17:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfKZWYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:24:30 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B91320678;
        Tue, 26 Nov 2019 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574807069;
        bh=QAX5ZkLqeX3XIqm05M7wJBsdoBGFDQs4mnX4cJBY7ro=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rd+Kt9pqSWX0e2SmWjaCIO6Gx/9U6YpAHGSBhthMDJGyAzRfTqHpwgrlUFg4rDMyi
         XRaPahjt4sjlaFlvy+yog9Jcdq/pd1myAYu5UVPboOix5/wBySHDhvEwCBbXq/Qbgv
         TPJCMVzYH0edjHzllovHWLkhDf1gJAvacTZy64Ss=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E883235227AB; Tue, 26 Nov 2019 14:24:28 -0800 (PST)
Date:   Tue, 26 Nov 2019 14:24:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 11/13] powerpc: Remove comment about
 read_barrier_depends()
Message-ID: <20191126222428.GX2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191108170120.22331-1-will@kernel.org>
 <20191108170120.22331-12-will@kernel.org>
 <87imnebzpb.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imnebzpb.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 09:37:52PM +1100, Michael Ellerman wrote:
> Will Deacon <will@kernel.org> writes:
> > 'read_barrier_depends()' doesn't exist anymore so stop talking about it.
> >
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/powerpc/include/asm/barrier.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
> > index fbe8df433019..123adcefd40f 100644
> > --- a/arch/powerpc/include/asm/barrier.h
> > +++ b/arch/powerpc/include/asm/barrier.h
> > @@ -18,8 +18,6 @@
> >   * mb() prevents loads and stores being reordered across this point.
> >   * rmb() prevents loads being reordered across this point.
> >   * wmb() prevents stores being reordered across this point.
> > - * read_barrier_depends() prevents data-dependent loads being reordered
> > - *	across this point (nop on PPC).
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Queued for v5.6, thank you both!

							Thanx, Paul
