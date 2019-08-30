Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A5A3569
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 13:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfH3LJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Aug 2019 07:09:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35206 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726660AbfH3LJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:09:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3307FAF11;
        Fri, 30 Aug 2019 11:09:09 +0000 (UTC)
Date:   Fri, 30 Aug 2019 13:09:07 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Sangwoo <sangwoo2.park@lge.com>
Cc:     hannes@cmpxchg.org, arunks@codeaurora.org, guro@fb.com,
        richard.weiyang@gmail.com, glider@google.com, jannh@google.com,
        dan.j.williams@intel.com, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com, rppt@linux.vnet.ibm.com,
        gregkh@linuxfoundation.org, janne.huttunen@nokia.com,
        pasha.tatashin@soleen.com, vbabka@suse.cz, osalvador@suse.de,
        mgorman@techsingularity.net, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Add nr_free_highatomimic to fix incorrect watermatk
 routine
Message-ID: <20190830110907.GC28313@dhcp22.suse.cz>
References: <1567157153-22024-1-git-send-email-sangwoo2.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567157153-22024-1-git-send-email-sangwoo2.park@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 18:25:53, Sangwoo wrote:
> The highatomic migrate block can be increased to 1% of Total memory.
> And, this is for only highorder ( > 0 order). So, this block size is
> excepted during check watermark if allocation type isn't alloc_harder.
> 
> It has problem. The usage of highatomic is already calculated at NR_FREE_PAGES.
> So, if we except total block size of highatomic, it's twice minus size of allocated
> highatomic.
> It's cause allocation fail although free pages enough.
> 
> We checked this by random test on my target(8GB RAM).
> 
> 	Binder:6218_2: page allocation failure: order:0, mode:0x14200ca(GFP_HIGHUSER_MOVABLE), nodemask=(null)
> 	Binder:6218_2 cpuset=background mems_allowed=0

How come this order-0 sleepable allocation fails? The upstream kernel
doesn't fail those allocations unless the process context is killed by
the oom killer.

Also please note that atomic reserves are released when the memory
pressure is high and we cannot reclaim any other memory. Have a look at
unreserve_highatomic_pageblock called from should_reclaim_retry.
-- 
Michal Hocko
SUSE Labs
