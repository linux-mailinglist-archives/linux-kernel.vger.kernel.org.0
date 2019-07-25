Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C0748C3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 10:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389089AbfGYIGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 04:06:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:53754 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389040AbfGYIGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 04:06:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8D211AFF4;
        Thu, 25 Jul 2019 08:06:33 +0000 (UTC)
Date:   Thu, 25 Jul 2019 09:06:31 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/3] mm, compaction: use MIN_COMPACT_COSTLY_PRIORITY
 everywhere for costly orders
Message-ID: <20190725080631.GC2708@suse.de>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
 <20190724175014.9935-3-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190724175014.9935-3-mike.kravetz@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:50:13AM -0700, Mike Kravetz wrote:
> For PAGE_ALLOC_COSTLY_ORDER allocations, MIN_COMPACT_COSTLY_PRIORITY is
> minimum (highest priority).  Other places in the compaction code key off
> of MIN_COMPACT_PRIORITY.  Costly order allocations will never get to
> MIN_COMPACT_PRIORITY.  Therefore, some conditions will never be met for
> costly order allocations.
> 
> This was observed when hugetlb allocations could stall for minutes or
> hours when should_compact_retry() would return true more often then it
> should.  Specifically, this was in the case where compact_result was
> COMPACT_DEFERRED and COMPACT_PARTIAL_SKIPPED and no progress was being
> made.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
