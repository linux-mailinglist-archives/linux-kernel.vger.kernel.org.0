Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 351E599468
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2019 15:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbfHVNCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Aug 2019 09:02:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:47520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730867AbfHVNCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:02:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07064ADBB;
        Thu, 22 Aug 2019 13:02:20 +0000 (UTC)
Date:   Thu, 22 Aug 2019 15:02:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        pankaj.suryawanshi@einfochips.com
Subject: Re: How cma allocation works ?
Message-ID: <20190822130219.GK12785@dhcp22.suse.cz>
References: <CACDBo56W1JGOc6w-NAf-hyWwJQ=vEDsAVAkO8MLLJBpQ0FTAcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDBo56W1JGOc6w-NAf-hyWwJQ=vEDsAVAkO8MLLJBpQ0FTAcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-08-19 22:58:03, Pankaj Suryawanshi wrote:
> Hello,
> 
> Hard time to understand cma allocation how differs from normal allocation ?

The buddy allocator which is built for order-N sized allocations and it
is highly optimized because it used from really hot paths. The allocator
also involves memory reclaim to get memory when there is none
immediatelly available.

CMA allocator operates on a pre reserved physical memory range(s) and
focuses on allocating areas that require physically contigous memory of
larger sizes. Very broadly speaking. LWN usually contains nice writeups
for many kernel internals. E.g. quick googling pointed to https://lwn.net/Articles/486301/

> I know theoretically how cma works.
> 
> 1. How it reserved the memory (start pfn to end pfn) ? what is bitmap_*
> functions ?

Not sure what you are asking here TBH

> 2. How alloc_contig_range() works ? it isolate all the pages including
> unevictable pages, what is the practical work flow ? all this works with
> virtual pages or physical pages ?

Yes it isolates a specific physical contiguous (pfn) range, tries to
move any used memory within that range and make it available for the
caller.

> 3.what start_isolate_page_range() does ?

There is some documentation for that function. Which part is not clear?

> 4. what alloc_contig_migrate_range does() ?

Have you checked the code? It simply tries to reclaim and/or migrate
pages off the pfn range.

> 5.what isolate_migratepages_range(), reclaim_clean_pages_from_list(),
>  migrate_pages() and shrink_page_list() is doing ?

Again, have you checked the code/comments? What exactly is not clear?
 
> Please let me know the flow with simple example.

Look at alloc_gigantic_page which is using the contiguous allocator to
get 1GB physically contiguous memory ranges to be used for hugetlb
pages.

HTH
-- 
Michal Hocko
SUSE Labs
