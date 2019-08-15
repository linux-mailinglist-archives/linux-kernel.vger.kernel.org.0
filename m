Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203808F1FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2019 19:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfHORTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Aug 2019 13:19:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731134AbfHORTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 13:19:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41DFE8535C;
        Thu, 15 Aug 2019 17:19:21 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 24D02601A4;
        Thu, 15 Aug 2019 17:19:20 +0000 (UTC)
Date:   Thu, 15 Aug 2019 13:19:18 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm/migrate: clean up useless code in
 migrate_vma_collect_pmd()
Message-ID: <20190815171918.GC30916@redhat.com>
References: <20190807052858.GA9749@mypc>
 <1565167272-21453-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1565167272-21453-1-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 15 Aug 2019 17:19:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 04:41:12PM +0800, Pingfan Liu wrote:
> Clean up useless 'pfn' variable.

NAK there is a bug see below:

> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Jan Kara <jack@suse.cz>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> To: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/migrate.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8992741..d483a55 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2225,17 +2225,15 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  		pte_t pte;
>  
>  		pte = *ptep;
> -		pfn = pte_pfn(pte);
>  
>  		if (pte_none(pte)) {
>  			mpfn = MIGRATE_PFN_MIGRATE;
>  			migrate->cpages++;
> -			pfn = 0;
>  			goto next;
>  		}
>  
>  		if (!pte_present(pte)) {
> -			mpfn = pfn = 0;
> +			mpfn = 0;
>  
>  			/*
>  			 * Only care about unaddressable device page special
> @@ -2252,10 +2250,10 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			if (is_write_device_private_entry(entry))
>  				mpfn |= MIGRATE_PFN_WRITE;
>  		} else {
> +			pfn = pte_pfn(pte);
>  			if (is_zero_pfn(pfn)) {
>  				mpfn = MIGRATE_PFN_MIGRATE;
>  				migrate->cpages++;
> -				pfn = 0;
>  				goto next;
>  			}
>  			page = vm_normal_page(migrate->vma, addr, pte);
> @@ -2265,10 +2263,9 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  
>  		/* FIXME support THP */
>  		if (!page || !page->mapping || PageTransCompound(page)) {
> -			mpfn = pfn = 0;
> +			mpfn = 0;
>  			goto next;
>  		}
> -		pfn = page_to_pfn(page);

You can not remove that one ! Otherwise it will break the device
private case.
