Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2D64987D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2019 06:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfFRE5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jun 2019 00:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbfFRE5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 00:57:53 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655802085A;
        Tue, 18 Jun 2019 04:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560833871;
        bh=w+gB2F5dYye00PGW41w3Ta0fKYcvbRLeUI20zlmMIcs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PzYEh9w15oAHl/5+DWIcKrLey234a0uiq0n8QAcsKIIvkD+9bOlHnZiXlY3FTrD8z
         QbGYu0AkfxcGrKu700nhTv5AAxsUusMx2xVPd71iWWvU71sO7HwW6NZ3yMOVjWY/tl
         ddlDhLRXEMz8eUrp9pUXynA3sqlPR14qWsnLehLo=
Date:   Mon, 17 Jun 2019 21:57:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Borislav Petkov <bp@suse.de>, Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 3/3] resource: Introduce resource cache
Message-Id: <20190617215750.8e46ae846c09cd5c1f22fdf9@linux-foundation.org>
In-Reply-To: <20190613045903.4922-4-namit@vmware.com>
References: <20190613045903.4922-1-namit@vmware.com>
        <20190613045903.4922-4-namit@vmware.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2019 21:59:03 -0700 Nadav Amit <namit@vmware.com> wrote:

> For efficient search of resources, as needed to determine the memory
> type for dax page-faults, introduce a cache of the most recently used
> top-level resource. Caching the top-level should be safe as ranges in
> that level do not overlap (unlike those of lower levels).
> 
> Keep the cache per-cpu to avoid possible contention. Whenever a resource
> is added, removed or changed, invalidate all the resources. The
> invalidation takes place when the resource_lock is taken for write,
> preventing possible races.
> 
> This patch provides relatively small performance improvements over the
> previous patch (~0.5% on sysbench), but can benefit systems with many
> resources.

> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -53,6 +53,12 @@ struct resource_constraint {
>  
>  static DEFINE_RWLOCK(resource_lock);
>  
> +/*
> + * Cache of the top-level resource that was most recently use by
> + * find_next_iomem_res().
> + */
> +static DEFINE_PER_CPU(struct resource *, resource_cache);

A per-cpu cache which is accessed under a kernel-wide read_lock looks a
bit odd - the latency getting at that rwlock will swamp the benefit of
isolating the CPUs from each other when accessing resource_cache.

On the other hand, if we have multiple CPUs running
find_next_iomem_res() concurrently then yes, I see the benefit.  Has
the benefit of using a per-cpu cache (rather than a kernel-wide one)
been quantified?


> @@ -262,9 +268,20 @@ static void __release_child_resources(struct resource *r)
>  	}
>  }
>  
> +static void invalidate_resource_cache(void)
> +{
> +	int cpu;
> +
> +	lockdep_assert_held_exclusive(&resource_lock);
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu(resource_cache, cpu) = NULL;
> +}

All the calls to invalidate_resource_cache() are rather a
maintainability issue - easy to miss one as the code evolves.

Can't we just make find_next_iomem_res() smarter?  For example, start
the lookup from the cached point and if that failed, do a full sweep?

> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();
> +			invalidate_resource_cache();
> +	invalidate_resource_cache();
> +	invalidate_resource_cache();

Ow.  I guess the maintainability situation can be improved by renaming
resource_lock to something else (to avoid mishaps) then adding wrapper
functions.  But still.  I can't say this is a super-exciting patch :(
