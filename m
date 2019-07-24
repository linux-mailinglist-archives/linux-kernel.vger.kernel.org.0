Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2A4723C7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2019 03:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfGXBio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jul 2019 21:38:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfGXBio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 21:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AFwPz9F7BR2KO7EHQe4D2tuUr0dHyiHUKqAqUScb/5k=; b=RULrgcX43IxPsdqZAr6lzCNtc
        zncXOGdm5at73wpugQrjVm/0D5jAFMwnWKMKvNEA4wlnwbE6pgoawegICLrGsEQBv3zxPp/3b/kuy
        irE/ozw1NZOQwzdR1gpTm0V1AtY6m0TW83pVr89t+9aWKmjX7SJCi7nfKmLroTQsKWOB+LVwEItZC
        qlFd1a/r5p9/fZ+bovKzNcmCrBIXwIgFiTVdaetrzDdeLU1VPV7tJXwY4XA7Gr5jj19De7QnjImV2
        +emEkD2xFmY7RB4rzv8jQmLp24bAE5Y8MPNZ8EYASJsS1q40hA7KT+nJarwSVQNPfOCF6U0kNje1W
        SSuCf5tTg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hq6Eq-0008Ul-UO; Wed, 24 Jul 2019 01:38:40 +0000
Date:   Tue, 23 Jul 2019 18:38:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH] mm/memory-failure: Poison read receives SIGKILL instead
 of SIGBUS if mmaped more than once
Message-ID: <20190724013840.GS363@bombadil.infradead.org>
References: <1563925110-19359-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563925110-19359-1-git-send-email-jane.chu@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 05:38:30PM -0600, Jane Chu wrote:
> @@ -331,16 +330,21 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>  		tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
>  
>  	/*
> -	 * In theory we don't have to kill when the page was
> -	 * munmaped. But it could be also a mremap. Since that's
> -	 * likely very rare kill anyways just out of paranoia, but use
> -	 * a SIGKILL because the error is not contained anymore.
> +	 * Indeed a page could be mmapped N times within a process. And it's possible

You should run this patch through checkpatch.pl so I don't have to tell
you whats wrong with the trivial aspects of it ;-)

