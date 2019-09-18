Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD750B6259
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2019 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfIRLjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Sep 2019 07:39:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfIRLjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IAYC/Jc5bVfNQWNB/ikhUHnQAj5LWMWkZUg7+xRVIaA=; b=alQY9wcjpTvXEUZ//nfikWjzh
        NtH6nFaoRHnd5FXht/TcJMzlODjqsigNZu13rUdjjpzRXf4ElZCUYTNofG/dmiQbSiusXkPpGHiyq
        VoW/3bg7HbjGLwj8X8eQSse81+Y0Q8ns8Rsdeis+qxmfdf4+tPX5UFl+YQYJvYSjkBe1ks8yeoIhU
        lw6UNYcS/kLG14s5mtNA1ZqDdBT5jRHpIfT5SowVjoGzG97eSKDKN6cajlYc5zaeYiPOvPn6lzkMu
        ZNL+rkIYhBO2bCFB8pz+Hu9G6MjBg9t5FlSEewbeo3+VYboXLWNFwkXsEhkIEH5/kjqiyTv430SlG
        1spgXP9WQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iAYIV-0004bK-6p; Wed, 18 Sep 2019 11:38:59 +0000
Date:   Wed, 18 Sep 2019 04:38:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Lin Feng <linf@wangsu.com>
Cc:     corbet@lwn.net, mcgrof@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        keescook@chromium.org, mchehab+samsung@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        ktkhai@virtuozzo.com, hannes@cmpxchg.org
Subject: Re: [PATCH] [RFC] vmscan.c: add a sysctl entry for controlling
 memory reclaim IO congestion_wait length
Message-ID: <20190918113859.GA9880@bombadil.infradead.org>
References: <20190917115824.16990-1-linf@wangsu.com>
 <20190917120646.GT29434@bombadil.infradead.org>
 <3fbb428e-9466-b56b-0be8-c0f510e3aa99@wangsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fbb428e-9466-b56b-0be8-c0f510e3aa99@wangsu.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:21:04AM +0800, Lin Feng wrote:
> > Adding a new tunable is not the right solution.  The right way is
> > to make Linux auto-tune itself to avoid the problem.  For example,
> > bdi_writeback contains an estimated write bandwidth (calculated by the
> > memory management layer).  Given that, we should be able to make an
> > estimate for how long to wait for the queues to drain.
> > 
> 
> Yes, I had ever considered that, auto-tuning is definitely the senior AI way.
> While considering all kinds of production environments hybird storage solution
> is also common today, servers' dirty pages' bdi drivers can span from high end
> ssds to low end sata disk, so we have to think of a *formula(AI core)* by using
> the factors of dirty pages' amount and bdis' write bandwidth, and this AI-core
> will depend on if the estimated write bandwidth is sane and moreover the to be
> written back dirty pages is sequential or random if the bdi is rotational disk,
> it's likey to give a not-sane number and hurt guys who dont't want that, while
> if only consider ssd is relatively simple.
> 
> So IMHO it's not sane to brute force add a guessing logic into memory writeback
> codes and pray on inventing a formula that caters everyone's need.
> Add a sysctl entry may be a right choice that give people who need it and
> doesn't hurt people who don't want it.

You're making this sound far harder than it is.  All the writeback code
needs to know is "How long should I sleep for in order for the queues
to drain a substantial amount".  Since you know the bandwidth and how
many pages you've queued up, it's a simple calculation.

