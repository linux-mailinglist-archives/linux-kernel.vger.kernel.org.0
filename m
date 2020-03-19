Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E737218B344
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Mar 2020 13:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCSMV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Mar 2020 08:21:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:36044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgCSMV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:21:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A06E6AFC8;
        Thu, 19 Mar 2020 12:21:21 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] mm/page_alloc: use ac->high_zoneidx for
 classzone_idx
To:     Joonsoo Kim <js1304@gmail.com>,
        David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584502378-12609-2-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.21.2003181419090.70237@chino.kir.corp.google.com>
 <CAAmzW4PZr6QiO=6VcM_Nbf4079awHBLULAm+_A_-2mCxrzOO2g@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9a7c94c0-c2b2-d533-316a-4fd42bdf55b1@suse.cz>
Date:   Thu, 19 Mar 2020 13:21:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAmzW4PZr6QiO=6VcM_Nbf4079awHBLULAm+_A_-2mCxrzOO2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/20 9:57 AM, Joonsoo Kim wrote:
>> Curious: is this only an issue when vm.numa_zonelist_order is set to Node?
> 
> Do you mean "/proc/sys/vm/numa_zonelist_order"? It looks like it's gone now.
> 
> Thanks.

Yes it's gone now, but indeed, AFAIU on older kernels with zone order instead of
node order, this problem wouldn't manifest.

This was in my reply to v1, 2 years ago :)

So to summarize;
- ac->high_zoneidx is computed via the arcane gfp_zone(gfp_mask) and
represents the highest zone the allocation can use
- classzone_idx was supposed to be the highest zone that the allocation can use,
that is actually available in the system. Somehow that became the highest zone
that is available on the preferred node (in the default node-order zonelist),
which causes the watermark inconsistencies you mention.



