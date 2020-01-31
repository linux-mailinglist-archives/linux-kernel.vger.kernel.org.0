Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23D14F0F6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jan 2020 17:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgAaQ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jan 2020 11:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgAaQ5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:57:23 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45C3214D8;
        Fri, 31 Jan 2020 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580489842;
        bh=eng9x2c4Ep6LkQVraWxLpgjmLPOYM2DWVkVo91THJm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XnqqjIgfLu+qRlqqXH1iC5hB2x8a8N63l/Sh++Jji0rs0YSbq96CrHZDrVi/o38Xu
         gzvbDxgJ6NYtlOu+8LczFxXzBdEnCc9Lnr28+Qwsqpq5ht721TQ2HHWxfxhMc2rOGP
         viyJ5OHjKO0B0OYnfNKlg68o4Hz9kboOLdQ+k2xE=
Date:   Fri, 31 Jan 2020 16:57:18 +0000
From:   Will Deacon <will@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Confused about hlist_unhashed_lockless()
Message-ID: <20200131165718.GA5517@willie-the-truck>
References: <20200131164308.GA5175@willie-the-truck>
 <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+CnezK81gZSLOy0w7MaZy0uT=xyxoKSTyZU3aMpzifOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:48:05AM -0800, Eric Dumazet wrote:
> On Fri, Jan 31, 2020 at 8:43 AM Will Deacon <will@kernel.org> wrote:
> > I just ran into c54a2744497d ("list: Add hlist_unhashed_lockless()")
> > but I'm a bit confused about what it's trying to achieve. It also seems
> > to have been merged without any callers (even in -next) -- was that
> > intentional?
> >
> > My main source of confusion is the lack of memory barriers. For example,
> > if you look at the following pair of functions:
> >
> >
> > static inline int hlist_unhashed_lockless(const struct hlist_node *h)
> > {
> >         return !READ_ONCE(h->pprev);
> > }
> >
> > static inline void hlist_add_before(struct hlist_node *n,
> >                                     struct hlist_node *next)
> > {
> >         WRITE_ONCE(n->pprev, next->pprev);
> >         WRITE_ONCE(n->next, next);
> >         WRITE_ONCE(next->pprev, &n->next);
> >         WRITE_ONCE(*(n->pprev), n);
> > }
> >
> >
> > Then running these two concurrently on the same node means that
> > hlist_unhashed_lockless() doesn't really tell you anything about whether
> > or not the node is reachable in the list (i.e. there is another node
> > with a next pointer pointing to it). In other words, I think all of
> > these outcomes are permitted:
> >
> >         hlist_unhashed_lockless(n)      n reachable in list
> >         0                               0 (No reordering)
> >         0                               1 (No reordering)
> >         1                               0 (No reordering)
> >         1                               1 (Reorder first and last WRITE_ONCEs)
> >
> > So I must be missing some details about the use-case here. Please could
> > you enlighten me? The RCU implementation permits only the first three
> > outcomes afaict, why not use that and leave non-RCU hlist as it was?
> >
> 
> I guess the following has been lost :

Thanks, although...

> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Nov 7 11:23:14 2019 -0800
> 
>     timer: use hlist_unhashed_lockless() in timer_pending()
> 
>     timer_pending() is mostly used in lockless contexts.

... my point above still stands: the value returned by
hlist_unhashed_lockless() doesn't tell you anything about whether or
not the timer is reachable in the hlist or not. The comment above
timer_pending() also states that:

  | Callers must ensure serialization wrt. other operations done to
  | this timer, e.g. interrupt contexts, or other CPUs on SMP.

If that is intended to preclude list operations, shouldn't we use an
RCU hlist instead of throwing {READ,WRITE}_ONCE() at the problem to
shut the sanitiser up without actually fixing anything? :(

Will
