Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE12DF5BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2019 00:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfKHXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Nov 2019 18:42:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfKHXm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:42:27 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.120.164.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1C0207FA;
        Fri,  8 Nov 2019 23:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573256547;
        bh=njd2BrNS+CzqOGrTNd0P/SZn4caSso1i9s77K2rtDlM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZfsypRI+tdJF9WNRVlFaZeKwDUwJ1rHBPopMKn94YcPfzYc59892vSEPLYoDAF2YF
         h7CTnROlSogdw8odeUevtUempX7ghDinliYP/d43cw7zJ4dXhx9p/KnBzHy7jyZkiP
         esgvK6ID0tTmEkbM3NSVs/hAcXscUvdc2d1rqESk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0512F3520B54; Fri,  8 Nov 2019 15:42:25 -0800 (PST)
Date:   Fri, 8 Nov 2019 15:42:24 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 1/2] list: add hlist_unhashed_lockless()
Message-ID: <20191108234224.GF20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191107193738.195914-1-edumazet@google.com>
 <20191108192448.GB20975@paulmck-ThinkPad-P72>
 <CANn89iKNLESN7U7BtyzkC6WLVn__Hm727A5cRm6PDuzG5+E4vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKNLESN7U7BtyzkC6WLVn__Hm727A5cRm6PDuzG5+E4vA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 12:17:49PM -0800, Eric Dumazet wrote:
> On Fri, Nov 8, 2019 at 11:24 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Nov 07, 2019 at 11:37:37AM -0800, Eric Dumazet wrote:
> > > We would like to use hlist_unhashed() from timer_pending(),
> > > which runs without protection of a lock.
> > >
> > > Note that other callers might also want to use this variant.
> > >
> > > Instead of forcing a READ_ONCE() for all hlist_unhashed()
> > > callers, add a new helper with an explicit _lockless suffix
> > > in the name to better document what is going on.
> > >
> > > Also add various WRITE_ONCE() in __hlist_del(), hlist_add_head()
> > > and hlist_add_before()/hlist_add_behind() to pair with
> > > the READ_ONCE().
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> >
> > I have queued this, but if you prefer it go some other way:
> >
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > But shouldn't the uses in include/linux/rculist.h also be converted
> > into the patch below?  If so, I will squash the following into your
> > patch.
> >
> >                                                 Thanx, Paul
> >
> > ------------------------------------------------------------------------
> 
> Agreed, thanks for the addition of this Paul.

Very good, squashed and pushed, thank you!

							Thanx, Paul
