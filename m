Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 620FC8D791
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfHNQCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Aug 2019 12:02:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfHNQCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:02:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3449DADE6;
        Wed, 14 Aug 2019 16:02:21 +0000 (UTC)
Date:   Wed, 14 Aug 2019 18:02:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 2/4] mm/memory_hotplug: Handle unaligned start and
 nr_pages in online_pages_blocks()
Message-ID: <20190814160220.GF17933@dhcp22.suse.cz>
References: <20190809125701.3316-1-david@redhat.com>
 <20190809125701.3316-3-david@redhat.com>
 <20190814140805.GA17933@dhcp22.suse.cz>
 <ddb10470-8d6e-c8bd-4877-197621219612@redhat.com>
 <8d1ba12d-9993-1822-38e4-422a46108fec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1ba12d-9993-1822-38e4-422a46108fec@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-08-19 16:28:21, David Hildenbrand wrote:
> On 14.08.19 16:17, David Hildenbrand wrote:
> > On 14.08.19 16:08, Michal Hocko wrote:
> >> On Fri 09-08-19 14:56:59, David Hildenbrand wrote:
> >>> Take care of nr_pages not being a power of two and start not being
> >>> properly aligned. Essentially, what walk_system_ram_range() could provide
> >>> to us. get_order() will round-up in case it's not a power of two.
> >>>
> >>> This should only apply to memory blocks that contain strange memory
> >>> resources (especially with holes), not to ordinary DIMMs.
> >>
> >> I would really like to see an example of such setup before making the
> >> code hard to read. Because I am not really sure something like that
> >> exists at all.
> > 
> > I don't have a real-live example at hand (founds this while exploring
> > the code), however, the linked commit changed it without stating why it
> > would be safe to do so.
> 
> So, while I agree that "not a power of two" is rare, are you sure we
> will only have holes that are aligned to 4MB (especially on x86)?

No I am not saying that because I do not know. I am not aware of any
such HW but that doesn't really mean anything. But I would like to see
an example and have it archived in the changelog before we make the code
more complicated.
-- 
Michal Hocko
SUSE Labs
