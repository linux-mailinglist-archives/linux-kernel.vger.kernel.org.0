Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D042D76077
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2019 10:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfGZIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jul 2019 04:12:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:58086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfGZIMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:12:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 206DAB62D;
        Fri, 26 Jul 2019 08:12:29 +0000 (UTC)
Date:   Fri, 26 Jul 2019 09:12:25 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] mm, reclaim: make should_continue_reclaim
 perform dryrun detection
Message-ID: <20190726081225.GF2708@suse.de>
References: <20190724175014.9935-1-mike.kravetz@oracle.com>
 <20190724175014.9935-2-mike.kravetz@oracle.com>
 <20190725080551.GB2708@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190725080551.GB2708@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hillf Danton <hdanton@sina.com>
> Subject: [RFC PATCH 1/3] mm, reclaim: make should_continue_reclaim perform dryrun detection
> 
> Address the issue of should_continue_reclaim continuing true too often
> for __GFP_RETRY_MAYFAIL attempts when !nr_reclaimed and nr_scanned.
> This could happen during hugetlb page allocation causing stalls for
> minutes or hours.
> 
> We can stop reclaiming pages if compaction reports it can make a progress.
> A code reshuffle is needed to do that. And it has side-effects, however,
> with allocation latencies in other cases but that would come at the cost
> of potential premature reclaim which has consequences of itself.
> 
> We can also bail out of reclaiming pages if we know that there are not
> enough inactive lru pages left to satisfy the costly allocation.
> 
> We can give up reclaiming pages too if we see dryrun occur, with the
> certainty of plenty of inactive pages. IOW with dryrun detected, we are
> sure we have reclaimed as many pages as we could.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Hillf Danton <hdanton@sina.com>

Acked-by: Mel Gorman <mgorman@suse.de>

Thanks Hillf

-- 
Mel Gorman
SUSE Labs
