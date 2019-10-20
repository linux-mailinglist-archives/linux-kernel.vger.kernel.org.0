Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3446DDF1A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2019 17:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfJTPYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Oct 2019 11:24:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfJTPYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 11:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4ZH3C9BlRkulrqsRUN1NO9rzPeBK4dlwWV9oddVh+sM=; b=LK3ejOPlikkCcTsnulHKdpcnl
        8s6WJyrbr4VzaJhIiWuCrdk2S3F93UW6m9ES+6eLTaDcxPzvqHUHezP0h8EeBnZEFm1dXZHSt93NY
        9bI7xgyr+9+S+h9gK7aRSnuNQRkBs//8au2GkhNvOQ+HycWVHjHK1sOLqPJG93NP1Q84ptSepiLBD
        WSNO7FYuzuPxU29XV0eAPoIEqe4P8tjp5v/N0OvhIKcxwdSyzXaHdXOzBVOCPGeMs3bysMRppp6AJ
        bixYWWRZlMZHAStqP6CSgGuYDu0Dh2ZLV73DoS7cbMxyuGVL6SwXGumUxW81dAtqZ7szAuUfjnsok
        74SW3yOkA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMD3o-0006br-E1; Sun, 20 Oct 2019 15:24:00 +0000
Date:   Sun, 20 Oct 2019 08:24:00 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v1] mm: add page preemption
Message-ID: <20191020152400.GA9214@bombadil.infradead.org>
References: <20191020134304.11700-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020134304.11700-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 09:43:04PM +0800, Hillf Danton wrote:
> First on the page side, page->prio that is used to mirror the prio
> of page owner tasks is added, and a couple of helpers for setting,
> copying and comparing page->prio to help to add pages to lru.

Um, no.  struct page is 64 bytes and shall remain so without a very very
good reason.

> @@ -197,6 +198,10 @@ struct page {
>  	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
>  	atomic_t _refcount;
>  
> +#ifdef CONFIG_PAGE_PREEMPTION
> +	int prio; /* mirror page owner task->prio */
> +#endif
> +
>  #ifdef CONFIG_MEMCG
>  	struct mem_cgroup *mem_cgroup;
>  #endif
