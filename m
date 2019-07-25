Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2E74352
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 04:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbfGYCcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jul 2019 22:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388369AbfGYCcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 22:32:52 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D44321734;
        Thu, 25 Jul 2019 02:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564021971;
        bh=ibY4e/drCaKLwNL3K3X/eLcpITyljqY6j1fyxEzgnFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJbTYpESLMzczubKldo96bh7CeNd2DIEtY440m44fauTpRt9BrxvVQh0yAwfOuROF
         iZe7fMFTVCgEaKT67hOlvIOsI0AFUW7pilJcU+4prrYzwSOqmsJsfRRQ4Rkr2TvTpP
         lGAVkY3ofEeOd5cQ8/85Yyi3lqltPIfZzVlQdtpg=
Date:   Wed, 24 Jul 2019 19:32:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peng Fan <peng.fan@nxp.com>, Ira Weiny <ira.weiny@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm: replace list_move_tail() with
 add_page_to_lru_list_tail()
Message-Id: <20190724193249.00875235c4fa2495e0098451@linux-foundation.org>
In-Reply-To: <20190716212436.7137-1-yuzhao@google.com>
References: <20190716212436.7137-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jul 2019 15:24:36 -0600 Yu Zhao <yuzhao@google.com> wrote:

> This is a cleanup patch that replaces two historical uses of
> list_move_tail() with relatively recent add_page_to_lru_list_tail().
> 

Looks OK to me.

> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -515,7 +515,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>  	del_page_from_lru_list(page, lruvec, lru + active);
>  	ClearPageActive(page);
>  	ClearPageReferenced(page);
> -	add_page_to_lru_list(page, lruvec, lru);
>  
>  	if (PageWriteback(page) || PageDirty(page)) {
>  		/*
> @@ -523,13 +522,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
>  		 * It can make readahead confusing.  But race window
>  		 * is _really_ small and  it's non-critical problem.
>  		 */
> +		add_page_to_lru_list(page, lruvec, lru);
>  		SetPageReclaim(page);
>  	} else {
>  		/*
>  		 * The page's writeback ends up during pagevec
>  		 * We moves tha page into tail of inactive.
>  		 */

That comment is really hard to follow.  Minchan, can you please explain
the first sentence?

The second sentence can simply be removed.

> -		list_move_tail(&page->lru, &lruvec->lists[lru]);
> +		add_page_to_lru_list_tail(page, lruvec, lru);
>  		__count_vm_event(PGROTATED);
>  	}
