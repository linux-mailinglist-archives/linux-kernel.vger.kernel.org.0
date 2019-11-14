Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5C9FC841
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2019 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKNN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Nov 2019 08:59:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:39700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbfKNN7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:59:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2AC0ABCE;
        Thu, 14 Nov 2019 13:59:48 +0000 (UTC)
Date:   Thu, 14 Nov 2019 14:59:48 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/debug: PageAnon() is true for PageKsm() pages
Message-ID: <20191114135948.GB1356@dhcp22.suse.cz>
References: <20191113000651.20677-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113000651.20677-1-rcampbell@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-11-19 16:06:51, Ralph Campbell wrote:
> PageAnon() and PageKsm() use the low two bits of the page->mapping pointer
> to indicate the page type. PageAnon() only checks the LSB while PageKsm()
> checks the least significant 2 bits are equal to 3. Therefore, PageAnon()
> is true for KSM pages.
> __dump_page() incorrectly will never print "ksm" because it checks
> PageAnon() first. Fix this by checking PageKsm() first.

Thanks for spotting this

Fixes: 1c6fb1d89e73 ("mm: print more information about mapping in __dump_page")

> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/debug.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/debug.c b/mm/debug.c
> index 772d4cf0691f..0461df1207cb 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -77,10 +77,10 @@ void __dump_page(struct page *page, const char *reason)
>  		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
>  			page, page_ref_count(page), mapcount,
>  			page->mapping, page_to_pgoff(page));
> -	if (PageAnon(page))
> -		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
> -	else if (PageKsm(page))
> +	if (PageKsm(page))
>  		pr_warn("ksm flags: %#lx(%pGp)\n", page->flags, &page->flags);
> +	else if (PageAnon(page))
> +		pr_warn("anon flags: %#lx(%pGp)\n", page->flags, &page->flags);
>  	else if (mapping) {
>  		if (mapping->host && mapping->host->i_dentry.first) {
>  			struct dentry *dentry;
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
