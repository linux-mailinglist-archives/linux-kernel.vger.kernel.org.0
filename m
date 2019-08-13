Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881FC8B440
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 11:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfHMJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 05:35:16 -0400
Received: from foss.arm.com ([217.140.110.172]:60794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfHMJfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:35:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E7C337;
        Tue, 13 Aug 2019 02:35:15 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48873F706;
        Tue, 13 Aug 2019 02:35:14 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:35:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 3/3] mm: kmemleak: Use the memory pool for early
 allocations
Message-ID: <20190813093512.GE62772@arrakis.emea.arm.com>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
 <20190812160642.52134-4-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812160642.52134-4-catalin.marinas@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 05:06:42PM +0100, Catalin Marinas wrote:
> @@ -466,9 +419,13 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
>  	struct kmemleak_object *object;
>  
>  	/* try the slab allocator first */
> -	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> -	if (object)
> -		return object;
> +	if (object_cache) {
> +		object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
> +		if (object)
> +			return object;
> +		else
> +			WARN_ON_ONCE(1);

Oops, this was actually my debug warning just to make sure it triggered
(tested with failslab). The WARN_ON_ONCE(1) should be removed (I changed
it locally in case I post an update).

I noticed it in Andrew's subsequent checkpatch fix.

-- 
Catalin
