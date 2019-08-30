Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0B1A3537
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 12:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfH3Kt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 06:49:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:45210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbfH3Kt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 06:49:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 484C5AC1C;
        Fri, 30 Aug 2019 10:49:27 +0000 (UTC)
Date:   Fri, 30 Aug 2019 12:49:25 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Eric Dumazet <edumazet@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jinyu Qi <jinyuqi@huawei.com>
Subject: Re: [PATCH] iommu/iova: avoid false sharing on fq_timer_on
Message-ID: <20190830104925.GI17192@suse.de>
References: <20190828131338.89832-1-edumazet@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828131338.89832-1-edumazet@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me, but adding Robin for his opinion.

On Wed, Aug 28, 2019 at 06:13:38AM -0700, Eric Dumazet wrote:
> In commit 14bd9a607f90 ("iommu/iova: Separate atomic variables
> to improve performance") Jinyu Qi identified that the atomic_cmpxchg()
> in queue_iova() was causing a performance loss and moved critical fields
> so that the false sharing would not impact them.
> 
> However, avoiding the false sharing in the first place seems easy.
> We should attempt the atomic_cmpxchg() no more than 100 times
> per second. Adding an atomic_read() will keep the cache
> line mostly shared.
> 
> This false sharing came with commit 9a005a800ae8
> ("iommu/iova: Add flush timer").
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Jinyu Qi <jinyuqi@huawei.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/iova.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 3e1a8a6755723a927a7942a7429ab7e6c19a0027..41c605b0058f9615c2dbdd83f1de2404a9b1d255 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -577,7 +577,9 @@ void queue_iova(struct iova_domain *iovad,
>  
>  	spin_unlock_irqrestore(&fq->lock, flags);
>  
> -	if (atomic_cmpxchg(&iovad->fq_timer_on, 0, 1) == 0)
> +	/* Avoid false sharing as much as possible. */
> +	if (!atomic_read(&iovad->fq_timer_on) &&
> +	    !atomic_cmpxchg(&iovad->fq_timer_on, 0, 1))
>  		mod_timer(&iovad->fq_timer,
>  			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
>  }
> -- 
> 2.23.0.187.g17f5b7556c-goog
