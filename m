Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C887D62F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2019 09:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfHAHRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Aug 2019 03:17:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:53346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730201AbfHAHRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 03:17:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3DE8EADC4;
        Thu,  1 Aug 2019 07:17:12 +0000 (UTC)
Date:   Thu, 1 Aug 2019 09:17:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Rashmica Gupta <rashmica.g@gmail.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        anshuman.khandual@arm.com, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Allocate memmap from hotadded memory
Message-ID: <20190801071709.GE11627@dhcp22.suse.cz>
References: <2ebfbd36-11bd-9576-e373-2964c458185b@redhat.com>
 <20190626080249.GA30863@linux>
 <2750c11a-524d-b248-060c-49e6b3eb8975@redhat.com>
 <20190626081516.GC30863@linux>
 <887b902e-063d-a857-d472-f6f69d954378@redhat.com>
 <9143f64391d11aa0f1988e78be9de7ff56e4b30b.camel@gmail.com>
 <20190702074806.GA26836@linux>
 <CAC6rBskRyh5Tj9L-6T4dTgA18H0Y8GsMdC-X5_0Jh1SVfLLYtg@mail.gmail.com>
 <20190731120859.GJ9330@dhcp22.suse.cz>
 <4ddee0dd719abd50350f997b8089fa26f6004c0c.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ddee0dd719abd50350f997b8089fa26f6004c0c.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 09:06:40, Rashmica Gupta wrote:
> On Wed, 2019-07-31 at 14:08 +0200, Michal Hocko wrote:
> > On Tue 02-07-19 18:52:01, Rashmica Gupta wrote:
> > [...]
> > > > 2) Why it was designed, what is the goal of the interface?
> > > > 3) When it is supposed to be used?
> > > > 
> > > > 
> > > There is a hardware debugging facility (htm) on some power chips.
> > > To use
> > > this you need a contiguous portion of memory for the output to be
> > > dumped
> > > to - and we obviously don't want this memory to be simultaneously
> > > used by
> > > the kernel.
> > 
> > How much memory are we talking about here? Just curious.
> 
> From what I've seen a couple of GB per node, so maybe 2-10GB total.

OK, that is really a lot to keep around unused just in case the
debugging is going to be used.

I am still not sure the current approach of (ab)using memory hotplug is
ideal. Sure there is some overlap but you shouldn't really need to
offline the required memory range at all. All you need is to isolate the
memory from any existing user and the page allocator. Have you checked
alloc_contig_range?

-- 
Michal Hocko
SUSE Labs
