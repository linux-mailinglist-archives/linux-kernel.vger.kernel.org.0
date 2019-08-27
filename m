Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC769F6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 01:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfH0Xed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Aug 2019 19:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfH0Xed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:34:33 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 351362186A;
        Tue, 27 Aug 2019 23:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566948872;
        bh=u9kCNCuUavGaLUJ2do7q30aA0z/LKW25VjraHn2v2vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LXm9jCHmK23s8tYo+VE6Lab+PTzMgUi6sRDCTL0vitposmHdXmBpAC+mgt6kTUbFt
         nIfo1O1h4No9kJag7WO7GxlixmY9oakcfe2fa9j1m3Pxb6/QZaYTir6B6q51dwbT9X
         mykbsb5rT60Zb9k45E0ee8wQp//7FsxTnbPABkao=
Date:   Tue, 27 Aug 2019 16:34:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas@shipmail.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: cleanup the walk_page_range interface
Message-Id: <20190827163431.65a284b295004d1ed258fbd5@linux-foundation.org>
In-Reply-To: <20190827013408.GC31766@mellanox.com>
References: <20190808154240.9384-1-hch@lst.de>
        <CAHk-=wh3jZnD3zaYJpW276WL=N0Vgo4KGW8M2pcFymHthwf0Vg@mail.gmail.com>
        <20190816062751.GA16169@infradead.org>
        <20190823134308.GH12847@mellanox.com>
        <20190824222654.GA28766@infradead.org>
        <20190827013408.GC31766@mellanox.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 01:34:13 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:

> On Sat, Aug 24, 2019 at 03:26:55PM -0700, Christoph Hellwig wrote:
> > On Fri, Aug 23, 2019 at 01:43:12PM +0000, Jason Gunthorpe wrote:
> > > > So what is the plan forward?  Probably a little late for 5.3,
> > > > so queue it up in -mm for 5.4 and deal with the conflicts in at least
> > > > hmm?  Queue it up in the hmm tree even if it doesn't 100% fit?
> > > 
> > > Did we make a decision on this? Due to travel & LPC I'd like to
> > > finalize the hmm tree next week.
> > 
> > I don't think we've made any decision.  I'd still love to see this
> > in hmm.git.  It has a minor conflict, but I can resend a rebased
> > version.
> 
> I'm looking at this.. The hmm conflict is easy enough to fix.
> 
> But the compile conflict with these two patches in -mm requires some
> action from Andrew:
> 
> commit 027b9b8fd9ee3be6b7440462102ec03a2d593213
> Author: Minchan Kim <minchan@kernel.org>
> Date:   Sun Aug 25 11:49:27 2019 +1000
> 
>     mm: introduce MADV_PAGEOUT
> 
> commit f227453a14cadd4727dd159782531d617f257001
> Author: Minchan Kim <minchan@kernel.org>
> Date:   Sun Aug 25 11:49:27 2019 +1000
> 
>     mm: introduce MADV_COLD
>     
>     Patch series "Introduce MADV_COLD and MADV_PAGEOUT", v7.
> 
> I'm inclined to suggest you send this series in the 2nd half of the
> merge window after this MADV stuff lands for least disruption? 

Just merge it, I'll figure it out.  Probably by staging Minchan's
patches after linux-next.

