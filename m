Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C52419C9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 09:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfHZHEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 03:04:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48768 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729788AbfHZHEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:04:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BFC4AD7F;
        Mon, 26 Aug 2019 07:04:37 +0000 (UTC)
Date:   Mon, 26 Aug 2019 09:04:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        pankaj.suryawanshi@einfochips.com
Subject: Re: PageBlocks and Migrate Types
Message-ID: <20190826070436.GA7538@dhcp22.suse.cz>
References: <CACDBo57u+sgordDvFpTzJ=U4mT8uVz7ZovJ3qSZQCrhdYQTw0A@mail.gmail.com>
 <20190822125231.GJ12785@dhcp22.suse.cz>
 <CACDBo57OkND1LCokPLfyR09+oRTbA6+GAPc90xAEF6AM_LmbyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACDBo57OkND1LCokPLfyR09+oRTbA6+GAPc90xAEF6AM_LmbyQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 22-08-19 23:54:19, Pankaj Suryawanshi wrote:
> On Thu, Aug 22, 2019 at 6:22 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 21-08-19 22:23:44, Pankaj Suryawanshi wrote:
> > > Hello,
> > >
> > > 1. What are Pageblocks and migrate types(MIGRATE_CMA) in Linux memory ?
> >
> > Pageblocks are a simple grouping of physically contiguous pages with
> > common set of flags. I haven't checked closely recently so I might
> > misremember but my recollection is that only the migrate type is stored
> > there. Normally we would store that information into page flags but
> > there is not enough room there.
> >
> > MIGRATE_CMA represent pages allocated for the CMA allocator. There are
> > other migrate types denoting unmovable/movable allocations or pages that
> > are isolated from the page allocator.
> >
> > Very broadly speaking, the migrate type groups pages with similar
> > movability properties to reduce fragmentation that compaction cannot
> > do anything about because there are objects of different properti
> > around. Please note that pageblock might contain objects of a different
> > migrate type in some cases (e.g. low on memory).
> >
> > Have a look at gfpflags_to_migratetype and how the gfp mask is converted
> > to a migratetype for the allocation. Also follow different MIGRATE_$TYPE
> > to see how it is used in the code.
> >
> > > How many movable/unmovable pages are defined by default?
> >
> > There is nothing like that. It depends on how many objects of a specific
> > type are allocated.
> 
> 
> It means that it started creating pageblocks after allocation of
> different objects, but from which block it allocate initially when
> there is nothing like pageblocks ? (when memory subsystem up)

Pageblocks are just a way to group physically contiguous pages. They
just exist along with the physically contiguous memory. The migrate type
for most of the memory is set to MIGRATE_MOVABLE. Portion of the memory
might be reserved by CMA then that memory has MIGRATE_CMA. Following
set_pageblock_migratetype call paths will give you a good picture. 

> Pageblocks and its type dynamically changes ?

Yes as the purpose of the underlying memory for the block changes.
-- 
Michal Hocko
SUSE Labs
