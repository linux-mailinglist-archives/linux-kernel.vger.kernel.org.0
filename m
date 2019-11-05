Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBEACEFDD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2019 14:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbfKENC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Nov 2019 08:02:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:41924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388008AbfKENC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:02:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3687EADFE;
        Tue,  5 Nov 2019 13:02:55 +0000 (UTC)
Date:   Tue, 5 Nov 2019 14:02:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [patch for-5.3 0/4] revert immediate fallback to remote hugepages
Message-ID: <20191105130253.GO22672@dhcp22.suse.cz>
References: <20190930112817.GC15942@dhcp22.suse.cz>
 <20191001054343.GA15624@dhcp22.suse.cz>
 <20191001083743.GC15624@dhcp22.suse.cz>
 <20191018141550.GS5017@dhcp22.suse.cz>
 <53c4a6ca-a4d0-0862-8744-f999b17d82d8@suse.cz>
 <alpine.DEB.2.21.1910241156370.130350@chino.kir.corp.google.com>
 <08a3f4dd-c3ce-0009-86c5-9ee51aba8557@suse.cz>
 <20191029151549.GO31513@dhcp22.suse.cz>
 <20191029143351.95f781f09a9fbf254163d728@linux-foundation.org>
 <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910291623050.9914@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-10-19 16:25:17, David Rientjes wrote:
> On Tue, 29 Oct 2019, Andrew Morton wrote:
> 
> > On Tue, 29 Oct 2019 16:15:49 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > > > 
> > > > 1. local node only THP allocation with no reclaim, just compaction.
> > > > 2. for madvised VMA's or when synchronous compaction is enabled always - THP
> > > >    allocation from any node with effort determined by global defrag setting
> > > >    and VMA madvise
> > > > 3. fallback to base pages on any node
> > > > 
> > > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > 
> > > I've given this a try and here are the results of my previous testcase
> > > (memory full of page cache).
> > 
> > Thanks, I'll queue this for some more testing.  At some point we should
> > decide on a suitable set of Fixes: tags and a backporting strategy, if any?
> > 
> 
> I'd strongly suggest that Andrea test this patch out on his workload on 
> hosts where all nodes are low on memory because based on my understanding 
> of his reported issue this would result in swap storms reemerging but 
> worse this time because they wouldn't be constrained only locally.  (This 
> patch causes us to no longer circumvent excessive reclaim when using 
> MADV_HUGEPAGE.)

Could you be more specific on why this would be the case? My testing is
doesn't show any such signs and I am effectivelly testing memory low
situation. The amount of reclaimed memory matches the amount of
requested memory.

-- 
Michal Hocko
SUSE Labs
