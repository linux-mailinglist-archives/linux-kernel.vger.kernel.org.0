Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF815890F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 04:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBKDyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 22:54:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgBKDyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xyUxhDDylUL+UjwdQ8hbkvgcFL8EGI0zwerP7xmjMTY=; b=Ce3uez2venNJGkWfXOA3f8Qvpc
        Z5WqJfuP4vnPqODgs/VUySyyQi02UwgVnbp9Dl+eKedNQi76FPTHzP2l2rmVE/sA3q0sQKgua5ZCi
        Cfd5iWheXsoFFYcyugFnNrTFfablimvCWS7KcVgChJU5cT+A3QKVBfqiLKCxL6XTSMSlovKCGAzQJ
        XmiloqT+o2B4DFQHpl7f+Sy9Vbw/lvLYOWbK/PVkA20vbYG1DeqWkGYFDy2b2ovf0ytSckeWnktU6
        QYjyuWN/FMza0xOK6ap9YMPcQHi6BCU8GXsMoy3t7ko0gOwZ4jWKT47xUIFy7fxMckOh41ESzF23m
        6BGgTQFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Mcm-00069F-51; Tue, 11 Feb 2020 03:54:12 +0000
Date:   Mon, 10 Feb 2020 19:54:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix long time stall from mm_populate
Message-ID: <20200211035412.GR8731@bombadil.infradead.org>
References: <20200211001958.170261-1-minchan@kernel.org>
 <20200211011021.GP8731@bombadil.infradead.org>
 <20200211035004.GA242563@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211035004.GA242563@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 07:50:04PM -0800, Minchan Kim wrote:
> On Mon, Feb 10, 2020 at 05:10:21PM -0800, Matthew Wilcox wrote:
> > On Mon, Feb 10, 2020 at 04:19:58PM -0800, Minchan Kim wrote:
> > >       filemap_fault
> > >         find a page form page(PG_uptodate|PG_readahead|PG_writeback)
> > 
> > Uh ... That shouldn't be possible.
> 
> Please see shrink_page_list. Vmscan uses PG_reclaim to accelerate
> page reclaim when the writeback is done so the page will have both
> flags at the same time and the PG reclaim could be regarded as
> PG_readahead in fault conext.

What part of fault context can make that mistake?  The snippet I quoted
below is from page_cache_async_readahead() where it will clearly not
make that mistake.  There's a lot of code here; please don't presume I
know all the areas you're talking about.

> > 
> >         /*
> >          * Same bit is used for PG_readahead and PG_reclaim.
> >          */
> >         if (PageWriteback(page))
> >                 return;
> > 
> >         ClearPageReadahead(page);
