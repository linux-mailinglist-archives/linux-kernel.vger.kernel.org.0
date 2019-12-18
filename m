Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4367C124397
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Dec 2019 10:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLRJrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Dec 2019 04:47:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57182 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:47:41 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ihVvd-0005Rx-IR; Wed, 18 Dec 2019 10:47:37 +0100
Date:   Wed, 18 Dec 2019 10:47:37 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of: Rework and simplify phandle cache to use a fixed size
Message-ID: <20191218094737.tqq5oeajfgvds6n5@linutronix.de>
References: <20191211232345.24810-1-robh@kernel.org>
 <CAL_JsqKfV-4mx_uidUupQJT4qfq+y+qx1=S=Du-Qsaweh4CPUQ@mail.gmail.com>
 <20191212130539.loxpr2hbfcodh4gz@linutronix.de>
 <CAL_JsqJgi+Rd1jiBiTcbuoiZUnpahdNfbAQNkbPH4LEM1Cs09A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqJgi+Rd1jiBiTcbuoiZUnpahdNfbAQNkbPH4LEM1Cs09A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-12 13:28:26 [-0600], Rob Herring wrote:
> On Thu, Dec 12, 2019 at 7:05 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2019-12-11 17:48:54 [-0600], Rob Herring wrote:
> > > > -       if (phandle_cache) {
> > > > -               if (phandle_cache[masked_handle] &&
> > > > -                   handle == phandle_cache[masked_handle]->phandle)
> > > > -                       np = phandle_cache[masked_handle];
> > > > -               if (np && of_node_check_flag(np, OF_DETACHED)) {
> > > > -                       WARN_ON(1); /* did not uncache np on node removal */
> > > > -                       of_node_put(np);
> > > > -                       phandle_cache[masked_handle] = NULL;
> > > > -                       np = NULL;
> > > > -               }
> > > > +       if (phandle_cache[handle_hash] &&
> > > > +           handle == phandle_cache[handle_hash]->phandle)
> > > > +               np = phandle_cache[handle_hash];
> > > > +       if (np && of_node_check_flag(np, OF_DETACHED)) {
> > > > +               WARN_ON(1); /* did not uncache np on node removal */
> > >
> > > BTW, I don't think this check is even valid. If we failed to detach
> > > and remove the node from the cache, then we could be accessing np
> > > after freeing it.
> >
> > this is kmalloc()ed memory which is always valid. If the memory is
> > already re-used then
> >         handle == phandle_cache[handle_hash]->phandle
> >
> > will fail (the check, not the memory access itself).
> 
> There's a 1 in 2^32 chance it won't.

:)

> > If the check
> > remains valid then you can hope for the OF_DETACHED flag to trigger the
> > warning.
> 
> Keyword is hope.
> 
> To look at it another way. Do we need this check? It is in the "fast
> path". There's a single location where we set OF_DETACHED and the
> cache entry is removed at the same time. Also, if we do free the
> node's memory, it also checks for OF_DETACHED. Previously, a free
> wouldn't happen because we incremented the ref count on nodes in the
> cache.

So get rid of it then. It is just __of_detach_node() that removes it.

> Rob

Sebastian
