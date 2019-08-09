Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9A238804D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2019 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437455AbfHIQfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Aug 2019 12:35:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437226AbfHIQfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEBED300BEAC;
        Fri,  9 Aug 2019 16:35:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 00E1B19C70;
        Fri,  9 Aug 2019 16:35:52 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  9 Aug 2019 18:35:54 +0200 (CEST)
Date:   Fri, 9 Aug 2019 18:35:52 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 3/6] mm, thp: introduce FOLL_SPLIT_PMD
Message-ID: <20190809163551.GB21489@redhat.com>
References: <20190807233729.3899352-1-songliubraving@fb.com>
 <20190807233729.3899352-4-songliubraving@fb.com>
 <20190808163745.GC7934@redhat.com>
 <48316E06-10B2-439C-AD10-3EC8C86C259C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48316E06-10B2-439C-AD10-3EC8C86C259C@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 09 Aug 2019 16:35:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08, Song Liu wrote:
>
> > On Aug 8, 2019, at 9:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 08/07, Song Liu wrote:
> >>
> >> @@ -399,7 +399,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
> >> 		spin_unlock(ptl);
> >> 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> >> 	}
> >> -	if (flags & FOLL_SPLIT) {
> >> +	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
> >> 		int ret;
> >> 		page = pmd_page(*pmd);
> >> 		if (is_huge_zero_page(page)) {
> >> @@ -408,7 +408,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
> >> 			split_huge_pmd(vma, pmd, address);
> >> 			if (pmd_trans_unstable(pmd))
> >> 				ret = -EBUSY;
> >> -		} else {
> >> +		} else if (flags & FOLL_SPLIT) {
> >> 			if (unlikely(!try_get_page(page))) {
> >> 				spin_unlock(ptl);
> >> 				return ERR_PTR(-ENOMEM);
> >> @@ -420,6 +420,10 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
> >> 			put_page(page);
> >> 			if (pmd_none(*pmd))
> >> 				return no_page_table(vma, flags);
> >> +		} else {  /* flags & FOLL_SPLIT_PMD */
> >> +			spin_unlock(ptl);
> >> +			split_huge_pmd(vma, pmd, address);
> >> +			ret = pte_alloc(mm, pmd) ? -ENOMEM : 0;
> >> 		}
> >
> > Can't resist, let me repeat that I do not like this patch because imo
> > it complicates this code for no reason.
>
> Personally, I don't think this is more complicated than your version.

I do, but of course this is subjective.

> Also, if some code calls follow_pmd_mask() with flags contains both
> FOLL_SPLIT and FOLL_SPLIT_PMD, we should honor FOLL_SPLIT and split the
> huge page.

Heh. why not other way around?

> Of course, there is no code that sets both flags.

and of course, nobody should ever pass both FOLL_SPLIT and FOLL_SPLIT_PMD,
perhaps this deserves a warning.

Not to mention that it would be nice to kill FOLL_SPLIT which has a single
user, but this is another story.

Oleg.

