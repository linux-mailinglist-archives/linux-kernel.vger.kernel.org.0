Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 588AB74B45
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 12:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbfGYKNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 06:13:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:35746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387531AbfGYKNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 06:13:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF2CBAEAC;
        Thu, 25 Jul 2019 10:13:29 +0000 (UTC)
Date:   Thu, 25 Jul 2019 12:13:27 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] mm,memory_hotplug: Introduce MHP_VMEMMAP_FLAGS
Message-ID: <20190725101322.GA16385@linux>
References: <20190625075227.15193-1-osalvador@suse.de>
 <20190625075227.15193-3-osalvador@suse.de>
 <CAPcyv4hvu+wp4tJJNW70jp2G_rNabyvzGMvDTS3PzkDCAFztYg@mail.gmail.com>
 <20190725092751.GA15964@linux>
 <71a30086-b093-48a4-389f-7e407898718f@redhat.com>
 <20190725094030.GA16069@linux>
 <6410dd7d-bc9c-1ca2-6cb7-d51b059be388@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6410dd7d-bc9c-1ca2-6cb7-d51b059be388@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 12:04:08PM +0200, David Hildenbrand wrote:
> As I said somewhere already (as far as I recall), one mode would be
> sufficient. If you want per memblock, add the memory in memblock
> granularity.
> 
> So having a MHP_MEMMAP_ON_MEMORY that allocates it in one chunk would be
> sufficient for the current use cases (DIMMs, Hyper-V).
> 
> MHP_MEMMAP_ON_MEMORY: Allocate the memmap for the added memory in one
> chunk from the beginning of the added memory. This piece of memory will
> be accessed and used even before the memory is onlined.

This is what I had in my early versions of the patchset, but I do remember
that Michal suggested to let the caller specify if it wants the memmaps
to be allocated per memblock, or per whole-range.

I still think it makes somse sense, you can just pass a large chunk
(spanning multiple memory-blocks) at once and yet specify to allocate
it per memory-blocks.

Of course, I also agree that having only one mode would ease things
(not that much as v3 does not suppose that difference wrt. range vs
memory-block).

-- 
Oscar Salvador
SUSE L3
