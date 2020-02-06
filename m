Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFF715456A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Feb 2020 14:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBFNu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Feb 2020 08:50:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53330 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727060AbgBFNu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580997027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5cANr4eZW1Ze25yG7ClVn5wTKGraXdr9//7Uu9WkcI=;
        b=EBSnrko3/QIMsqyTo04Xwt16qF0s80bfzoRuP5c1jcJv8dcB5IqXsZnXkDgfUiWyB6WnHQ
        07HiIBIQJguOX8eur154PUbvGKD6BU/dZo/O+fYYUhLj9ShT2YXCFlN0neqB+axbqpQXNj
        dx8zXVRB4/l/DNj+iomIsFd8tuO/lpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-y_daEZWhN9CaDR13pcBrDw-1; Thu, 06 Feb 2020 08:50:23 -0500
X-MC-Unique: y_daEZWhN9CaDR13pcBrDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE93D18AB2E9;
        Thu,  6 Feb 2020 13:50:21 +0000 (UTC)
Received: from localhost (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BF0F5DA7D;
        Thu,  6 Feb 2020 13:50:18 +0000 (UTC)
Date:   Thu, 6 Feb 2020 21:50:16 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, osalvador@suse.de,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM
Message-ID: <20200206135016.GA25537@MiWiFi-R3L-srv>
References: <20200206125343.9070-1-richardw.yang@linux.intel.com>
 <6d9e36cb-ee4a-00c8-447b-9b75a0262c3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d9e36cb-ee4a-00c8-447b-9b75a0262c3a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 at 02:28pm, David Hildenbrand wrote:
> On 06.02.20 13:53, Wei Yang wrote:
> > When we use SPARSEMEM instead of SPARSEMEM_VMEMMAP, pfn_to_page()
> > doesn't work before sparse_init_one_section() is called. This leads to a
> > crash when hotplug memory.
> > 
> > We should use memmap as it did.
> > 
> > Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > CC: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  mm/sparse.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 5a8599041a2a..2efb24ff8f96 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -882,7 +882,7 @@ int __meminit sparse_add_section(int nid, unsigned long start_pfn,
> >  	 * Poison uninitialized struct pages in order to catch invalid flags
> >  	 * combinations.
> >  	 */
> > -	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
> > +	page_init_poison(memmap, sizeof(struct page) * nr_pages);
> 
> If you add sub-sections that don't fall onto the start of the section,
> 
> pfn_to_page(start_pfn) != memmap
> 
> and your patch would break that under SPARSEMEM_VMEMMAP if I am not wrong.

It returns the pfn_to_page(pfn) from __populate_section_memmap() and
assign to memmap in vmemmap case, how come it breaks anything. Correct
me if I was wrong.

> 
> Instead of memmap, there would have to be something like
> 
> memmap + (start_pfn - SECTION_ALIGN_DOWN(start_pfn))
> 
> If I am not wrong :)
> 
> -- 
> Thanks,
> 
> David / dhildenb

