Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF228F44
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2019 04:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbfEXCvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 May 2019 22:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387654AbfEXCvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:51:13 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5612177E;
        Fri, 24 May 2019 02:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558666271;
        bh=mGxUo/+4R9E64TUxiYnoUO+bFwL9PHRzl0hlVota7eM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c1MNF1n66YWPAvd2JfLrXxTUDIWXPLg9dpZj21BOdke6Vz/KMRd1INezZgN22rOni
         UyL7wL9nEoHFq6WfrSKSWbmvCM1gQPJOfxlHJSvLA8fBAH6QKK0EBvOj1mNTRmRccm
         FZb/sxCvARG8NFUtGqugIfGq5O4n3gx2Q36bD+dg=
Date:   Thu, 23 May 2019 19:51:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Tobin C . Harding" <tobin@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Yury Norov <ynorov@marvell.com>,
        Jens Axboe <axboe@kernel.dk>,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 5/7] lib: rework bitmap_parse()
Message-Id: <20190523195110.f98e60898c8c29884d231a6e@linux-foundation.org>
In-Reply-To: <20190510022633.GA30629@yury-thinkpad>
References: <20190501010636.30595-1-ynorov@marvell.com>
        <20190501010636.30595-6-ynorov@marvell.com>
        <20190508084632.GY9224@smile.fi.intel.com>
        <20190510022633.GA30629@yury-thinkpad>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 19:26:33 -0700 Yury Norov <yury.norov@gmail.com> wrote:

> Hi Andy,
> 
> Thanks for thorough review.
> 
> On Wed, May 08, 2019 at 11:46:32AM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 30, 2019 at 06:06:34PM -0700, Yury Norov wrote:
> > > bitmap_parse() is ineffective and full of opaque variables and opencoded
> > > parts. It leads to hard understanding and usage of it. This rework
> > > includes:
> > >  - remove bitmap_shift_left() call from the cycle. Now it makes the
> > >    complexity of the algorithm as O(nbits^2). In the suggested approach
> > >    the input string is parsed in reverse direction, so no shifts needed;
> > >  - relax requirement on a single comma and no white spaces between chunks.
> > >    It is considered useful in scripting, and it aligns with
> > >    bitmap_parselist();
> > >  - split bitmap_parse() to small readable helpers;
> > >  - make an explicit calculation of the end of input line at the
> > >    beginning, so users of the bitmap_parse() won't bother doing this.
> > 
> > > +static inline bool in_str(const char *start, const char *ptr)
> > > +{
> > > +	return start <= ptr;
> > > +}
> > > +
> > 
> > The explicit use of the conditional is better.
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> 
> I still think that is_str() is more verbose, but it's minor issue
> anyways, so I obey. Below is the patch that removes the function.
> It's up to Andrew finally, either apply it or not.

I agree with Andy - open-coding the comparisons makes it easier to
understand the varoius in_str() callsites, IMO.

> @@ -653,7 +648,7 @@ int bitmap_parse(const char *start, unsigned int buflen,
>  	u32 *bitmap = (u32 *)maskp;
>  	int unset_bit;
>  
> -	while (in_str(start, (end = bitmap_find_region_reverse(start, end)))) {
> +	while (start <= (end = bitmap_find_region_reverse(start, end))) {

This statement hurts my little brain.  Can it be broken into easier to digest
chunks?

>  		if (!chunks--)
>  			return -EOVERFLOW;
>  
