Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D75EB67B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfIRQGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 12:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727609AbfIRQGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:06:24 -0400
Received: from paulmck-ThinkPad-P72 (unknown [50.237.200.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E0E4208C0;
        Wed, 18 Sep 2019 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568822784;
        bh=ufV+8/UZw+vPMDxNA536wLRDJt1zPivHGmQyve3d8aw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=15NJGStM4Da4odbjTTHfh/6lBz4MhxmwovCJSvCvLS4Bz3vRQ8UokWtiXuxTvsTb8
         X2f4xkjBMTU2ptM2IMkvGGgXIjjEDCXEq90+uXlkQihx9KtGqvAWX23Mk/Cr8g01au
         0ubr42g5whT68U+j/17JeotLNHGHDNjZsHLqDBp4=
Date:   Wed, 18 Sep 2019 09:06:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: locktorture: Do not include rwlock.h directly
Message-ID: <20190918160621.GH30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190916145404.bukcmlliequu77wk@linutronix.de>
 <20190917071614.kcmux562y6wbskj5@linux-p48b>
 <20190917170620.GC30224@paulmck-ThinkPad-P72>
 <20190918062404.hyk5p2gs4mtybl3t@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918062404.hyk5p2gs4mtybl3t@linux-p48b>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 11:24:04PM -0700, Davidlohr Bueso wrote:
> On Tue, 17 Sep 2019, Paul E. McKenney wrote:
> 
> > On Tue, Sep 17, 2019 at 12:16:14AM -0700, Davidlohr Bueso wrote:
> > > On Mon, 16 Sep 2019, Sebastian Andrzej Siewior wrote:
> > > 
> > > > From: Wolfgang M. Reimer <linuxball@gmail.com>
> > > >
> > > > Including rwlock.h directly will cause kernel builds to fail
> > > > if CONFIG_PREEMPT_RT is defined. The correct header file
> > > > (rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
> > > > is included by locktorture.c anyway.
> > > >
> > > > Remove the include of linux/rwlock.h.
> > > >
> > > 
> > > Acked-by: Davidlohr Bueso <dbueso@suse.de>
> > 
> > Applied, thank you!
> > 
> > But does anyone actually run locktorture?
> 
> I do at least. I also know of cases of other folks making use of the
> "framework" to test/pound on custom tailored locks -- ie btrfs tree lock.
> 
> I've also seen it in one or two academic papers.

OK, I will hold off on a patch removing it, then.  ;-)

							Thanx, Paul
