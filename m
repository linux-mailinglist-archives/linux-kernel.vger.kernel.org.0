Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C06AE7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2019 12:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbfIJKZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Sep 2019 06:25:08 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:42938 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfIJKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:25:05 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id C3FF82DC1B4F;
        Tue, 10 Sep 2019 06:25:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1568111101;
        bh=HDAltXrE8fa0s1cXwhaPiIFePgfp29KfB1TH4WQiFKM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=bLdhODUhBW4Fo/x94Nj+R+V91mwnbDdWHLNOGLCq0biZGZH3Jh+idjt+I4APSOr8C
         Rbc8OmvyYWwlcbdY4DffVqXm1RUEEn3bfRKdaZ1uoMBCsX+spov/LrzTCPI8p/m6yG
         eorPdXIjF7Xp4/1L2OakqTNsZo7lNf7vyW9f4wCMpok5yTmvZEsL0GMXwFEsrDvVqV
         u2BgYZUPjehGpv0d4ae7pNuevsXh0ymINJnKAs/jiu7A8fXASd+pYF2Z09eDbzZJTh
         rpu+wYaQiZaqh9o5kRpPypjiPm7X6UFOTf8brRROPvWQI0tSg3gcbZbnpN8doK/0IN
         To853JLOgdR9DOz+Rofmdkpor1j24qEnCwrL59ebH7AMvY/hgaDftc8bL+w6G3fDiu
         /DdLZUth6SFIpG/syJjKU3YM7QaK33iOJMTO6896o/9bTT2Wyrd0PQItUV+aDxtWFh
         5uh5FAYEVcPNCe4PJ7st0HYpohFsbuKa9xyf360C6loFML0oFu6jUNQYj0uur0Skg0
         1fg545R3fYt0a+/SbIObDbvt9lhOh7fMJeqCxkIaudOiWBuTxoYKmBCzDF+5yKubCL
         f82z0VccKg8yE5D2YaC57RDufBuKihrXFF2SH0JqSFbPOehLLX0RZH1maGEvkJ7hTj
         ZOP4NSLQU6ekz1+NkJkLdFdQ=
Received: from Hawking (ntp.lan [10.0.1.1])
        (authenticated bits=0)
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id x8AAOsMd022564
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Sep 2019 20:24:54 +1000 (AEST)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     "'David Hildenbrand'" <david@redhat.com>,
        "'Alastair D'Silva'" <alastair@au1.ibm.com>
Cc:     "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Oscar Salvador'" <osalvador@suse.com>,
        "'Michal Hocko'" <mhocko@suse.com>,
        "'Pavel Tatashin'" <pasha.tatashin@soleen.com>,
        "'Dan Williams'" <dan.j.williams@intel.com>,
        "'Wei Yang'" <richard.weiyang@gmail.com>,
        "'Qian Cai'" <cai@lca.pw>, "'Jason Gunthorpe'" <jgg@ziepe.ca>,
        "'Logan Gunthorpe'" <logang@deltatee.com>,
        "'Ira Weiny'" <ira.weiny@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20190910025225.25904-1-alastair@au1.ibm.com> <20190910025225.25904-3-alastair@au1.ibm.com> <6ca671a0-8b00-e974-7de9-a574ad9b77ec@redhat.com>
In-Reply-To: <6ca671a0-8b00-e974-7de9-a574ad9b77ec@redhat.com>
Subject: RE: [PATCH 2/2] mm: Add a bounds check in devm_memremap_pages()
Date:   Tue, 10 Sep 2019 20:24:54 +1000
Message-ID: <05af01d567c1$fdb256d0$f9170470$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHvMJj7Zv4jgOWqcZIGTeYry0K56gJQpAzUAu4+QZimxyuUcA==
Content-Language: en-au
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Tue, 10 Sep 2019 20:24:56 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: David Hildenbrand <david@redhat.com>
> Sent: Tuesday, 10 September 2019 5:39 PM
> To: Alastair D'Silva <alastair@au1.ibm.com>; alastair@d-silva.org
> Cc: Andrew Morton <akpm@linux-foundation.org>; Oscar Salvador
> <osalvador@suse.com>; Michal Hocko <mhocko@suse.com>; Pavel Tatashin
> <pasha.tatashin@soleen.com>; Dan Williams <dan.j.williams@intel.com>;
> Wei Yang <richard.weiyang@gmail.com>; Qian Cai <cai@lca.pw>; Jason
> Gunthorpe <jgg@ziepe.ca>; Logan Gunthorpe <logang@deltatee.com>; Ira
> Weiny <ira.weiny@intel.com>; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] mm: Add a bounds check in
> devm_memremap_pages()
> 
> On 10.09.19 04:52, Alastair D'Silva wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > The call to check_hotplug_memory_addressable() validates that the
> > memory is fully addressable.
> >
> > Without this call, it is possible that we may remap pages that is not
> > physically addressable, resulting in bogus section numbers being
> > returned from __section_nr().
> >
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >  mm/memremap.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/mm/memremap.c b/mm/memremap.c index
> > 86432650f829..fd00993caa3e 100644
> > --- a/mm/memremap.c
> > +++ b/mm/memremap.c
> > @@ -269,6 +269,13 @@ void *devm_memremap_pages(struct device
> *dev,
> > struct dev_pagemap *pgmap)
> >
> >  	mem_hotplug_begin();
> >
> > +	error = check_hotplug_memory_addressable(res->start,
> > +						 resource_size(res));
> > +	if (error) {
> > +		mem_hotplug_done();
> > +		goto err_checkrange;
> > +	}
> > +
> 
> No need to check under the memory hotplug lock.
> 

Thanks, I'll adjust it.

> >  	/*
> >  	 * For device private memory we call add_pages() as we only need to
> >  	 * allocate and initialize struct page for the device memory. More-
> > @@ -324,6 +331,7 @@ void *devm_memremap_pages(struct device *dev,
> > struct dev_pagemap *pgmap)
> >
> >   err_add_memory:
> >  	kasan_remove_zero_shadow(__va(res->start), resource_size(res));
> > + err_checkrange:
> >   err_kasan:
> >  	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
> >   err_pfn_remap:
> >
> 
> 
> --
> 
> Thanks,
> 
> David / dhildenb
> 

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece

