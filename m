Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3024E4AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2019 14:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502563AbfJYMA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Oct 2019 08:00:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:50932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409923AbfJYMA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:00:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C5C6AE09;
        Fri, 25 Oct 2019 12:00:26 +0000 (UTC)
Date:   Fri, 25 Oct 2019 13:00:23 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-ID: <20191025120023.GD28938@suse.de>
References: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <192965B3-B446-499C-AEE8-DFF087D46B87@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 07:18:37AM -0400, Qian Cai wrote:
> ???
> 
> > On Oct 25, 2019, at 3:26 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Considering the pagetypeinfo is a debugging tool we do not really need
> > exact numbers here. The primary reason to look at the outuput is to see
> > how pageblocks are spread among different migratetypes and low number of
> > pages is much more interesting therefore putting a bound on the number
> > of pages on the free_list sounds like a reasonable tradeoff.
> > 
> > The new output will simply tell
> > [...]
> > Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648
> 
> It was mentioned that developers could use this file is to see the movement of those numbers for debugging, so this supposed to introduce regressions as there is no movement anymore for those 100k+ items?

They would need to be more explicit on what their requirements are. When
the file was first introduced, the main interesting point was to see
an approximate distribution of orders by migration type. The exact
count was not particularly interesting other than knowing whether
there was large numbers at lower orders that could not be recovered
by compaction/drop_caches/hugetlbfs-allocation/memhog-abuse etc and
the distribution of pageblocks by migration type overall. That was my
perspective at least when developing fragmentation avoidance, lumpy
reclaim and later compaction.

-- 
Mel Gorman
SUSE Labs
