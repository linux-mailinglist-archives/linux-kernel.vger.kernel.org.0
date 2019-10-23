Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3354CE20D9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407325AbfJWQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 12:41:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:54694 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730796AbfJWQls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:41:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DA1EAC84;
        Wed, 23 Oct 2019 16:41:46 +0000 (UTC)
Date:   Wed, 23 Oct 2019 18:41:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo
Message-ID: <20191023164145.GL17610@dhcp22.suse.cz>
References: <20191023095607.GE3016@techsingularity.net>
 <20191023102737.32274-1-mhocko@kernel.org>
 <20191023102737.32274-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023102737.32274-3-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a brown paper bag bug fixed. I have also added a note about low
number of pages being more important as per Vlastimil's feedback

From 0282f604144a5c06fdf3cf0bb2df532411e7f8c9 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 23 Oct 2019 12:13:02 +0200
Subject: [PATCH] mm, vmstat: reduce zone->lock holding time by
 /proc/pagetypeinfo

pagetypeinfo_showfree_print is called by zone->lock held in irq mode.
This is not really nice because it blocks both any interrupts on that
cpu and the page allocator. On large machines this might even trigger
the hard lockup detector.

Considering the pagetypeinfo is a debugging tool we do not really need
exact numbers here. The primary reason to look at the outuput is to see
how pageblocks are spread among different migratetypes and low number of
pages is much more interesting therefore putting a bound on the number
of pages on the free_list sounds like a reasonable tradeoff.

The new output will simply tell
[...]
Node    6, zone   Normal, type      Movable >100000 >100000 >100000 >100000  41019  31560  23996  10054   3229    983    648

instead of
Node    6, zone   Normal, type      Movable 399568 294127 221558 102119  41019  31560  23996  10054   3229    983    648

The limit has been chosen arbitrary and it is a subject of a future
change should there be a need for that.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmstat.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4e885ecd44d1..c156ce24a322 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1383,12 +1383,29 @@ static void pagetypeinfo_showfree_print(struct seq_file *m,
 			unsigned long freecount = 0;
 			struct free_area *area;
 			struct list_head *curr;
+			bool overflow = false;
 
 			area = &(zone->free_area[order]);
 
-			list_for_each(curr, &area->free_list[mtype])
-				freecount++;
-			seq_printf(m, "%6lu ", freecount);
+			list_for_each(curr, &area->free_list[mtype]) {
+				/*
+				 * Cap the free_list iteration because it might
+				 * be really large and we are under a spinlock
+				 * so a long time spent here could trigger a
+				 * hard lockup detector. Anyway this is a
+				 * debugging tool so knowing there is a handful
+				 * of pages in this order should be more than
+				 * sufficient
+				 */
+				if (++freecount >= 100000) {
+					overflow = true;
+					spin_unlock_irq(&zone->lock);
+					cond_resched();
+					spin_lock_irq(&zone->lock);
+					break;
+				}
+			}
+			seq_printf(m, "%s%6lu ", overflow ? ">" : "", freecount);
 		}
 		seq_putc(m, '\n');
 	}
-- 
2.20.1

-- 
Michal Hocko
SUSE Labs
