Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6858D17DBE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Mar 2020 09:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCII5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Mar 2020 04:57:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725796AbgCII5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583744224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=FLow7QjaCQ9sm04eXSAADbzZJYLzhqYCrkj6e/53ZSY=;
        b=iNvH2QxtQ6/mNzMef69feo9ZWjnjquwM8DRFg5pHbMQ8vVzAuG92Gxh/i4H3OdTSL7wV2Z
        HNRiVpSNaKbxbvY2PI9HtbriIA4Q3eU4CC6zdkvEoaBuZSQDKutnDeF/ioi9I6DpGUvQcb
        oIVVVsgDE1zY/Kggdm3KvLErGxSpo5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-BjcSSUSrO5y9HFq62QFOFg-1; Mon, 09 Mar 2020 04:57:00 -0400
X-MC-Unique: BjcSSUSrO5y9HFq62QFOFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A1C0800D48;
        Mon,  9 Mar 2020 08:56:58 +0000 (UTC)
Received: from [10.36.118.32] (unknown [10.36.118.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5857E5C13D;
        Mon,  9 Mar 2020 08:56:55 +0000 (UTC)
Subject: Re: [PATCH v3 1/7] mm/hotplug: fix hot remove failure in
 SPARSEMEM|!VMEMMAP case
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-2-bhe@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <56640bcb-d7f9-9154-4965-12d8b25d050a@redhat.com>
Date:   Mon, 9 Mar 2020 09:56:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307084229.28251-2-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.03.20 09:42, Baoquan He wrote:
> In section_deactivate(), pfn_to_page() doesn't work any more after
> ms->section_mem_map is resetting to NULL in SPARSEMEM|!VMEMMAP case.
> It caused hot remove failure:
> 
> kernel BUG at mm/page_alloc.c:4806!
> invalid opcode: 0000 [#1] SMP PTI
> CPU: 3 PID: 8 Comm: kworker/u16:0 Tainted: G        W         5.5.0-next-20200205+ #340
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
> Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> RIP: 0010:free_pages+0x85/0xa0
> Call Trace:
>  __remove_pages+0x99/0xc0
>  arch_remove_memory+0x23/0x4d
>  try_remove_memory+0xc8/0x130
>  ? walk_memory_blocks+0x72/0xa0
>  __remove_memory+0xa/0x11
>  acpi_memory_device_remove+0x72/0x100
>  acpi_bus_trim+0x55/0x90
>  acpi_device_hotplug+0x2eb/0x3d0
>  acpi_hotplug_work_fn+0x1a/0x30
>  process_one_work+0x1a7/0x370
>  worker_thread+0x30/0x380
>  ? flush_rcu_work+0x30/0x30
>  kthread+0x112/0x130
>  ? kthread_create_on_node+0x60/0x60
>  ret_from_fork+0x35/0x40
> 
> Let's move the ->section_mem_map resetting after depopulate_section_memmap()
> to fix it.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/sparse.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 42c18a38ffaa..1b50c15677d7 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -734,6 +734,7 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	struct mem_section *ms = __pfn_to_section(pfn);
>  	bool section_is_early = early_section(ms);
>  	struct page *memmap = NULL;
> +	bool empty = false;
>  	unsigned long *subsection_map = ms->usage
>  		? &ms->usage->subsection_map[0] : NULL;
>  
> @@ -764,7 +765,8 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
>  	 */
>  	bitmap_xor(subsection_map, map, subsection_map, SUBSECTIONS_PER_SECTION);
> -	if (bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION)) {
> +	empty = bitmap_empty(subsection_map, SUBSECTIONS_PER_SECTION);
> +	if (empty) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
>  
>  		/*
> @@ -779,13 +781,15 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  			ms->usage = NULL;
>  		}
>  		memmap = sparse_decode_mem_map(ms->section_mem_map, section_nr);
> -		ms->section_mem_map = (unsigned long)NULL;
>  	}
>  
>  	if (section_is_early && memmap)
>  		free_map_bootmem(memmap);
>  	else
>  		depopulate_section_memmap(pfn, nr_pages, altmap);
> +
> +	if (empty)
> +		ms->section_mem_map = (unsigned long)NULL;
>  }
>  
>  static struct page * __meminit section_activate(int nid, unsigned long pfn,
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

