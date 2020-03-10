Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 042CC180087
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 15:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgCJOqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 10:46:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40439 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgCJOqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:46:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id p2so15428638wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 07:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crbMDI2Wimbm4HzDN7I4IadEFygYJVO7wqLa6x2GCB0=;
        b=HJbRxaWPr5kDXm2mc6t4iayPMQ417++BINqpxADhuIOxOJi0DgSN94gYeVKfFkw7N3
         Ru0MVV313+TB+Q9J8gdxSYgTdkZoduiHi4h3RJyEu2MGolHTD0dvtpQgUY07e9dCElck
         hHia8M4GXYR33+47L7QIIxVSF6kzfoeBOU1YZgUWUhGlUb+8iqEh27EhdvXfVHYK7/B9
         fvxhrgTnVBZ1lz/z+zfA8cnABkUTYT0ZjH63lXU9YKd5UUhfdPzlFnDwt/VxAsUxdBh5
         YIxUxhxSVOcDGFz4iRpAtsqHu87auEhk4nTXvACl8cvRQ9G1oHCvbZvUrh5h4sGqfjnA
         mzuw==
X-Gm-Message-State: ANhLgQ2xwbsm6U+b6J+TnNJBFa4IcWtmJgI56Vm2BJqFqAzqw5Oc6rHA
        Z7w1CB9XxZ/AnguoutKuyCE=
X-Google-Smtp-Source: ADFU+vs+x5SuPXyNi5EA7awyb+YpsPeAacDIV/ITuPW+C/+phyX1/4KoqZW9FDZmPvqisWLvb4P1MA==
X-Received: by 2002:adf:f00d:: with SMTP id j13mr29112891wro.207.1583851578791;
        Tue, 10 Mar 2020 07:46:18 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y200sm1844481wmc.20.2020.03.10.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 07:46:18 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:46:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com,
        richardw.yang@linux.intel.com, dan.j.williams@intel.com,
        osalvador@suse.de, rppt@linux.ibm.com
Subject: Re: [PATCH v3 5/7] mm/sparse.c: add note about only VMEMMAP
 supporting sub-section support
Message-ID: <20200310144616.GM8447@dhcp22.suse.cz>
References: <20200307084229.28251-1-bhe@redhat.com>
 <20200307084229.28251-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307084229.28251-6-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 07-03-20 16:42:27, Baoquan He wrote:
> And tell check_pfn_span() gating the porper alignment and size of
> hot added memory region.
> 
> And also move the code comments from inside section_deactivate()
> to being above it. The code comments are reasonable for the whole
> function, and the moving makes code cleaner.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I have glanced through other patches and they seem sane but I do not
have time to go deeper to give an ack. I like this one though because it
really makes the intention clearer.

> ---
>  mm/sparse.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 2142045ab5c5..0fbd79c4ad81 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -772,6 +772,22 @@ static bool is_subsection_map_empty(struct mem_section *ms)
>  }
>  #endif
>  
> +/*
> + * To deactivate a memory region, there are 3 cases to handle across
> + * two configurations (SPARSEMEM_VMEMMAP={y,n}):
> + *
> + * 1. deactivation of a partial hot-added section (only possible in
> + *    the SPARSEMEM_VMEMMAP=y case).
> + *      a) section was present at memory init.
> + *      b) section was hot-added post memory init.
> + * 2. deactivation of a complete hot-added section.
> + * 3. deactivation of a complete section from memory init.
> + *
> + * For 1, when subsection_map does not empty we will not be freeing the
> + * usage map, but still need to free the vmemmap range.
> + *
> + * For 2 and 3, the SPARSEMEM_VMEMMAP={y,n} cases are unified
> + */
>  static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		struct vmem_altmap *altmap)
>  {
> @@ -784,23 +800,6 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
>  		return;
>  
>  	empty = is_subsection_map_empty(ms);
> -	/*
> -	 * There are 3 cases to handle across two configurations
> -	 * (SPARSEMEM_VMEMMAP={y,n}):
> -	 *
> -	 * 1/ deactivation of a partial hot-added section (only possible
> -	 * in the SPARSEMEM_VMEMMAP=y case).
> -	 *    a/ section was present at memory init
> -	 *    b/ section was hot-added post memory init
> -	 * 2/ deactivation of a complete hot-added section
> -	 * 3/ deactivation of a complete section from memory init
> -	 *
> -	 * For 1/, when subsection_map does not empty we will not be
> -	 * freeing the usage map, but still need to free the vmemmap
> -	 * range.
> -	 *
> -	 * For 2/ and 3/ the SPARSEMEM_VMEMMAP={y,n} cases are unified
> -	 */
>  	if (empty) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
>  
> @@ -907,6 +906,10 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>   *
>   * This is only intended for hotplug.
>   *
> + * Note that only VMEMMAP supports sub-section aligned hotplug,
> + * the proper alignment and size are gated by check_pfn_span().
> + *
> + *
>   * Return:
>   * * 0		- On success.
>   * * -EEXIST	- Section has been present.
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs
