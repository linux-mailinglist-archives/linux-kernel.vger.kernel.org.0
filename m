Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922F8DE066
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 22:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfJTU3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 16:29:38 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:46461 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbfJTU3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 16:29:38 -0400
X-IronPort-AV: E=Sophos;i="5.67,320,1566856800"; 
   d="scan'208";a="407084399"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 22:29:35 +0200
Date:   Sun, 20 Oct 2019 22:29:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [Outreachy kernel] Re: [PATCH v1 1/5] staging: wfx: fix warnings
 of no space is necessary
In-Reply-To: <7ef650e0a6487a3eefc8df9eaf0ab20b5d26bad1.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1910202227480.10441@hadrien>
References: <20191019140719.2542-1-jbi.octave@gmail.com>   <20191019140719.2542-2-jbi.octave@gmail.com>  <20191019142443.GH24678@kadam>   <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>   <20191019180514.GI24678@kadam>   <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
  <20191020191759.GJ24678@kadam>  <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>  <alpine.DEB.2.21.1910202149140.10441@hadrien> <7ef650e0a6487a3eefc8df9eaf0ab20b5d26bad1.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 Oct 2019, Joe Perches wrote:

> On Sun, 2019-10-20 at 21:52 +0200, Julia Lawall wrote:
> > On Sun, 20 Oct 2019, Joe Perches wrote:
> []
> > > There's probably a generic cocci mechanism to check function
> > > prototypes and then remove uses of unnecessary void pointer casts
> > > in function calls.  I'm not going to try to figure out that syntax.
> >
> > With the --recursive-includes option, perhaps:
> >
> > @r@
> > identifier f;
> > parameter list[n] ps;
> > type T;
> > identifier i;
> > @@
> >
> > T f(ps, void *i, ...);
> >
> > @@
> > expression e;
> > identifier r.f;
> > expression list[r.n] es;
> > @@
> >
> > f(es,
> > - (void *)(e)
> > + e
> >   ,...)
> >
> > This of course only works for functions that have prototypes, and not for
> > macros.  It will also run slowly.
>
> You are not kidding about slow, but it doesn't seem to work
> for mem<foo>, maybe because system includes aren't analyzed.

No they are not.

> Single file processing time on an XPS13 averages more than
> 100 seconds per file.

Not surprising.

Actually, --include-headers-for-types should provide some benefit.  That
discards the header files after the type inference.

> Also:
>
> 	expression e;
>
> could probably be better as:
>
> 	type T;
> 	T *p;

Good point.  expression *e; would be sufficient.

julia

>
> as some of the expressions cast to void are int or size_t
> and it's probably better to restrict the conversions to
> just pointer or array types.
>
>
>
