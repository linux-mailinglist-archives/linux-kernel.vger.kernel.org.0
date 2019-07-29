Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C478782
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 10:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfG2IfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 04:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbfG2IfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:35:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 739D4B023;
        Mon, 29 Jul 2019 08:35:16 +0000 (UTC)
Date:   Mon, 29 Jul 2019 10:35:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: release the spinlock on zap_pte_range
Message-ID: <20190729083515.GD9330@dhcp22.suse.cz>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190729074523.GC9330@dhcp22.suse.cz>
 <20190729082052.GA258885@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729082052.GA258885@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-07-19 17:20:52, Minchan Kim wrote:
> On Mon, Jul 29, 2019 at 09:45:23AM +0200, Michal Hocko wrote:
> > On Mon 29-07-19 16:10:37, Minchan Kim wrote:
> > > In our testing(carmera recording), Miguel and Wei found unmap_page_range
> > > takes above 6ms with preemption disabled easily. When I see that, the
> > > reason is it holds page table spinlock during entire 512 page operation
> > > in a PMD. 6.2ms is never trivial for user experince if RT task couldn't
> > > run in the time because it could make frame drop or glitch audio problem.
> > 
> > Where is the time spent during the tear down? 512 pages doesn't sound
> > like a lot to tear down. Is it the TLB flushing?
> 
> Miguel confirmed there is no such big latency without mark_page_accessed
> in zap_pte_range so I guess it's the contention of LRU lock as well as
> heavy activate_page overhead which is not trivial, either.

Please give us more details ideally with some numbers.
-- 
Michal Hocko
SUSE Labs
