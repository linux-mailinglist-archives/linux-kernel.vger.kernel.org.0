Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68811D6ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2019 22:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733052AbfJNU2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Oct 2019 16:28:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:16285 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbfJNU2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:28:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 13:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="207323991"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 14 Oct 2019 13:28:47 -0700
Date:   Mon, 14 Oct 2019 13:28:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        kbuild test robot <lkp@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 2/2] mm/gup: fix a misnamed "write" argument, and a
 related bug
Message-ID: <20191014202846.GA8816@iweiny-DESK2.sc.intel.com>
References: <20191014184639.1512873-1-jhubbard@nvidia.com>
 <20191014184639.1512873-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014184639.1512873-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:46:39AM -0700, John Hubbard wrote:
> In several routines, the "flags" argument is incorrectly
> named "write". Change it to "flags".
> 
> Also, in one place, the misnaming led to an actual bug:
> "flags & FOLL_WRITE" is required, rather than just "flags".
> (That problem was flagged by krobot, in v1 of this patch.)
> 
> Also, change the flags argument from int, to unsigned int.
> 
> You can see that this was a simple oversight, because the
> calling code passes "flags" to the fifth argument:
> 
> gup_pgd_range():
>     ...
>     if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
> 		    PGDIR_SHIFT, next, flags, pages, nr))
> 
> ...which, until this patch, the callees referred to as "write".
> 
> Also, change two lines to avoid checkpatch line length
> complaints, and another line to fix another oversight
> that checkpatch called out: missing "int" on pdshift.
> 
> Fixes: b798bec4741b ("mm/gup: change write parameter to flags in fast walk")
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 23a9f9c9d377..8f236a335ae9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1973,7 +1973,8 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
>  }
>  
>  static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
> -		       unsigned long end, int write, struct page **pages, int *nr)
> +		       unsigned long end, unsigned int flags,
> +		       struct page **pages, int *nr)
>  {
>  	unsigned long pte_end;
>  	struct page *head, *page;
> @@ -1986,7 +1987,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  
>  	pte = READ_ONCE(*ptep);
>  
> -	if (!pte_access_permitted(pte, write))
> +	if (!pte_access_permitted(pte, flags & FOLL_WRITE))
>  		return 0;
>  
>  	/* hugepages are never "special" */
> @@ -2023,7 +2024,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  }
>  
>  static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
> -		unsigned int pdshift, unsigned long end, int write,
> +		unsigned int pdshift, unsigned long end, unsigned int flags,
>  		struct page **pages, int *nr)
>  {
>  	pte_t *ptep;
> @@ -2033,7 +2034,7 @@ static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
>  	ptep = hugepte_offset(hugepd, addr, pdshift);
>  	do {
>  		next = hugepte_addr_end(addr, end, sz);
> -		if (!gup_hugepte(ptep, sz, addr, end, write, pages, nr))
> +		if (!gup_hugepte(ptep, sz, addr, end, flags, pages, nr))
>  			return 0;
>  	} while (ptep++, addr = next, addr != end);
>  
> @@ -2041,7 +2042,7 @@ static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
>  }
>  #else
>  static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
> -		unsigned pdshift, unsigned long end, int write,
> +		unsigned int pdshift, unsigned long end, unsigned int flags,
>  		struct page **pages, int *nr)
>  {
>  	return 0;
> @@ -2049,7 +2050,8 @@ static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
>  #endif /* CONFIG_ARCH_HAS_HUGEPD */
>  
>  static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> -		unsigned long end, unsigned int flags, struct page **pages, int *nr)
> +			unsigned long end, unsigned int flags,
> +			struct page **pages, int *nr)
>  {
>  	struct page *head, *page;
>  	int refs;
> -- 
> 2.23.0
> 
> 
