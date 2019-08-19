Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841EA92523
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2019 15:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfHSNfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Aug 2019 09:35:45 -0400
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:49700 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727172AbfHSNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:35:45 -0400
Received: from mail.blacknight.com (unknown [81.17.254.16])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id 42915BB2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 14:35:43 +0100 (IST)
Received: (qmail 26429 invoked from network); 19 Aug 2019 13:35:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.93])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Aug 2019 13:35:43 -0000
Date:   Mon, 19 Aug 2019 14:35:41 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, page_alloc: move_freepages should not examine struct
 page of reserved memory
Message-ID: <20190819133541.GP2739@techsingularity.net>
References: <alpine.DEB.2.21.1908122036560.10779@chino.kir.corp.google.com>
 <20190813141630.bd8cee48e6a83ca77eead6ad@linux-foundation.org>
 <alpine.DEB.2.21.1908131625310.224017@chino.kir.corp.google.com>
 <20190814154929.f050d937f2bd2c4d80c7f772@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190814154929.f050d937f2bd2c4d80c7f772@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:49:29PM -0700, Andrew Morton wrote:
> On Tue, 13 Aug 2019 16:31:35 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> 
> > > > Move the debug checks to after verifying PageBuddy is true.  This isolates
> > > > the scope of the checks to only be for buddy pages which are on the zone's
> > > > freelist which move_freepages_block() is operating on.  In this case, an
> > > > incorrect node or zone is a bug worthy of being warned about (and the
> > > > examination of struct page is acceptable bcause this memory is not
> > > > reserved).
> > > 
> > > I'm thinking Fixes:907ec5fca3dc and Cc:stable?  But 907ec5fca3dc is
> > > almost a year old, so you were doing something special to trigger this?
> > > 
> > 
> > We noticed it almost immediately after bringing 907ec5fca3dc in on 
> > CONFIG_DEBUG_VM builds.  It depends on finding specific free pages in the 
> > per-zone free area where the math in move_freepages() will bring the start 
> > or end pfn into reserved memory and wanting to claim that entire pageblock 
> > as a new migratetype.  So the path will be rare, require CONFIG_DEBUG_VM, 
> > and require fallback to a different migratetype.
> > 
> > Some struct pages were already zeroed from reserve pages before 
> > 907ec5fca3c so it theoretically could trigger before this commit.  I think 
> > it's rare enough under a config option that most people don't run that 
> > others may not have noticed.  I wouldn't argue against a stable tag and 
> > the backport should be easy enough, but probably wouldn't single out a 
> > commit that this is fixing.
> 
> OK, thanks.  I added the above two paragraphs to the changelog and
> removed the Fixes:
> 
> Hopefully Mel will be able to review this for us.

Bit late as I was offline but FWIW

Acked-by: Mel Gorman <mgorman@techsingularity.net>

That said, the overhead of the debugging check is higher with this
patch although it'll only affect debug builds and the path is not
particularly hot. If this was a concern, I think it would be reasonable
to simply remove the debugging check as the zone boundaries are checked
in move_freepages_block and we never expect a zone/node to be smaller
than a pageblock and stuck in the middle of another zone.

-- 
Mel Gorman
SUSE Labs
