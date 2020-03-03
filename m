Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E51417715F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Mar 2020 09:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgCCIjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Mar 2020 03:39:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57407 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgCCIje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583224773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q5YjirUqQW8GCcjkQKud8Ijnucv8uHhr7MqZmTlXkQw=;
        b=fSb9qEOzJpSzBaeU3dm4WcY+twluFjC2Q+053dk2gllKUAyKoeYjms73nqnBzM+YH6pv6W
        J+rj8rExfkbLkjmSOoD3yaq8FJA92T7CsaM1BdvjEoLsWse/c5mVfGpko3czuTAkW2LCCR
        lwpC72ly9gfwjlaxr9MYZ+84mizi0kI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-_7NAB4SeMmOCMhU9EEaHfg-1; Tue, 03 Mar 2020 03:39:30 -0500
X-MC-Unique: _7NAB4SeMmOCMhU9EEaHfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 827D5800D5B;
        Tue,  3 Mar 2020 08:39:28 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D988C8D55E;
        Tue,  3 Mar 2020 08:39:24 +0000 (UTC)
Date:   Tue, 3 Mar 2020 16:39:22 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, richardw.yang@linux.intel.com,
        osalvador@suse.de, dan.j.williams@intel.com, mhocko@suse.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
Message-ID: <20200303083922.GC4433@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220043316.19668-2-bhe@redhat.com>
 <7f88efb9-a404-c623-92d0-9292132ca881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f88efb9-a404-c623-92d0-9292132ca881@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 at 09:34am, David Hildenbrand wrote:
> On 20.02.20 05:33, Baoquan He wrote:
> > In section_deactivate(), pfn_to_page() doesn't work any more after
> > ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
> > It caused hot remove failure:
> > 
> > kernel BUG at mm/page_alloc.c:4806!
> > invalid opcode: 0000 [#1] SMP PTI
> > CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> > Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> > RIP: 0010:free_pages+0x85/0xa0
> > Call Trace:
> >  __remove_pages+0x99/0xc0
> >  arch_remove_memory+0x23/0x4d
> >  try_remove_memory+0xc8/0x130
> >  ? walk_memory_blocks+0x72/0xa0
> >  __remove_memory+0xa/0x11
> >  acpi_memory_device_remove+0x72/0x100
> >  acpi_bus_trim+0x55/0x90
> >  acpi_device_hotplug+0x2eb/0x3d0
> >  acpi_hotplug_work_fn+0x1a/0x30
> >  process_one_work+0x1a7/0x370
> >  worker_thread+0x30/0x380
> >  ? flush_rcu_work+0x30/0x30
> >  kthread+0x112/0x130
> >  ? kthread_create_on_node+0x60/0x60
> >  ret_from_fork+0x35/0x40
> > 
> > Let's move the ->section_mem_map resetting after depopulate_section_memmap()
> > to fix it.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  mm/sparse.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/sparse.c b/mm/sparse.c
> > index 596b2a45b100..b8e52c8fed7f 100644
> > --- a/mm/sparse.c
> > +++ b/mm/sparse.c
> > @@ -779,13 +779,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> >  			ms->usage = NULL;
> >  		}
> >  		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> > -		ms->section_mem_map = (unsigned long)NULL;
> >  	}
> >  
> >  	if (section_is_early && memmap)
> >  		free_map_bootmem(memmap);
> >  	else
> >  		depopulate_section_memmap(pfn, nr_pages, altmap);
> > +
> > +	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION))
> > +		ms->section_mem_map = (unsigned long)NULL;
> >  }
> >  
> >  static struct page * __meminit section_activate(int nid, unsigned long pfn,
> > 
> 
> As discussed, I think this is broken here already. As you explained, the
> subsection_map can get freed via kfree(ms->usage) after the first
> bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION) check.

Yes, I will correct it as you suggested in another reply.

