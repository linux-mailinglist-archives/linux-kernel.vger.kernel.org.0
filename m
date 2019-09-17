Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D851B539D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2019 19:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730707AbfIQRGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Sep 2019 13:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfIQRGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 13:06:24 -0400
Received: from paulmck-ThinkPad-P72 (unknown [50.237.200.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20E62067B;
        Tue, 17 Sep 2019 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568739984;
        bh=2GzNt1P+iqY/06t/D5kCmnG+P1fIONIj1Ts/1jyDsRA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xZ0/InWY37pRBWkJRyhn7y07poVMPUU3OnqDU2tNYBCoU6rP22nkOEJqRfrfL9beU
         izDrC8g9OPcWKcNYX480XSgF785jXpu06tVL6ZNJPeqta9ZFV4uSW+Sw1VJOHxRbXx
         WZVwTFQDqcD316NGjcUFYh+OxjoD8AYepj0NKz+I=
Date:   Tue, 17 Sep 2019 10:06:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: locktorture: Do not include rwlock.h directly
Message-ID: <20190917170620.GC30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190916145404.bukcmlliequu77wk@linutronix.de>
 <20190917071614.kcmux562y6wbskj5@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917071614.kcmux562y6wbskj5@linux-p48b>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 12:16:14AM -0700, Davidlohr Bueso wrote:
> On Mon, 16 Sep 2019, Sebastian Andrzej Siewior wrote:
> 
> > From: Wolfgang M. Reimer <linuxball@gmail.com>
> > 
> > Including rwlock.h directly will cause kernel builds to fail
> > if CONFIG_PREEMPT_RT is defined. The correct header file
> > (rwlock_rt.h OR rwlock.h) will be included by spinlock.h which
> > is included by locktorture.c anyway.
> > 
> > Remove the include of linux/rwlock.h.
> > 
> 
> Acked-by: Davidlohr Bueso <dbueso@suse.de>

Applied, thank you!

But does anyone actually run locktorture?

							Thanx, Paul

> > Signed-off-by: Wolfgang M. Reimer <linuxball@gmail.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > kernel/locking/locktorture.c | 1 -
> > 1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > index c513031cd7e33..9fb042d610d23 100644
> > --- a/kernel/locking/locktorture.c
> > +++ b/kernel/locking/locktorture.c
> > @@ -16,7 +16,6 @@
> > #include <linux/kthread.h>
> > #include <linux/sched/rt.h>
> > #include <linux/spinlock.h>
> > -#include <linux/rwlock.h>
> > #include <linux/mutex.h>
> > #include <linux/rwsem.h>
> > #include <linux/smp.h>
> > -- 
> > 2.23.0
> > 
