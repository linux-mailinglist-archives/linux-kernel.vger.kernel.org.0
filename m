Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6188A8FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2019 23:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHLVHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Aug 2019 17:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfHLVHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:07:32 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75159206C2;
        Mon, 12 Aug 2019 21:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565644051;
        bh=8eWu0FeEigtryjeLkybywbMKb9yID/F2+1F7HYeW6MM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KSc2f7WJ+aVJbY03uw3UilWLAtizXPAUmMYG3sHCkIFvvCmev13bVOmzlC7c9DVvu
         TeJWhQV7OhPUJ2Tp8JQEIgR7dRP5f1Cy44CsuUM+mAdfmg1cwNi5yByYYrqsdtng6l
         6qQ6wmggXbxoq8GT9R4qXV42gFqJDwD+b6ejhFnw=
Date:   Mon, 12 Aug 2019 14:07:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 0/3] mm: kmemleak: Use a memory pool for kmemleak
 object allocations
Message-Id: <20190812140730.71dd7f35d568b4d8530f8908@linux-foundation.org>
In-Reply-To: <20190812160642.52134-1-catalin.marinas@arm.com>
References: <20190812160642.52134-1-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 17:06:39 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> Following the discussions on v2 of this patch(set) [1], this series
> takes slightly different approach:
> 
> - it implements its own simple memory pool that does not rely on the
>   slab allocator
> 
> - drops the early log buffer logic entirely since it can now allocate
>   metadata from the memory pool directly before kmemleak is fully
>   initialised
> 
> - CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE option is renamed to
>   CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE
> 
> - moves the kmemleak_init() call earlier (mm_init())
> 
> - to avoid a separate memory pool for struct scan_area, it makes the
>   tool robust when such allocations fail as scan areas are rather an
>   optimisation
> 
> [1] http://lkml.kernel.org/r/20190727132334.9184-1-catalin.marinas@arm.com

Using the term "memory pool" is a little unfortunate, but better than
using "mempool"!

The changelog doesn't answer the very first question: why not use
mempools.  Please send along a paragraph which explains this decision.
