Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA3A7E1E32
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406379AbfJWObG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 10:31:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:43858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403845AbfJWObF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:31:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5D9AB442;
        Wed, 23 Oct 2019 14:31:03 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:31:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-ID: <20191023143102.GI17610@dhcp22.suse.cz>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-3-mhocko@kernel.org>
 <30211965-8ad0-416d-0fe1-113270bd1ea8@suse.cz>
 <20191023133720.GA17610@dhcp22.suse.cz>
 <7fb34979-66a4-4a5d-1798-402826e31e72@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb34979-66a4-4a5d-1798-402826e31e72@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-10-19 15:48:36, Vlastimil Babka wrote:
> On 10/23/19 3:37 PM, Michal Hocko wrote:
> > On Wed 23-10-19 15:32:05, Vlastimil Babka wrote:
> >> On 10/23/19 12:27 PM, Michal Hocko wrote:
> >>> From: Michal Hocko <mhocko@suse.com>
> >>>
> >>> pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
> >>> This is not really nice because it blocks both any interrupts on that
> >>> cpu and the page allocator. On large machines this might even trigger
> >>> the hard lockup detector.
> >>>
> >>> Considering the pagetypeinfo is a debugging tool we do not really need
> >>> exact numbers here. The primary reason to look at the outuput is to see
> >>> how pageblocks are spread among different migratetypes therefore putting
> >>> a bound on the number of pages on the free_list sounds like a reasonable
> >>> tradeoff.
> >>>
> >>> The new output will simply tell
> >>> [...]
> >>> Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648
> >>>
> >>> instead of
> >>> Node    6, zone   Normal, type      Movable 399568 294127 221558 102119  41019  31560  23996  10054   3229    983    648
> >>>
> >>> The limit has been chosen arbitrary and it is a subject of a future
> >>> change should there be a need for that.
> >>>
> >>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> >>> Signed-off-by: Michal Hocko <mhocko@suse.com>
> >>
> >> Hmm dunno, I would rather e.g. hide the file behind some config or boot
> >> option than do this. Or move it to /sys/kernel/debug ?
> > 
> > But those wouldn't really help to prevent from the lockup, right?
> 
> No, but it would perhaps help ensure that only people who know what they
> are doing (or been told so by a developer e.g. on linux-mm) will try to
> collect the data, and not some automatic monitoring tools taking
> periodic snapshots of stuff in /proc that looks interesting.

Well, we do trust root doesn't do harm, right?

> > Besides that who would enable that config and how much of a difference
> > would root only vs. debugfs make?
> 
> I would hope those tools don't scrap debugfs as much as /proc, but I
> might be wrong of course :)
> 
> > Is the incomplete value a real problem?
> 
> Hmm perhaps not. If the overflow happens only for one migratetype, one
> can use also /proc/buddyinfo to get to the exact count, as was proposed
> in this thread for Movable migratetype.

Let's say this won't be the case. What is the worst case that the
imprecision would cause? In other words. Does it really matter whether
we have 100k pages on the free list of the specific migrate type for
order or say 200k?

-- 
Michal Hocko
SUSE Labs
