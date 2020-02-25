Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE07416B82F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 04:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgBYDpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Feb 2020 22:45:38 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:31503 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbgBYDpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:45:38 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 01P3jTMA008979;
        Tue, 25 Feb 2020 04:45:29 +0100
Date:   Tue, 25 Feb 2020 04:45:29 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Denis Efremov <efremov@linux.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/10] floppy: cleanup: expand macro FDCS
Message-ID: <20200225034529.GA8908@1wt.eu>
References: <20200224212352.8640-1-w@1wt.eu>
 <20200224212352.8640-2-w@1wt.eu>
 <CAHk-=wi4R_nPdE4OuNW9daKFD4FpV74PkG4USHqub+nuvOWYFg@mail.gmail.com>
 <28e72058-021d-6de0-477e-6038a10d96da@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e72058-021d-6de0-477e-6038a10d96da@linux.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 02:13:42AM +0300, Denis Efremov wrote:
> On 2/25/20 12:53 AM, Linus Torvalds wrote:
> > So I'd like to see that second step that does the
> > 
> >     -static int fdc;                 /* current fdc */
> >     +static int current_fdc;
> > 
> > change.
> > 
> > We already call the global 'drive' variable 'current_drive', so it
> > really is 'fdc' that is misnamed and ambiguous because it then has two
> > different cases: the global 'fdc' and then the various shadowing local
> > 'fdc' variables (or function arguments).
> > 
> > Mind adding that too? Slightly less automatic, I agree, because then
> > you really do have to disambiguate between the "is this the shadowed
> > use of a local 'fdc'" case or the "this is the global 'fdc' use" case.

I definitely agree. I first wanted to be sure the patches were acceptable
as a principle, but disambiguating the variables is easy to do now.

> > Can coccinelle do that?

I could do it by hand, I did quite a bit of manual changes and checks
already and the driver is not that long.

> Willy, if you don't want to spend your time with this code anymore I can
> prepare pat?hes for the second step. I know coccinelle and could try
> to automate this transformation. At first sight your patches look
> good to me. I will answer to the top email after more accurate review.

OK, it's as you like. If you think you can do the change quickly, feel
free to do so, otherwise it should not take me more than one hour. In
any case as previously mentioned I still have the hardware in a usable
state if you want me to recheck anything.

Cheers,
Willy
