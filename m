Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE51F9BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2019 22:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfKLVN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Nov 2019 16:13:28 -0500
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:42918 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbfKLVN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:27 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E3C03180A68D7;
        Tue, 12 Nov 2019 21:13:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:599:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:4031:4321:4385:5007:10004:10400:10482:10848:11026:11232:11473:11658:11914:12043:12291:12296:12297:12438:12555:12683:12740:12760:12895:13439:14181:14659:14721:19901:19997:21080:21433:21451:21627:21740:30054:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: head78_1dbdc56a2c617
X-Filterd-Recvd-Size: 3277
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Nov 2019 21:13:24 +0000 (UTC)
Message-ID: <a7fddda6f3e47b6aeb5d6d6ea9ea28ec019d3d94.camel@perches.com>
Subject: Re: [PATCH 2/2] hugetlbfs: convert macros to static inline, fix
 sparse warning
From:   Joe Perches <joe@perches.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jason Gunthorpe <jgg@ziepe.ca>, kbuild@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 12 Nov 2019 13:13:07 -0800
In-Reply-To: <20191112194558.139389-3-mike.kravetz@oracle.com>
References: <20191112194558.139389-1-mike.kravetz@oracle.com>
         <20191112194558.139389-3-mike.kravetz@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-12 at 11:45 -0800, Mike Kravetz wrote:
> huge_pte_offset() produced a sparse warning due to an improper
> return type when the kernel was built with !CONFIG_HUGETLB_PAGE.
> Fix the bad type and also convert all the macros in this block
> to static inline wrappers.  Two existing wrappers in this block
> had lines in excess of 80 columns so clean those up as well.
> 
> No functional change.
> 
> Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  include/linux/hugetlb.h | 137 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 115 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 53fc34f930d0..ef412fe0be3d 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -164,38 +164,130 @@ static inline void adjust_range_if_pmd_sharing_possible(
>  {
>  }
>  
> -#define follow_hugetlb_page(m,v,p,vs,a,b,i,w,n)	({ BUG(); 0; })
> -#define follow_huge_addr(mm, addr, write)	ERR_PTR(-EINVAL)
> -#define copy_hugetlb_page_range(src, dst, vma)	({ BUG(); 0; })
> +static inline long follow_hugetlb_page(struct mm_struct *mm,
> +			struct vm_area_struct *vma, struct page **pages,
> +			struct vm_area_struct **vmas, unsigned long *position,
> +			unsigned long *nr_pages, long i, unsigned int flags,
> +			int *nonblocking)
> +{
> +	BUG();

While this is not different from the original, perhaps this is
also an opportunity to change the BUG()s to WARN()s.

> +static inline int copy_hugetlb_page_range(struct mm_struct *dst,
> +			struct mm_struct *src, struct vm_area_struct *vma)
> +{
> +	BUG();
> +	return 0;
> +}
[]
> +static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> +				unsigned long addr, unsigned long end,
> +				unsigned long floor, unsigned long ceiling)
> +{
> +	BUG();
> +}
> +
> +static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> +						pte_t *dst_pte,
> +						struct vm_area_struct *dst_vma,
> +						unsigned long dst_addr,
> +						unsigned long src_addr,
> +						struct page **pagep)
> +{
> +	BUG();
> +	return 0;
> +}


