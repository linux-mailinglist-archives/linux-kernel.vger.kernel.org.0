Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD5B5FDF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2019 22:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfGDUyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jul 2019 16:54:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfGDUyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:54:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A517928;
        Thu,  4 Jul 2019 13:54:52 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B922D3F738;
        Thu,  4 Jul 2019 13:54:50 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
 <20190626073533.GA24199@infradead.org>
 <20190626123139.GB20635@lakrids.cambridge.arm.com>
 <20190626153829.GA22138@infradead.org> <20190626154532.GA3088@mellanox.com>
 <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
 <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org>
 <20190704195934.GA23542@mellanox.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <de2286d9-6f5c-a79c-dcee-de4225aca58a@arm.com>
Date:   Thu, 4 Jul 2019 21:54:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704195934.GA23542@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-04 8:59 pm, Jason Gunthorpe wrote:
> On Thu, Jul 04, 2019 at 11:53:24AM -0700, Andrew Morton wrote:
>> On Wed, 26 Jun 2019 20:35:51 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>>>> Let me know and I can help orchestate this.
>>>
>>> Well.  Whatever works.  In this situation I'd stage the patches after
>>> linux-next and would merge them up after the prereq patches have been
>>> merged into mainline.  Easy.
>>
>> All right, what the hell just happened?

Aw crap, and I had this series chalked up as done...

> Christoph's patch series for the devmap & hmm rework finally made it
> into linux-next, sorry, it took quite a few iterations on the list to
> get all the reviews and tests, and figure out how to resolve some
> other conflicting things. So it just made it this week.
> 
> Recall, this is the patch series I asked you about routing a few weeks
> ago, as it really exceeded the small area that hmm.git was supposed to
> cover. I think we are both caught off guard how big the conflict is!
> 
>> A bunch of new material has just been introduced into linux-next.
>> I've partially unpicked the resulting mess, haven't dared trying to
>> compile it yet.  To get this far I'll need to drop two patch series
>> and one individual patch:
>    
>> mm-clean-up-is_device__page-definitions.patch
>> mm-introduce-arch_has_pte_devmap.patch
>> arm64-mm-implement-pte_devmap-support.patch
>> arm64-mm-implement-pte_devmap-support-fix.patch
> 
> This one we discussed, and I thought we agreed would go to your 'stage
> after linux-next' flow (see above). I think the conflict was minor
> here.

I can rebase and resend tomorrow if there's an agreement on what exactly 
to base it on - I'd really like to get this ticked off for 5.3 if at all 
possible.

Thanks,
Robin.

>> mm-sparsemem-introduce-struct-mem_section_usage.patch
>> mm-sparsemem-introduce-a-section_is_early-flag.patch
>> mm-sparsemem-add-helpers-track-active-portions-of-a-section-at-boot.patch
>> mm-hotplug-prepare-shrink_zone-pgdat_span-for-sub-section-removal.patch
>> mm-sparsemem-convert-kmalloc_section_memmap-to-populate_section_memmap.patch
>> mm-hotplug-kill-is_dev_zone-usage-in-__remove_pages.patch
>> mm-kill-is_dev_zone-helper.patch
>> mm-sparsemem-prepare-for-sub-section-ranges.patch
>> mm-sparsemem-support-sub-section-hotplug.patch
>> mm-document-zone_device-memory-model-implications.patch
>> mm-document-zone_device-memory-model-implications-fix.patch
>> mm-devm_memremap_pages-enable-sub-section-remap.patch
>> libnvdimm-pfn-fix-fsdax-mode-namespace-info-block-zero-fields.patch
>> libnvdimm-pfn-stop-padding-pmem-namespaces-to-section-alignment.patch
> 
> Dan pointed to this while reviewing CH's series and said the conflicts
> would be manageable, but they are certainly larger than I expected!
> 
> This series is the one that seems to be the really big trouble. I
> already checked all the other stuff that Stephen resolved, and it
> looks OK and managable. Just this one conflict with kernel/memremap.c
> is beyond me.
> 
> What approach do you want to take to go forward? Here are some thoughts:
> 
> CH has said he is away for the long weekend, so the path that involves
> the fewest people is if Dan respins the above on linux-next and it
> goes later with the arm patches above, assuming defering it for now
> has no other adverse effects on -mm.
> 
> Pushing CH's series to -mm would need a respin on top of Dan's series
> above and would need to carry along the whole hmm.git (about 44
> patches). Signs are that this could be managed with the code currently
> in the GPU trees.
> 
> If we give up on CH's series the hmm.git will not have conflicts,
> however we just kick the can to the next merge window where we will be
> back to having to co-ordinate amd/nouveau/rdma git trees and -mm's
> patch workflow - and I think we will be worse off as we will have
> totally given up on a git based work flow for this. :(
> 
>> mm-sparsemem-cleanup-section-number-data-types.patch
>> mm-sparsemem-cleanup-section-number-data-types-fix.patch
> 
> Stephen used a minor conflict resolution for this one, I checked it
> carefully and it looked OK.
> 
>> I thought you were just going to move material out of -mm and into
>> hmm.git.
> 
> Dan brought up a patch from Ira conflicting with CH's work and we did
> handle that by moving a single patch, as well I moved several hmm
> specific patches early in the cycle.
> 
>> Didn't begin to suspect that new and quite disruptive material would
>> be introduced late in -rc7!!
> 
> Unfortunately a non-rebasing tree like hmm.git should only get patches
> into linux-next once they are fully reviewed and done on the list. I
> did not attempt to run separately patches 'under review' into
> linux-next as you do.
> 
> Actually I didn't even know this would benefit your workflow, rebasing
> patches on top of linux-next is not part of the git based workflow I'm
> using :(
> 
> AFAIK Dan and CH were both tracking conflicts with linux-next, so I'd
> like to hear from Dan what he thinks about his series, maybe the
> rebase is simple & safe for him? Dan and CH were working pretty
> closely on CH's series.
> 
> Jason
> 
