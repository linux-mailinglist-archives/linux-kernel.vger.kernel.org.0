Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0624D1585E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 00:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbgBJXFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Feb 2020 18:05:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:63046 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBJXFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 18:05:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 15:05:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,426,1574150400"; 
   d="scan'208";a="433485952"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 10 Feb 2020 15:05:19 -0800
Date:   Tue, 11 Feb 2020 07:05:37 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        david@redhat.com
Subject: Re: [PATCH 7/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-ID: <20200210230537.GA32495@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200209104826.3385-1-bhe@redhat.com>
 <20200209104826.3385-8-bhe@redhat.com>
 <20200209235202.GC8705@richard>
 <20200210034105.GA8965@MiWiFi-R3L-srv>
 <20200210060804.GF7326@richard>
 <20200210075406.GE8965@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210075406.GE8965@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 03:54:06PM +0800, Baoquan He wrote:
>On 02/10/20 at 02:08pm, Wei Yang wrote:
>> On Mon, Feb 10, 2020 at 11:41:05AM +0800, Baoquan He wrote:
>> >On 02/10/20 at 07:52am, Wei Yang wrote:
>> >> >---
>> >> > mm/sparse.c | 4 +++-
>> >> > 1 file changed, 3 insertions(+), 1 deletion(-)
>> >> >
>> >> >diff --git a/mm/sparse.c b/mm/sparse.c
>> >> >index 623755e88255..345d065ef6ce 100644
>> >> >--- a/mm/sparse.c
>> >> >+++ b/mm/sparse.c
>> >> >@@ -854,13 +854,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>> >> > 			ms->usage = NULL;
>> >> > 		}
>> >> > 		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
>> >> >-		ms->section_mem_map = (unsigned long)NULL;
>> >> > 	}
>> >> > 
>> >> > 	if (section_is_early && memmap)
>> >> > 		free_map_bootmem(memmap);
>> >> > 	else
>> >> > 		depopulate_section_memmap(pfn, nr_pages, altmap);
>> >> 
>> >> The crash happens in depopulate_section_memmap() when trying to get memmap by
>> >> pfn_to_page(). Can we pass memmap directly?
>> >
>> >Yes, that's also a good idea. While it needs to add a parameter for
>> >depopulate_section_memmap(), the parameter is useless for VMEMMAP
>> >though, I personally prefer the current fix which is a little simpler.
>> >
>> 
>> Not a new parameter, but replace pfn with memmap.
>> 
>> Not sure why the parameter is useless for VMEMMAP? memmap will be assigned to
>> start and finally pass to vmemmap_free().
>
>In section_deactivate(), per the code comments from Dan, we can know
>that:
>
>	/*
>	 * section which only contains bootmem will be handled by
>	 * free_map_bootmem(), including a complete section, or partial
>	 * section which only has memory starting from the begining.
>	 */
>        if (section_is_early && memmap)
>                free_map_bootmem(memmap);                                                                                                         
>        else
>	/* 
>	 * section which contains region mixing bootmem with hot added
>	 * sub-section region, only sub-section region, complete
>	 * section. And in the mxied case, if hot remove the hot added
>	 * sub-section aligned part, no memmap is got in the current
>	 * code. So we still need pfn to calculate it for vmemmap case.
>	 * To me, whenever we need, it looks better that we always use
>	 * pfn to get its own memmap. 
>	 */
>                depopulate_section_memmap(pfn, nr_pages, altmap);
>
>This is why I would like to keep the current logic as is,only one line
>of code adjusting can fix the issue. Please let me know if I miss
>anything.
>

You are right. I missed this point.

>
>> 
>> >Anyway, both is fine to me, I can update if you think passing memmap is
>> >better.
>> >
>> >> 
>> >> >+
>> >> >+	if(!rc)
>> >> >+		ms->section_mem_map = (unsigned long)NULL;
>> >> > }
>> >> > 
>> >> > static struct page * __meminit section_activate(int nid, unsigned long pfn,
>> >> >-- 
>> >> >2.17.2
>> >> 
>> >> -- 
>> >> Wei Yang
>> >> Help you, Help me
>> >> 
>> 
>> -- 
>> Wei Yang
>> Help you, Help me
>> 

-- 
Wei Yang
Help you, Help me
